//
//  HuiYuanViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/11.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HuiYuanViewController.h"

@interface HuiYuanViewController ()<UIScrollViewDelegate>



@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIScrollView * topScrollView;

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
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.height+self.topNavView.top, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.height+self.topNavView.top))];
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 157*BiLiWidth)];
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.clipsToBounds = NO;
    self.topScrollView.pagingEnabled = YES;
    self.topScrollView.delegate = self;
    self.topScrollView.tag = 1001;
    [self.mainScrollView addSubview:self.topScrollView];
    
    self.nianKaVipButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(12*BiLiWidth, 0, 310*BiLiWidth, 157*BiLiWidth)];
    self.nianKaVipButton.clipsToBounds = YES;
    [self.nianKaVipButton setBackgroundImage:[UIImage imageNamed:@"huiYuan_yearCard"] forState:UIControlStateNormal];
//    [self.nianKaVipButton addTarget:self action:@selector(nianKaVipClick) forControlEvents:UIControlEventTouchUpInside];
    self.nianKaVipButton.button_lable.frame = CGRectMake(0, 61.5*BiLiWidth, self.nianKaVipButton.width, 20*BiLiWidth);
    self.nianKaVipButton.button_lable.font = [UIFont systemFontOfSize:20*BiLiWidth];
    self.nianKaVipButton.button_lable.textAlignment = NSTextAlignmentCenter;
    self.nianKaVipButton.button_lable.textColor = [UIColor whiteColor];
    self.nianKaVipButton.button_lable.text = @"永恒钻石VIP";
    self.nianKaVipButton.button_lable1.frame = CGRectMake(0, self.nianKaVipButton.button_lable.top+self.nianKaVipButton.button_lable.height+11*BiLiWidth, self.nianKaVipButton.width, 14*BiLiWidth);
    self.nianKaVipButton.button_lable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.nianKaVipButton.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.nianKaVipButton.button_lable1.textColor = [UIColor whiteColor];
    self.nianKaVipButton.button_lable1.text = @"年卡";
    [self.topScrollView addSubview:self.nianKaVipButton];
    
    
    self.yongJiuVipButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(self.nianKaVipButton.left+self.nianKaVipButton.width+5*BiLiWidth, 0, 310*BiLiWidth, 157*BiLiWidth)];
    self.yongJiuVipButton.clipsToBounds = YES;
    [self.yongJiuVipButton setBackgroundImage:[UIImage imageNamed:@"huiYuan_yongJiu"] forState:UIControlStateNormal];
//    [self.yongJiuVipButton addTarget:self action:@selector(yongJiuVipClick) forControlEvents:UIControlEventTouchUpInside];
    self.yongJiuVipButton.button_lable.frame = CGRectMake(0, 61.5*BiLiWidth, self.yongJiuVipButton.width, 20*BiLiWidth);
    self.yongJiuVipButton.button_lable.font = [UIFont systemFontOfSize:20*BiLiWidth];
    self.yongJiuVipButton.button_lable.textAlignment = NSTextAlignmentCenter;
    self.yongJiuVipButton.button_lable.textColor = [UIColor whiteColor];
    self.yongJiuVipButton.button_lable.text = @"最强王者VIP";
    self.yongJiuVipButton.button_lable1.frame = CGRectMake(0, self.yongJiuVipButton.button_lable.top+self.yongJiuVipButton.button_lable.height+11*BiLiWidth, self.yongJiuVipButton.width, 14*BiLiWidth);
    self.yongJiuVipButton.button_lable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.yongJiuVipButton.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.yongJiuVipButton.button_lable1.textColor = [UIColor whiteColor];
    self.yongJiuVipButton.button_lable1.text = @"永久卡";
    [self.topScrollView addSubview:self.yongJiuVipButton];
    
    self.yongJiuVipButton.transform = CGAffineTransformMakeScale(0.9, 0.9);

    
    self.nianKaTipLable = [[UILabel alloc] initWithFrame:CGRectMake(-8*BiLiWidth, 115*BiLiWidth, 68*BiLiWidth, 25*BiLiWidth)];
    self.nianKaTipLable.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.nianKaTipLable.layer.cornerRadius = 25*BiLiWidth/2;
    self.nianKaTipLable.layer.masksToBounds = YES;
    self.nianKaTipLable.textAlignment = NSTextAlignmentCenter;
    self.nianKaTipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.nianKaTipLable.textColor = [UIColor whiteColor];
    self.nianKaTipLable.text = @"已拥有";
    [self.nianKaVipButton addSubview:self.nianKaTipLable];
    
    self.yongJiuTipLable = [[UILabel alloc] initWithFrame:CGRectMake(-8*BiLiWidth, 115*BiLiWidth, 68*BiLiWidth, 25*BiLiWidth)];
    self.yongJiuTipLable.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.yongJiuTipLable.layer.cornerRadius = 25*BiLiWidth/2;
    self.yongJiuTipLable.layer.masksToBounds = YES;
    self.yongJiuTipLable.textAlignment = NSTextAlignmentCenter;
    self.yongJiuTipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.yongJiuTipLable.textColor = [UIColor whiteColor];
    self.yongJiuTipLable.text = @"已拥有";
    [self.yongJiuVipButton addSubview:self.yongJiuTipLable];


    //auth_vip 2终身会员 1年会员 0非会员
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

    
    [self.topScrollView setContentSize:CGSizeMake(self.yongJiuVipButton.left+self.yongJiuVipButton.width+20*BiLiWidth, self.topScrollView.height)];

    
    UIImageView * tieQuanImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-16*BiLiWidth*329/38)/2, self.nianKaVipButton.top+self.nianKaVipButton.height+36*BiLiWidth, 16*BiLiWidth*329/38, 16*BiLiWidth)];
    tieQuanImageView.image = [UIImage imageNamed:@"huiYuan_tip"];
    [self.mainScrollView addSubview:tieQuanImageView];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, tieQuanImageView.top, WIDTH_PingMu, 15*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:16*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0x333333);
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.text = @"会员特权";
    [self.mainScrollView addSubview:tipLable];
    


    self.button1 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, tipLable.top+tipLable.height+26*BiLiWidth, WIDTH_PingMu/3, 87*BiLiWidth)];
    self.button1.button_imageView.frame = CGRectMake((self.button1.width-50*BiLiWidth)/2, 0, 50*BiLiWidth, 50*BiLiWidth);
    self.button1.button_imageView.image = [UIImage imageNamed:@"huiYuan_jinBi"];
    self.button1.button_lable.frame = CGRectMake(0, self.button1.button_imageView.top+self.button1.button_imageView.height+11*BiLiWidth, self.button1.width, 13*BiLiWidth);
    self.button1.button_lable.textAlignment = NSTextAlignmentCenter;
    self.button1.button_lable.textColor = RGBFormUIColor(0x333333);
    self.button1.button_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13*BiLiWidth];
    self.button1.button_lable.text = @"金币礼包";
    self.button1.button_lable1.frame = CGRectMake(0, self.button1.button_lable.top+self.button1.button_lable.height+7*BiLiWidth, self.button1.width, 12*BiLiWidth);
    self.button1.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.button1.button_lable1.textColor = RGBFormUIColor(0x999999);
    self.button1.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.mainScrollView addSubview:self.button1];

    self.button2 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/3, self.button1.top, WIDTH_PingMu/3, 87*BiLiWidth)];
    self.button2.button_imageView.frame = CGRectMake((self.button2.width-50*BiLiWidth)/2, 0, 50*BiLiWidth, 50*BiLiWidth);
    self.button2.button_imageView.image = [UIImage imageNamed:@"huiYuan_freeMessage"];
    self.button2.button_lable.frame = CGRectMake(0, self.button2.button_imageView.top+self.button2.button_imageView.height+11*BiLiWidth, self.button2.width, 15*BiLiWidth);
    self.button2.button_lable.textAlignment = NSTextAlignmentCenter;
    self.button2.button_lable.textColor = RGBFormUIColor(0x333333);
    self.button2.button_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13*BiLiWidth];
    self.button2.button_lable.text = @"基本信息免费看";
    self.button2.button_lable1.frame = CGRectMake(0, self.button2.button_lable.top+self.button2.button_lable.height+7*BiLiWidth, self.button2.width, 12*BiLiWidth);
    self.button2.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.button2.button_lable1.textColor = RGBFormUIColor(0x999999);
    self.button2.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.mainScrollView addSubview:self.button2];

    
    self.button3 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/3*2, self.button1.top, WIDTH_PingMu/3, 87*BiLiWidth)];
    self.button3.button_imageView.frame = CGRectMake((self.button1.width-50*BiLiWidth)/2, 0, 50*BiLiWidth, 50*BiLiWidth);
    self.button3.button_imageView.image = [UIImage imageNamed:@"huiYuan_freeFaBu"];
    self.button3.button_lable.frame = CGRectMake(0, self.button3.button_imageView.top+self.button3.button_imageView.height+11*BiLiWidth, self.button3.width, 15*BiLiWidth);
    self.button3.button_lable.textAlignment = NSTextAlignmentCenter;
    self.button3.button_lable.textColor = RGBFormUIColor(0x333333);
    self.button3.button_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13*BiLiWidth];
    self.button3.button_lable.text = @"免费发布信息";
    self.button3.button_lable1.frame = CGRectMake(0, self.button3.button_lable.top+self.button3.button_lable.height+7*BiLiWidth, self.button3.width, 12*BiLiWidth);
    self.button3.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.button3.button_lable1.textColor = RGBFormUIColor(0x999999);
    self.button3.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.mainScrollView addSubview:self.button3];
    
    self.button4 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.button1.top+self.button1.height+34*BiLiWidth, WIDTH_PingMu/3, 87*BiLiWidth)];
    self.button4.button_imageView.frame = CGRectMake((self.button1.width-50*BiLiWidth)/2, 0, 50*BiLiWidth, 50*BiLiWidth);
    self.button4.button_imageView.image = [UIImage imageNamed:@"huiYuan_more"];
    self.button4.button_lable.frame = CGRectMake(0, self.button3.button_imageView.top+self.button3.button_imageView.height+11*BiLiWidth, self.button3.width, 15*BiLiWidth);
    self.button4.button_lable.textAlignment = NSTextAlignmentCenter;
    self.button4.button_lable.textColor = RGBFormUIColor(0x333333);
    self.button4.button_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13*BiLiWidth];
    self.button4.button_lable.text = @"更多权益";
    self.button4.button_lable1.frame = CGRectMake(0, self.button3.button_lable.top+self.button3.button_lable.height+7*BiLiWidth, self.button3.width, 12*BiLiWidth);
    self.button4.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.button4.button_lable1.textColor = RGBFormUIColor(0x999999);
    self.button4.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.button4.button_lable1.text = @"敬请期待";
    [self.mainScrollView addSubview:self.button4];


    self.kaiTongButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-153*BiLiWidth)/2, self.button4.top+self.button4.height+32*BiLiWidth, 153*BiLiWidth, 40*BiLiWidth)];
    [self.kaiTongButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.kaiTongButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xF8E29F);
    UIColor *colorTwo = RGBFormUIColor(0xEAC384);
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

//    [self.nianKaVipButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self nianKaVipClick];

}
-(void)nianKaVipClick
{
    /*
    "vip_funlock_num":"15",//终身会员当天解锁次数
    "vip_fpost_num":"15",//终身会员当天发帖次数
    "vip_ypost_num":"10",//年会员当天发帖次数
    "vip_yunlock_num":"10",//年会员当天解锁次数
    "vip_fpack_coin":"1000",//开通终身会员送的金币
    "vip_ypack_coin":"500",//开通年会员送的金币
     
     "vip_forever_coin":"1000000",//终身会员金币
     "vip_year_coin":"100000",//年会员金币

     */

    self.button1.button_lable1.text = [NSString stringWithFormat:@"获得%@金币",[NormalUse getJinBiStr:@"vip_ypack_coin"]];
    self.button2.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_yunlock_num"]];
    self.button3.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_ypost_num"]];
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
    self.button1.button_lable1.text = [NSString stringWithFormat:@"获得%@金币",[NormalUse getJinBiStr:@"vip_fpack_coin"]];
    self.button2.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_funlock_num"]];
    self.button3.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_fpost_num"]];
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
-(void)tiJiaoButtonClick
{
    
    if(self.auth_vip.intValue==0)
    {

        self.kaiTongHuiYuanQueRenView.hidden = NO;
        
        if ([@"vip_year" isEqualToString:self.vip_type]) {
            
            self.kaiTongHuiYuanQueRenViewTipLable.text = @"是否确定开通年卡";

        }
        else
        {
            self.kaiTongHuiYuanQueRenViewTipLable.text = @"是否确定开通永久卡";
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

            self.kaiTongButton.hidden = YES;

            //2终身会员 1年会员 0非会员
            if ([@"vip_year" isEqualToString:self.vip_type]) {
                
                self.nianKaTipLable.hidden = NO;
                self.yongJiuTipLable.hidden = YES;
                self.auth_vip = [NSNumber numberWithInt:1];
                kaiTongHuiYuanQueRenViewTipLable.text = @"年卡会员开通成功";
                
                [NormalUse defaultsSetObject:[NSNumber numberWithInt:1] forKey:@"UserAlsoVip"];//本地存储会员身份

            }
            else
            {
                self.nianKaTipLable.hidden = YES;
                self.yongJiuTipLable.hidden = NO;
                self.auth_vip = [NSNumber numberWithInt:2];
                kaiTongHuiYuanQueRenViewTipLable.text = @"永久卡会员开通成功";
                [NormalUse defaultsSetObject:[NSNumber numberWithInt:2] forKey:@"UserAlsoVip"];//本地存储会员身份

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
-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (scrollView.tag==1001) {
        
//        int  specialIndex = scrollView.contentOffset.x/scrollView.width;
        
        if (scrollView.contentOffset.x==0)
        {
            [UIView animateWithDuration:0.25 animations:^{
                
                self.nianKaVipButton.transform = CGAffineTransformIdentity;
                self.yongJiuVipButton.transform = CGAffineTransformMakeScale(0.9, 0.9);

            }];
            [self nianKaVipClick];
        }
        else
        {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.yongJiuVipButton.transform = CGAffineTransformIdentity;
                self.nianKaVipButton.transform = CGAffineTransformMakeScale(0.9, 0.9);

            }];


            [self yongJiuVipClick];
        }
        
    }

}

@end
