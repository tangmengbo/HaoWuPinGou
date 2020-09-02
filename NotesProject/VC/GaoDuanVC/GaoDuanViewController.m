//
//  GaoDuanViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GaoDuanViewController.h"
#import "GaoDuanHomeCell.h"

@interface GaoDuanViewController ()<WSPageViewDelegate,WSPageViewDataSource,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel * locationLable;

@property(nonatomic,strong)NSMutableArray * listButtonArray;

@property(nonatomic,strong)UIScrollView * contentScrollView;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong,nullable)WSPageView *pageView;
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

@property(nonatomic,strong)NSArray * guanFangTuiJianDianPuArray;


@end

@implementation GaoDuanViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self xianShiTabBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView.hidden = YES;
    self.lineView.hidden = YES;
    
    UIImageView * locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-11*BiLiWidth-55*BiLiWidth, (self.topNavView.height-14*BiLiWidth)/2, 11*BiLiWidth, 14*BiLiWidth)];
    locationImageView.image = [UIImage imageNamed:@"home_location"];
    [self.topNavView addSubview:locationImageView];
    
    self.locationLable = [[UILabel alloc] initWithFrame:CGRectMake(locationImageView.left+locationImageView.width+5*BiLiWidth, locationImageView.top, 50*BiLiWidth, locationImageView.height)];
    self.locationLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.locationLable.adjustsFontSizeToFitWidth = YES;
    self.locationLable.textColor = RGBFormUIColor(0x333333);
    self.locationLable.text = @"深圳市";
    [self.topNavView addSubview:self.locationLable];
    
    self.listButtonArray = [NSMutableArray array];
    NSArray * array = [[NSArray alloc] initWithObjects:@"经纪人",@"认证女神",@"外围空降",@"全球陪玩", nil];
    float originx = 13*BiLiWidth;
    CGSize size;
    for (int i=0; i<array.count; i++) {
        
        UIButton * button;
        if (i==0) {
            
            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:17*BiLiWidth];
            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx,17*BiLiWidth+15*BiLiWidth, size.width, 17*BiLiWidth)];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17*BiLiWidth];


        }
        else
        {
            size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
            button  = [[UIButton alloc] initWithFrame:CGRectMake(originx, 17*BiLiWidth+19*BiLiWidth, size.width, 12*BiLiWidth)];
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
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(10.5*BiLiWidth,17*BiLiWidth+27*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
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


    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height+BottomHeight_PingMu))];
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

    self.itemButtonContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, 14.5*BiLiWidth*2+12*BiLiWidth)];
    self.itemButtonContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.itemButtonContentView];
    
    self.zuiXinOrZuiRe = @"1";
    
    self.pingFenButton1 = [[UIButton alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 14.5*BiLiWidth, 50*BiLiWidth, 12*BiLiWidth)];
    [self.pingFenButton1 setTitle:@"评分最高" forState:UIControlStateNormal];
    [self.pingFenButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    self.pingFenButton1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.pingFenButton1 addTarget:self action:@selector(pingFenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.itemButtonContentView addSubview:self.pingFenButton1];
    
    self.zuiXinButton1 = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton1.left+self.pingFenButton1.width+33*BiLiWidth, self.pingFenButton1.top, 33.5*BiLiWidth, 12*BiLiWidth)];
    [self.zuiXinButton1 setTitle:@"最新" forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    self.zuiXinButton1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.zuiXinButton1 addTarget:self action:@selector(zuiXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.itemButtonContentView addSubview:self.zuiXinButton1];
    
    self.zuiReButton1 = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton1.left+self.pingFenButton1.width+79*BiLiWidth, self.pingFenButton1.top, 33.5*BiLiWidth, 12*BiLiWidth)];
    [self.zuiReButton1 setTitle:@"最热" forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    self.zuiReButton1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.zuiReButton1 addTarget:self action:@selector(zuiReButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.itemButtonContentView addSubview:self.zuiReButton1];

    self.itemButtonContentView.hidden = YES;
    
    [HTTPModel getBannerList:[[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
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
#pragma mark--顶部按钮点击
-(void)listTopButtonClick:(UIButton *)selectButton
{
    [self.contentScrollView setContentOffset:CGPointMake(selectButton.tag*WIDTH_PingMu, 0) animated:YES];
    float originx = 13*BiLiWidth;
    CGSize size;
    for (int i=0; i<self.listButtonArray.count; i++) {
        
        UIButton * button = [self.listButtonArray objectAtIndex:i];
        if (button.tag==selectButton.tag) {
            
            size  = [NormalUse setSize:button.titleLabel.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:17*BiLiWidth];
            button.frame  = CGRectMake(originx,17*BiLiWidth+15*BiLiWidth, size.width, 17*BiLiWidth);
            button.titleLabel.font = [UIFont systemFontOfSize:17*BiLiWidth];
            
            [UIView animateWithDuration:0.5 animations:^{
                self.sliderView.left = button.left+(button.width-self.sliderView.width)/2;
            }];


        }
        else
        {
            size  = [NormalUse setSize:button.titleLabel.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
            button.frame  = CGRectMake(originx, 17*BiLiWidth+19*BiLiWidth, size.width, 12*BiLiWidth);
            button.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        }
        
        originx = button.left+button.width+11.5*BiLiWidth;

        
    }
}
#pragma mark--经纪人认证 女神认证 全国空降 陪玩

-(void)jingJiRenRenZhengButtonClick
{
    JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)nvShenRenZhengButtonClick
{
    NvShenRenZhengStep1VC * vc = [[NvShenRenZhengStep1VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)kongJiangButtonClick
{
    
}

-(void)peiWanButtonClick
{
    
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
            }

        }
        if (offset < 0 && distanceFromBottom > hight) {
            NSLog(@"下拉行为");
            if (scrollView.contentOffset.y<=500*BiLiWidth) {
                
                
            self.itemButtonContentView.hidden = YES;
                       
            }
        }

    }


}
#pragma mark UItableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return  197*BiLiWidth+48*BiLiWidth+21*BiLiWidth+8*BiLiWidth;
    
    
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
    [cell contentViewSetData:nil];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        
    return 501*BiLiWidth+24*BiLiWidth;
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 501*BiLiWidth+24*BiLiWidth)];
    headerView.backgroundColor = [UIColor whiteColor];
    //顶部轮播图
    self.pageView = [[WSPageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 100*BiLiWidth)];
    self.pageView.currentWidth = 305;
    self.pageView.currentHeight = 100;
    self.pageView.normalHeight = 87;
    self.pageView.delegate = self;
    self.pageView.dataSource = self;
    self.pageView.minimumPageAlpha = 1;   //非当前页的透明比例
    self.pageView.minimumPageScale = 0.8;  //非当前页的缩放比例
    self.pageView.orginPageCount = 3; //原始页数
    self.pageView.autoTime = 4;    //自动切换视图的时间,默认是5.0
    [headerView addSubview:self.pageView] ;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, self.pageView.top+self.pageView.height+8*BiLiWidth, 200*BiLiWidth, 10)];
    self.pageControl.currentPage = 0;      //设置当前页指示点
    self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
    self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
    self.pageControl.numberOfPages = 3;
    [headerView addSubview:self.pageControl];
    
    //分类scrollview
    UIScrollView * fenLeiScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.pageControl.top+self.pageControl.height+25*BiLiWidth, WIDTH_PingMu, 57*BiLiWidth)];
    [headerView addSubview:fenLeiScrollView];
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(12*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_jingJiRenRenZheng"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(jingJiRenRenZhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button1];
    
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(button1.left+button1.width+5.5*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_nuShenRenZheng"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(nvShenRenZhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button2];
    
    
    UIButton * button3 = [[UIButton alloc] initWithFrame:CGRectMake(button2.left+button2.width+5.5*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button3 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_quanGuoKongJian"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(kongJiangButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button3];
    
    
    UIButton * button4 = [[UIButton alloc] initWithFrame:CGRectMake(button3.left+button3.width+5.5*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button4 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_quanQiuPeiWan"] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(peiWanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button4];
    [fenLeiScrollView setContentSize:CGSizeMake(button4.left+button4.width+12*BiLiWidth, fenLeiScrollView.height)];
    
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
    
    self.zuiXinButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+33*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
    [self.zuiXinButton setTitle:@"最新" forState:UIControlStateNormal];
    self.zuiXinButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.zuiXinButton addTarget:self action:@selector(zuiXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.zuiXinButton];
    
    self.zuiReButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+79*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
    [self.zuiReButton setTitle:@"最热" forState:UIControlStateNormal];
    self.zuiReButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.zuiReButton addTarget:self action:@selector(zuiReButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.zuiReButton];
    
    if ([@"1" isEqualToString:self.zuiXinOrZuiRe]) {
        
        [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];


    }
    else
    {
        [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
        [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];

    }
    
    return headerView;
    
}
-(void)pingFenButtonClick
{
}
-(void)zuiXinButtonClick
{
    self.zuiXinOrZuiRe = @"1";
    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
}
-(void)zuiReButtonClick
{
    self.zuiXinOrZuiRe = @"2";

    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];

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
        bannerView = [[WSIndexBanner alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu-60*BiLiWidth, 100*BiLiWidth)];
    }
    
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597827992453&di=89f2d23d41e7e650adec139e15eb8688&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853"]];
    return bannerView;
    
}

@end
