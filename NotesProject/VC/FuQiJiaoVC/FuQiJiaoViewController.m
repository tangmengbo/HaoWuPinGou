//
//  FuQiJiaoViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "FuQiJiaoViewController.h"
#import "FuQiJiaoHomeCell.h"

@interface FuQiJiaoViewController ()<UITableViewDelegate,UITableViewDataSource,WSPageViewDelegate,WSPageViewDataSource>

@property(nonatomic,strong,nullable)WSPageView *pageView;
@property(nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)NSArray * bannerArray;

@property(nonatomic,strong)UIScrollView * contentScrollView;

@property(nonatomic,strong)NSMutableArray * listButtonArray;
@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)NSMutableArray * tableViewArray;//存放tableview
@property(nonatomic,strong)NSMutableArray * pageIndexArray;//存放pageindex
@property(nonatomic,strong)NSMutableArray * dataSourceArray;//存放数据源






@end

@implementation FuQiJiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView.hidden = YES;
    self.lineView.hidden = YES;
    
    self.topTitleLale.text = @"夫妻交友";
    
    [HTTPModel getBannerList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.bannerArray = responseObject;
            
            if([NormalUse isValidArray:self.bannerArray])
            {
                self.pageControl.numberOfPages = self.bannerArray.count;

                //顶部轮播图
                self.pageView = [[WSPageView alloc]initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, 146*BiLiWidth)];
                self.pageView.currentWidth = 305;
                self.pageView.currentHeight = 146;
                self.pageView.normalHeight = 134;
                self.pageView.delegate = self;
                self.pageView.dataSource = self;
                self.pageView.minimumPageAlpha = 1;   //非当前页的透明比例
                self.pageView.minimumPageScale = 0.8;  //非当前页的缩放比例
                self.pageView.orginPageCount = 3; //原始页数
                self.pageView.autoTime = 4;    //自动切换视图的时间,默认是5.0
                [self.view addSubview:self.pageView] ;

            }
                

        }
    }];

    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, self.topNavView.top+self.topNavView.height+146*BiLiWidth+8*BiLiWidth, 200*BiLiWidth, 10)];
    self.pageControl.currentPage = 0;      //设置当前页指示点
    self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
    self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
    self.pageControl.numberOfPages = self.bannerArray.count;
    [self.view addSubview:self.pageControl];
    
    self.listButtonArray = [NSMutableArray array];
    NSArray * array = [[NSArray alloc] initWithObjects:@"最新上传",@"热门推荐", nil];
    float originx = 13*BiLiWidth;
    CGSize size;
    for (int i=0; i<array.count; i++) {
        
        UIButton * button;
        if (i==0) {
            
            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:18*BiLiWidth];
            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx,self.pageControl.top+self.pageControl.height+27.5*BiLiWidth, size.width, 18*BiLiWidth)];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18*BiLiWidth];


        }
        else
        {
            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:14*BiLiWidth];
            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx, self.pageControl.top+self.pageControl.height+32.5*BiLiWidth, size.width, 14*BiLiWidth)];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];


        }
        button.tag = i;
        [button addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        originx = button.left+button.width+11.5*BiLiWidth;
        
        [self.listButtonArray addObject:button];
    }
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(19.5*BiLiWidth,self.pageControl.top+self.pageControl.height+40*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
    self.sliderView.layer.cornerRadius = 7*BiLiWidth/2;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.alpha = 0.8;
    [self.view addSubview:self.sliderView];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.sliderView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    [self.sliderView.layer addSublayer:gradientLayer];
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.sliderView.top+self.sliderView.height+20*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(self.sliderView.top+self.sliderView.height+20*BiLiWidth+BottomHeight_PingMu))];
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.tag = 1001;
    self.contentScrollView.delegate = self;
    [self.contentScrollView setContentSize:CGSizeMake(WIDTH_PingMu*2, self.contentScrollView.height)];
    [self.view addSubview:self.contentScrollView];
    
    
    self.pageIndexArray = [NSMutableArray array];
    self.tableViewArray = [NSMutableArray array];
    self.dataSourceArray = [NSMutableArray array];
    
    for (int i=0; i<array.count; i++) {
        
        NSNumber * pageIndexNumber = [NSNumber numberWithInt:0];
        [self.pageIndexArray addObject:pageIndexNumber];
        
        NSMutableArray * sourceArray = [[NSMutableArray alloc] init];
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
    [self firstGetZuiXinShangChuanList];
    [self firstGetRenMenTuiJianList];



}
-(void)firstGetZuiXinShangChuanList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
    
    [HTTPModel getFuQiJiaoList:[[NSDictionary alloc]initWithObjectsAndKeys:@"0",@"apge",@"time",@"order", nil]
                   callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:0 withObject:pageIndexNumber];
            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:0 withObject:sourceArray];
            
            UITableView * tableView = [self.tableViewArray objectAtIndex:0];
            [tableView.mj_header endRefreshing];
            if (dataArray.count>=10) {
                
                [tableView.mj_footer endRefreshing];
            }
            else
            {
                [tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [tableView reloadData];
            
            
        }
        
    }];
}
-(void)firstGetRenMenTuiJianList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
    
    [HTTPModel getFuQiJiaoList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"apge",@"hot",@"order", nil]
                 callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];

            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:1 withObject:sourceArray];

            UITableView * tableView = [self.tableViewArray objectAtIndex:1];
            [tableView.mj_header endRefreshing];
            if (dataArray.count>=10) {
                
                [tableView.mj_footer endRefreshing];
            }
            else
            {
                [tableView.mj_footer endRefreshingWithNoMoreData];
            }

            [tableView reloadData];
            

        }
        
    }];

}
-(void)loadNewLsit
{
    int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;
    if (index==0) {
            
        [self firstGetZuiXinShangChuanList];
    }
    else if(index==1)
    {
        [self firstGetRenMenTuiJianList];

    }

}
-(void)loadMoreList
{
    int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;
    if (index==0) {
        
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:0];

        [HTTPModel getFuQiJiaoList:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue],@"apge",@"time",@"order", nil]
                       callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:0];
                pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
                [self.pageIndexArray replaceObjectAtIndex:0 withObject:pageIndexNumber];

                NSArray * dataArray = [responseObject objectForKey:@"data"];
                NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:0];
                for (NSDictionary * info in dataArray) {
                    
                    [sourceArray addObject:info];
                }
                [self.dataSourceArray replaceObjectAtIndex:0 withObject:sourceArray];

                UITableView * tableView = [self.tableViewArray objectAtIndex:0];
                if (dataArray.count>=10) {
                    
                    [tableView.mj_footer endRefreshing];
                }
                else
                {
                    [tableView.mj_footer endRefreshingWithNoMoreData];
                }

                [tableView reloadData];


                
            }
            
        }];

        
    }
    else if(index==1)
    {
        
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:1];
        [HTTPModel getFuQiJiaoList:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue],@"apge",@"hot",@"order", nil]
                     callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:1];
                pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
                [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];

                NSArray * dataArray = [responseObject objectForKey:@"data"];
                NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:1];
                for (NSDictionary * info in dataArray) {
                    
                    [sourceArray addObject:info];
                }
                [self.dataSourceArray replaceObjectAtIndex:1 withObject:sourceArray];

                UITableView * tableView = [self.tableViewArray objectAtIndex:1];
                if (dataArray.count>=10) {
                    
                    [tableView.mj_footer endRefreshing];
                }
                else
                {
                    [tableView.mj_footer endRefreshingWithNoMoreData];
                }

                [tableView reloadData];

            }
            
        }];



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
#pragma mark UItableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag==0) {
        
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:0];
        int cellNumber;
        if (sourcerray.count%2==0) {
            
            cellNumber = (int)sourcerray.count/2;
        }
        else
        {
            cellNumber = (int)sourcerray.count/2+1;
        }
        
        return cellNumber;
    }
    else if (tableView.tag==1)
    {
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:1];
        int cellNumber;
        if (sourcerray.count%2==0) {
            
            cellNumber = (int)sourcerray.count/2;
        }
        else
        {
            cellNumber = (int)sourcerray.count/2+1;
        }
        
        return cellNumber;
        
    }
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  200*BiLiWidth;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"FuQiJiaoHomeCellCell"] ;
    FuQiJiaoHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[FuQiJiaoHomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView.tag==0) {
        
        NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:0];
        if ((indexPath.row+1)*2<=sourceArray.count) {
            
            [cell initData:[sourceArray objectAtIndex:indexPath.row*2] info2:[sourceArray objectAtIndex:indexPath.row*2+1]];
        }
        else
        {
            [cell initData:[sourceArray objectAtIndex:indexPath.row*2] info2:nil];
        }


    }
    else if(tableView.tag==1)
    {
        NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:1];
        if ((indexPath.row+1)*2<=sourceArray.count) {
            
            [cell initData:[sourceArray objectAtIndex:indexPath.row*2] info2:[sourceArray objectAtIndex:indexPath.row*2+1]];
        }
        else
        {
            [cell initData:[sourceArray objectAtIndex:indexPath.row*2] info2:nil];
        }

    }
    return cell;
}

#pragma mark -- 分类buttonclick
-(void)listTopButtonClick:(UIButton *)selectButton
{
    [self.contentScrollView setContentOffset:CGPointMake(selectButton.tag*WIDTH_PingMu, 0) animated:YES];
    
    float originx = 13*BiLiWidth;
    CGSize size;
    
    for (int i=0; i<self.listButtonArray.count; i++) {
        
        UIButton * button = [self.listButtonArray objectAtIndex:i];
        if (button.tag==selectButton.tag) {
            
            size  = [NormalUse setSize:button.titleLabel.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:18*BiLiWidth];
            button.frame  = CGRectMake(originx,self.pageControl.top+self.pageControl.height+27.5*BiLiWidth, size.width, 18*BiLiWidth);
            button.titleLabel.font = [UIFont systemFontOfSize:18*BiLiWidth];
            
            [UIView animateWithDuration:0.5 animations:^{
                self.sliderView.left = button.left+(button.width-self.sliderView.width)/2;
            }];

            
        }
        else
        {
            size  = [NormalUse setSize:button.titleLabel.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:14*BiLiWidth];
            button.frame  = CGRectMake(originx, self.pageControl.top+self.pageControl.height+32.5*BiLiWidth, size.width, 14*BiLiWidth);
            button.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        }
        
        originx = button.left+button.width+11.5*BiLiWidth;
        
        
    }
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
    
    return self.bannerArray.count;
}

- (UIView *)flowView:(WSPageView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    WSIndexBanner *bannerView = (WSIndexBanner *)[flowView dequeueReusableCell];
    if (!bannerView)
    {
        bannerView = [[WSIndexBanner alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu-60*BiLiWidth, 100*BiLiWidth)];
    }
    NSDictionary * info = [self.bannerArray objectAtIndex:index];
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_REQUESTURL,[info objectForKey:@"picture"]]]];
    
    return bannerView;
    
}


@end
