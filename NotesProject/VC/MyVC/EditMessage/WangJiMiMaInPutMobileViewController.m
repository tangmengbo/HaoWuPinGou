//
//  WangJiMiMaInPutMobileViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/27.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "WangJiMiMaInPutMobileViewController.h"
#import "InputCheckNumberViewController.h"

@interface WangJiMiMaInPutMobileViewController ()

@property(nonatomic,strong)Lable_ImageButton * mobileCodeButton;
@property(nonatomic,strong)UITextField * mobileTF;



@end

@implementation WangJiMiMaInPutMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingFullScreen = @"yes";
    
    self.topTitleLale.text = @"绑定手机号";
    
    UIImageView * logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-72*BiLiWidth)/2, self.topNavView.top+self.topNavView.height+50*BiLiWidth, 72*BiLiWidth, 72*BiLiWidth)];
    logoImageView.image = [UIImage imageNamed:@"telEdit_logo"];
    [self.view addSubview:logoImageView];
    
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(22.5*BiLiWidth, logoImageView.top+logoImageView.height+30*BiLiWidth, WIDTH_PingMu, 15*BiLiWidth)];
    titleLable.textColor = RGBFormUIColor(0x333333);
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*BiLiWidth];
    titleLable.text = @"请输入要找回密码的手机号码";
    [self.view addSubview:titleLable];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tap];
    
    
    self.mobileCodeButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(22*BiLiWidth, titleLable.top+titleLable.height+30*BiLiWidth, 70*BiLiWidth, 55*BiLiWidth)];
    self.mobileCodeButton.button_lable.frame = CGRectMake(0, 0, 34*BiLiWidth, self.mobileCodeButton.height);
    self.mobileCodeButton.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.mobileCodeButton.button_lable.text = @"+86";
    self.mobileCodeButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.mobileCodeButton.button_imageView.frame = CGRectMake(34*BiLiWidth, (self.mobileCodeButton.height-5.5*BiLiWidth)/2, 10*BiLiWidth, 5.5*BiLiWidth);
    //    self.mobileCodeButton.button_imageView.image = [UIImage imageNamed:@"mobileCode_xia"];
    [self.view addSubview:self.mobileCodeButton];
    
    self.mobileTF = [[UITextField alloc] initWithFrame:CGRectMake(self.mobileCodeButton.left+self.mobileCodeButton.width, self.mobileCodeButton.top, WIDTH_PingMu-(self.mobileCodeButton.left+self.mobileCodeButton.width+10*BiLiWidth), self.mobileCodeButton.height)];
    self.mobileTF.placeholder = @"请输入手机号";
    self.mobileTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.mobileTF.textColor = RGBFormUIColor(0x333333);
    self.mobileTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.mobileTF];
    
    UIView * mobileLineView = [[UIView alloc] initWithFrame:CGRectMake(22*BiLiWidth, self.mobileCodeButton.top+self.mobileCodeButton.height, WIDTH_PingMu-44*BiLiWidth, 1)];
    mobileLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.view addSubview:mobileLineView];
    
    UIButton * bangDingButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, mobileLineView.top+mobileLineView.height+43*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
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
    
    UIButton * wangJiMiMaButton = [[UIButton alloc] initWithFrame:CGRectMake(0, bangDingButton.top+bangDingButton.height+30*BiLiWidth, WIDTH_PingMu, 30*BiLiWidth)];
    [wangJiMiMaButton setTitle:@"请输入要找回密码的手机号" forState:UIControlStateNormal];
    [wangJiMiMaButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    wangJiMiMaButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
    [wangJiMiMaButton addTarget:self action:@selector(wangJiMiMaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wangJiMiMaButton];
    
}
-(void)viewTap
{
    [self.mobileTF resignFirstResponder];
    
}
-(void)nextClick
{
    
    if(![NormalUse isValidString:self.mobileTF.text]||self.mobileTF.text.length !=11)
    {
        [NormalUse showToastView:@"请输入有效的手机号码" view:self.view];
        return;
    }
    [NormalUse showMessageLoadView:@"处理中..." vc:self];
    [HTTPModel mobileAlsoExit:[[NSDictionary alloc]initWithObjectsAndKeys:self.mobileTF.text,@"mobile", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse removeMessageLoadingView:self];
        
        if (status==1) {
            
            NSNumber * exist_flg = [responseObject objectForKey:@"exist_flg"];
            if (exist_flg.intValue==0) {
                
                [NormalUse showToastView:@"当前手机号未绑定,请更换手机号码" view:self.view];
            }
            else
            {
                InputCheckNumberViewController * vc = [[InputCheckNumberViewController alloc] init];
                vc.editPWOrBangDing = @"1";
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];

}
-(void)wangJiMiMaButtonClick
{
    
}
@end
