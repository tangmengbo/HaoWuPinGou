//
//  InputCheckNumberViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/27.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "InputCheckNumberViewController.h"

@interface InputCheckNumberViewController ()
{
    int stepSeconds;
}


@property(nonatomic,strong)UITextField * yanZhengMaTF;
@property(nonatomic,strong)UITextField * miMaTF;
@property(nonatomic,strong)UIButton * daoJiShiButton;

@property(nonatomic,strong,nullable)NSTimer * timer;


@end

@implementation InputCheckNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"绑定手机号";
    
    UIImageView * logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-72*BiLiWidth)/2, self.topNavView.top+self.topNavView.height+50*BiLiWidth, 72*BiLiWidth, 72*BiLiWidth)];
    logoImageView.image = [UIImage imageNamed:@"telEdit_logo"];
    [self.view addSubview:logoImageView];
    
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(22.5*BiLiWidth, logoImageView.top+logoImageView.height+30*BiLiWidth, WIDTH_PingMu, 15*BiLiWidth)];
    titleLable.textColor = RGBFormUIColor(0x333333);
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*BiLiWidth];
    titleLable.text = @"绑定手机号";
    [self.view addSubview:titleLable];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tap];

    UILabel * yanZhengMaLable = [[UILabel alloc] initWithFrame:CGRectMake(22*BiLiWidth, titleLable.top+titleLable.height+30*BiLiWidth, 70*BiLiWidth, 55*BiLiWidth)];
    yanZhengMaLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    yanZhengMaLable.textColor = RGBFormUIColor(0x333333);
    yanZhengMaLable.text = @"验证码";
    [self.view addSubview:yanZhengMaLable];
    
    self.yanZhengMaTF = [[UITextField alloc] initWithFrame:CGRectMake(yanZhengMaLable.left+yanZhengMaLable.width, yanZhengMaLable.top, 150*BiLiWidth, yanZhengMaLable.height)];
    self.yanZhengMaTF.placeholder = @"请输入验证码";
    self.yanZhengMaTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.yanZhengMaTF.textColor = RGBFormUIColor(0x333333);
    self.yanZhengMaTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.yanZhengMaTF];
    
    self.daoJiShiButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-100*BiLiWidth, yanZhengMaLable.top, 100*BiLiWidth, yanZhengMaLable.height)];
    self.daoJiShiButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.daoJiShiButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.daoJiShiButton setTitleColor:RGBFormUIColor(0x00AEFF) forState:UIControlStateNormal];
    [self.daoJiShiButton addTarget:self action:@selector(getCheckNumberButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.daoJiShiButton];
    
    UIView * yanZhengMaLineView = [[UIView alloc] initWithFrame:CGRectMake(22*BiLiWidth, yanZhengMaLable.top+yanZhengMaLable.height, WIDTH_PingMu-44*BiLiWidth, 1)];
    yanZhengMaLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.view addSubview:yanZhengMaLineView];

    
    UILabel * miMaLable = [[UILabel alloc] initWithFrame:CGRectMake(22*BiLiWidth, yanZhengMaLineView.top+yanZhengMaLineView.height, 70*BiLiWidth, 55*BiLiWidth)];
    miMaLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    miMaLable.textColor = RGBFormUIColor(0x333333);
    miMaLable.text = @"密码";
    [self.view addSubview:miMaLable];
    
    self.miMaTF = [[UITextField alloc] initWithFrame:CGRectMake(miMaLable.left+miMaLable.width, miMaLable.top, 150*BiLiWidth, yanZhengMaLable.height)];
    self.miMaTF.placeholder = @"请输入密码";
    self.miMaTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.miMaTF.textColor = RGBFormUIColor(0x333333);
    [self.view addSubview:self.miMaTF];
    
    UIView * miMaLineView = [[UIView alloc] initWithFrame:CGRectMake(22*BiLiWidth, miMaLable.top+miMaLable.height, WIDTH_PingMu-44*BiLiWidth, 1)];
    miMaLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.view addSubview:miMaLineView];
    
    UIButton * bangDingButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, miMaLineView.top+miMaLineView.height+43*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [bangDingButton addTarget:self action:@selector(bangDingButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
    tiJiaoLable.text = @"立即绑定";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [bangDingButton addSubview:tiJiaoLable];
    
    if([@"1" isEqualToString:self.editPWOrBangDing])
    {
        tiJiaoLable.text = @"确定重置密码";
    }

    
}
-(void)getCheckNumberButtonClick
{
    [HTTPModel getVerifyCode:[[NSDictionary alloc]initWithObjectsAndKeys:self.mobileStr,@"mobile", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.daoJiShiButton.enabled = NO;
            self->stepSeconds = 120;
            [self.daoJiShiButton setTitle:[NSString stringWithFormat:@"%ds",120] forState:UIControlStateNormal];
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daoShu) userInfo:nil repeats:YES];
            
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
        
    }];
    
}
-(void)daoShu
{
    stepSeconds --;
    [self.daoJiShiButton setTitle:[NSString stringWithFormat:@"%ds",stepSeconds] forState:UIControlStateNormal];
    if(stepSeconds == 0)
    {
        [self.timer invalidate];
        self.timer = nil;
        self.daoJiShiButton.enabled = YES;
        [self.daoJiShiButton setTitle:@"重新获取" forState:UIControlStateNormal];

    }
    
}
-(void)bangDingButtonClick
{
    if (![NormalUse isValidString:self.yanZhengMaTF.text]) {
        
        [NormalUse showToastView:@"请输入验证码" view:self.view];
        return;

    }
    if (![NormalUse isValidString:self.miMaTF.text]) {
        
        [NormalUse showToastView:@"请输入密码" view:self.view];
        return;
        
    }
    if (self.miMaTF.text.length<5) {

        [NormalUse showToastView:@"密码不能少于5位数" view:self.view];
        return;

    }
    [self xianShiLoadingView:@"绑定中..." view:self.view];
    
    if([@"1" isEqualToString:self.editPWOrBangDing])//重置密码
    {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:self.mobileStr forKey:@"mobile"];
        [dic setObject:self.yanZhengMaTF.text forKey:@"verification"];
        [dic setObject:self.miMaTF.text forKey:@"password"];
        [HTTPModel chognZhiMiMa:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
           
            [self yinCangLoadingView];
            
            if (status==1) {
                
                [NormalUse showToastView:@"重置密码成功" view:self.view];
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
    else
    {
        //绑定手机
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:self.mobileStr forKey:@"mobile"];
        [dic setObject:self.yanZhengMaTF.text forKey:@"verification"];
        [dic setObject:self.miMaTF.text forKey:@"password"];
        [HTTPModel bangDingMobile:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
           
            [self yinCangLoadingView];
            
            if (status==1) {
                
                [NormalUse showToastView:@"绑定成功" view:self.view];
                
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
}
-(void)viewTap
{
    [self.yanZhengMaTF resignFirstResponder];
    [self.miMaTF resignFirstResponder];
}

@end
