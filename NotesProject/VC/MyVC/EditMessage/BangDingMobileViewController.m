//
//  BangDingMobileViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "BangDingMobileViewController.h"

@interface BangDingMobileViewController ()<UIScrollViewDelegate>
{
    int stepSeconds;
}

@property(nonatomic,strong)UIScrollView * mainSrollView;

@property(nonatomic,strong)Lable_ImageButton * mobileCodeButton;
@property(nonatomic,strong)UITextField * mobileTF;
@property(nonatomic,strong)NSString * mobileStr;
@property(nonatomic,strong)UITextField * yanZhengMaTF;
@property(nonatomic,strong)UITextField * miMaTF;

@property(nonatomic,strong,nullable)NSTimer * timer;


@property(nonatomic,strong)UIButton * daoJiShiButton;


@end

@implementation BangDingMobileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingFullScreen = @"yes";
    
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(22.5*BiLiWidth, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, 22*BiLiWidth)];
    titleLable.textColor = RGBFormUIColor(0x333333);
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:22*BiLiWidth];
    titleLable.text = @"注册/绑定手机号";
    [self.view addSubview:titleLable];
    
    self.mainSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleLable.top+titleLable.height+33*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu)];
    [self.mainSrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.mainSrollView.height+40*BiLiWidth)];
    self.mainSrollView.delegate = self;
    [self.view addSubview:self.mainSrollView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.mainSrollView addGestureRecognizer:tap];


    self.mobileCodeButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(22*BiLiWidth, 0, 70*BiLiWidth, 55*BiLiWidth)];
    self.mobileCodeButton.button_lable.frame = CGRectMake(0, 0, 34*BiLiWidth, self.mobileCodeButton.height);
    self.mobileCodeButton.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.mobileCodeButton.button_lable.text = @"+86";
    self.mobileCodeButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.mobileCodeButton.button_imageView.frame = CGRectMake(34*BiLiWidth, (self.mobileCodeButton.height-5.5*BiLiWidth)/2, 10*BiLiWidth, 5.5*BiLiWidth);
    self.mobileCodeButton.button_imageView.image = [UIImage imageNamed:@"mobileCode_xia"];
    [self.mainSrollView addSubview:self.mobileCodeButton];
    
    self.mobileTF = [[UITextField alloc] initWithFrame:CGRectMake(self.mobileCodeButton.left+self.mobileCodeButton.width, self.mobileCodeButton.top, WIDTH_PingMu-(self.mobileCodeButton.left+self.mobileCodeButton.width+10*BiLiWidth), self.mobileCodeButton.height)];
    self.mobileTF.placeholder = @"请输入手机号";
    self.mobileTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.mobileTF.textColor = RGBFormUIColor(0x333333);
    self.mobileTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.mainSrollView addSubview:self.mobileTF];
    
    UIView * mobileLineView = [[UIView alloc] initWithFrame:CGRectMake(22*BiLiWidth, self.mobileCodeButton.top+self.mobileCodeButton.height, WIDTH_PingMu-44*BiLiWidth, 1)];
    mobileLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.mainSrollView addSubview:mobileLineView];

    
    UILabel * yanZhengMaLable = [[UILabel alloc] initWithFrame:CGRectMake(22*BiLiWidth, mobileLineView.top+mobileLineView.height, 70*BiLiWidth, 55*BiLiWidth)];
    yanZhengMaLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    yanZhengMaLable.textColor = RGBFormUIColor(0x333333);
    yanZhengMaLable.text = @"验证码";
    [self.mainSrollView addSubview:yanZhengMaLable];
    
    self.yanZhengMaTF = [[UITextField alloc] initWithFrame:CGRectMake(yanZhengMaLable.left+yanZhengMaLable.width, yanZhengMaLable.top, 150*BiLiWidth, yanZhengMaLable.height)];
    self.yanZhengMaTF.placeholder = @"请输入验证码";
    self.yanZhengMaTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.yanZhengMaTF.textColor = RGBFormUIColor(0x333333);
    self.yanZhengMaTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.mainSrollView addSubview:self.yanZhengMaTF];
    
    self.daoJiShiButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-100*BiLiWidth, yanZhengMaLable.top, 100*BiLiWidth, yanZhengMaLable.height)];
    self.daoJiShiButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.daoJiShiButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.daoJiShiButton setTitleColor:RGBFormUIColor(0x00AEFF) forState:UIControlStateNormal];
    [self.daoJiShiButton addTarget:self action:@selector(getCheckNumberButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainSrollView addSubview:self.daoJiShiButton];
    
    UIView * yanZhengMaLineView = [[UIView alloc] initWithFrame:CGRectMake(22*BiLiWidth, yanZhengMaLable.top+yanZhengMaLable.height, WIDTH_PingMu-44*BiLiWidth, 1)];
    yanZhengMaLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.mainSrollView addSubview:yanZhengMaLineView];

    
    UILabel * miMaLable = [[UILabel alloc] initWithFrame:CGRectMake(22*BiLiWidth, yanZhengMaLineView.top+yanZhengMaLineView.height, 70*BiLiWidth, 55*BiLiWidth)];
    miMaLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    miMaLable.textColor = RGBFormUIColor(0x333333);
    miMaLable.text = @"密码";
    [self.mainSrollView addSubview:miMaLable];
    
    self.miMaTF = [[UITextField alloc] initWithFrame:CGRectMake(miMaLable.left+miMaLable.width, miMaLable.top, 150*BiLiWidth, yanZhengMaLable.height)];
    self.miMaTF.placeholder = @"请输入密码";
    self.miMaTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.miMaTF.textColor = RGBFormUIColor(0x333333);
    [self.mainSrollView addSubview:self.miMaTF];
    
    UIView * miMaLineView = [[UIView alloc] initWithFrame:CGRectMake(22*BiLiWidth, miMaLable.top+miMaLable.height, WIDTH_PingMu-44*BiLiWidth, 1)];
    miMaLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.mainSrollView addSubview:miMaLineView];
    
    UIButton * bangDingButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, miMaLineView.top+miMaLineView.height+43*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [bangDingButton addTarget:self action:@selector(bangDingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainSrollView addSubview:bangDingButton];
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



}
-(void)getCheckNumberButtonClick
{
    if(![NormalUse isValidString:self.mobileTF.text]||self.mobileTF.text.length !=11)
    {
        [NormalUse showToastView:@"请输入有效的手机号码" view:self.view];

    }
    else
    {
          
        self.mobileStr = self.mobileTF.text;
        
        [HTTPModel getVerifyCode:[[NSDictionary alloc]initWithObjectsAndKeys:self.mobileTF.text,@"mobile", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
           
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
    if (![NormalUse isValidString:self.mobileTF.text]||self.mobileTF.text.length !=11) {
        
        [NormalUse showToastView:@"请输入有效的手机号码" view:self.view];
        return;
    }
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
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.mobileTF.text forKey:@"mobile"];
    [dic setObject:self.yanZhengMaTF.text forKey:@"verification"];
    [dic setObject:self.miMaTF.text forKey:@"password"];
    [HTTPModel bangDingMobile:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        [self yinCangLoadingView];
        
        if (status==1) {
            
            //如果返回logintoken 则说明切换账户
            if([NormalUse isValidString:[responseObject objectForKey:@"logintoken"]])
            {
                NSString *  logintoken = [responseObject objectForKey:@"logintoken"];
                [NormalUse defaultsSetObject:logintoken forKey:LoginToken];

            }
            
            [NormalUse showToastView:@"绑定成功" view:self.view];
            [self.delegate bangDingMobileSuccess:self.mobileStr];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
}
-(void)viewTap
{
    [self.mobileTF resignFirstResponder];
    [self.yanZhengMaTF resignFirstResponder];
    [self.miMaTF resignFirstResponder];

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.mobileTF resignFirstResponder];
    [self.yanZhengMaTF resignFirstResponder];
    [self.miMaTF resignFirstResponder];
}
@end
