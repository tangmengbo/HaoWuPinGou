//
//  HuiYuanViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/11.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HuiYuanViewController.h"

@interface HuiYuanViewController ()<UIScrollViewDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>



@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIScrollView * itemScrollView;

@property(nonatomic,strong)Lable_ImageButton * nianKaVipButton;
@property(nonatomic,strong)Lable_ImageButton * yongJiuVipButton;

@property(nonatomic,strong)Lable_ImageButton * button1;
@property(nonatomic,strong)Lable_ImageButton * button2;
@property(nonatomic,strong)Lable_ImageButton * button3;
@property(nonatomic,strong)Lable_ImageButton * button4;

@property(nonatomic,strong)UILabel * kaiTongJinBiLable;

@property(nonatomic,strong)UILabel * nianKaTipLable;

@property(nonatomic,strong)UILabel * yongJiuTipLable;

@property(nonatomic,strong)NSString * vip_type;//vip_type vip_forever永久会员 vip_year年会员

//auth_vip 2终身会员 1年会员 0非会员
@property(nonatomic,strong)NSNumber * auth_vip;
@property(nonatomic,strong)UIButton * kaiTongButton;

@property(nonatomic,strong)UIView * kaiTongHuiYuanQueRenView;
@property(nonatomic,strong)UILabel * kaiTongHuiYuanQueRenViewTipLable;

@property(nonatomic,strong)UIView * tiShiKuangView;

@property(nonatomic,strong)UIView * kaiTongSuccessTipView;
@end

@implementation HuiYuanViewController

-(UIView *)kaiTongHuiYuanQueRenView
{
    if (!_kaiTongHuiYuanQueRenView) {
        
        _kaiTongHuiYuanQueRenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _kaiTongHuiYuanQueRenView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [[UIApplication sharedApplication].keyWindow addSubview:_kaiTongHuiYuanQueRenView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-234*BiLiWidth)/2, 287*BiLiWidth, 234*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [_kaiTongHuiYuanQueRenView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(queRenViewCloseTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [_kaiTongHuiYuanQueRenView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"提示";
        [kuangImageView addSubview:tipLable1];
        
        self.kaiTongHuiYuanQueRenViewTipLable = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 40*BiLiWidth)];
        self.kaiTongHuiYuanQueRenViewTipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.kaiTongHuiYuanQueRenViewTipLable.textColor = RGBFormUIColor(0x343434);
        self.kaiTongHuiYuanQueRenViewTipLable.text = @"";
        self.kaiTongHuiYuanQueRenViewTipLable.textAlignment = NSTextAlignmentCenter;
        [kuangImageView addSubview:self.kaiTongHuiYuanQueRenViewTipLable];
        
//        UIButton * quXiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-85.5*BiLiWidth-11.5*BiLiWidth-115*BiLiWidth)/2, self.kaiTongHuiYuanQueRenViewTipLable.top+self.kaiTongHuiYuanQueRenViewTipLable.height+25*BiLiWidth, 85.5*BiLiWidth, 40*BiLiWidth)];
//        [quXiaoButton setTitle:@"取消" forState:UIControlStateNormal];
//        quXiaoButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
//        quXiaoButton.layer.cornerRadius = 20*BiLiWidth;
//        [quXiaoButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
//        quXiaoButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
//        [quXiaoButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
//        [kuangImageView addSubview:quXiaoButton];

        UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-200*BiLiWidth)/2, self.kaiTongHuiYuanQueRenViewTipLable.top+self.kaiTongHuiYuanQueRenViewTipLable.height+25*BiLiWidth, 200*BiLiWidth, 40*BiLiWidth)];
        [sureButton addTarget:self action:@selector(queRenViewSureButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:sureButton];
        
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = sureButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [sureButton.layer addSublayer:gradientLayer1];
        
        UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sureButton.width, sureButton.height)];
        sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        sureLable.text = @"确定";
        sureLable.textAlignment = NSTextAlignmentCenter;
        sureLable.textColor = [UIColor whiteColor];
        [sureButton addSubview:sureLable];

    }
    return _kaiTongHuiYuanQueRenView;
}
-(void)queRenViewCloseTipKuangView
{
    self.kaiTongHuiYuanQueRenView.hidden = YES;
    
}
-(void)queRenViewSureButtonClick
{
    [self kaiTongHuiYuan];

    self.kaiTongHuiYuanQueRenView.hidden = YES;
}
-(UIView *)tiShiKuangView
{
    if (!_tiShiKuangView) {
        
        _tiShiKuangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _tiShiKuangView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [[UIApplication sharedApplication].keyWindow addSubview:_tiShiKuangView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-274*BiLiWidth)/2, 287*BiLiWidth, 274*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [_tiShiKuangView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [_tiShiKuangView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"提示";
        [kuangImageView addSubview:tipLable1];
        
        UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 80*BiLiWidth)];
        tipLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
        tipLable2.textColor = RGBFormUIColor(0x343434);
        tipLable2.numberOfLines = 2;
        tipLable2.text = @"开通此会员卡会替换您目前拥有的会员卡，是否确定开通";
        [kuangImageView addSubview:tipLable2];
        
        UIButton * quXiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-85.5*BiLiWidth-11.5*BiLiWidth-115*BiLiWidth)/2, tipLable2.top+tipLable2.height+25*BiLiWidth, 85.5*BiLiWidth, 40*BiLiWidth)];
        [quXiaoButton setTitle:@"取消" forState:UIControlStateNormal];
        quXiaoButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
        quXiaoButton.layer.cornerRadius = 20*BiLiWidth;
        [quXiaoButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        quXiaoButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [quXiaoButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:quXiaoButton];

        UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake(quXiaoButton.left+quXiaoButton.width+11.5*BiLiWidth, quXiaoButton.top, 115*BiLiWidth, 40*BiLiWidth)];
        [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:sureButton];
        
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = sureButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [sureButton.layer addSublayer:gradientLayer1];
        
        UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sureButton.width, sureButton.height)];
        sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        sureLable.text = @"确定";
        sureLable.textAlignment = NSTextAlignmentCenter;
        sureLable.textColor = [UIColor whiteColor];
        [sureButton addSubview:sureLable];

    }
    return _tiShiKuangView;
}
-(void)sureButtonClick
{
    self.tiShiKuangView.hidden = YES;
    [self kaiTongHuiYuan];
}
-(void)closeTipKuangView
{
    self.tiShiKuangView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    self.topTitleLale.text = @"VIP 会员";
    
    self.vip_type = @"vip_year";
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    
    UIImageView * topBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, WIDTH_PingMu*645/1125)];
    topBgImageView.image = [UIImage imageNamed:@"vip_topBG"];
    [self.mainScrollView addSubview:topBgImageView];
    
    [self.view bringSubviewToFront:self.topNavView];
    self.topNavView.backgroundColor = [UIColor clearColor];
    self.backImageView.frame = CGRectMake(self.backImageView.left, (self.topNavView.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.backImageView.image = [UIImage imageNamed:@"white_back"];
    self.topTitleLale.textColor = [UIColor whiteColor];
    
    self.bannerArray = [[NSArray alloc] initWithObjects:@"vip_nianKa",@"vip_jiaoLong",@"vip_zuiQiangWangZhe", nil];
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, 157*BiLiWidth)];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.isCarousel = YES;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = NO;
    pageFlowView.orginPageCount = self.bannerArray.count;
    [pageFlowView reloadData];
    [self.mainScrollView addSubview:pageFlowView];

    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, pageFlowView.top+pageFlowView.height+8*BiLiWidth, 200*BiLiWidth, 10*BiLiWidth)];
    self.pageControl.currentPage = 0;      //设置当前页指示点
    self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
    self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
    self.pageControl.numberOfPages = self.bannerArray.count;
    [self.mainScrollView addSubview:self.pageControl];

    //auth_vip 3蛟龙炮神会员 2终身会员 1年会员 0非会员
    if ([NormalUse isValidDictionary:self.info]) {
        
        self.auth_vip = [self.info objectForKey:@"auth_vip"];

    }
    else
    {
        self.auth_vip = [NormalUse defaultsGetObjectKey:@"UserAlsoVip"];
    }
    if (self.auth_vip.intValue!=1) {
        
        self.nianKaTipLable.hidden = YES;
        
    }
     if (self.auth_vip.intValue != 2)
    {
        self.yongJiuTipLable.hidden = YES;
    }

    UIImageView * tieQuanImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-26*BiLiWidth)/2, self.pageControl.top+self.pageControl.height+25*BiLiWidth, 26*BiLiWidth, 20.5*BiLiWidth)];
    tieQuanImageView.image = [UIImage imageNamed:@"vip_title"];
    [self.mainScrollView addSubview:tieQuanImageView];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, tieQuanImageView.top+tieQuanImageView.height+4*BiLiWidth, WIDTH_PingMu, 15*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:16*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0x333333);
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.text = @"会员特权";
    [self.mainScrollView addSubview:tipLable];

    
    self.itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, tipLable.top+tipLable.height+15*BiLiWidth, WIDTH_PingMu, 275*BiLiWidth)];
    self.itemScrollView.showsVerticalScrollIndicator = NO;
    self.itemScrollView.showsHorizontalScrollIndicator = NO;
    self.itemScrollView.clipsToBounds = NO;
    self.itemScrollView.pagingEnabled = YES;
    self.itemScrollView.delegate = self;
    self.itemScrollView.scrollEnabled = NO;
    [self.mainScrollView addSubview:self.itemScrollView];


    [self setYongJiuVipItem];
    [self setJiaoLongVipItem];
    [self setWangZheVipItem];




    self.kaiTongButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-280*BiLiWidth)/2, HEIGHT_PingMu-50*BiLiWidth, 280*BiLiWidth, 40*BiLiWidth)];
    [self.kaiTongButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.kaiTongButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6B6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0A76);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = self.kaiTongButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [self.kaiTongButton.layer addSublayer:gradientLayer1];
    
    self.kaiTongJinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.kaiTongButton.width, self.kaiTongButton.height)];
    self.kaiTongJinBiLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.kaiTongJinBiLable.textAlignment = NSTextAlignmentCenter;
    self.kaiTongJinBiLable.textColor = [UIColor whiteColor];
    [self.kaiTongButton addSubview:self.kaiTongJinBiLable];
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.kaiTongButton.top+self.kaiTongButton.height+30*BiLiWidth)];
    
    if(self.auth_vip.intValue==1)
    {
        self.kaiTongButton.enabled = NO;
        self.kaiTongJinBiLable.text = @"已开通";

    }
    else
    {
        self.kaiTongJinBiLable.text = [NSString stringWithFormat:@"%@金币开启",[NormalUse getJinBiStr:@"vip_year_coin"]];

    }


}
-(void)setYongJiuVipItem
{
    Lable_ImageButton * button1 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(69.5*BiLiWidth, 0, 105*BiLiWidth, 130*BiLiWidth)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"vip_itemBG"] forState:UIControlStateNormal];
    button1.button_imageView.frame = CGRectMake((button1.width-31*BiLiWidth)/2, 21.5*BiLiWidth, 31*BiLiWidth, 31*BiLiWidth);
    button1.button_imageView.image = [UIImage imageNamed:@"vip_jieSuo"];
    button1.button_lable.frame = CGRectMake(0, button1.button_imageView.top+button1.button_imageView.height+16*BiLiWidth, button1.width, 13*BiLiWidth);
    button1.button_lable.textAlignment = NSTextAlignmentCenter;
    button1.button_lable.textColor = RGBFormUIColor(0x333333);
    button1.button_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13*BiLiWidth];
    button1.button_lable.text = @"特权一";
    button1.button_lable1.frame = CGRectMake((button1.width-71*BiLiWidth)/2, button1.button_lable.top+button1.button_lable.height+9*BiLiWidth, 71*BiLiWidth, 30*BiLiWidth);
    button1.button_lable1.textAlignment = NSTextAlignmentCenter;
    button1.button_lable1.textColor = RGBFormUIColor(0x999999);
    button1.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    button1.button_lable1.numberOfLines = 2;
    button1.button_lable1.text = @"基础信息免费解锁";
    [self.itemScrollView addSubview:button1];

    Lable_ImageButton * button2 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(button1.left+button1.width+25.5*BiLiWidth, button1.top, button1.width, button1.height)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"vip_itemBG"] forState:UIControlStateNormal];
    button2.button_imageView.frame = button1.button_imageView.frame;
    button2.button_imageView.image = [UIImage imageNamed:@"vip_faBu"];
    button2.button_lable.frame = button1.button_lable.frame;
    button2.button_lable.textAlignment = NSTextAlignmentCenter;
    button2.button_lable.textColor = RGBFormUIColor(0x333333);
    button2.button_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13*BiLiWidth];
    button2.button_lable.text = @"特权二";
    button2.button_lable1.frame = button1.button_lable1.frame;
    button2.button_lable1.textAlignment = NSTextAlignmentCenter;
    button2.button_lable1.textColor = RGBFormUIColor(0x999999);
    button2.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    button2.button_lable1.text = @"免费发布信息";
    button2.button_lable1.numberOfLines = 2;
    [self.itemScrollView addSubview:button2];

    
}
-(void)setJiaoLongVipItem
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    NSDictionary * info1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"特权一",@"title",@"金币礼包",@"message",@"vip_liHe",@"imageName", nil];
    NSDictionary * info2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"特权二",@"title",@"所有信息免费解锁",@"message",@"vip_jieSuo",@"imageName", nil];
    NSDictionary * info3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"特权三",@"title",@"免费发布信息",@"message",@"vip_faBu",@"imageName", nil];
    NSDictionary * info4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"特权四",@"title",@"定制服务免费发布",@"message",@"vip_dingZhi",@"imageName", nil];
    NSDictionary * info5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"特权五",@"title",@"每日领取五组金币兑奖号码",@"message",@"vip_teQuan",@"imageName", nil];
    [array addObject:info1];
    [array addObject:info2];
    [array addObject:info3];
    [array addObject:info4];
    [array addObject:info5];
    
    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        Lable_ImageButton * button1 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu+10.5*BiLiWidth+119.5*BiLiWidth*(i%3), 145*BiLiWidth*(i/3), 105*BiLiWidth, 130*BiLiWidth)];
        [button1 setBackgroundImage:[UIImage imageNamed:@"vip_itemBG"] forState:UIControlStateNormal];
        button1.button_imageView.frame = CGRectMake((button1.width-31*BiLiWidth)/2, 21.5*BiLiWidth, 31*BiLiWidth, 31*BiLiWidth);
        button1.button_imageView.image = [UIImage imageNamed:[info objectForKey:@"imageName"]];
        button1.button_lable.frame = CGRectMake(0, button1.button_imageView.top+button1.button_imageView.height+16*BiLiWidth, button1.width, 13*BiLiWidth);
        button1.button_lable.textAlignment = NSTextAlignmentCenter;
        button1.button_lable.textColor = RGBFormUIColor(0x333333);
        button1.button_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13*BiLiWidth];
        button1.button_lable.text = [info objectForKey:@"title"];
        button1.button_lable1.frame = CGRectMake((button1.width-71*BiLiWidth)/2, button1.button_lable.top+button1.button_lable.height+9*BiLiWidth, 71*BiLiWidth, 30*BiLiWidth);
        button1.button_lable1.textAlignment = NSTextAlignmentCenter;
        button1.button_lable1.textColor = RGBFormUIColor(0x999999);
        button1.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
        button1.button_lable1.numberOfLines = 2;
        button1.button_lable1.text = [info objectForKey:@"message"];
        button1.button_lable1.adjustsFontSizeToFitWidth = YES;
        [self.itemScrollView addSubview:button1];

    }


}
-(void)setWangZheVipItem
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    NSDictionary * info1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"特权一",@"title",@"金币礼包",@"message",@"vip_liHe",@"imageName", nil];
    NSDictionary * info2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"特权二",@"title",@"所有信息免费解锁",@"message",@"vip_jieSuo",@"imageName", nil];
    NSDictionary * info3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"特权三",@"title",@"免费发布信息",@"message",@"vip_faBu",@"imageName", nil];
    NSDictionary * info4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"特权五",@"title",@"每日领取一组金币兑奖号码",@"message",@"vip_teQuan",@"imageName", nil];
    [array addObject:info1];
    [array addObject:info2];
    [array addObject:info3];
    [array addObject:info4];
    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        Lable_ImageButton * button1 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu*2+10.5*BiLiWidth+119.5*BiLiWidth*(i%3), 145*BiLiWidth*(i/3), 105*BiLiWidth, 130*BiLiWidth)];
        [button1 setBackgroundImage:[UIImage imageNamed:@"vip_itemBG"] forState:UIControlStateNormal];
        button1.button_imageView.frame = CGRectMake((button1.width-31*BiLiWidth)/2, 21.5*BiLiWidth, 31*BiLiWidth, 31*BiLiWidth);
        button1.button_imageView.image = [UIImage imageNamed:[info objectForKey:@"imageName"]];
        button1.button_lable.frame = CGRectMake(0, button1.button_imageView.top+button1.button_imageView.height+16*BiLiWidth, button1.width, 13*BiLiWidth);
        button1.button_lable.textAlignment = NSTextAlignmentCenter;
        button1.button_lable.textColor = RGBFormUIColor(0x333333);
        button1.button_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13*BiLiWidth];
        button1.button_lable.text = [info objectForKey:@"title"];
        button1.button_lable1.frame = CGRectMake((button1.width-71*BiLiWidth)/2, button1.button_lable.top+button1.button_lable.height+9*BiLiWidth, 71*BiLiWidth, 30*BiLiWidth);
        button1.button_lable1.textAlignment = NSTextAlignmentCenter;
        button1.button_lable1.textColor = RGBFormUIColor(0x999999);
        button1.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
        button1.button_lable1.numberOfLines = 2;
        button1.button_lable1.adjustsFontSizeToFitWidth = YES;
        button1.button_lable1.text = [info objectForKey:@"message"];
        [self.itemScrollView addSubview:button1];

    }
}
/*
-(void)nianKaVipClick
{
    
    "vip_funlock_num":"15",终身会员当天解锁次数
    "vip_fpost_num":"15",终身会员当天发帖次数
    "vip_ypost_num":"10",年会员当天发帖次数
    "vip_yunlock_num":"10",年会员当天解锁次数
    "vip_fpack_coin":"1000",开通终身会员送的金币
    "vip_ypack_coin":"500",开通年会员送的金币
     
     "vip_forever_coin":"1000000",终身会员金币
     "vip_year_coin":"100000",年会员金币

     

    button1.button_lable1.text = [NSString stringWithFormat:@"获得%@金币",[NormalUse getJinBiStr:@"vip_ypack_coin"]];
    button2.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_yunlock_num"]];
    button3.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_ypost_num"]];
    self.kaiTongJinBiLable.text = [NSString stringWithFormat:@"%@金币开启",[NormalUse getJinBiStr:@"vip_year_coin"]];
    
    self.vip_type = @"vip_year";
    
    if(self.auth_vip.intValue==1 || self.auth_vip.intValue==2)
    {
        self.kaiTongButton.hidden = YES;
    }
    
    else
    {
        self.kaiTongButton.hidden = NO;
    }


}
-(void)yongJiuVipClick
{
    button1.button_lable1.text = [NSString stringWithFormat:@"获得%@金币",[NormalUse getJinBiStr:@"vip_fpack_coin"]];
    button2.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_funlock_num"]];
    button3.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_fpost_num"]];
    self.kaiTongJinBiLable.text = [NSString stringWithFormat:@"%@金币开启",[NormalUse getJinBiStr:@"vip_forever_coin"]];

    self.vip_type = @"vip_forever";
    
    if(self.auth_vip.intValue==2)
    {
        self.kaiTongButton.hidden = YES;
    }
    else
    {
        self.kaiTongButton.hidden = NO;
    }

    

}
*/
-(void)tiJiaoButtonClick
{
    
    if(self.auth_vip.intValue==0)
    {

        self.kaiTongHuiYuanQueRenView.hidden = NO;
        
        if ([@"vip_year" isEqualToString:self.vip_type]) {
            
            self.kaiTongHuiYuanQueRenViewTipLable.text = @"是否确定开通年卡";

        }
        else if ([@"vip_forever" isEqualToString:self.vip_type])
        {
            self.kaiTongHuiYuanQueRenViewTipLable.text = @"是否确定开通永久卡";

        }
        else
        {
            self.kaiTongHuiYuanQueRenViewTipLable.text = @"是否确定开通蛟龙炮神卡";
        }

    }
    else
    {
        self.tiShiKuangView.hidden = NO;
    }
}
-(void)kaiTongHuiYuan
{
    [NormalUse showMessageLoadView:@"开通中..." vc:self];

    [HTTPModel kaiTongHuiYuan:[[NSDictionary alloc]initWithObjectsAndKeys:self.vip_type,@"vip_type", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        [NormalUse removeMessageLoadingView:self];
        if (status==1) {
            
             self.kaiTongSuccessTipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
            self.kaiTongSuccessTipView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            [[UIApplication sharedApplication].keyWindow addSubview:self.kaiTongSuccessTipView];
            
            UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-234*BiLiWidth)/2, 287*BiLiWidth, 234*BiLiWidth)];
            kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
            kuangImageView.userInteractionEnabled = YES;
            [self.kaiTongSuccessTipView addSubview:kuangImageView];
            
            UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
            [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
            [closeButton addTarget:self action:@selector(kaiTongSuccessCloseTipKuangView) forControlEvents:UIControlEventTouchUpInside];
            [self.kaiTongSuccessTipView addSubview:closeButton];
            
            UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
            tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
            tipLable1.textColor = RGBFormUIColor(0x343434);
            tipLable1.textAlignment = NSTextAlignmentCenter;
            tipLable1.text = @"提示";
            [kuangImageView addSubview:tipLable1];
            
            UILabel * kaiTongHuiYuanQueRenViewTipLable = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 40*BiLiWidth)];
            kaiTongHuiYuanQueRenViewTipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
            kaiTongHuiYuanQueRenViewTipLable.textColor = RGBFormUIColor(0x343434);
            kaiTongHuiYuanQueRenViewTipLable.textAlignment = NSTextAlignmentCenter;
            [kuangImageView addSubview:kaiTongHuiYuanQueRenViewTipLable];
            

            UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-200*BiLiWidth)/2, kaiTongHuiYuanQueRenViewTipLable.top+kaiTongHuiYuanQueRenViewTipLable.height+25*BiLiWidth, 200*BiLiWidth, 40*BiLiWidth)];
            [sureButton addTarget:self action:@selector(kaiTongSuccessCloseTipKuangView) forControlEvents:UIControlEventTouchUpInside];
            [kuangImageView addSubview:sureButton];
            
            //渐变设置
            UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
            UIColor *colorTwo = RGBFormUIColor(0xFF0876);
            CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
            gradientLayer1.frame = sureButton.bounds;
            gradientLayer1.cornerRadius = 20*BiLiWidth;
            gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
            gradientLayer1.startPoint = CGPointMake(0, 0);
            gradientLayer1.endPoint = CGPointMake(0, 1);
            gradientLayer1.locations = @[@0,@1];
            [sureButton.layer addSublayer:gradientLayer1];
            
            UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sureButton.width, sureButton.height)];
            sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
            sureLable.text = @"确定";
            sureLable.textAlignment = NSTextAlignmentCenter;
            sureLable.textColor = [UIColor whiteColor];
            [sureButton addSubview:sureLable];


            self.kaiTongButton.enabled = NO;
            self.kaiTongJinBiLable.text = @"已开通";

            //2终身会员 1年会员 0非会员
            if ([@"vip_year" isEqualToString:self.vip_type]) {
                
                self.nianKaTipLable.hidden = NO;
                self.yongJiuTipLable.hidden = YES;
                self.auth_vip = [NSNumber numberWithInt:1];
                kaiTongHuiYuanQueRenViewTipLable.text = @"年卡会员开通成功";
                
                [NormalUse defaultsSetObject:[NSNumber numberWithInt:1] forKey:@"UserAlsoVip"];//本地存储会员身份

            }
            else if ([@"vip_forever" isEqualToString:self.vip_type])
            {
                self.nianKaTipLable.hidden = YES;
                self.yongJiuTipLable.hidden = NO;
                self.auth_vip = [NSNumber numberWithInt:2];
                kaiTongHuiYuanQueRenViewTipLable.text = @"永久卡会员开通成功";
                [NormalUse defaultsSetObject:[NSNumber numberWithInt:2] forKey:@"UserAlsoVip"];//本地存储会员身份

            }
            else
            {
                self.nianKaTipLable.hidden = YES;
                self.yongJiuTipLable.hidden = NO;
                self.auth_vip = [NSNumber numberWithInt:3];
                kaiTongHuiYuanQueRenViewTipLable.text = @"蛟龙炮神卡会员开通成功";
                [NormalUse defaultsSetObject:[NSNumber numberWithInt:3] forKey:@"UserAlsoVip"];//本地存储会员身份

            }
            
        }
        else
        {
            
            if(status==11402)
            {
                ChongZhiOrHuiYuanAlertView * view = [[ChongZhiOrHuiYuanAlertView alloc] initWithFrame:CGRectZero];
                view.alsoFromVipVC = YES;
                [view initData];
                [self.view addSubview:view];

            }
            else
            {
                [NormalUse showToastView:msg view:self.view];

            }
            
        }
        
    }];

}
-(void)kaiTongSuccessCloseTipKuangView
{
    [self.kaiTongSuccessTipView removeFromSuperview];
}

#pragma mark NewPagedFlowView Delegate
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    
    return CGSizeMake(WIDTH_PingMu-60*BiLiWidth,flowView.frame.size.height);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    if (subIndex==-1) {
        subIndex = subIndex+1;
    }
    
   // NSDictionary * info = [self.bannerArray objectAtIndex:subIndex];
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    self.pageControl.currentPage = pageNumber;
    [self.itemScrollView setContentOffset:CGPointMake(WIDTH_PingMu*pageNumber, 0)];
    
//    self.kaiTongJinBiLable.text = [NSString stringWithFormat:@"%@金币开启",[NormalUse getJinBiStr:@"vip_forever_coin"]];
// self.kaiTongJinBiLable.text = [NSString stringWithFormat:@"%@金币开启",[NormalUse getJinBiStr:@"vip_year_coin"]];

    if (pageNumber==0) {
        
        self.vip_type = @"vip_year";
        
        if(self.auth_vip.intValue==1)
        {
            self.kaiTongButton.enabled = NO;
            self.kaiTongJinBiLable.text = @"已开通";
        }
        
        else
        {
            self.kaiTongButton.enabled = YES;
            self.kaiTongJinBiLable.text = [NSString stringWithFormat:@"%@金币开启",[NormalUse getJinBiStr:@"vip_year_coin"]];
        }
    }
    else if (pageNumber==1)
    {
        self.vip_type = @"svip_forever";
        
        if(self.auth_vip.intValue==3)
        {
            self.kaiTongButton.enabled = NO;
            self.kaiTongJinBiLable.text = @"已开通";

        }
        else
        {
            self.kaiTongButton.enabled = YES;
            self.kaiTongJinBiLable.text = [NSString stringWithFormat:@"%@金币开启",[NormalUse getJinBiStr:@"svip_forever_coin"]];
        }
    }
    else
    {
        self.vip_type = @"vip_forever";
        
        if(self.auth_vip.intValue==2)
        {
            self.kaiTongButton.enabled = NO;
            self.kaiTongJinBiLable.text = @"已开通";

        }
        else
        {
            self.kaiTongButton.enabled = YES;
            self.kaiTongJinBiLable.text = [NSString stringWithFormat:@"%@金币开启",[NormalUse getJinBiStr:@"vip_forever_coin"]];
        }
    }
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
   bannerView.mainImageView.image = [UIImage imageNamed:[self.bannerArray objectAtIndex:index]];
    if (index==0) {
        
        bannerView.tipLable1.text = [NSString stringWithFormat:@"%@元 原价%@元",[NormalUse getJinBiStr:@"vip_year_coin"],@"1000"];
        bannerView.tipLable.text = @"";
        bannerView.lineView.backgroundColor = [UIColor clearColor];
        
        bannerView.tipLable1.font = [UIFont systemFontOfSize:10*BiLiWidth];
        bannerView.tipLable1.textColor = RGBFormUIColor(0xB2B2B2);
        bannerView.lineView1.backgroundColor = RGBFormUIColor(0xB2B2B2);
        
        NSString * str = [NSString stringWithFormat:@"%@元 原价%@元",[NormalUse getJinBiStr:@"vip_year_coin"],@"1000"];

        NSString * xianJiaStr = [NSString stringWithFormat:@"%@元",[NormalUse getJinBiStr:@"vip_year_coin"]];
        
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
        
        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        
        [text1 addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12*BiLiWidth]
                      range:NSMakeRange(0, xianJiaStr.length)];
        
        bannerView.tipLable1.attributedText = text1;

    }
    else if (index==1)
    {
        bannerView.tipLable1.text = @"";
        bannerView.lineView1.backgroundColor = [UIColor clearColor];

        bannerView.tipLable.text = [NSString stringWithFormat:@"%@元 原价%@元",[NormalUse getJinBiStr:@"svip_forever_coin"],@"10000"];
        bannerView.tipLable.textColor = RGBFormUIColor(0xBDA757);
        bannerView.lineView.backgroundColor = RGBFormUIColor(0xBDA757);
        bannerView.tipLable.font = [UIFont systemFontOfSize:10*BiLiWidth];

        NSString * str = [NSString stringWithFormat:@"%@元 原价%@元",[NormalUse getJinBiStr:@"svip_forever_coin"],@"10000"];
        NSString * xianJiaStr = [NSString stringWithFormat:@"%@元",[NormalUse getJinBiStr:@"svip_forever_coin"]];
        
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
        
        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        
        [text1 addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12*BiLiWidth]
                      range:NSMakeRange(0, xianJiaStr.length)];
        
        bannerView.tipLable.attributedText = text1;

    }
    else
    {
        
        bannerView.tipLable.text = @"";
        bannerView.lineView.backgroundColor = [UIColor clearColor];

        bannerView.tipLable1.textColor = RGBFormUIColor(0xBDA757);
        bannerView.lineView1.backgroundColor = RGBFormUIColor(0xBDA757);
        bannerView.tipLable1.font = [UIFont systemFontOfSize:10*BiLiWidth];

        
        NSString * str = [NSString stringWithFormat:@"%@元 原价%@元",[NormalUse getJinBiStr:@"vip_forever_coin"],@"10000"];
        NSString * xianJiaStr = [NSString stringWithFormat:@"%@元",[NormalUse getJinBiStr:@"vip_forever_coin"]];
        
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
        
        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        
        [text1 addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12*BiLiWidth]
                      range:NSMakeRange(0, xianJiaStr.length)];
        
        bannerView.tipLable1.attributedText = text1;


    }
    return bannerView;
}

@end
