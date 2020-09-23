//
//  GengHuanMobileViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GengHuanMobileViewController.h"
#import "ChongZhiMiMaViewController.h"

@interface GengHuanMobileViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * mainSrollView;

@property(nonatomic,strong)Lable_ImageButton * mobileCodeButton;
@property(nonatomic,strong)UITextField * mobileTF;
@property(nonatomic,strong)NSString * mobileStr;

@property(nonatomic,strong)UITextField * miMaTF;



@end

@implementation GengHuanMobileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingFullScreen = @"yes";
    
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(22.5*BiLiWidth, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, 22*BiLiWidth)];
    titleLable.textColor = RGBFormUIColor(0x333333);
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:22*BiLiWidth];
    titleLable.text = @"登陆/绑定手机号";
    [self.view addSubview:titleLable];
    
    self.mainSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleLable.top+titleLable.height+33*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu)];
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

    

    
    UILabel * miMaLable = [[UILabel alloc] initWithFrame:CGRectMake(22*BiLiWidth, mobileLineView.top+mobileLineView.height, 70*BiLiWidth, 55*BiLiWidth)];
    miMaLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    miMaLable.textColor = RGBFormUIColor(0x333333);
    miMaLable.text = @"密码";
    [self.mainSrollView addSubview:miMaLable];
    
    self.miMaTF = [[UITextField alloc] initWithFrame:CGRectMake(miMaLable.left+miMaLable.width, miMaLable.top, 150*BiLiWidth, miMaLable.height)];
    self.miMaTF.placeholder = @"请输入密码";
    self.miMaTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.miMaTF.textColor = RGBFormUIColor(0x333333);
    [self.mainSrollView addSubview:self.miMaTF];
    
    UIView * miMaLineView = [[UIView alloc] initWithFrame:CGRectMake(22*BiLiWidth, miMaLable.top+miMaLable.height, WIDTH_PingMu-44*BiLiWidth, 1)];
    miMaLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.mainSrollView addSubview:miMaLineView];
    
    UIButton * wangJiMiMaButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-100*BiLiWidth, miMaLable.top+miMaLable.height, 100*BiLiWidth, 36*BiLiWidth)];
    wangJiMiMaButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [wangJiMiMaButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [wangJiMiMaButton setTitleColor:RGBFormUIColor(0x00AEFF) forState:UIControlStateNormal];
    [wangJiMiMaButton addTarget:self action:@selector(wangJiMiMaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainSrollView addSubview:wangJiMiMaButton];

    UIButton * bangDingButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, miMaLineView.top+miMaLineView.height+68*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
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
-(void)bangDingButtonClick
{
    if (![NormalUse isValidString:self.mobileTF.text]||self.mobileTF.text.length !=11) {
        
        [NormalUse showToastView:@"请输入有效的手机号码" view:self.view];
        return;
    }
    if (![NormalUse isValidString:self.miMaTF.text]) {
        
        [NormalUse showToastView:@"请输入密码" view:self.view];
        return;
        
    }
    self.mobileStr = self.mobileTF.text;
    
    [self xianShiLoadingView:@"绑定中..." view:self.view];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.mobileTF.text forKey:@"mobile"];
    [dic setObject:self.miMaTF.text forKey:@"password"];
    [HTTPModel bangDingMobile:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        [self yinCangLoadingView];
        
        if (status==1) {
            
            [NormalUse showToastView:@"绑定成功" view:self.view];
            [self.delegate gengHuanMobileSuccess:self.mobileStr];
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
    [self.miMaTF resignFirstResponder];

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.mobileTF resignFirstResponder];
    [self.miMaTF resignFirstResponder];
}
-(void)wangJiMiMaButtonClick
{
    ChongZhiMiMaViewController * vc = [[ChongZhiMiMaViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
