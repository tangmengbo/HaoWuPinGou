//
//  GaoDuanViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GaoDuanViewController.h"
#import "GaoDuanHomeCell.h"
#import "GaoDuanShaiXuanView.h"

@interface GaoDuanViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NvShenListViewController * nvShenListVC;
    WaiWeiListViewController * waiWeiVC;
    PeiWanListViewController * peiWanVC;
}

@property(nonatomic,strong)UILabel * locationLable;

@property(nonatomic,strong)NSMutableArray * listButtonArray;

@property(nonatomic,strong)UIScrollView * contentScrollView;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong,nullable)NewPagedFlowView *pageView;
@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)UIButton * pingFenButton;
@property(nonatomic,strong)UIButton * zuiXinButton;
@property(nonatomic,strong)UIButton * zuiReButton;

@property(nonatomic,strong)UIView * itemButtonContentView;
@property(nonatomic,strong)UIButton * pingFenButton1;
@property(nonatomic,strong)UIButton * zuiXinButton1;
@property(nonatomic,strong)UIButton * zuiReButton1;

@property(nonatomic,assign)CGFloat  lastcontentOffset;

@property(nonatomic,strong)NSString * zuiXinOrZuiRe;//1 最新 2 最热

@property(nonatomic,strong)NSArray * guanFangTuiJianDianPuArray;//官方推荐列表

@property(nonatomic,strong)NSMutableArray * jingJiRenListArray;//官方推荐列表

@property(nonatomic,strong)GaoDuanShaiXuanView * gaoDuanShaiXuanView;

@property(nonatomic,strong)NSString * field;
@property(nonatomic,strong)NSString * order;

@end

@implementation GaoDuanViewController

-(GaoDuanShaiXuanView *)gaoDuanShaiXuanView
{
    if (!_gaoDuanShaiXuanView) {
        
        _gaoDuanShaiXuanView = [[GaoDuanShaiXuanView alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu-240*BiLiWidth-BottomHeight_PingMu, WIDTH_PingMu, 240*BiLiWidth)];
        [[UIApplication sharedApplication].keyWindow addSubview:_gaoDuanShaiXuanView];
        
        __weak typeof(self) wself = self;
        [_gaoDuanShaiXuanView setPaiXuSelect:^(NSString * _Nonnull field, NSString * _Nonnull order) {
            
            wself.field = field;
            wself.order = order;
            [wself loadNewLsit];
        }];
    }
    return _gaoDuanShaiXuanView;
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
                //auth_couple  :夫妻交认证
                
                NSDictionary * info = responseObject;
                

                NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
                NSString * defaultsKey = [UserRole stringByAppendingString:token];

                NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
                
                if ([NormalUse isValidDictionary:userRoleDic]) {
                    
                    if (![info isEqual:userRoleDic]) {
                        
                        [NormalUse defaultsSetObject:info forKey:defaultsKey];
                        [self.mainTableView reloadData];

                    }
                    
                }
                else
                {
                    [NormalUse defaultsSetObject:info forKey:defaultsKey];
                    [self.mainTableView reloadData];
                }
            }
        }];

    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView.hidden = YES;
    self.lineView.hidden = YES;
    
    self.listButtonArray = [NSMutableArray array];
    NSArray * array = [[NSArray alloc] initWithObjects:@"经纪人",@"认证女神",@"外围空降",@"全球陪玩", nil];
    float originx = 20*BiLiWidth;
    CGSize size;
    for (int i=0; i<array.count; i++) {
        
        UIButton * button;
//        if (i==0) {
            
            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx,TopHeight_PingMu+25*BiLiWidth, size.width, 17*BiLiWidth)];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];


//        }
//        else
//        {
//            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:14*BiLiWidth];
//            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx, TopHeight_PingMu+27*BiLiWidth, size.width, 14*BiLiWidth)];
//            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
//            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
//            button.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
//
//
//        }
        if (i==0) {
            
            button.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }

        button.tag = i;
        [button addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        originx = button.left+button.width+20*BiLiWidth;
        
        [self.listButtonArray addObject:button];
    }
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(10.5*BiLiWidth,TopHeight_PingMu+37*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
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


    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TopHeight_PingMu+58*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(TopHeight_PingMu+58*BiLiWidth+BottomHeight_PingMu))];
    [self.contentScrollView setContentSize:CGSizeMake(WIDTH_PingMu*array.count, self.contentScrollView.height)];
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.tag = 1001;
    self.contentScrollView.delegate = self;
    [self.view addSubview:self.contentScrollView];

    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, self.contentScrollView.height)style:UITableViewStyleGrouped];
   self.mainTableView.delegate = self;
   self.mainTableView.dataSource = self;
   self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tag = 1002;
   [self.contentScrollView addSubview:self.mainTableView];
    
    MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mainTableView.mj_header = mjHeader;
    [self.mainTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreList)];
    self.mainTableView.mj_footer = mjFooter;

    
    nvShenListVC = [[NvShenListViewController alloc] init];
    nvShenListVC.view.frame = CGRectMake(WIDTH_PingMu, 0, WIDTH_PingMu, self.contentScrollView.height);
    [self.contentScrollView addSubview:nvShenListVC.view];
    
    waiWeiVC = [[WaiWeiListViewController alloc] init];
    waiWeiVC.view.frame = CGRectMake(WIDTH_PingMu*2, 0, WIDTH_PingMu, self.contentScrollView.height);
    [self.contentScrollView addSubview:waiWeiVC.view];

    peiWanVC = [[PeiWanListViewController alloc] init];
    peiWanVC.view.frame = CGRectMake(WIDTH_PingMu*3, 0, WIDTH_PingMu, self.contentScrollView.height);
    [self.contentScrollView addSubview:peiWanVC.view];


    self.itemButtonContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+5*BiLiWidth, WIDTH_PingMu, 14.5*BiLiWidth*2+12*BiLiWidth)];
    self.itemButtonContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.itemButtonContentView];
    
    self.zuiXinOrZuiRe = @"1";
    
    self.pingFenButton1 = [[UIButton alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 0*BiLiWidth, 50*BiLiWidth, self.itemButtonContentView.height)];
    [self.pingFenButton1 setTitle:@"评分最高" forState:UIControlStateNormal];
    [self.pingFenButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    self.pingFenButton1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.pingFenButton1 addTarget:self action:@selector(pingFenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.itemButtonContentView addSubview:self.pingFenButton1];
    
//    self.zuiXinButton1 = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton1.left+self.pingFenButton1.width+33*BiLiWidth, self.pingFenButton1.top, 33.5*BiLiWidth, 12*BiLiWidth)];
//    [self.zuiXinButton1 setTitle:@"最新" forState:UIControlStateNormal];
//    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
//    self.zuiXinButton1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
//    [self.zuiXinButton1 addTarget:self action:@selector(zuiXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.itemButtonContentView addSubview:self.zuiXinButton1];
//
//    self.zuiReButton1 = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton1.left+self.pingFenButton1.width+79*BiLiWidth, self.pingFenButton1.top, 33.5*BiLiWidth, 12*BiLiWidth)];
//    [self.zuiReButton1 setTitle:@"最热" forState:UIControlStateNormal];
//    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
//    self.zuiReButton1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
//    [self.zuiReButton1 addTarget:self action:@selector(zuiReButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.itemButtonContentView addSubview:self.zuiReButton1];

    self.itemButtonContentView.hidden = YES;
    
    [HTTPModel getBannerList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.bannerArray = responseObject;
            
            if([NormalUse isValidArray:self.bannerArray])
            {
                [self.mainTableView reloadData];

            }
                

        }
    }];
    [HTTPModel getGuanFangTuiJianDianPu:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.guanFangTuiJianDianPuArray = responseObject;
            [self.mainTableView reloadData];
            
        }
    }];

}
-(void)loadNewLsit
{
    page = 1;
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    if ([NormalUse isValidString:self.field]) {
        
        [info setObject:self.field forKey:@"field"];
    }
    if ([NormalUse isValidString:self.order]) {
        
        [info setObject:self.order forKey:@"order"];

    }

    [HTTPModel getJingJiRenList:info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self->page++;
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            self.jingJiRenListArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.mainTableView.mj_header endRefreshing];
            if (dataArray.count>=10) {
                
                [self.mainTableView.mj_footer endRefreshing];
            }
            else
            {
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }

            
            [self.mainTableView reloadData];
        }
    }];

}
-(void)loadMoreList
{
    page = 1;
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    if ([NormalUse isValidString:self.field]) {
        
        [info setObject:self.field forKey:@"field"];
    }
    if ([NormalUse isValidString:self.order]) {
        
        [info setObject:self.order forKey:@"order"];

    }


    [HTTPModel getJingJiRenList:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary * info in dataArray) {
                
                [self.jingJiRenListArray addObject:info];
            }
            if (dataArray.count>=10) {
                
                [self.mainTableView.mj_footer endRefreshing];
            }
            else
            {
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }

            [self.mainTableView reloadData];
        }
    }];

}
#pragma mark--顶部按钮点击
-(void)listTopButtonClick:(UIButton *)selectButton
{
    [self.contentScrollView setContentOffset:CGPointMake(selectButton.tag*WIDTH_PingMu, 0) animated:YES];
    for (int i=0; i<self.listButtonArray.count; i++) {
        
        UIButton * button = [self.listButtonArray objectAtIndex:i];
        if (button.tag==selectButton.tag) {
            
            [UIView animateWithDuration:0.5 animations:^{
                
                button.transform = CGAffineTransformMakeScale(1.3, 1.3);

                self.sliderView.left = button.left+(button.width-self.sliderView.width)/2;
            }];

            
        }
        else
        {
            button.transform = CGAffineTransformIdentity;

        }

        
    }
    
    if (selectButton.tag==0 && self.itemButtonContentView.tag==1) {
        
        self.itemButtonContentView.hidden = NO;
    }
    else
    {
        self.itemButtonContentView.hidden = YES;

    }
}
#pragma mark--经纪人认证 女神认证 全国空降 陪玩

-(void)jingJiRenRenZhengButtonClick:(UIButton *)button
{
    if (button.tag==0) {
        
        JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
        vc.renZhengType = @"2";
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (button.tag==1)//已认证
    {
        CreateTieZiViewController * vc = [[CreateTieZiViewController alloc] init];
        vc.from_flg = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(button.tag==2)//审核中
    {
        JingJiRenRenZhengStep3VC * vc = [[JingJiRenRenZhengStep3VC alloc] init];
        vc.alsoShowBackButton = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
-(void)nvShenRenZhengButtonClick:(UIButton *)button
{
    if (button.tag==0) {//未认证
        
        NvShenRenZhengStep1VC * vc = [[NvShenRenZhengStep1VC alloc] init];
        vc.renZhengType = @"1";
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (button.tag==1)//已认证
    {
        
    }
    else if(button.tag==2)//审核中
    {
        NvShenRenZhengStep4VC * vc = [[NvShenRenZhengStep4VC alloc] init];
        vc.alsoShowBackButton = YES;
        [self.navigationController pushViewController:vc animated:YES];
        

    }
    
}

-(void)kongJiangButtonClick:(UIButton *)button
{
    
    if (button.tag==0) {//未认证
        
        NvShenRenZhengStep1VC * vc = [[NvShenRenZhengStep1VC alloc] init];
        vc.renZhengType = @"2";
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (button.tag==1)//已认证
    {
        
    }
    else if(button.tag==2)//审核中
    {
        NvShenRenZhengStep4VC * vc = [[NvShenRenZhengStep4VC alloc] init];
        vc.alsoShowBackButton = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }


}

-(void)peiWanButtonClick:(UIButton *)button
{
    if (button.tag==0) {//未认证
        
        NvShenRenZhengStep1VC * vc = [[NvShenRenZhengStep1VC alloc] init];
        vc.renZhengType = @"3";
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (button.tag==1)//已认证
    {
        
    }
    else if(button.tag==2)//审核中
    {
        NvShenRenZhengStep4VC * vc = [[NvShenRenZhengStep4VC alloc] init];
        vc.alsoShowBackButton = YES;
        [self.navigationController pushViewController:vc animated:YES];

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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==1002) {
        
        
        CGFloat hight = scrollView.frame.size.height;
        CGFloat contentOffset = scrollView.contentOffset.y;
        CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
        CGFloat offset = contentOffset - self.lastcontentOffset;
        self.lastcontentOffset = contentOffset;

        if (offset > 0 && contentOffset > 0) {
           NSLog(@"上拉行为");
            if (scrollView.contentOffset.y>=500*BiLiWidth) {
                
                self.itemButtonContentView.hidden = NO;
                self.itemButtonContentView.tag = 1;
            }

        }
        if (offset < 0 && distanceFromBottom > hight) {
            NSLog(@"下拉行为");
            if (scrollView.contentOffset.y<=500*BiLiWidth) {
                
                
            self.itemButtonContentView.hidden = YES;
                self.itemButtonContentView.tag = 0;

                       
            }
        }

    }
  

}
#pragma mark UItableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jingJiRenListArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * info = [self.jingJiRenListArray objectAtIndex:indexPath.row];
    if ([NormalUse isValidArray:[info objectForKey:@"post_list"]]) {
        
        return  197*BiLiWidth+48*BiLiWidth+21*BiLiWidth+8*BiLiWidth;

    }
    else
    {
        return  197*BiLiWidth+48*BiLiWidth+21*BiLiWidth+8*BiLiWidth-132*BiLiWidth;

    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"GaoDuanHomeCellCell"] ;
    GaoDuanHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[GaoDuanHomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    [cell contentViewSetData:[self.jingJiRenListArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * info = [self.jingJiRenListArray objectAtIndex:indexPath.row];
    DianPuDetailViewController * vc = [[DianPuDetailViewController alloc] init];
    NSNumber * idNumber = [info objectForKey:@"id"];
    vc.dianPuId = [NSString stringWithFormat:@"%d",idNumber.intValue];
    [self.navigationController pushViewController:vc animated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        
    return 501*BiLiWidth+24*BiLiWidth+47*BiLiWidth;
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 501*BiLiWidth+24*BiLiWidth)];
    headerView.backgroundColor = [UIColor whiteColor];
    //顶部轮播图
    if ([NormalUse isValidArray:self.bannerArray]) {
        
        NewPagedFlowView *pageView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 147*BiLiWidth)];
        pageView.delegate = self;
        pageView.dataSource = self;
        pageView.minimumPageAlpha = 0.1;
        pageView.isCarousel = YES;
        pageView.orientation = NewPagedFlowViewOrientationHorizontal;
        pageView.isOpenAutoScroll = YES;
        pageView.orginPageCount = self.bannerArray.count;
        [pageView reloadData];
        [headerView addSubview:pageView];

        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, pageView.top+pageView.height+8*BiLiWidth, 200*BiLiWidth, 10)];
        self.pageControl.currentPage = 0;      //设置当前页指示点
        self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
        self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
        self.pageControl.numberOfPages = self.bannerArray.count;
        [headerView addSubview:self.pageControl];
    }
   
    
    //分类scrollview
    MyScrollView * fenLeiScrollView = [[MyScrollView alloc] initWithFrame:CGRectMake(0, self.pageControl.top+self.pageControl.height+25*BiLiWidth, WIDTH_PingMu, 57*BiLiWidth)];
    [headerView addSubview:fenLeiScrollView];
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(12*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_jingJiRenRenZheng"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(jingJiRenRenZhengButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button1];
    
    
    
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(button1.left+button1.width+5.5*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_nuShenRenZheng"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(nvShenRenZhengButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button2];
    
    
    UIButton * button3 = [[UIButton alloc] initWithFrame:CGRectMake(button2.left+button2.width+5.5*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button3 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_waiWei"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(kongJiangButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button3];
    
    
    UIButton * button4 = [[UIButton alloc] initWithFrame:CGRectMake(button3.left+button3.width+5.5*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button4 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_quanQiuPeiWan"] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(peiWanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button4];
    [fenLeiScrollView setContentSize:CGSizeMake(button4.left+button4.width+12*BiLiWidth, fenLeiScrollView.height)];
    
    //0 未认证 1 已认证 2 审核中
    //"auth_nomal":0,//茶馆儿认证：无
    //auth_agent":1,//经纪人认证：有
    //auth_goddess":1,//女神认证：有
    //auth_global":0,//全球陪玩:无
    //auth_peripheral":0//外围认证：无
    if ([NormalUse isValidString:[NormalUse defaultsGetObjectKey:LoginToken]]) {

        NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
        NSString * defaultsKey = [UserRole stringByAppendingString:token];
        
        NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
        
        if ([NormalUse isValidDictionary:userRoleDic]) {
            
            NSNumber * auth_agent = [userRoleDic objectForKey:@"auth_agent"];
            if([auth_agent isKindOfClass:[NSNumber class]])
            {
                button1.tag = auth_agent.intValue;
                if (auth_agent.intValue==1) {
                    
                    [button1 setBackgroundImage:nil forState:UIControlStateNormal];
                    [button1 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_jingJiRenFaBuXinXi"] forState:UIControlStateNormal];


                }
                else if (auth_agent.intValue==2)
                {
                    [button1 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_jingJiRenRenZheng"] forState:UIControlStateNormal];

                }
                else
                {
                    [button1 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_jingJiRenRenZheng"] forState:UIControlStateNormal];

                }
            }
            
            NSNumber * auth_goddess = [userRoleDic objectForKey:@"auth_goddess"];
            
            if([auth_goddess isKindOfClass:[NSNumber class]])
            {
                button2.tag = auth_goddess.intValue;
                if (auth_goddess.intValue==1) {
                    
                    [button2 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_nvShenYiRenZheng"] forState:UIControlStateNormal];

                }
                else if (auth_goddess.intValue==2)
                {
                    [button2 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_nuShenRenZheng"] forState:UIControlStateNormal];

                }
                else
                {
                    [button2 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_nuShenRenZheng"] forState:UIControlStateNormal];

                }
            }
            
            NSNumber * auth_peripheral = [userRoleDic objectForKey:@"auth_peripheral"];
            if([auth_peripheral isKindOfClass:[NSNumber class]])
            {
                button3.tag = auth_peripheral.intValue;
                if (auth_peripheral.intValue==1) {
                    
                    [button3 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_waiWei"] forState:UIControlStateNormal];

                }
                else if (auth_peripheral.intValue==2)
                {
                    [button3 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_waiWei"] forState:UIControlStateNormal];

                }
                else
                {
                    [button3 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_waiWei"] forState:UIControlStateNormal];

                }
            }

            NSNumber * auth_global = [userRoleDic objectForKey:@"auth_global"];
            if([auth_global isKindOfClass:[NSNumber class]])
            {
                button4.tag = auth_global.intValue;
                if (auth_global.intValue==1) {
                    
                    [button4 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_quanQiuPeiWan"] forState:UIControlStateNormal];

                }
                else if (auth_global.intValue==2)
                {
                    [button4 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_quanQiuPeiWan"] forState:UIControlStateNormal];

                }
                else
                {
                    [button4 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_quanQiuPeiWan"] forState:UIControlStateNormal];

                }
            }


        }

        
    }
    //官方推荐
    UILabel * guanFangTuiJianLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, fenLeiScrollView.top+fenLeiScrollView.height+24*BiLiWidth, 200*BiLiWidth, 17*BiLiWidth)];
    guanFangTuiJianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17*BiLiWidth];
    guanFangTuiJianLable.textColor = RGBFormUIColor(0x333333);
    guanFangTuiJianLable.text = @"官方推荐";
    [headerView addSubview:guanFangTuiJianLable];
    
    UIScrollView * guanFangTuiJianScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, guanFangTuiJianLable.top+guanFangTuiJianLable.height+13*BiLiWidth, WIDTH_PingMu, 176*BiLiWidth)];
    [headerView addSubview:guanFangTuiJianScrollView];
    
    for (int i=0; i<self.guanFangTuiJianDianPuArray.count; i++) {
        
        NSDictionary * info = [self.guanFangTuiJianDianPuArray objectAtIndex:i];
        
        UIButton * contentView = [[UIButton alloc] initWithFrame:CGRectMake(12*BiLiWidth+156*BiLiWidth*i, 0, 151.5*BiLiWidth, 176*BiLiWidth)];
        contentView.layer.cornerRadius = 4*BiLiWidth;
        contentView.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
        contentView.layer.borderWidth = 1;
        contentView.clipsToBounds = YES;
        [guanFangTuiJianScrollView addSubview:contentView];
        
        
        [guanFangTuiJianScrollView setContentSize:CGSizeMake(contentView.left+contentView.width+12*BiLiWidth, guanFangTuiJianScrollView.height)];
        
        
        UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentView.width, 126*BiLiWidth)];
        headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        headerImageView.autoresizingMask = UIViewAutoresizingNone;
        headerImageView.clipsToBounds = YES;
        [contentView addSubview:headerImageView];
        [headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"image"]]];
        
        
        UIView *  jiaoBiaoView = [[UILabel alloc] initWithFrame:CGRectMake(contentView.width-39*BiLiWidth,0,39*BiLiWidth,18*BiLiWidth)];
        [contentView addSubview:jiaoBiaoView];
        
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = jiaoBiaoView.bounds;
        gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.locations = @[@0,@1];
        [jiaoBiaoView.layer addSublayer:gradientLayer];
        
        UILabel *  jiaoBiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(contentView.width-39*BiLiWidth,0,39*BiLiWidth,18*BiLiWidth)];
        jiaoBiaoLable.textAlignment = NSTextAlignmentCenter;
        jiaoBiaoLable.textColor = RGBFormUIColor(0xFFFFFF);
        jiaoBiaoLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        jiaoBiaoLable.adjustsFontSizeToFitWidth = YES;
        jiaoBiaoLable.text = [info objectForKey:@"city_name"];
        [contentView addSubview:jiaoBiaoLable];

        
        //某个角圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:jiaoBiaoLable.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4*BiLiWidth, 4*BiLiWidth)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = jiaoBiaoLable.bounds;
        maskLayer.path = maskPath.CGPath;
        jiaoBiaoLable.layer.mask = maskLayer;
        
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, headerImageView.top+headerImageView.height+9.5*BiLiWidth, contentView.width, 14*BiLiWidth)];
        titleLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        titleLable.textColor = RGBFormUIColor(0x333333);
        titleLable.text = [info objectForKey:@"name"];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:titleLable];
        
        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLable.top+titleLable.height+7*BiLiWidth, contentView.width, 11*BiLiWidth)];
        messageLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        messageLable.textColor = RGBFormUIColor(0x999999);
        messageLable.text = [info objectForKey:@"name"];
        messageLable.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:messageLable];
        
        UIButton * clickButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, contentView.width, contentView.height)];
        clickButton.tag = i;
        [clickButton addTarget:self action:@selector(guanFangTuiJianClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:clickButton];

        
    }
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, guanFangTuiJianScrollView.top+guanFangTuiJianScrollView.height+21*BiLiWidth, WIDTH_PingMu, 8*BiLiWidth)];
    lineView.backgroundColor = RGBFormUIColor(0xEDEDED);
    [headerView addSubview:lineView];
    
    //官方推荐
    UILabel * wangPaiJingJiRenLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, lineView.top+lineView.height+14*BiLiWidth, 200*BiLiWidth, 17*BiLiWidth)];
    wangPaiJingJiRenLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17*BiLiWidth];
    wangPaiJingJiRenLable.textColor = RGBFormUIColor(0x333333);
    wangPaiJingJiRenLable.text = @"王牌经纪人";
    [headerView addSubview:wangPaiJingJiRenLable];
    
    
    self.pingFenButton = [[UIButton alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, wangPaiJingJiRenLable.top+wangPaiJingJiRenLable.height+14.5*BiLiWidth, 50*BiLiWidth, 12*BiLiWidth)];
    [self.pingFenButton setTitle:@"评分最高" forState:UIControlStateNormal];
    [self.pingFenButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    self.pingFenButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.pingFenButton addTarget:self action:@selector(pingFenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.pingFenButton];
    
//    self.zuiXinButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+33*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
//    [self.zuiXinButton setTitle:@"最新" forState:UIControlStateNormal];
//    self.zuiXinButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
//    [self.zuiXinButton addTarget:self action:@selector(zuiXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:self.zuiXinButton];
//
//    self.zuiReButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+79*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
//    [self.zuiReButton setTitle:@"最热" forState:UIControlStateNormal];
//    self.zuiReButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
//    [self.zuiReButton addTarget:self action:@selector(zuiReButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:self.zuiReButton];
    
//    if ([@"1" isEqualToString:self.zuiXinOrZuiRe]) {
//
//        [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
//        [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
//
//
//    }
//    else
//    {
//        [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
//        [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
//
//    }
    
    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    return nil;
}
#pragma mark--UIButtonClick
-(void)guanFangTuiJianClick:(UIButton *)button
{
    NSDictionary * info = [self.guanFangTuiJianDianPuArray objectAtIndex:button.tag];
    DianPuDetailViewController * vc = [[DianPuDetailViewController alloc] init];
    NSNumber * idNumber = [info objectForKey:@"id"];
    vc.dianPuId = [NSString stringWithFormat:@"%d",idNumber.intValue];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pingFenButtonClick
{
    self.gaoDuanShaiXuanView.hidden = NO;
}
-(void)zuiXinButtonClick
{
    self.field = @"";
    self.zuiXinOrZuiRe = @"1";
    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
    [self loadNewLsit];
}
-(void)zuiReButtonClick
{
    self.field = @"hot_value";
    self.zuiXinOrZuiRe = @"2";

    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];

    [self loadNewLsit];
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
