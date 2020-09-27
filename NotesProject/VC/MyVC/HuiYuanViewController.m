//
//  HuiYuanViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/11.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HuiYuanViewController.h"

@interface HuiYuanViewController ()



@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIScrollView * topScrollView;

@property(nonatomic,strong)Lable_ImageButton * button1;
@property(nonatomic,strong)Lable_ImageButton * button2;
@property(nonatomic,strong)Lable_ImageButton * button3;
@property(nonatomic,strong)Lable_ImageButton * button4;

@property(nonatomic,strong)UILabel * kaiTongJinBiLable;

@property(nonatomic,strong)UILabel * nianKaTipLable;

@property(nonatomic,strong)UILabel * yongJiuTipLable;

@property(nonatomic,strong)NSString * vip_type;//vip_type vip_forever永久会员 vip_year年会员

@end

@implementation HuiYuanViewController

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
    [self.mainScrollView addSubview:self.topScrollView];
    
    Lable_ImageButton * nianKaVipButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(12*BiLiWidth, 0, 310*BiLiWidth, 157*BiLiWidth)];
    nianKaVipButton.clipsToBounds = YES;
    [nianKaVipButton setBackgroundImage:[UIImage imageNamed:@"huiYuan_yearCard"] forState:UIControlStateNormal];
    [nianKaVipButton addTarget:self action:@selector(nianKaVipClick) forControlEvents:UIControlEventTouchUpInside];
    nianKaVipButton.button_lable.frame = CGRectMake(0, 61.5*BiLiWidth, nianKaVipButton.width, 20*BiLiWidth);
    nianKaVipButton.button_lable.font = [UIFont systemFontOfSize:20*BiLiWidth];
    nianKaVipButton.button_lable.textAlignment = NSTextAlignmentCenter;
    nianKaVipButton.button_lable.textColor = [UIColor whiteColor];
    nianKaVipButton.button_lable.text = @"永恒钻石VIP";
    nianKaVipButton.button_lable1.frame = CGRectMake(0, nianKaVipButton.button_lable.top+nianKaVipButton.button_lable.height+11*BiLiWidth, nianKaVipButton.width, 14*BiLiWidth);
    nianKaVipButton.button_lable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
    nianKaVipButton.button_lable1.textAlignment = NSTextAlignmentCenter;
    nianKaVipButton.button_lable1.textColor = [UIColor whiteColor];
    nianKaVipButton.button_lable1.text = @"年卡";
    [self.topScrollView addSubview:nianKaVipButton];
    
    Lable_ImageButton * yongJiuVipButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(nianKaVipButton.left+nianKaVipButton.width+9*BiLiWidth, 0, 310*BiLiWidth, 157*BiLiWidth)];
    yongJiuVipButton.clipsToBounds = YES;
    [yongJiuVipButton setBackgroundImage:[UIImage imageNamed:@"huiYuan_yongJiu"] forState:UIControlStateNormal];
    [yongJiuVipButton addTarget:self action:@selector(yongJiuVipClick) forControlEvents:UIControlEventTouchUpInside];
    yongJiuVipButton.button_lable.frame = CGRectMake(0, 61.5*BiLiWidth, yongJiuVipButton.width, 20*BiLiWidth);
    yongJiuVipButton.button_lable.font = [UIFont systemFontOfSize:20*BiLiWidth];
    yongJiuVipButton.button_lable.textAlignment = NSTextAlignmentCenter;
    yongJiuVipButton.button_lable.textColor = [UIColor whiteColor];
    yongJiuVipButton.button_lable.text = @"最强王者VIP";
    yongJiuVipButton.button_lable1.frame = CGRectMake(0, yongJiuVipButton.button_lable.top+yongJiuVipButton.button_lable.height+11*BiLiWidth, yongJiuVipButton.width, 14*BiLiWidth);
    yongJiuVipButton.button_lable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
    yongJiuVipButton.button_lable1.textAlignment = NSTextAlignmentCenter;
    yongJiuVipButton.button_lable1.textColor = [UIColor whiteColor];
    yongJiuVipButton.button_lable1.text = @"永久卡";
    [self.topScrollView addSubview:yongJiuVipButton];
    
    self.nianKaTipLable = [[UILabel alloc] initWithFrame:CGRectMake(-8*BiLiWidth, 115*BiLiWidth, 68*BiLiWidth, 25*BiLiWidth)];
    self.nianKaTipLable.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.nianKaTipLable.layer.cornerRadius = 25*BiLiWidth/2;
    self.nianKaTipLable.layer.masksToBounds = YES;
    self.nianKaTipLable.textAlignment = NSTextAlignmentCenter;
    self.nianKaTipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.nianKaTipLable.textColor = [UIColor whiteColor];
    self.nianKaTipLable.text = @"已拥有";
    [nianKaVipButton addSubview:self.nianKaTipLable];
    
    self.yongJiuTipLable = [[UILabel alloc] initWithFrame:CGRectMake(-8*BiLiWidth, 115*BiLiWidth, 68*BiLiWidth, 25*BiLiWidth)];
    self.yongJiuTipLable.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.yongJiuTipLable.layer.cornerRadius = 25*BiLiWidth/2;
    self.yongJiuTipLable.layer.masksToBounds = YES;
    self.yongJiuTipLable.textAlignment = NSTextAlignmentCenter;
    self.yongJiuTipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.yongJiuTipLable.textColor = [UIColor whiteColor];
    self.yongJiuTipLable.text = @"已拥有";
    [yongJiuVipButton addSubview:self.yongJiuTipLable];


    //auth_vip 2终身会员 1年会员 0非会员
    NSNumber * auth_vip = [self.info objectForKey:@"auth_vip"];
    if (auth_vip.intValue!=1) {
        
        self.nianKaTipLable.hidden = YES;
        
    }
     if (auth_vip.intValue != 2)
    {
        self.yongJiuTipLable.hidden = YES;
    }

    
    [self.topScrollView setContentSize:CGSizeMake(yongJiuVipButton.left+yongJiuVipButton.width+20*BiLiWidth, self.topScrollView.height)];

    
    UIImageView * tieQuanImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-16*BiLiWidth*329/38)/2, nianKaVipButton.top+nianKaVipButton.height+36*BiLiWidth, 16*BiLiWidth*329/38, 16*BiLiWidth)];
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


    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-153*BiLiWidth)/2, self.button4.top+self.button4.height+32*BiLiWidth, 153*BiLiWidth, 40*BiLiWidth)];
    [tiJiaoButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:tiJiaoButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xF8E29F);
    UIColor *colorTwo = RGBFormUIColor(0xEAC384);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = tiJiaoButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [tiJiaoButton.layer addSublayer:gradientLayer1];
    
    self.kaiTongJinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tiJiaoButton.width, tiJiaoButton.height)];
    self.kaiTongJinBiLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.kaiTongJinBiLable.textAlignment = NSTextAlignmentCenter;
    self.kaiTongJinBiLable.textColor = [UIColor whiteColor];
    [tiJiaoButton addSubview:self.kaiTongJinBiLable];
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, tiJiaoButton.top+tiJiaoButton.height+30*BiLiWidth)];

    [nianKaVipButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
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


}
-(void)yongJiuVipClick
{
    self.button1.button_lable1.text = [NSString stringWithFormat:@"获得%@金币",[NormalUse getJinBiStr:@"vip_fpack_coin"]];
    self.button2.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_funlock_num"]];
    self.button3.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_fpost_num"]];
    self.kaiTongJinBiLable.text = [NSString stringWithFormat:@"%@金币开启",[NormalUse getJinBiStr:@"vip_forever_coin"]];

    self.vip_type = @"vip_forever";
    

}
-(void)tiJiaoButtonClick
{
    [NormalUse showMessageLoadView:@"开通中..." vc:self];
    [HTTPModel kaiTongHuiYuan:[[NSDictionary alloc]initWithObjectsAndKeys:self.vip_type,@"vip_type", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        [NormalUse removeMessageLoadingView:self];
        if (status==1) {
            
            if ([@"vip_year" isEqualToString:self.vip_type]) {
                
                self.nianKaTipLable.hidden = NO;
            }
            else
            {
                self.yongJiuTipLable.hidden = NO;

            }
            [NormalUse showToastView:msg view:self.view];

        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
        
    }];
}
@end
