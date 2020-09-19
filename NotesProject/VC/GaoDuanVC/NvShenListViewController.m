//
//  NvShenListViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/3.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "NvShenListViewController.h"

@interface NvShenListViewController ()<UITableViewDelegate,UITableViewDataSource,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
{
    int page;
}
@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)NSArray * bannerArray;

@property(nonatomic,strong)UIView * buttonContentView;
@property(nonatomic,strong)UIButton * zuiXinButton;
@property(nonatomic,strong)UIButton * zuiReButton;

@property(nonatomic,strong)NSMutableArray * sourceArray;
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NewPagedFlowView * pageView;
@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,assign)CGFloat  lastcontentOffset;


@end

@implementation NvShenListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topNavView.hidden = YES;
    page = 1;
    
    [HTTPModel getBannerList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {

        if (status==1) {

            self.bannerArray = responseObject;
            [self initContentView];

        }
    }];

    
}
-(void)initContentView
{
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu-(TopHeight_PingMu+58*BiLiWidth+BottomHeight_PingMu))];
    self.mainScrollView.tag = 1002;
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mainScrollView.mj_header = mjHeader;
    [self.mainScrollView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreList)];
    self.mainScrollView.mj_footer = mjFooter;

    self.pageView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 147*BiLiWidth)];
    self.pageView.delegate = self;
    self.pageView.dataSource = self;
    self.pageView.minimumPageAlpha = 0.1;
    self.pageView.isCarousel = YES;
    self.pageView.orientation = NewPagedFlowViewOrientationHorizontal;
    self.pageView.isOpenAutoScroll = YES;
    self.pageView.orginPageCount = self.bannerArray.count;
    [self.pageView reloadData];
    [self.mainScrollView addSubview:self.pageView];

    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, self.pageView.height-20*BiLiWidth, 200*BiLiWidth, 10)];
    self.pageControl.currentPage = 0;      //设置当前页指示点
    self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
    self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
    self.pageControl.numberOfPages = self.bannerArray.count;
    [self.pageView addSubview:self.pageControl];
    
    self.buttonContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.pageView.top+self.pageView.height, WIDTH_PingMu, 40*BiLiWidth)];
    self.buttonContentView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.buttonContentView];
    
    self.zuiXinButton = [[UIButton alloc] initWithFrame:CGRectMake(15*BiLiWidth, 0, 40*BiLiWidth, 40*BiLiWidth)];
    [self.zuiXinButton setTitle:@"最新" forState:UIControlStateNormal];
    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiXinButton addTarget:self action:@selector(zuiXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.zuiXinButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
    [self.buttonContentView addSubview:self.zuiXinButton];
    
    self.zuiReButton = [[UIButton alloc] initWithFrame:CGRectMake(self.zuiXinButton.left+self.zuiXinButton.width+15*BiLiWidth, 0, 40*BiLiWidth, 40*BiLiWidth)];
    [self.zuiReButton setTitle:@"最热" forState:UIControlStateNormal];
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiReButton addTarget:self action:@selector(zuiReButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.zuiReButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
    [self.buttonContentView addSubview:self.zuiReButton];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.buttonContentView.top+self.buttonContentView.height, WIDTH_PingMu, 0)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainScrollView addSubview:self.tableView];
    
    
}
#pragma mark--最新 最热button点击
-(void)zuiXinButtonClick
{
    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    self.field = @"";
    [self.mainScrollView.mj_header beginRefreshing];
}
-(void)zuiReButtonClick
{
    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    self.field = @"hot_value";
    [self.mainScrollView.mj_header beginRefreshing];
}

-(void)loadNewLsit
{
    page = 1;
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:@"1" forKey:@"type_id"];
    [info setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    if ([NormalUse isValidString:self.field]) {
        
        [info setObject:self.field forKey:@"field"];
    }
    [HTTPModel getSanDaGirlList:info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self->page++;
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            [self.mainScrollView.mj_header endRefreshing];
            if (dataArray.count>=10) {
                
                [self.mainScrollView.mj_footer endRefreshing];
            }
            else
            {
                [self.mainScrollView.mj_footer endRefreshingWithNoMoreData];
            }
            self.sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.tableView reloadData];
            self.tableView.scrollEnabled = NO;
            [self setTableViewHeightAndScollViewContentSize];
            
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
    
}
-(void)loadMoreList
{
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:@"1" forKey:@"type_id"];
    [info setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    if ([NormalUse isValidString:self.field]) {
        
        [info setObject:self.field forKey:@"field"];
    }

    [HTTPModel getSanDaGirlList:info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self->page++;
            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary * info in dataArray) {
                
                [self.sourceArray addObject:info];
            }
            if (dataArray.count>=10) {
                
                [self.mainScrollView.mj_footer endRefreshing];
            }
            else
            {
                [self.mainScrollView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
            [self setTableViewHeightAndScollViewContentSize];

        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];

}
-(void)setTableViewHeightAndScollViewContentSize
{
    int cellNumber;
    if (self.sourceArray.count%2==0) {
        
        cellNumber = (int)self.sourceArray.count/2;
    }
    else
    {
        cellNumber = (int)self.sourceArray.count/2+1;
    }
    
    self.tableView.height =  200*BiLiWidth*cellNumber;
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.tableView.top+self.tableView.height)];

}
#pragma mark---scrollviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==1002) {
        
        CGFloat hight = scrollView.frame.size.height;
        CGFloat contentOffset = scrollView.contentOffset.y;
        CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
        CGFloat offset = contentOffset - self.lastcontentOffset;
        self.lastcontentOffset = contentOffset;
        
        // NSLog(@"上拉行为");
        if (offset > 0 && contentOffset > 0) {
            
            //如果mainScrollview上滑到 buttonItemView的位置 则把buttonItemView添加到当前view上(实现悬浮效果)
            if (scrollView.contentOffset.y>=147*BiLiWidth) {
                
                self.buttonContentView.top = 0;
                [self.view addSubview:self.buttonContentView];
            }
            
        }
        //NSLog(@"下拉行为");
        if (offset < 0 && distanceFromBottom > hight) {
            
            //如果mainScrollview下滑到 buttonItemView的位置 则把buttonItemView添加到scrollview上(让buttonItemView和scrollview一起滚动)
            
            if (scrollView.contentOffset.y<=147*BiLiWidth) {
                
                self.buttonContentView.top = self.pageView.top+self.pageView.height;
                [self.mainScrollView addSubview:self.buttonContentView];
                
                
            }
            
            
        }
        
    }
    
    
}

#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    int cellNumber;
    if (self.sourceArray.count%2==0) {
        
        cellNumber = (int)self.sourceArray.count/2;
    }
    else
    {
        cellNumber = (int)self.sourceArray.count/2+1;
    }
    
    return cellNumber;


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  200*BiLiWidth;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"NvShenListTableViewCell"] ;
    NvShenListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[NvShenListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ((indexPath.row+1)*2<=self.sourceArray.count) {
        
        [cell initData:[self.sourceArray objectAtIndex:indexPath.row*2] info2:[self.sourceArray objectAtIndex:indexPath.row*2+1]];
    }
    else
    {
        [cell initData:[self.sourceArray objectAtIndex:indexPath.row*2] info2:nil];
    }
    cell.type = @"3";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    
    return CGSizeMake(WIDTH_PingMu-60*BiLiWidth,flowView.frame.size.height);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    self.pageControl.currentPage = pageNumber;
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.bannerArray.count;
    
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
          NSDictionary * info = [self.bannerArray objectAtIndex:index];
          [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_REQUESTURL,[info objectForKey:@"picture"]]]];
//    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}

@end
