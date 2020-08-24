//
//  HomeViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<WSPageViewDelegate,WSPageViewDataSource,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray * vipFuncationArray;
@property(nonatomic,strong,nullable)WSPageView *pageView;
@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)UILabel * locationLable;

@property(nonatomic,strong)Lable_ImageButton * dingZhi;

@property(nonatomic,strong)NSMutableArray * listButtonArray;

@property(nonatomic,strong)NSMutableArray * tableViewArray;//存放tableview
@property(nonatomic,strong)NSMutableArray * pageIndexArray;//存放pageindex
@property(nonatomic,strong)NSMutableArray * dataSourceArray;//存放数据源


@property(nonatomic,strong)UIScrollView * contentScrollView;


@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self xianShiTabBar];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView.hidden = YES;
    self.lineView.hidden = YES;
    
    UIImageView * locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16*BiLiWidth, (self.topNavView.height-14*BiLiWidth)/2, 11*BiLiWidth, 14*BiLiWidth)];
    locationImageView.image = [UIImage imageNamed:@"home_location"];
    [self.topNavView addSubview:locationImageView];
    
    self.locationLable = [[UILabel alloc] initWithFrame:CGRectMake(locationImageView.left+locationImageView.width+5*BiLiWidth, locationImageView.top, 50*BiLiWidth, locationImageView.height)];
    self.locationLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.locationLable.adjustsFontSizeToFitWidth = YES;
    self.locationLable.textColor = RGBFormUIColor(0x333333);
    self.locationLable.text = @"深圳市";
    [self.topNavView addSubview:self.locationLable];
    
    //筛选
    UIButton * shaiXuanButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-11*BiLiWidth-46*BiLiWidth, (self.topNavView.height-16*BiLiWidth)/2, 11*BiLiWidth, 16*BiLiWidth)];
    [shaiXuanButton setImage:[UIImage imageNamed:@"home_shaiXuan"] forState:UIControlStateNormal];
    [self.topNavView addSubview:shaiXuanButton];
    
    //搜索
    UIButton * searchButton = [[UIButton alloc] initWithFrame:CGRectMake(shaiXuanButton.left+shaiXuanButton.width+16*BiLiWidth, (self.topNavView.height-16*BiLiWidth)/2, 16*BiLiWidth, 16*BiLiWidth)];
    [searchButton setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    [self.topNavView addSubview:searchButton];


    
    [self initContentView];

}
-(void)initContentView
{
    
    self.pageView = [[WSPageView alloc]initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, 147*BiLiWidth)];
    self.pageView.currentWidth = 305;
    self.pageView.currentHeight = 147;
    self.pageView.normalHeight = 134;
    self.pageView.delegate = self;
    self.pageView.dataSource = self;
    self.pageView.minimumPageAlpha = 1;   //非当前页的透明比例
    self.pageView.minimumPageScale = 0.8;  //非当前页的缩放比例
    self.pageView.orginPageCount = self.vipFuncationArray.count; //原始页数
    self.pageView.autoTime = 4;    //自动切换视图的时间,默认是5.0
    [self.view addSubview:self.pageView] ;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, self.pageView.top+self.pageView.height+8*BiLiWidth, 200*BiLiWidth, 10)];
    self.pageControl.currentPage = 0;      //设置当前页指示点
    self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
    self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
    self.pageControl.numberOfPages = 3;
    [self.view addSubview:self.pageControl];
    
    Lable_ImageButton * tiYanBaoGao = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(13.5*BiLiWidth, self.pageControl.top+self.pageControl.height+5*BiLiWidth, 69.5*BiLiWidth, 76.5*BiLiWidth)];
    [tiYanBaoGao addTarget:self action:@selector(tiYanBaoGaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    tiYanBaoGao.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    tiYanBaoGao.button_imageView.image = [UIImage imageNamed:@"home_tiYan"];
    tiYanBaoGao.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    tiYanBaoGao.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    tiYanBaoGao.button_lable.textColor = RGBFormUIColor(0x333333);
    tiYanBaoGao.button_lable.textAlignment = NSTextAlignmentCenter;
    tiYanBaoGao.button_lable.text = @"体验报告";
    [self.view addSubview:tiYanBaoGao];
    
    Lable_ImageButton * fangLei = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(tiYanBaoGao.left+tiYanBaoGao.width+16.5*BiLiWidth, tiYanBaoGao.top, tiYanBaoGao.width, tiYanBaoGao.height)];
    [fangLei addTarget:self action:@selector(fangLeiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    fangLei.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    fangLei.button_imageView.image = [UIImage imageNamed:@"home_dangLei"];
    fangLei.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    fangLei.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    fangLei.button_lable.textColor = RGBFormUIColor(0x333333);
    fangLei.button_lable.textAlignment = NSTextAlignmentCenter;
    fangLei.button_lable.text = @"防雷防骗";
    [self.view addSubview:fangLei];

    
    Lable_ImageButton * heiDian = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(fangLei.left+fangLei.width+16.5*BiLiWidth, tiYanBaoGao.top, tiYanBaoGao.width, tiYanBaoGao.height)];
    [heiDian addTarget:self action:@selector(heiDianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    heiDian.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    heiDian.button_imageView.image = [UIImage imageNamed:@"home_heiDian"];
    heiDian.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    heiDian.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    heiDian.button_lable.textColor = RGBFormUIColor(0x333333);
    heiDian.button_lable.textAlignment = NSTextAlignmentCenter;
    heiDian.button_lable.text = @"黑店曝光";
    [self.view addSubview:heiDian];

    
    self.dingZhi = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(heiDian.left+heiDian.width+16.5*BiLiWidth, tiYanBaoGao.top, tiYanBaoGao.width, tiYanBaoGao.height)];
    [self.dingZhi addTarget:self action:@selector(dingZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.dingZhi.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    self.dingZhi.button_imageView.image = [UIImage imageNamed:@"home_dingZhi"];
    self.dingZhi.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    self.dingZhi.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.dingZhi.button_lable.textColor = RGBFormUIColor(0x333333);
    self.dingZhi.button_lable.textAlignment = NSTextAlignmentCenter;
    self.dingZhi.button_lable.text = @"定制服务";
    [self.view addSubview:self.dingZhi];

    self.listButtonArray = [NSMutableArray array];
    NSArray * array = [[NSArray alloc] initWithObjects:@"最新上传",@"红榜推荐",@"验证榜单",@"验车报告", nil];
    float originx = 13*BiLiWidth;
    CGSize size;
    for (int i=0; i<array.count; i++) {
        
        UIButton * button;
        if (i==0) {
            
            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:17*BiLiWidth];
            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx,self.dingZhi.top+self.dingZhi.height+27.5*BiLiWidth, size.width, 17*BiLiWidth)];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17*BiLiWidth];


        }
        else
        {
            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx, self.dingZhi.top+self.dingZhi.height+32.5*BiLiWidth, size.width, 12*BiLiWidth)];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];


        }
        button.tag = i;
        [button addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        originx = button.left+button.width+11.5*BiLiWidth;
        
        [self.listButtonArray addObject:button];
    }
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.dingZhi.top+self.dingZhi.height+64.5*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(self.dingZhi.top+self.dingZhi.height+64.5*BiLiWidth+BottomHeight_PingMu))];
    [self.contentScrollView setContentSize:CGSizeMake(WIDTH_PingMu*array.count, self.contentScrollView.height)];
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.tag = 1001;
    self.contentScrollView.delegate = self;
    [self.view addSubview:self.contentScrollView];
    
    self.pageIndexArray = [NSMutableArray array];
    self.tableViewArray = [NSMutableArray array];
    self.dataSourceArray = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        
        NSNumber * pageIndexNumber = [NSNumber numberWithInt:0];
        [self.pageIndexArray addObject:pageIndexNumber];
        
        NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithObjects:@"1", nil];
        [self.dataSourceArray addObject:sourceArray];
        
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*i, 0, WIDTH_PingMu, self.contentScrollView.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentScrollView addSubview:tableView];
        
        [self.tableViewArray addObject:tableView];
        
        
        MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
        mjHeader.lastUpdatedTimeLabel.hidden = YES;
        tableView.mj_header = mjHeader;
        
        MJRefreshBackNormalFooter * mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreList)];
        tableView.mj_footer = mjFooter;

    }

}
-(void)loadNewLsit
{
    int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;
    if (index==0) {
        
        NSNumber * pageIndexNumber = [NSNumber numberWithInt:0];
        [self.pageIndexArray replaceObjectAtIndex:0 withObject:pageIndexNumber];
        
        NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:0];
        sourceArray = [[NSMutableArray alloc] initWithObjects:@"1", nil];
        [self.dataSourceArray replaceObjectAtIndex:0 withObject:sourceArray];
        
        UITableView * tableView = [self.tableViewArray objectAtIndex:0];
        [tableView.mj_header endRefreshing];
        [tableView reloadData];
    }
    else if(index==1)
    {
        NSNumber * pageIndexNumber = [NSNumber numberWithInt:0];
        [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
        
        NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:0];
        sourceArray = [[NSMutableArray alloc] initWithObjects:@"1", nil];
        [self.dataSourceArray replaceObjectAtIndex:1 withObject:sourceArray];

        
        UITableView * tableView = [self.tableViewArray objectAtIndex:1];
        [tableView.mj_header endRefreshing];
        [tableView reloadData];

    }
    else if(index==2)
    {
        NSNumber * pageIndexNumber = [NSNumber numberWithInt:0];
        [self.pageIndexArray replaceObjectAtIndex:2 withObject:pageIndexNumber];
        
        NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:0];
        sourceArray = [[NSMutableArray alloc] initWithObjects:@"1", nil];
        [self.dataSourceArray replaceObjectAtIndex:2 withObject:sourceArray];

        
        UITableView * tableView = [self.tableViewArray objectAtIndex:2];
        [tableView.mj_header endRefreshing];
        [tableView reloadData];

    }
    else if(index==3)
    {
        NSNumber * pageIndexNumber = [NSNumber numberWithInt:0];
        [self.pageIndexArray replaceObjectAtIndex:3 withObject:pageIndexNumber];
        
        
        NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:0];
        sourceArray = [[NSMutableArray alloc] initWithObjects:@"1", nil];
        [self.dataSourceArray replaceObjectAtIndex:3 withObject:sourceArray];

        
        UITableView * tableView = [self.tableViewArray objectAtIndex:3];
        [tableView.mj_header endRefreshing];
        [tableView reloadData];

    }
        
    NSLog(@"%@",self.pageIndexArray);

}
-(void)loadMoreList
{
    int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;
    if (index==0) {
        
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:0];
        pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
        [self.pageIndexArray replaceObjectAtIndex:0 withObject:pageIndexNumber];
        
        NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:0];
        [sourceArray addObject:@"1"];
        [self.dataSourceArray replaceObjectAtIndex:0 withObject:sourceArray];

        
        UITableView * tableView = [self.tableViewArray objectAtIndex:0];
        [tableView.mj_footer endRefreshing];
        [tableView reloadData];
        
    }
    else if(index==1)
    {
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:1];
        pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
        [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
        
        NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:1];
        [sourceArray addObject:@"1"];
        [self.dataSourceArray replaceObjectAtIndex:1 withObject:sourceArray];

        
        UITableView * tableView = [self.tableViewArray objectAtIndex:1];
        [tableView.mj_footer endRefreshing];
        [tableView reloadData];


    }
    else if(index==2)
    {
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:2];
        pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
        [self.pageIndexArray replaceObjectAtIndex:2 withObject:pageIndexNumber];
        
        NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:2];
        [sourceArray addObject:@"1"];
        [self.dataSourceArray replaceObjectAtIndex:2 withObject:sourceArray];

        
        UITableView * tableView = [self.tableViewArray objectAtIndex:2];
        [tableView.mj_footer endRefreshing];
        [tableView reloadData];


    }
    else if(index==3)
    {
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:3];
        pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
        [self.pageIndexArray replaceObjectAtIndex:3 withObject:pageIndexNumber];
        
        NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:3];
        [sourceArray addObject:@"1"];
        [self.dataSourceArray replaceObjectAtIndex:3 withObject:sourceArray];

        
        UITableView * tableView = [self.tableViewArray objectAtIndex:3];
        [tableView.mj_footer endRefreshing];
        [tableView reloadData];

    }
    NSLog(@"%@",self.pageIndexArray);
}
-(void)listTopButtonClick:(UIButton *)selectButton
{
    [self.contentScrollView setContentOffset:CGPointMake(selectButton.tag*WIDTH_PingMu, 0) animated:YES];
    float originx = 13*BiLiWidth;
    CGSize size;
    for (int i=0; i<self.listButtonArray.count; i++) {
        
        UIButton * button = [self.listButtonArray objectAtIndex:i];
        if (button.tag==selectButton.tag) {
            
            size  = [NormalUse setSize:button.titleLabel.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:17*BiLiWidth];
            button.frame  = CGRectMake(originx,self.dingZhi.top+self.dingZhi.height+27.5*BiLiWidth, size.width, 17*BiLiWidth);
            button.titleLabel.font = [UIFont systemFontOfSize:17*BiLiWidth];

        }
        else
        {
            size  = [NormalUse setSize:button.titleLabel.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
            button.frame  = CGRectMake(originx, self.dingZhi.top+self.dingZhi.height+32.5*BiLiWidth, size.width, 12*BiLiWidth);
            button.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        }
        
        originx = button.left+button.width+11.5*BiLiWidth;

        
    }
}
#pragma mark---scrollviewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (scrollView.tag==1001) {
        
        int  specialIndex = scrollView.contentOffset.x/WIDTH_PingMu;
        
        UIButton * button = [self.listButtonArray objectAtIndex:specialIndex];
        [button sendActionsForControlEvents:UIControlEventTouchUpInside];
    }

}

#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0) {
        
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:0];
        return sourcerray.count;
    }
    else if (tableView.tag==1)
    {
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:1];
        return sourcerray.count;

    }
    else if (tableView.tag==2)
    {
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:2];
        return sourcerray.count;

    }
    else if (tableView.tag==3)
    {
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:3];
        return sourcerray.count;

    }
    else
    {
        return 5;

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return  144*BiLiWidth+17*BiLiWidth;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"HomeListCellCell"] ;
    HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[HomeListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    [cell contentViewSetData:nil];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark UIButtonClick

-(void)tiYanBaoGaoButtonClick
{
    TiYanBaoGaoViewController * vc = [[TiYanBaoGaoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)fangLeiButtonClick
{
    FangLeiFangPianViewController * vc = [[FangLeiFangPianViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)heiDianButtonClick
{
    HeiDianBaoGuangViewController * vc = [[HeiDianBaoGuangViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)dingZhiButtonClick
{
    DingZhiFuWuViewController * vc = [[DingZhiFuWuViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(WSPageView *)flowView {
    
    return CGSizeMake(WIDTH_PingMu-60*BiLiWidth,flowView.frame.size.height);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
}
- (void)didScrollToPage:(float)contentOffsetX inFlowView:(WSPageView *)flowView pageNumber:(int)pageNumber{
    
    self.pageControl.currentPage = pageNumber;
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(WSPageView *)flowView {
    
    return 3;
}

- (UIView *)flowView:(WSPageView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    WSIndexBanner *bannerView = (WSIndexBanner *)[flowView dequeueReusableCell];
    if (!bannerView)
    {
        bannerView = [[WSIndexBanner alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu-60*BiLiWidth, 147*BiLiWidth)];
    }
    
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597827992453&di=89f2d23d41e7e650adec139e15eb8688&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853"]];
    return bannerView;
    
}


@end
