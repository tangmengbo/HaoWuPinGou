//
//  HuiYuanViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/11.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HuiYuanViewController.h"

@interface HuiYuanViewController ()

@property(nonatomic,strong)UIScrollView * topScrollView;

@property(nonatomic,strong)Lable_ImageButton * button1;
@property(nonatomic,strong)Lable_ImageButton * button2;
@property(nonatomic,strong)Lable_ImageButton * button3;

@property(nonatomic,strong)UILabel * kaiTongJinBiLable;

@end

@implementation HuiYuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    self.topTitleLale.text = @"VIP 会员";
    
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+20*BiLiWidth, WIDTH_PingMu, 200*BiLiWidth)];
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.topScrollView];
    
    UIButton * nianKaVipButton = [[UIButton alloc] initWithFrame:CGRectMake(20*BiLiWidth, 0, WIDTH_PingMu/3*2, 146*BiLiWidth)];
    nianKaVipButton.backgroundColor = [UIColor redColor];
    [nianKaVipButton addTarget:self action:@selector(nianKaVipClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topScrollView addSubview:nianKaVipButton];
    
    UIButton * yongJiuVipButton = [[UIButton alloc] initWithFrame:CGRectMake(nianKaVipButton.left+nianKaVipButton.width+20*BiLiWidth, 0, WIDTH_PingMu/3*2, 146*BiLiWidth)];
    yongJiuVipButton.backgroundColor = [UIColor greenColor];
    [yongJiuVipButton addTarget:self action:@selector(yongJiuVipClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topScrollView addSubview:yongJiuVipButton];
    
    //auth_vip 2终身会员 1年会员 0非会员
    NSNumber * auth_vip = [self.info objectForKey:@"auth_vip"];
    if (auth_vip.intValue!=1) {
        
        UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(nianKaVipButton.width-50*BiLiWidth, 0, 40*BiLiWidth, 40*BiLiWidth)];
        tipLable.backgroundColor = [UIColor greenColor];
        tipLable.layer.cornerRadius = 20*BiLiWidth;
        tipLable.layer.masksToBounds = YES;
        tipLable.textAlignment = NSTextAlignmentCenter;
        tipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        tipLable.textColor = [UIColor whiteColor];
        tipLable.text = @"已拥有";
        tipLable.transform = CGAffineTransformMakeRotation(45 *M_PI / 180.0);
        [nianKaVipButton addSubview:tipLable];
    }
    else if (auth_vip.intValue == 2)
    {
        
    }

    
    [self.topScrollView setContentSize:CGSizeMake(yongJiuVipButton.left+yongJiuVipButton.width+20*BiLiWidth, self.topScrollView.height)];

    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(30*BiLiWidth, self.topScrollView.top+self.topScrollView.height+30*BiLiWidth, 100*BiLiWidth, 1)];
    lineView1.backgroundColor = RGBFormUIColor(0x343434);
    [self.view addSubview:lineView1];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, lineView1.top-7*BiLiWidth, WIDTH_PingMu, 15*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0x343434);
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.text = @"会员特权";
    [self.view addSubview:tipLable];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-100*BiLiWidth-30*BiLiWidth, self.topScrollView.top+self.topScrollView.height+30*BiLiWidth, 100*BiLiWidth, 1)];
    lineView2.backgroundColor = RGBFormUIColor(0x343434);
    [self.view addSubview:lineView2];


    self.button1 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, tipLable.top+tipLable.height+50*BiLiWidth, WIDTH_PingMu/3, 87*BiLiWidth)];
    self.button1.button_imageView.frame = CGRectMake((self.button1.width-40*BiLiWidth)/2, 0, 40*BiLiWidth, 40*BiLiWidth);
    self.button1.button_imageView.backgroundColor = [UIColor greenColor];
    self.button1.button_lable.frame = CGRectMake(0, self.button1.button_imageView.top+self.button1.button_imageView.height+10*BiLiWidth, self.button1.width, 15*BiLiWidth);
    self.button1.button_lable.textAlignment = NSTextAlignmentCenter;
    self.button1.button_lable.textColor = RGBFormUIColor(0x343434);
    self.button1.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.button1.button_lable.text = @"金币礼包";
    self.button1.button_lable1.frame = CGRectMake(0, self.button1.button_lable.top+self.button1.button_lable.height+10*BiLiWidth, self.button1.width, 12*BiLiWidth);
    self.button1.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.button1.button_lable1.textColor = RGBFormUIColor(0x343434);
    self.button1.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.view addSubview:self.button1];

    self.button2 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/3, tipLable.top+tipLable.height+50*BiLiWidth, WIDTH_PingMu/3, 87*BiLiWidth)];
    self.button2.button_imageView.frame = CGRectMake((self.button2.width-40*BiLiWidth)/2, 0, 40*BiLiWidth, 40*BiLiWidth);
    self.button2.button_imageView.backgroundColor = [UIColor greenColor];
    self.button2.button_lable.frame = CGRectMake(0, self.button2.button_imageView.top+self.button2.button_imageView.height+10*BiLiWidth, self.button2.width, 15*BiLiWidth);
    self.button2.button_lable.textAlignment = NSTextAlignmentCenter;
    self.button2.button_lable.textColor = RGBFormUIColor(0x343434);
    self.button2.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.button2.button_lable.text = @"基本信息免费看";
    self.button2.button_lable1.frame = CGRectMake(0, self.button2.button_lable.top+self.button2.button_lable.height+10*BiLiWidth, self.button2.width, 12*BiLiWidth);
    self.button2.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.button2.button_lable1.textColor = RGBFormUIColor(0x343434);
    self.button2.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.view addSubview:self.button2];

    
    self.button3 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/3*2, tipLable.top+tipLable.height+50*BiLiWidth, WIDTH_PingMu/3, 87*BiLiWidth)];
    self.button3.button_imageView.frame = CGRectMake((self.button1.width-40*BiLiWidth)/2, 0, 40*BiLiWidth, 40*BiLiWidth);
    self.button3.button_imageView.backgroundColor = [UIColor greenColor];
    self.button3.button_lable.frame = CGRectMake(0, self.button3.button_imageView.top+self.button3.button_imageView.height+10*BiLiWidth, self.button3.width, 15*BiLiWidth);
    self.button3.button_lable.textAlignment = NSTextAlignmentCenter;
    self.button3.button_lable.textColor = RGBFormUIColor(0x343434);
    self.button3.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.button3.button_lable.text = @"免费发布信息";
    self.button3.button_lable1.frame = CGRectMake(0, self.button3.button_lable.top+self.button3.button_lable.height+10*BiLiWidth, self.button3.width, 12*BiLiWidth);
    self.button3.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.button3.button_lable1.textColor = RGBFormUIColor(0x343434);
    self.button3.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.view addSubview:self.button3];

    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, HEIGHT_PingMu-60*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [tiJiaoButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tiJiaoButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
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
    self.kaiTongJinBiLable.text = [NSString stringWithFormat:@"¥%@开启",[NormalUse getJinBiStr:@"vip_year_coin"]];

}
-(void)yongJiuVipClick
{
    self.button1.button_lable1.text = [NSString stringWithFormat:@"获得%@金币",[NormalUse getJinBiStr:@"vip_fpack_coin"]];
    self.button2.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_funlock_num"]];
    self.button3.button_lable1.text = [NSString stringWithFormat:@"每日%@次",[NormalUse getJinBiStr:@"vip_fpost_num"]];
    self.kaiTongJinBiLable.text = [NSString stringWithFormat:@"¥%@开启",[NormalUse getJinBiStr:@"vip_forever_coin"]];

}
-(void)tiJiaoButtonClick
{
    
}
@end
