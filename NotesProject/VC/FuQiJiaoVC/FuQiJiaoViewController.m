//
//  FuQiJiaoViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "FuQiJiaoViewController.h"
#import "FuQiJiaoHomeCell.h"

@interface FuQiJiaoViewController ()<UITableViewDelegate,UITableViewDataSource,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
{
}

@property(nonatomic,strong,nullable)NewPagedFlowView *pageView;
@property(nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)NSArray * bannerArray;

@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)UIScrollView * contentScrollView;

@property(nonatomic,strong)UIView * buttonItemView;
@property(nonatomic,strong)NSMutableArray * listButtonArray;
@property(nonatomic,strong)UIView * sliderView;


@property(nonatomic,strong)NSMutableArray * tableViewArray;//存放tableview
@property(nonatomic,strong)NSMutableArray * pageIndexArray;//存放pageindex
@property(nonatomic,strong)NSMutableArray * dataSourceArray;//存放数据源


@property(nonatomic,strong)UIButton * liJiRenZhengButton;

@property(nonatomic,strong)NSNumber * auth_couple;//夫妻交认证状态

@property(nonatomic,assign)CGFloat  lastcontentOffset;


@end

@implementation FuQiJiaoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self xianShiTabBar];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

    
    //获取当前用户角色
    if ([NormalUse isValidString:[NormalUse defaultsGetObjectKey:LoginToken]]) {
        
        [HTTPModel getUserRole:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if(status==1)
            {
                //0 未认证 1 已认证 2 审核中
                //"auth_nomal":0,//茶馆儿认证：无
                //auth_agent":1,//经纪人认证：有
                //auth_goddess":1,//女神认证：有
                //auth_global":0,//全球陪玩:无
                //auth_peripheral":0//外围认证：无
                //auth_couple  :夫妻交认证
                
                NSDictionary * info = responseObject;
                
                self.auth_couple = [info objectForKey:@"auth_couple"];
                if ([self.auth_couple isKindOfClass:[NSNumber class]]) {
                    
                    if (self.auth_couple.intValue==1) {
                        
                        self.liJiRenZhengButton.hidden = YES;
                    }
                    else
                    {
                        self.liJiRenZhengButton.hidden = NO;

                    }
                }
                
            }
        }];

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView.hidden = YES;
    self.lineView.hidden = YES;
    
    self.topTitleLale.text = @"夫妻交友";
    
    self.liJiRenZhengButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-72*BiLiWidth-12*BiLiWidth, 0, 72*BiLiWidth, self.topNavView.height)];
    [self.liJiRenZhengButton setImage:[UIImage imageNamed:@"fuQiJiaoR_renZheng"] forState:UIControlStateNormal];
    [self.liJiRenZhengButton addTarget:self action:@selector(liJiRenZhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.liJiRenZhengButton.hidden = YES;
    [self.topNavView addSubview:self.liJiRenZhengButton];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height+BottomHeight_PingMu))];
    self.mainScrollView.tag = 1002;
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mainScrollView.mj_header = mjHeader;
    
    
    MJRefreshBackNormalFooter * mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreList)];
    self.mainScrollView.mj_footer = mjFooter;

    
    [HTTPModel getBannerList:[[NSDictionary alloc]initWithObjectsAndKeys:@"3",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.bannerArray = responseObject;
            
            if([NormalUse isValidArray:self.bannerArray])
            {
                self.pageControl.numberOfPages = self.bannerArray.count;

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

            }
                

        }
    }];

    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, 146*BiLiWidth+8*BiLiWidth, 200*BiLiWidth, 10*BiLiWidth)];
    self.pageControl.currentPage = 0;      //设置当前页指示点
    self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
    self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
    self.pageControl.numberOfPages = self.bannerArray.count;
    [self.mainScrollView addSubview:self.pageControl];
    
    self.buttonItemView = [[UIView alloc] initWithFrame:CGRectMake(0, self.pageControl.top+self.pageControl.height+10*BiLiWidth, WIDTH_PingMu, 40*BiLiWidth)];
    [self.buttonItemView setBackgroundColor:[UIColor whiteColor]];
    [self.mainScrollView addSubview:self.buttonItemView];
    
    self.listButtonArray = [NSMutableArray array];
    NSArray * array = [[NSArray alloc] initWithObjects:@"最新上传",@"热门推荐", nil];
    float originx = 13*BiLiWidth;
    CGSize size;
    for (int i=0; i<array.count; i++) {
        
        UIButton * button;
        if (i==0) {
            
            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:18*BiLiWidth];
            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx,0, size.width, 40*BiLiWidth)];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18*BiLiWidth];


        }
        else
        {
            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:18*BiLiWidth];
            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx, 0, size.width, 40*BiLiWidth)];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];


        }
        button.tag = i;
        [button addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonItemView addSubview:button];
        originx = button.left+button.width+11.5*BiLiWidth;
        
        [self.listButtonArray addObject:button];
    }
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(19.5*BiLiWidth,self.buttonItemView.height-15*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
    self.sliderView.layer.cornerRadius = 7*BiLiWidth/2;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.alpha = 0.8;
    [self.buttonItemView addSubview:self.sliderView];
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
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.buttonItemView.top+self.buttonItemView.height+20*BiLiWidth, WIDTH_PingMu, self.mainScrollView.height-(self.buttonItemView.top+self.buttonItemView.height+20*BiLiWidth))];
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.tag = 1001;
    self.contentScrollView.delegate = self;
    [self.contentScrollView setContentSize:CGSizeMake(WIDTH_PingMu*2, 0)];
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    [self.mainScrollView addSubview:self.contentScrollView];
    
    
    self.pageIndexArray = [NSMutableArray array];
    self.tableViewArray = [NSMutableArray array];
    self.dataSourceArray = [NSMutableArray array];
    
    for (int i=0; i<array.count; i++) {
        
        NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
        [self.pageIndexArray addObject:pageIndexNumber];
        
        NSMutableArray * sourceArray = [[NSMutableArray alloc] init];
        [self.dataSourceArray addObject:sourceArray];
        
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*i, 0, WIDTH_PingMu, self.contentScrollView.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = NO;
        [self.contentScrollView addSubview:tableView];
        
        [self.tableViewArray addObject:tableView];
        
    }
    [self firstGetZuiXinShangChuanList];
    [self firstGetRenMenTuiJianList];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationChangeLoadNewLsit) name:@"cityChangeReloadMessageNotification" object:nil];


}
-(void)locationChangeLoadNewLsit
{
    [self firstGetZuiXinShangChuanList];
    [self firstGetRenMenTuiJianList];

}
-(void)firstGetZuiXinShangChuanList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
    
    [HTTPModel getFuQiJiaoList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"apge",@"time",@"order", nil]
                   callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [self.mainScrollView.mj_header endRefreshing];

        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:0 withObject:pageIndexNumber];
            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];

            [self.dataSourceArray replaceObjectAtIndex:0 withObject:sourceArray];
            
            if (dataArray.count>=10) {
                
                [self.mainScrollView.mj_footer endRefreshing];
            }
            else
            {
                [self.mainScrollView.mj_footer endRefreshingWithNoMoreData];
            }
            
            UITableView * tableView = [self.tableViewArray objectAtIndex:0];
            [tableView reloadData];
            
            int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;

            if (index==0) {
                
                int cellNumber;
                if (sourceArray.count%2==0) {
                    
                    cellNumber = (int)sourceArray.count/2;
                }
                else
                {
                    cellNumber = (int)sourceArray.count/2+1;
                }
                tableView.height = cellNumber*200*BiLiWidth;
                [self setTableViewHeightAndScollViewContentSize:tableView];

            }

            
            
        }
        
    }];
}
-(void)firstGetRenMenTuiJianList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
    
    [HTTPModel getFuQiJiaoList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"apge",@"hot",@"order", nil]
                 callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [self.mainScrollView.mj_header endRefreshing];

        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];

            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:1 withObject:sourceArray];

            if (dataArray.count>=10) {
                
                [self.mainScrollView.mj_footer endRefreshing];
            }
            else
            {
                [self.mainScrollView.mj_footer endRefreshingWithNoMoreData];
            }

            UITableView * tableView = [self.tableViewArray objectAtIndex:1];
            [tableView reloadData];
            
            int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;

            if (index==1) {
                
                int cellNumber;
                if (sourceArray.count%2==0) {
                    
                    cellNumber = (int)sourceArray.count/2;
                }
                else
                {
                    cellNumber = (int)sourceArray.count/2+1;
                }
                tableView.height = cellNumber*200*BiLiWidth;
                [self setTableViewHeightAndScollViewContentSize:tableView];

            }


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

                if (dataArray.count>=10) {
                    
                    [self.mainScrollView.mj_footer endRefreshing];
                }
                else
                {
                    [self.mainScrollView.mj_footer endRefreshingWithNoMoreData];
                }
                
                UITableView * tableView = [self.tableViewArray objectAtIndex:0];
                [tableView reloadData];

                int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;

                if (index==0) {
                    
                    int cellNumber;
                    if (sourceArray.count%2==0) {
                        
                        cellNumber = (int)sourceArray.count/2;
                    }
                    else
                    {
                        cellNumber = (int)sourceArray.count/2+1;
                    }
                    tableView.height = cellNumber*200*BiLiWidth;
                    [self setTableViewHeightAndScollViewContentSize:tableView];

                }

                
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

                if (dataArray.count>=10) {
                    
                    [self.mainScrollView.mj_footer endRefreshing];
                }
                else
                {
                    [self.mainScrollView.mj_footer endRefreshingWithNoMoreData];
                }
                
                UITableView * tableView = [self.tableViewArray objectAtIndex:1];
                [tableView reloadData];
                
                int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;

                if (index==1) {
                    
                    int cellNumber;
                    if (sourceArray.count%2==0) {
                        
                        cellNumber = (int)sourceArray.count/2;
                    }
                    else
                    {
                        cellNumber = (int)sourceArray.count/2+1;
                    }
                    tableView.height = cellNumber*200*BiLiWidth;
                    [self setTableViewHeightAndScollViewContentSize:tableView];

                }

            }
            
        }];



    }
    
}
-(void)setTableViewHeightAndScollViewContentSize:(UITableView *)tableView
{
    self.contentScrollView.height = tableView.height+tableView.top;
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.contentScrollView.top+self.contentScrollView.height)];
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
            if (scrollView.contentOffset.y>=146*BiLiWidth+28*BiLiWidth) {
                
                self.buttonItemView.top = self.topNavView.top+self.topNavView.height;
                [self.view addSubview:self.buttonItemView];
            }
            
        }
        //NSLog(@"下拉行为");
        if (offset < 0 && distanceFromBottom > hight) {
            
            //如果mainScrollview下滑到 buttonItemView的位置 则把buttonItemView添加到scrollview上(让buttonItemView和scrollview一起滚动)
            
            if (scrollView.contentOffset.y<=146*BiLiWidth+28*BiLiWidth) {
                
                self.buttonItemView.top = self.pageControl.top+self.pageControl.height+10*BiLiWidth;
                [self.mainScrollView addSubview:self.buttonItemView];
                
                
            }
            
            
        }
        
    }
    
    
}
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
   // cell.auth_vip = 
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
#pragma mark--认证按钮点击

-(void)liJiRenZhengButtonClick
{
    if (self.auth_couple.intValue==0) {
        
        FuQiJiaoRenZhengStep1VC * vc = [[FuQiJiaoRenZhengStep1VC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else
    {
        FuQiJiaoRenZhengStep4VC * vc = [[FuQiJiaoRenZhengStep4VC alloc] init];
        vc.alsoShowBackButton = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }
}
#pragma mark -- 分类buttonclick
-(void)listTopButtonClick:(UIButton *)selectButton
{
    [self.contentScrollView setContentOffset:CGPointMake(selectButton.tag*WIDTH_PingMu, 0) animated:YES];
    
    UITableView * tableView = [self.tableViewArray objectAtIndex:selectButton.tag];
    [self setTableViewHeightAndScollViewContentSize:tableView];
    
    if (tableView.height<self.mainScrollView.height) {
        
        self.buttonItemView.top = self.pageControl.top+self.pageControl.height+10*BiLiWidth;
        [self.mainScrollView addSubview:self.buttonItemView];
    }
    
    for (int i=0; i<self.listButtonArray.count; i++) {
        
        UIButton * button = [self.listButtonArray objectAtIndex:i];
        if (button.tag==selectButton.tag) {
        
            button.titleLabel.font = [UIFont systemFontOfSize:18*BiLiWidth];

            [UIView animateWithDuration:0.5 animations:^{
                
                self.sliderView.left = button.left+(button.width-self.sliderView.width)/2;

            }];

            
        }
        else
        {
            button.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        }
        
    }
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    
    return CGSizeMake(WIDTH_PingMu-60*BiLiWidth,flowView.frame.size.height);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    if (subIndex==-1) {
        subIndex = subIndex+1;
    }
    NSDictionary * info = [self.bannerArray objectAtIndex:subIndex];
    if ([NormalUse isValidString:[info objectForKey:@"url"]]) {
        
        WKWebViewController * vc = [[WKWebViewController alloc] init];
        vc.titleStr = [info objectForKey:@"title"];
        vc.url = [info objectForKey:@"url"];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    self.pageControl.currentPage = pageNumber;
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
