//
//  HomeViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<WSPageViewDelegate,WSPageViewDataSource,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSArray * bannerArray;

@property(nonatomic,strong)NSMutableArray * vipFuncationArray;
@property(nonatomic,strong,nullable)WSPageView *pageView;
@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)UILabel * locationLable;

@property(nonatomic,strong)Lable_ImageButton * dingZhi;

@property(nonatomic,strong)UIView * itemButtonContentView;
@property(nonatomic,assign)CGFloat  lastcontentOffset;


@property(nonatomic,assign)CGFloat  tableView1LastContentOffset;
@property(nonatomic,assign)CGFloat  tableView2LastContentOffset;
@property(nonatomic,assign)CGFloat  tableView3LastContentOffset;
@property(nonatomic,assign)CGFloat  tableView4LastContentOffset;




@property(nonatomic,strong)NSMutableArray * listButtonArray;

@property(nonatomic,strong)NSMutableArray * tableViewArray;//存放tableview
@property(nonatomic,strong)NSMutableArray * pageIndexArray;//存放pageindex
@property(nonatomic,strong)NSMutableArray * dataSourceArray;//存放数据源


@property(nonatomic,strong)UIScrollView * contentScrollView;


@end

@implementation HomeViewController

-(UIView *)chaXiaoErFaTieRenZhengView
{
    if (!_chaXiaoErFaTieRenZhengView) {
        
        
        _chaXiaoErFaTieRenZhengView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu-BottomHeight_PingMu)];
        _chaXiaoErFaTieRenZhengView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self.view addSubview:_chaXiaoErFaTieRenZhengView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeChaXiaoErFaTieRenZhengView)];
        [_chaXiaoErFaTieRenZhengView addGestureRecognizer:tap];
        
        UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, _chaXiaoErFaTieRenZhengView.height-200*BiLiWidth, WIDTH_PingMu, 200*BiLiWidth)];
        contentView.backgroundColor = [UIColor whiteColor];
        [_chaXiaoErFaTieRenZhengView addSubview:contentView];

        
        UIButton * renZhengButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-100*BiLiWidth)/3, 150*BiLiWidth/2, 50*BiLiWidth, 50*BiLiWidth)];
        [renZhengButton setTitle:@"认证茶小二" forState:UIControlStateNormal];
        [renZhengButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        renZhengButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        [renZhengButton addTarget:self action:@selector(chaXiaoErRenZheng) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:renZhengButton];
        
        UIButton * faTieButton = [[UIButton alloc] initWithFrame:CGRectMake(renZhengButton.left+renZhengButton.width+(WIDTH_PingMu-100*BiLiWidth)/3, 150*BiLiWidth/2, 50*BiLiWidth, 50*BiLiWidth)];
        [faTieButton setTitle:@"发布帖子" forState:UIControlStateNormal];
        [faTieButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        faTieButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        [faTieButton addTarget:self action:@selector(faTieButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:faTieButton];

    }
    return _chaXiaoErFaTieRenZhengView;
}
-(void)removeChaXiaoErFaTieRenZhengView
{
    self.chaXiaoErFaTieRenZhengView.hidden = YES;
}
-(void)chaXiaoErRenZheng
{
    NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
    NSString * defaultsKey = [UserRole stringByAppendingString:token];
    NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
    NSNumber * auth_nomal = [userRoleDic objectForKey:@"auth_nomal"];
    
    if ([auth_nomal isKindOfClass:[NSNumber class]]) {
        
        if (auth_nomal.intValue==0) {
            
            JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
            vc.renZhengType = @"1";
            [self.navigationController pushViewController:vc animated:YES];

        }
        else if (auth_nomal.intValue==2)
        {
            JingJiRenRenZhengStep3VC * vc = [[JingJiRenRenZhengStep3VC alloc] init];
            vc.alsoShowBackButton = YES;
            [self.navigationController pushViewController:vc animated:YES];

        }
    }
    self.chaXiaoErFaTieRenZhengView.hidden = YES;


}
-(void)faTieButtonClick
{
    
    CreateTieZiViewController * vc = [[CreateTieZiViewController alloc] init];
    vc.from_flg = @"0";
    [self.navigationController pushViewController:vc animated:YES];
    self.chaXiaoErFaTieRenZhengView.hidden = YES;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self xianShiTabBar];
    
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
                
                NSDictionary * info = responseObject;

                NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
                NSString * defaultsKey = [UserRole stringByAppendingString:token];
                
                NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
                
                if ([NormalUse isValidDictionary:userRoleDic]) {
                    
                    if (![info isEqual:userRoleDic]) {
                        
                        [NormalUse defaultsSetObject:info forKey:defaultsKey];
                    }
                }
                else
                {
                    [NormalUse defaultsSetObject:info forKey:defaultsKey];
                }
            }
        }];
        
    }
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.height+self.topNavView.top, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.height+self.topNavView.top+BottomHeight_PingMu))];
    self.mainScrollView.delegate = self;
    self.mainScrollView.tag = 1002;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];

    
    [HTTPModel getBannerList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.bannerArray = responseObject;
            [self initContentView];

        }
    }];
    
//    [HTTPModel login:[[NSDictionary alloc]initWithObjectsAndKeys:@"18740118239",@"mobile",@"123456",@"password", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
//        
//        if (status==1) {
//            
//            NSString *  logintoken = [responseObject objectForKey:@"logintoken"];
//            [NormalUse defaultsSetObject:logintoken forKey:LoginToken];
//            
//        }
//    }];

        
    self.backImageView.hidden = YES;
    self.lineView.hidden = YES;
    
    
    UIImageView * locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16*BiLiWidth, (self.topNavView.height-14*BiLiWidth)/2, 11*BiLiWidth, 14*BiLiWidth)];
    locationImageView.image = [UIImage imageNamed:@"home_location"];
    [self.topNavView addSubview:locationImageView];
    
    self.locationLable = [[UILabel alloc] initWithFrame:CGRectMake(locationImageView.left+locationImageView.width+5*BiLiWidth, locationImageView.top, 50*BiLiWidth, locationImageView.height)];
    self.locationLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.locationLable.adjustsFontSizeToFitWidth = YES;
    self.locationLable.textColor = RGBFormUIColor(0x333333);
    [self.topNavView addSubview:self.locationLable];
    
    [HTTPModel getCurrentCity:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        self.locationLable.text = [responseObject objectForKey:@"cityName"];
        [NormalUse defaultsSetObject:[responseObject objectForKey:@"cityName"] forKey:CurrentCity];
    }];

}
-(void)initContentView
{
    
    self.pageView = [[WSPageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 147*BiLiWidth)];
    self.pageView.currentWidth = 305;
    self.pageView.currentHeight = 147;
    self.pageView.normalHeight = 134;
    self.pageView.delegate = self;
    self.pageView.dataSource = self;
    self.pageView.minimumPageAlpha = 1;   //非当前页的透明比例
    self.pageView.minimumPageScale = 0.8;  //非当前页的缩放比例
    self.pageView.orginPageCount = self.vipFuncationArray.count; //原始页数
    self.pageView.autoTime = 4;    //自动切换视图的时间,默认是5.0
    [self.mainScrollView addSubview:self.pageView] ;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, self.pageView.top+self.pageView.height+8*BiLiWidth, 200*BiLiWidth, 10*BiLiWidth)];
    self.pageControl.currentPage = 0;      //设置当前页指示点
    self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
    self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
    self.pageControl.numberOfPages = self.bannerArray.count;
    [self.mainScrollView addSubview:self.pageControl];
    
    Lable_ImageButton * tiYanBaoGao = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(13.5*BiLiWidth, self.pageControl.top+self.pageControl.height+5*BiLiWidth, 69.5*BiLiWidth, 76.5*BiLiWidth)];
    [tiYanBaoGao addTarget:self action:@selector(tiYanBaoGaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    tiYanBaoGao.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    tiYanBaoGao.button_imageView.image = [UIImage imageNamed:@"home_tiYan"];
    tiYanBaoGao.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    tiYanBaoGao.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    tiYanBaoGao.button_lable.textColor = RGBFormUIColor(0x333333);
    tiYanBaoGao.button_lable.textAlignment = NSTextAlignmentCenter;
    tiYanBaoGao.button_lable.text = @"体验报告";
    [self.mainScrollView addSubview:tiYanBaoGao];
    
    Lable_ImageButton * fangLei = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(tiYanBaoGao.left+tiYanBaoGao.width+16.5*BiLiWidth, tiYanBaoGao.top, tiYanBaoGao.width, tiYanBaoGao.height)];
    [fangLei addTarget:self action:@selector(fangLeiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    fangLei.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    fangLei.button_imageView.image = [UIImage imageNamed:@"home_dangLei"];
    fangLei.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    fangLei.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    fangLei.button_lable.textColor = RGBFormUIColor(0x333333);
    fangLei.button_lable.textAlignment = NSTextAlignmentCenter;
    fangLei.button_lable.text = @"防雷防骗";
    [self.mainScrollView addSubview:fangLei];

    
    Lable_ImageButton * heiDian = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(fangLei.left+fangLei.width+16.5*BiLiWidth, tiYanBaoGao.top, tiYanBaoGao.width, tiYanBaoGao.height)];
    [heiDian addTarget:self action:@selector(heiDianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    heiDian.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    heiDian.button_imageView.image = [UIImage imageNamed:@"home_heiDian"];
    heiDian.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    heiDian.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    heiDian.button_lable.textColor = RGBFormUIColor(0x333333);
    heiDian.button_lable.textAlignment = NSTextAlignmentCenter;
    heiDian.button_lable.text = @"黑店曝光";
    [self.mainScrollView addSubview:heiDian];

    
    self.dingZhi = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(heiDian.left+heiDian.width+16.5*BiLiWidth, tiYanBaoGao.top, tiYanBaoGao.width, tiYanBaoGao.height)];
    [self.dingZhi addTarget:self action:@selector(dingZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.dingZhi.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    self.dingZhi.button_imageView.image = [UIImage imageNamed:@"home_dingZhi"];
    self.dingZhi.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    self.dingZhi.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.dingZhi.button_lable.textColor = RGBFormUIColor(0x333333);
    self.dingZhi.button_lable.textAlignment = NSTextAlignmentCenter;
    self.dingZhi.button_lable.text = @"定制服务";
    [self.mainScrollView addSubview:self.dingZhi];

    self.itemButtonContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.dingZhi.top+self.dingZhi.height+17.5*BiLiWidth, WIDTH_PingMu, 37*BiLiWidth)];
    self.itemButtonContentView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.itemButtonContentView];
    
    self.listButtonArray = [NSMutableArray array];
    NSArray * array = [[NSArray alloc] initWithObjects:@"最新上传",@"红榜推荐",@"验证榜单",@"验车报告", nil];
    float originx = 13*BiLiWidth;
    CGSize size;
    for (int i=0; i<array.count; i++) {
        
        UIButton * button;
        if (i==0) {
            
            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:17*BiLiWidth];
            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx,10*BiLiWidth, size.width, 17*BiLiWidth)];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17*BiLiWidth];


        }
        else
        {
            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx, 15*BiLiWidth, size.width, 12*BiLiWidth)];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];


        }
        button.tag = i;
        [button addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemButtonContentView addSubview:button];
        originx = button.left+button.width+11.5*BiLiWidth;
        
        [self.listButtonArray addObject:button];
        

    }
    
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(19.5*BiLiWidth,22.5*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
    self.sliderView.layer.cornerRadius = 7*BiLiWidth/2;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.alpha = 0.8;
    [self.itemButtonContentView addSubview:self.sliderView];
    
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

    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.dingZhi.top+self.dingZhi.height+64.5*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(self.dingZhi.top+self.dingZhi.height+64.5*BiLiWidth+BottomHeight_PingMu))];
    [self.contentScrollView setContentSize:CGSizeMake(WIDTH_PingMu*array.count, self.contentScrollView.height)];
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.tag = 1001;
    self.contentScrollView.delegate = self;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    [self.mainScrollView addSubview:self.contentScrollView];
    
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
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        [self.contentScrollView addSubview:tableView];
        
        [self.tableViewArray addObject:tableView];
        
        
        MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
        mjHeader.lastUpdatedTimeLabel.hidden = YES;
        tableView.mj_header = mjHeader;
        
        
        MJRefreshBackNormalFooter * mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreList)];
        tableView.mj_footer = mjFooter;
        

    }
    [self firstGetTieZiList];
    [self firstGetRedList];
    [self firstGetYanZhengBangDanList];
    [self firstGetYanCheBaoGaoList];
    
    UIButton * faTieButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-60*BiLiWidth, HEIGHT_PingMu-60*BiLiWidth-BottomHeight_PingMu, 50*BiLiWidth, 50*BiLiWidth)];
    [faTieButton setBackgroundColor:[UIColor greenColor]];
    faTieButton.layer.cornerRadius = 25*BiLiWidth;
    [faTieButton addTarget:self action:@selector(faTieOrRenZhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:faTieButton];
    
}
-(void)firstGetTieZiList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
    
    [HTTPModel getTieZiList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"page", nil]
                   callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:0 withObject:pageIndexNumber];
            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:0 withObject:sourceArray];
            
            UITableView * tableView = [self.tableViewArray objectAtIndex:0];
            [tableView.mj_header endRefreshing];
            [tableView.mj_footer endRefreshing];
            
            [tableView reloadData];
            
            tableView.scrollEnabled = NO;
            self.mainScrollView.scrollEnabled = YES;

            tableView.height = (144*BiLiWidth+17*BiLiWidth)*sourceArray.count;
            
            if (self.contentScrollView.contentOffset.x==0) {
                
                [self setMainScrollViewContentSize:tableView];
            }
        }
        
    }];
    
}
-(void)firstGetRedList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
    
    [HTTPModel getRedList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"page", nil]
                 callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];

            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:1 withObject:sourceArray];

            UITableView * tableView = [self.tableViewArray objectAtIndex:1];
            [tableView.mj_header endRefreshing];
            [tableView.mj_footer endRefreshing];
            
            tableView.scrollEnabled = NO;
            self.mainScrollView.scrollEnabled = YES;

            [tableView reloadData];
            
            tableView.height = (144*BiLiWidth+17*BiLiWidth)*sourceArray.count;

            if (self.contentScrollView.contentOffset.x==WIDTH_PingMu) {
                
                [self setMainScrollViewContentSize:tableView];
            }


        }
        
    }];

}
-(void)firstGetYanZhengBangDanList
{
    
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:2 withObject:pageIndexNumber];

    [HTTPModel getYanZhengList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:2 withObject:pageIndexNumber];

            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:2 withObject:sourceArray];
            
            
            UITableView * tableView = [self.tableViewArray objectAtIndex:2];
            [tableView.mj_header endRefreshing];
            [tableView.mj_footer endRefreshing];
            
            tableView.scrollEnabled = NO;
            self.mainScrollView.scrollEnabled = YES;

            [tableView reloadData];
            
            tableView.height = (144*BiLiWidth+17*BiLiWidth)*sourceArray.count;

            if (self.contentScrollView.contentOffset.x==WIDTH_PingMu*2) {
                
                [self setMainScrollViewContentSize:tableView];
            }


        }
        
    }];
}
-(void)firstGetYanCheBaoGaoList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:3 withObject:pageIndexNumber];
    
    [HTTPModel getYanCheBaoGaoList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:3 withObject:pageIndexNumber];

            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:3 withObject:sourceArray];

            UITableView * tableView = [self.tableViewArray objectAtIndex:3];
            [tableView.mj_header endRefreshing];
            [tableView.mj_footer endRefreshing];
            
            tableView.scrollEnabled = NO;
            self.mainScrollView.scrollEnabled = YES;

            [tableView reloadData];
            
            float tableViewHeight  = 0;
            for (NSDictionary * info in sourceArray) {
                
                tableViewHeight = tableViewHeight+[CheYouPingJiaCell cellHegiht:info];
            }
            
            tableView.height = tableViewHeight;
            
            if (self.contentScrollView.contentOffset.x==WIDTH_PingMu*3) {
                
                [self setMainScrollViewContentSize:tableView];
            }


        }

    }];
}
-(void)loadNewLsit
{
    int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;
    if (index==0) {
            
        [self firstGetTieZiList];
    }
    else if(index==1)
    {
        [self firstGetRedList];

    }
    else if(index==2)
    {
        [self firstGetYanZhengBangDanList];
    }
    else if(index==3)
    {
        [self firstGetYanCheBaoGaoList];
    }
    

}
-(void)loadMoreList
{
    int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;
    if (index==0) {
        
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:0];

        [HTTPModel getTieZiList:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue],@"page", nil]
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

                tableView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;

                [tableView reloadData];

                tableView.height = (144*BiLiWidth+17*BiLiWidth)*sourceArray.count;

                
                if (self.contentScrollView.contentOffset.x==0) {
                    
                    [self setMainScrollViewContentSize:tableView];
                }


                
            }
            
        }];

        
    }
    else if(index==1)
    {
        
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:1];
        [HTTPModel getRedList:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue],@"page", nil]
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
                tableView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;


                [tableView reloadData];
                
                tableView.height = (144*BiLiWidth+17*BiLiWidth)*sourceArray.count;

                if (self.contentScrollView.contentOffset.x==WIDTH_PingMu) {
                    
                    [self setMainScrollViewContentSize:tableView];
                }

            }
            
        }];



    }
    else if(index==2)
    {
        
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:2];
        [HTTPModel getYanZhengList:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue],@"page", nil]
                          callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:2];
                pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
                [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
                
                NSArray * dataArray = [responseObject objectForKey:@"data"];
                NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:2];
                for (NSDictionary * info in dataArray) {
                    
                    [sourceArray addObject:info];
                }
                [self.dataSourceArray replaceObjectAtIndex:2 withObject:sourceArray];
                
                UITableView * tableView = [self.tableViewArray objectAtIndex:2];
                if (dataArray.count>=10) {
                    
                    [tableView.mj_footer endRefreshing];
                }
                else
                {
                    [tableView.mj_footer endRefreshingWithNoMoreData];
                }
                tableView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;


                [tableView reloadData];
                
                tableView.height = (144*BiLiWidth+17*BiLiWidth)*sourceArray.count;
                
                if (self.contentScrollView.contentOffset.x==WIDTH_PingMu*2) {
                    
                    [self setMainScrollViewContentSize:tableView];
                }


                
            }
            
        }];


    }
    else if(index==3)
    {
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:3];
        [HTTPModel getYanCheBaoGaoList:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue],@"page", nil]
                              callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:3];
                pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
                [self.pageIndexArray replaceObjectAtIndex:3 withObject:pageIndexNumber];
                
                NSArray * dataArray = [responseObject objectForKey:@"data"];
                NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:3];
                for (NSDictionary * info in dataArray) {
                    
                    [sourceArray addObject:info];
                }
                [self.dataSourceArray replaceObjectAtIndex:3 withObject:sourceArray];
                
                UITableView * tableView = [self.tableViewArray objectAtIndex:3];
                if (dataArray.count>=10) {
                    
                    [tableView.mj_footer endRefreshing];
                }
                else
                {
                    [tableView.mj_footer endRefreshingWithNoMoreData];
                }
                tableView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;

                [tableView reloadData];
               
                
                float tableViewHeight  = 0;
                for (NSDictionary * info in sourceArray) {
                    
                    tableViewHeight = tableViewHeight+[CheYouPingJiaCell cellHegiht:info];
                }
                
                tableView.height = tableViewHeight;
                
                if (self.contentScrollView.contentOffset.x==WIDTH_PingMu*3) {
                    
                    [self setMainScrollViewContentSize:tableView];
                }


            }
            
        }];

    }

}
-(void)setMainScrollViewContentSize:(UITableView *)tableView
{
    self.contentScrollView.height = tableView.top+tableView.height;
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.contentScrollView.top+self.contentScrollView.height)];

}
#pragma mark -- 分类buttonclick
-(void)listTopButtonClick:(UIButton *)selectButton
{
    [self.contentScrollView setContentOffset:CGPointMake(selectButton.tag*WIDTH_PingMu, 0) animated:YES];
    UITableView * tableView = [self.tableViewArray objectAtIndex:selectButton.tag];
    [self setMainScrollViewContentSize:tableView];
    
    float originx = 13*BiLiWidth;
    CGSize size;
    
    for (int i=0; i<self.listButtonArray.count; i++) {
        
        UIButton * button = [self.listButtonArray objectAtIndex:i];
        if (button.tag==selectButton.tag) {
            
            size  = [NormalUse setSize:button.titleLabel.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:17*BiLiWidth];
            button.frame  = CGRectMake(originx,10*BiLiWidth, size.width, 17*BiLiWidth);
            button.titleLabel.font = [UIFont systemFontOfSize:17*BiLiWidth];
            
            [UIView animateWithDuration:0.5 animations:^{
                self.sliderView.left = button.left+(button.width-self.sliderView.width)/2;
            }];

            
        }
        else
        {
            size  = [NormalUse setSize:button.titleLabel.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
            button.frame  = CGRectMake(originx, 15*BiLiWidth, size.width, 12*BiLiWidth);
            button.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        }
        
        originx = button.left+button.width+11.5*BiLiWidth;
        
        
    }
    
//    //切换tab后第一次滑动卡顿处理
    self.mainScrollView.scrollEnabled = YES;
    for (UITableView * tableView in self.tableViewArray) {
        
        tableView.scrollEnabled = NO;
    }

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
            if (scrollView.contentOffset.y>=267*BiLiWidth) {
                
                self.itemButtonContentView.top = TopHeight_PingMu;
                [self.view addSubview:self.itemButtonContentView];
            }
            
            //如果mainScrollview滑动到最底部 让所有的tableview可以滑动(让上拉加载功能可用)
            if ((int)scrollView.contentOffset.y>=(int)scrollView.contentSize.height-(int)scrollView.height) {
                
                scrollView.scrollEnabled = NO;
                
                for (UITableView * tableView in self.tableViewArray) {
                    
                    tableView.scrollEnabled = YES;

                    
                }

            }
            else
            {
                scrollView.scrollEnabled = YES;
                for (UITableView * tableView in self.tableViewArray) {
                    
                    tableView.scrollEnabled = NO;
                }

            }
        }
        //NSLog(@"下拉行为");
        if (offset < 0 && distanceFromBottom > hight) {
            
            //如果mainScrollview下滑到 buttonItemView的位置 则把buttonItemView添加到scrollview上(让buttonItemView和scrollview一起滚动)

            if (scrollView.contentOffset.y<=267*BiLiWidth) {
                
                self.itemButtonContentView.top = self.dingZhi.top+self.dingZhi.height+17.5*BiLiWidth;
                [self.mainScrollView addSubview:self.itemButtonContentView];

                       
            }
            //如果mainScrollview下滑到最顶部 让所有的tableview可以滑动(让下拉刷新功能可用)
            if (scrollView.contentOffset.y<=0) {
                
                for (UITableView * tableView in self.tableViewArray) {
                    
                    tableView.scrollEnabled = YES;
                    
                }
            }
            else
            {
                for (UITableView * tableView in self.tableViewArray) {
                    
                    tableView.scrollEnabled = NO;
                }

            }

        }

    }
    if (scrollView.tag==0) {
        
        CGFloat hight = scrollView.frame.size.height;
        CGFloat contentOffset = scrollView.contentOffset.y;
        CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
        CGFloat offset = contentOffset - self.tableView1LastContentOffset;
        self.tableView1LastContentOffset = contentOffset;
        
        //NSLog(@"下拉行为");
        if (offset < 0 && distanceFromBottom > hight && contentOffset < 0) {
            //如果当前tableview是向下滑动的 但是mainScrollView没有向下滑动到最顶部,则让tableview本身不可滑动
            if (self.mainScrollView.contentOffset.y!=0) {
                
                scrollView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;
            }
            else
            {
                scrollView.scrollEnabled = YES;
            }
        }
        // NSLog(@"上拉行为");
        if (offset > 0 && contentOffset > 0) {
            //如果当前tableview是向上滑动的 但是mainScrollView没有向上滑动到最底部,则让tableview本身不可滑动
            if ((int)self.mainScrollView.contentOffset.y>= (int)self.mainScrollView.contentSize.height-(int)self.mainScrollView.height) {
                
                scrollView.scrollEnabled = YES;
            }
            else
            {
                scrollView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;


            }
        }


        
    }
    if (scrollView.tag==1) {
        
        CGFloat hight = scrollView.frame.size.height;
        CGFloat contentOffset = scrollView.contentOffset.y;
        CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
        CGFloat offset = contentOffset - self.tableView2LastContentOffset;
        self.tableView2LastContentOffset = contentOffset;
        
        //NSLog(@"下拉行为");
        if (offset < 0 && distanceFromBottom > hight && contentOffset < 0) {
            //如果当前tableview是向下滑动的 但是mainScrollView没有向下滑动到最顶部,则让tableview本身不可滑动
            if (self.mainScrollView.contentOffset.y!=0) {
                
                scrollView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;

            }
            else
            {
                scrollView.scrollEnabled = YES;
            }
        }
        // NSLog(@"上拉行为");
        if (offset > 0 && contentOffset > 0) {
            //如果当前tableview是向上滑动的 但是mainScrollView没有向上滑动到最底部,则让tableview本身不可滑动
            if ((int)self.mainScrollView.contentOffset.y>= (int)self.mainScrollView.contentSize.height-(int)self.mainScrollView.height) {
                
                scrollView.scrollEnabled = YES;
            }
            else
            {
                scrollView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;


            }
        }

        
    }

    if (scrollView.tag==2) {
        
        CGFloat hight = scrollView.frame.size.height;
        CGFloat contentOffset = scrollView.contentOffset.y;
        CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
        CGFloat offset = contentOffset - self.tableView3LastContentOffset;
        self.tableView3LastContentOffset = contentOffset;
        
        //NSLog(@"下拉行为");
        if (offset < 0 && distanceFromBottom > hight && contentOffset < 0) {
            //如果当前tableview是向下滑动的 但是mainScrollView没有向下滑动到最顶部,则让tableview本身不可滑动
            if (self.mainScrollView.contentOffset.y!=0) {
                
                scrollView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;

            }
            else
            {
                scrollView.scrollEnabled = YES;
            }
        }
        // NSLog(@"上拉行为");
        if (offset > 0 && contentOffset > 0) {
            //如果当前tableview是向上滑动的 但是mainScrollView没有向上滑动到最底部,则让tableview本身不可滑动
            if ((int)self.mainScrollView.contentOffset.y>= (int)self.mainScrollView.contentSize.height-(int)self.mainScrollView.height) {
                
                scrollView.scrollEnabled = YES;
            }
            else
            {
                scrollView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;


            }
        }

        
    }
    if (scrollView.tag==3) {
        
        CGFloat hight = scrollView.frame.size.height;
        CGFloat contentOffset = scrollView.contentOffset.y;
        CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
        CGFloat offset = contentOffset - self.tableView4LastContentOffset;
        self.tableView4LastContentOffset = contentOffset;
        
        //NSLog(@"下拉行为");
        if (offset < 0 && distanceFromBottom > hight && contentOffset < 0) {
            //如果当前tableview是向下滑动的 但是mainScrollView没有向下滑动到最顶部,则让tableview本身不可滑动
            if (self.mainScrollView.contentOffset.y!=0) {
                
                scrollView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;

            }
            else
            {
                scrollView.scrollEnabled = YES;
            }
        }
        // NSLog(@"上拉行为");
        if (offset > 0 && contentOffset > 0) {
            //如果当前tableview是向上滑动的 但是mainScrollView没有向上滑动到最底部,则让tableview本身不可滑动
            if ((int)self.mainScrollView.contentOffset.y>= (int)self.mainScrollView.contentSize.height-(int)self.mainScrollView.height) {
                
                scrollView.scrollEnabled = YES;
            }
            else
            {
                scrollView.scrollEnabled = NO;
                self.mainScrollView.scrollEnabled = YES;


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
    
    if (tableView.tag==3) {
        
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:3];

        return [CheYouPingJiaCell cellHegiht:[sourcerray objectAtIndex:indexPath.row]];
    }
    else
    {
        return  144*BiLiWidth+17*BiLiWidth;

    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==3) {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"CheYouPingJiaCell"] ;
        CheYouPingJiaCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[CheYouPingJiaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor clearColor];
        NSMutableArray * sourcerray;
        sourcerray = [self.dataSourceArray objectAtIndex:3];
        cell.type = @"yanCheBaoGao";
        [cell initContentView:[sourcerray objectAtIndex:indexPath.row]];
        
        return cell;

    }
    else
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"HomeListCellCell"] ;
        HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[HomeListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor clearColor];
        NSMutableArray * sourcerray;
        if (tableView.tag==0) {
            
             sourcerray = [self.dataSourceArray objectAtIndex:0];
            [cell contentViewSetData:[sourcerray objectAtIndex:indexPath.row] cellType:ZuiXinShangChuan];

        }
        else if (tableView.tag==1)
        {
            sourcerray = [self.dataSourceArray objectAtIndex:1];
            [cell contentViewSetData:[sourcerray objectAtIndex:indexPath.row] cellType:HongBangTuiJian];


        }
        else if (tableView.tag==2)
        {
            sourcerray = [self.dataSourceArray objectAtIndex:2];
            [cell contentViewSetData:[sourcerray objectAtIndex:indexPath.row] cellType:YanZhengBangDan];


        }
        return cell;

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray * sourcerray;
    if (tableView.tag==0) {
        
         sourcerray = [self.dataSourceArray objectAtIndex:0];
    }
    else if (tableView.tag==1)
    {
        sourcerray = [self.dataSourceArray objectAtIndex:1];

    }
    else if (tableView.tag==2)
    {
        sourcerray = [self.dataSourceArray objectAtIndex:2];

    }
    else
    {
        sourcerray = [self.dataSourceArray objectAtIndex:3];

    }
    NSDictionary * info = [sourcerray objectAtIndex:indexPath.row];
    TieZiDetailViewController * vc = [[TieZiDetailViewController alloc] init];
    NSNumber * idNumber = [info objectForKey:@"id"];
    if ([idNumber isKindOfClass:[NSNumber class]]) {
        
        vc.post_id = [NSString stringWithFormat:@"%d",idNumber.intValue];

    }
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark UIButtonClick

-(void)faTieOrRenZhengButtonClick
{
    NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
    NSString * defaultsKey = [UserRole stringByAppendingString:token];
    NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
    NSNumber * auth_nomal = [userRoleDic objectForKey:@"auth_nomal"];
    
    if ([auth_nomal isKindOfClass:[NSNumber class]]) {
        
        if (auth_nomal.intValue==0) {//未认证
            
            self.chaXiaoErFaTieRenZhengView.hidden = NO;
        }
        else if (auth_nomal.intValue==1)//已认证
        {
            [self faTieButtonClick];
        }
        else if (auth_nomal.intValue==2)//审核中
        {
            self.chaXiaoErFaTieRenZhengView.hidden = NO;

        }

    }
    

}
-(void)shaiXuanButtonClick
{
    CityListViewController * vc = [[CityListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
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
    
    return self.bannerArray.count;
}

- (UIView *)flowView:(WSPageView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    WSIndexBanner *bannerView = (WSIndexBanner *)[flowView dequeueReusableCell];
    if (!bannerView)
    {
        bannerView = [[WSIndexBanner alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu-60*BiLiWidth, 147*BiLiWidth)];
    }
    NSDictionary * info = [self.bannerArray objectAtIndex:index];
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_REQUESTURL,[info objectForKey:@"picture"]]]];
    return bannerView;
    
}


@end
