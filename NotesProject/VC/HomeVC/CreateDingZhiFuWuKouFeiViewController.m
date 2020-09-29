//
//  CreateDingZhiFuWuKouFeiViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "CreateDingZhiFuWuKouFeiViewController.h"
#import "ZhangHuDetailViewController.h"

@interface CreateDingZhiFuWuKouFeiViewController ()

@property(nonatomic,strong)NSString * made_requirement_coin;
@property(nonatomic,strong)NSString * yuEStr;

@property(nonatomic,strong)UILabel * tiJiaoLable;

@end

@implementation CreateDingZhiFuWuKouFeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"支付";
    self.loadingFullScreen = @"yes";
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, 12*BiLiWidth)];
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.textColor = RGBFormUIColor(0x999999);
    [self.view addSubview:tipLable];
        
    
    UILabel * jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, tipLable.top+tipLable.height+54*BiLiWidth, WIDTH_PingMu, 21*BiLiWidth)];
    jinBiLable.font = [UIFont systemFontOfSize:16*BiLiWidth];
    jinBiLable.textColor = RGBFormUIColor(0x333333);
    jinBiLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:jinBiLable];
    
    self.made_requirement_coin = [NormalUse getJinBiStr:@"made_requirement_coin"];

    
    NSString * renZhengStr = [NSString stringWithFormat:@"%@金币",self.made_requirement_coin];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:renZhengStr];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:21*BiLiWidth] range:NSMakeRange(0, self.made_requirement_coin.length)];
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
            
            if (self.made_requirement_coin.intValue<=self.yuEStr.intValue) {
                
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

}
-(void)nextButtonClick
{
    if (self.made_requirement_coin.intValue<=self.yuEStr.intValue) {
        
        [self xianShiLoadingView:@"提交中..." view:self.view];
        

        NSMutableDictionary  * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:self.city_code forKey:@"city_code"];
        [dic setObject:self.start_date forKey:@"start_date"];
        [dic setObject:self.end_date forKey:@"end_date"];
        [dic setObject:self.min_price forKey:@"min_price"];
        [dic setObject:self.max_price forKey:@"max_price"];
        [dic setObject:self.love_type forKey:@"love_type"];
        [dic setObject:self.service_type forKey:@"service_type"];
        [dic setObject:[NormalUse getobjectForKey:self.mobie] forKey:@"mobie"];
        [dic setObject:[NormalUse getobjectForKey:self.qq] forKey:@"qq"];
        [dic setObject:[NormalUse getobjectForKey:self.wechat] forKey:@"wechat"];
        [dic setObject:self.describe forKey:@"describe"];

        
        [HTTPModel dingZhiXuQiu:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
           
            [self yinCangLoadingView];

            if (status==1) {
                
                [NormalUse showToastView:@"发布成功" view:[NormalUse getCurrentVC].view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   
                    NSArray *temArray = self.navigationController.viewControllers;
                    
                    for(UIViewController *temVC in temArray)
                    {
                        if ([temVC isKindOfClass:[DingZhiFuWuViewController class]])
                        {
                            [self.navigationController popToViewController:temVC animated:YES];
                        }
                    }

                    
                });

            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
            }
            
        }];

        
    }
    else
    {
        ZhangHuDetailViewController * vc = [[ZhangHuDetailViewController alloc] init];
        vc.yuEStr = self.yuEStr;
        [self.navigationController pushViewController:vc animated:YES];

    }

}


@end
