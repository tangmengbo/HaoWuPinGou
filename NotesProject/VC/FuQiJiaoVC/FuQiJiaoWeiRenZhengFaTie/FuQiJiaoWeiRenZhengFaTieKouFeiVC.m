//
//  FuQiJiaoWeiRenZhengFaTieKouFeiVC.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/10/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "FuQiJiaoWeiRenZhengFaTieKouFeiVC.h"

@interface FuQiJiaoWeiRenZhengFaTieKouFeiVC ()

@property(nonatomic,strong)NSString * publish_post_coin;//发帖所需金币
@property(nonatomic,strong)NSString * yuEStr;
@property(nonatomic,strong)UILabel * tiJiaoLable;


@end

@implementation FuQiJiaoWeiRenZhengFaTieKouFeiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingFullScreen = @"yes";

    self.topTitleLale.text = @"支付";
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, 12*BiLiWidth)];
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.textColor = RGBFormUIColor(0x999999);
    [self.view addSubview:tipLable];
    
    if (self.auth_couple.intValue!=1) {
        
        tipLable.text = @"您当前是未认证用户，发布帖子需要支付相应费用";

    }
    
    self.publish_post_coin = [NormalUse getJinBiStr:@"publish_post_coin"];
    
    UILabel * jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, tipLable.top+tipLable.height+54*BiLiWidth, WIDTH_PingMu, 21*BiLiWidth)];
    jinBiLable.font = [UIFont systemFontOfSize:16*BiLiWidth];
    jinBiLable.textColor = RGBFormUIColor(0x333333);
    jinBiLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:jinBiLable];
    
    NSString * renZhengStr = [NSString stringWithFormat:@"%@金币",self.publish_post_coin];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:renZhengStr];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:21*BiLiWidth] range:NSMakeRange(0, self.publish_post_coin.length)];
    jinBiLable.attributedText = str;

    
    UILabel * yuELable = [[UILabel alloc] initWithFrame:CGRectMake(0, jinBiLable.top+jinBiLable.height+16*BiLiWidth, WIDTH_PingMu, 14*BiLiWidth)];
    yuELable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    yuELable.textColor = RGBFormUIColor(0xFECF61);
    yuELable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:yuELable];
    
    
    [HTTPModel getUserInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            

            NSNumber * coin = [responseObject objectForKey:@"coin"];
            self.yuEStr = [NSString stringWithFormat:@"%d",coin.intValue];
            NSString * yuEStr = [NSString stringWithFormat:@"当前可用金币：%d",coin.intValue];
            NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:yuEStr];
            [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x333333) range:NSMakeRange(0, 7)];
            yuELable.attributedText = str;
            
            if (self.publish_post_coin.intValue<=self.yuEStr.intValue) {
                
                self.tiJiaoLable.text = @"立即支付";

            }
            else
            {
                self.tiJiaoLable.text = @"充值";

            }

        }

    }];
    
    UIButton * nextButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, yuELable.top+yuELable.height+69*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = nextButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [nextButton.layer addSublayer:gradientLayer1];
    
    self.tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, nextButton.width, nextButton.height)];
    self.tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    self.tiJiaoLable.textColor = [UIColor whiteColor];
    [nextButton addSubview:self.tiJiaoLable];

    
    if (self.auth_couple.intValue!=1) {
        
        UILabel * tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(50*BiLiWidth, nextButton.top+nextButton.height+15*BiLiWidth, WIDTH_PingMu-50*BiLiWidth*2, 30*BiLiWidth)];
        tipsLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        tipsLable.textColor = RGBFormUIColor(0xFF002A);
        tipsLable.numberOfLines = 2;
        tipsLable.userInteractionEnabled = YES;
        [self.view addSubview:tipsLable];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quRenZheng)];
        [tipsLable addGestureRecognizer:tap];

        
        NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc] initWithString:@"*注：未认证用户发布帖子不会显示【官方认证】标识，若您想获得标识请先进行认证。去认证"];
        [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(str1.length-3, 3)];
        tipsLable.attributedText = str1;

    }



}
-(void)nextButtonClick
{
    if (self.publish_post_coin.intValue<=self.yuEStr.intValue) {
        
        [self xianShiLoadingView:@"提交中..." view:self.view];
        
        [HTTPModel fuQiJiaoRenZheng:self.info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                [NormalUse showToastView:@"信息已提交，等待管理员审核" view:[NormalUse getCurrentVC].view];

            }
            else
            {
                [self yinCangLoadingView];
                [NormalUse showToastView:msg view:self.view];
            }
        }];

    }
    else
    {
        JinChanWebViewController * vc = [[JinChanWebViewController alloc] init];
        vc.forWhat = @"mall";
        [self.navigationController pushViewController:vc animated:YES];

    }

}

-(void)quRenZheng
{
    FuQiJiaoRenZhengStep1VC * vc = [[FuQiJiaoRenZhengStep1VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
