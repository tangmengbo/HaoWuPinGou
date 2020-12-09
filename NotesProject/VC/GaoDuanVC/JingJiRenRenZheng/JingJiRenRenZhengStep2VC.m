//
//  JingJiRenRenZhengStep2VC.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "JingJiRenRenZhengStep2VC.h"

@interface JingJiRenRenZhengStep2VC ()

@end

@implementation JingJiRenRenZhengStep2VC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topTitleLale.text = @"认证";
    self.loadingFullScreen = @"yes";
    [self initTopStepView];
}
-(void)initTopStepView
{
    
    UILabel * step1Lable = [[UILabel alloc] initWithFrame:CGRectMake(56*BiLiWidth, self.topNavView.top+self.topNavView.height+20*BiLiWidth, 22*BiLiWidth, 22*BiLiWidth)];
    step1Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step1Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step1Lable.textAlignment = NSTextAlignmentCenter;
    step1Lable.text = @"1";
    step1Lable.layer.masksToBounds = YES;
    step1Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step1Lable.layer.cornerRadius = 11*BiLiWidth;
    [self.view addSubview:step1Lable];
    
    UILabel * step1TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step1Lable.left-30*BiLiWidth,step1Lable.top+step1Lable.height+8.5*BiLiWidth , step1Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step1TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step1TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step1TipLable.text = @"填写个人资料";
    step1TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step1TipLable];
    
    
    UIButton * step1BottomView = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-22*BiLiWidth)/2, step1Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.cornerRadius = 11*BiLiWidth;
    gradientLayer.frame = step1BottomView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    [step1BottomView.layer addSublayer:gradientLayer];
    [self.view addSubview:step1BottomView];

    
    UILabel * step2Lable = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH_PingMu-22*BiLiWidth)/2, step1Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step2Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step2Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step2Lable.textAlignment = NSTextAlignmentCenter;
    step2Lable.layer.cornerRadius = 11*BiLiWidth;
    step2Lable.layer.masksToBounds = YES;
    step2Lable.text = @"2";
    [self.view addSubview:step2Lable];
    
    UILabel * step2TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step2Lable.left-30*BiLiWidth,step2Lable.top+step2Lable.height+8.5*BiLiWidth , step2Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step2TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step2TipLable.textColor = RGBFormUIColor(0x343434);
    step2TipLable.text = @"缴纳押金";
    step2TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step2TipLable];

    
    UILabel * step3Lable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-22*BiLiWidth-56*BiLiWidth, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step3Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step3Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step3Lable.textAlignment = NSTextAlignmentCenter;
    step3Lable.layer.cornerRadius = 11*BiLiWidth;
    step3Lable.layer.masksToBounds = YES;
    step3Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step3Lable.text = @"3";
    [self.view addSubview:step3Lable];
    
    UILabel * step3TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step3Lable.left-30*BiLiWidth,step3Lable.top+step3Lable.height+8.5*BiLiWidth , step3Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step3TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step3TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step3TipLable.text = @"等待审核";
    step3TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step3TipLable];

    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-318*BiLiWidth)/2, step3TipLable.top+step3TipLable.height+30*BiLiWidth, 318*BiLiWidth, 206*BiLiWidth)];
    tipImageView.image = [UIImage imageNamed:@"jiaoLaYaJin_jingJiRen"];
    [self.view addSubview:tipImageView];
    
    self.jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, 160*BiLiWidth, 150*BiLiWidth, 24*BiLiWidth)];
    self.jinBiLable.font = [UIFont systemFontOfSize:24*BiLiWidth];
    self.jinBiLable.textColor = RGBFormUIColor(0x333333);
    [tipImageView addSubview:self.jinBiLable];
    
    NSString * jinBiStr;
    NSString * type = [self.info objectForKey:@"type"];
    if ([@"1" isEqualToString:type]) {
        
        jinBiStr = [NSString stringWithFormat:@"%@ 金币",[NormalUse getJinBiStr:@"normal_auth_coin"]];
    }
    else
    {
        jinBiStr = [NSString stringWithFormat:@"%@ 金币",[NormalUse getJinBiStr:@"agent_auth_coin"]];

    }
    
     
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:jinBiStr];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x999999) range:NSMakeRange(jinBiStr.length-2, 2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*BiLiWidth] range:NSMakeRange(jinBiStr.length-2, 2)];
    self.jinBiLable.attributedText = str;
    
    UILabel * renZhengTipLable = [[UILabel alloc] initWithFrame:CGRectMake(tipImageView.width-175*BiLiWidth, self.jinBiLable.top, 150*BiLiWidth, 24*BiLiWidth)];
    renZhengTipLable.textAlignment = NSTextAlignmentRight;
    renZhengTipLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    renZhengTipLable.text = @"申请认证所需费用";
    [tipImageView addSubview:renZhengTipLable];
    

    
    UILabel * yuELable = [[UILabel alloc] initWithFrame:CGRectMake(0, tipImageView.top+tipImageView.height+9*BiLiWidth, WIDTH_PingMu, 18*BiLiWidth)];
    yuELable.font = [UIFont systemFontOfSize:18*BiLiWidth];
    yuELable.textColor = RGBFormUIColor(0xFED062);
    yuELable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:yuELable];
    

    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, yuELable.top+yuELable.height+36*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [tiJiaoButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tiJiaoButton];
    //渐变设置
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.frame = tiJiaoButton.bounds;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [tiJiaoButton.layer addSublayer:gradientLayer1];

    UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tiJiaoButton.width, tiJiaoButton.height)];
    tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiJiaoLable.text = @"下一步";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [tiJiaoButton addSubview:tiJiaoLable];
    
    UILabel * tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(20*BiLiWidth, tiJiaoButton.top+tiJiaoButton.height+15*BiLiWidth, WIDTH_PingMu-20*BiLiWidth*2, 50*BiLiWidth)];
    tipsLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    tipsLable.textColor = RGBFormUIColor(0x333333);
    tipsLable.numberOfLines = 3;
    tipsLable.userInteractionEnabled = YES;
    [self.view addSubview:tipsLable];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quRenZheng)];
    [tipsLable addGestureRecognizer:tap];

    
    NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc] initWithString:@"提示:认证的结果可在消息中查看，认证成功后发布的信息将带有“官方认证”标签，助力您快速开单，您在认证过程中遇到任何问题，可以联系在线客服>"];
    [str1 addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x0033FF) range:NSMakeRange(str1.length-5, 5)];
    tipsLable.attributedText = str1;

    
    
    [HTTPModel getUserInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            NSNumber * coin = [responseObject objectForKey:@"coin"];
            
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前可用金币：%d",coin.intValue]];
            [str1 addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x343434) range:NSMakeRange(0, 7)];
            [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*BiLiWidth] range:NSMakeRange(0, 7)];
            yuELable.attributedText = str1;

        }
    }];

    
}
-(void)quRenZheng
{
    JinChanWebViewController * vc = [[JinChanWebViewController alloc] init];
    vc.forWhat = @"help";
    [self.navigationController pushViewController:vc animated:YES];

}


-(void)nextButtonClick
{
    
    [self xianShiLoadingView:@"提交中..." view:self.view];
    [HTTPModel jingJiRenRenZheng:self.info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            JingJiRenRenZhengStep3VC * vc = [[JingJiRenRenZhengStep3VC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        }
        else
        {
            [self yinCangLoadingView];
            if(status==11402)
            {
                ChongZhiOrHuiYuanAlertView * view = [[ChongZhiOrHuiYuanAlertView alloc] initWithFrame:CGRectZero];
                [self.view addSubview:view];

            }
            else
            {
                [NormalUse showToastView:msg view:self.view];

            }
        }
    }];
}

@end
