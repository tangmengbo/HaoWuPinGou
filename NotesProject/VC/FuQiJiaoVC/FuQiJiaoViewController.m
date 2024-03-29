//
//  FuQiJiaoViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "FuQiJiaoViewController.h"
#import "FuQiJiaoHomeCell.h"
#import "FuQiJiaoWeiRenZhengFaTieVC.h"
#import "FuQiJiaoRehnZhengNewViewController.h"

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

@property(nonatomic,strong)UIView * fuQiJiaoFaTieRenZhengView;

@end

@implementation FuQiJiaoViewController

-(UIView *)fuQiJiaoFaTieRenZhengView
{
    if (!_fuQiJiaoFaTieRenZhengView) {
        
        _fuQiJiaoFaTieRenZhengView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _fuQiJiaoFaTieRenZhengView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [[UIApplication sharedApplication].keyWindow addSubview:_fuQiJiaoFaTieRenZhengView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-274*BiLiWidth)/2, 287*BiLiWidth, 274*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [_fuQiJiaoFaTieRenZhengView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [_fuQiJiaoFaTieRenZhengView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33.5*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"提示";
        [kuangImageView addSubview:tipLable1];
        
        UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 80*BiLiWidth)];
        tipLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
        tipLable2.textColor = RGBFormUIColor(0x343434);
        tipLable2.numberOfLines = 4;
        tipLable2.text = @"您当前是未认证用户，发布的信息不会得到官方认证且不享有任何官方特权，如需享有官方特权和扶持请尽快认证滴滴约";
        [kuangImageView addSubview:tipLable2];
        
        
        UIButton * faTieButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-85.5*BiLiWidth-11.5*BiLiWidth-115*BiLiWidth)/2, tipLable2.top+tipLable2.height+25*BiLiWidth, 85.5*BiLiWidth, 40*BiLiWidth)];
        [faTieButton setTitle:@"继续发帖" forState:UIControlStateNormal];
        faTieButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
        faTieButton.layer.cornerRadius = 20*BiLiWidth;
        [faTieButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        faTieButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [faTieButton addTarget:self action:@selector(faTieButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:faTieButton];

        UIButton * renZhengButton = [[UIButton alloc] initWithFrame:CGRectMake(faTieButton.left+faTieButton.width+11.5*BiLiWidth, faTieButton.top, 115*BiLiWidth, 40*BiLiWidth)];
        [renZhengButton addTarget:self action:@selector(quRenZheng) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:renZhengButton];
        
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = renZhengButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [renZhengButton.layer addSublayer:gradientLayer1];
        
        UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, renZhengButton.width, renZhengButton.height)];
        sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        sureLable.text = @"去认证";
        sureLable.textAlignment = NSTextAlignmentCenter;
        sureLable.textColor = [UIColor whiteColor];
        [renZhengButton addSubview:sureLable];
        

        

    }
    return _fuQiJiaoFaTieRenZhengView;
}
-(void)closeTipKuangView
{
    self.fuQiJiaoFaTieRenZhengView.hidden = YES;
}
-(void)faTieButtonClick
{
    self.fuQiJiaoFaTieRenZhengView.hidden = YES;

    FuQiJiaoWeiRenZhengFaTieVC * vc = [[FuQiJiaoWeiRenZhengFaTieVC alloc] init];
    vc.auth_couple = self.auth_couple;
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)quRenZheng
{
    self.fuQiJiaoFaTieRenZhengView.hidden = YES;

    if (self.auth_couple.intValue==0) {//未认证
        
        FuQiJiaoRenZhengStep1VC * vc = [[FuQiJiaoRenZhengStep1VC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (self.auth_couple.intValue==1)//已认证
    {
        
    }
    else if(self.auth_couple.intValue==2)//审核中
    {
        FuQiJiaoRenZhengStep4VC * vc = [[FuQiJiaoRenZhengStep4VC alloc] init];
        vc.alsoShowBackButton = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }

}

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
                        
                        [self.liJiRenZhengButton setTitle:@"发布信息" forState:UIControlStateNormal];
                    }
                    else
                    {
                        [self.liJiRenZhengButton setTitle:@"立即认证" forState:UIControlStateNormal];

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
    
    self.liJiRenZhengButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-72*BiLiWidth-12*BiLiWidth, (self.topNavView.height-24*BiLiWidth)/2, 72*BiLiWidth, 24*BiLiWidth)];
    self.liJiRenZhengButton.layer.cornerRadius = 12*BiLiWidth;
    self.liJiRenZhengButton.layer.borderWidth = 1;
    self.liJiRenZhengButton.layer.borderColor = [RGBFormUIColor(0xFF6C6C) CGColor];
    self.liJiRenZhengButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.liJiRenZhengButton setTitleColor:RGBFormUIColor(0xFF6C6C) forState:UIControlStateNormal];
    [self.liJiRenZhengButton addTarget:self action:@selector(liJiRenZhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
    
    [HTTPModel getFuQiJiaoList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"page",@"time",@"order", nil]
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

            int cellNumber;
            if (sourceArray.count%2==0) {
                
                cellNumber = (int)sourceArray.count/2;
            }
            else
            {
                cellNumber = (int)sourceArray.count/2+1;
            }
            tableView.height = cellNumber*200*BiLiWidth;

            if (index==0) {
                [self setTableViewHeightAndScollViewContentSize:tableView];
            }
        }
        
    }];
}
-(void)firstGetRenMenTuiJianList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
    
    [HTTPModel getFuQiJiaoList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"page",@"hot",@"order", nil]
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

            int cellNumber;
            if (sourceArray.count%2==0) {
                
                cellNumber = (int)sourceArray.count/2;
            }
            else
            {
                cellNumber = (int)sourceArray.count/2+1;
            }
            tableView.height = cellNumber*200*BiLiWidth;

            if (index==1) {
                
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

        [HTTPModel getFuQiJiaoList:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue],@"page",@"time",@"order", nil]
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

                int cellNumber;
                if (sourceArray.count%2==0) {
                    
                    cellNumber = (int)sourceArray.count/2;
                }
                else
                {
                    cellNumber = (int)sourceArray.count/2+1;
                }
                tableView.height = cellNumber*200*BiLiWidth;

                if (index==0) {
                    
                    [self setTableViewHeightAndScollViewContentSize:tableView];

                }

                
            }
            
        }];

        
    }
    else if(index==1)
    {
        
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:1];
        [HTTPModel getFuQiJiaoList:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue],@"page",@"hot",@"order", nil]
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
                int cellNumber;
                if (sourceArray.count%2==0) {
                    
                    cellNumber = (int)sourceArray.count/2;
                }
                else
                {
                    cellNumber = (int)sourceArray.count/2+1;
                }
                tableView.height = cellNumber*200*BiLiWidth;
                if (index==1) {
                    
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
    if (self.auth_couple.intValue==1) {
        
        FuQiJiaoWeiRenZhengFaTieVC * vc = [[FuQiJiaoWeiRenZhengFaTieVC alloc] init];
        vc.auth_couple = self.auth_couple;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        self.fuQiJiaoFaTieRenZhengView.hidden = NO;
    }
//    if (self.auth_couple.intValue==0) {
//
//        FuQiJiaoRenZhengStep1VC * vc = [[FuQiJiaoRenZhengStep1VC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
//    else
//    {
//        FuQiJiaoRenZhengStep4VC * vc = [[FuQiJiaoRenZhengStep4VC alloc] init];
//        vc.alsoShowBackButton = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
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
          //[bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_REQUESTURL,[info objectForKey:@"picture"]]]];
        [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_REQUESTURL,[info objectForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"banner_kong"]];

    return bannerView;
}


@end
