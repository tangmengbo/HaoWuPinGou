//
//  InpurPassWorldViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/27.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "InpurPassWorldViewController.h"

@interface InpurPassWorldViewController ()

@property(nonatomic,strong)UITextField * miMaTF;

@end

@implementation InpurPassWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"绑定手机号";
    
    UIImageView * logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-100*BiLiWidth)/2, self.topNavView.top+self.topNavView.height+10*BiLiWidth, 100*BiLiWidth, 100*BiLiWidth)];
    logoImageView.image = [UIImage imageNamed:@""];
    logoImageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:logoImageView];
    
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(22.5*BiLiWidth, logoImageView.top+logoImageView.height+30*BiLiWidth, WIDTH_PingMu, 15*BiLiWidth)];
    titleLable.textColor = RGBFormUIColor(0x333333);
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*BiLiWidth];
    titleLable.text = @"绑定手机号";
    [self.view addSubview:titleLable];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tap];
    
    
    UILabel * miMaLable = [[UILabel alloc] initWithFrame:CGRectMake(22*BiLiWidth, titleLable.top+titleLable.height+30*BiLiWidth, 70*BiLiWidth, 55*BiLiWidth)];
    miMaLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    miMaLable.textColor = RGBFormUIColor(0x333333);
    miMaLable.text = @"密码";
    [self.view addSubview:miMaLable];
    
    self.miMaTF = [[UITextField alloc] initWithFrame:CGRectMake(miMaLable.left+miMaLable.width, miMaLable.top, 150*BiLiWidth, miMaLable.height)];
    self.miMaTF.placeholder = @"请输入密码";
    self.miMaTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.miMaTF.textColor = RGBFormUIColor(0x333333);
    [self.view addSubview:self.miMaTF];
    
    UIView * miMaLineView = [[UIView alloc] initWithFrame:CGRectMake(22*BiLiWidth, miMaLable.top+miMaLable.height, WIDTH_PingMu-44*BiLiWidth, 1)];
    miMaLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.view addSubview:miMaLineView];

    UIButton * bangDingButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, miMaLineView.top+miMaLineView.height+43*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [bangDingButton addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bangDingButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = bangDingButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [bangDingButton.layer addSublayer:gradientLayer1];
    
    UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bangDingButton.width, bangDingButton.height)];
    tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiJiaoLable.text = @"下一步";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [bangDingButton addSubview:tiJiaoLable];

    
}
-(void)viewTap
{
    [self.miMaTF resignFirstResponder];
}
-(void)nextClick
{
    [HTTPModel login:[[NSDictionary alloc] initWithObjectsAndKeys:self.mobileStr,@"mobile",self.miMaTF.text,@"password", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            [NormalUse showToastView:@"更换成功" view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
                NSArray *temArray = self.navigationController.viewControllers;
                
                for(UIViewController *temVC in temArray)
                {
                    if ([temVC isKindOfClass:[SheZhiViewController class]])
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
