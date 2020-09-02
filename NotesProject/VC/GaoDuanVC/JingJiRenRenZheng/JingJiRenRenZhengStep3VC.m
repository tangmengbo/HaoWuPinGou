//
//  JingJiRenRenZhengStep3VC.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "JingJiRenRenZhengStep3VC.h"

@interface JingJiRenRenZhengStep3VC ()

@end

@implementation JingJiRenRenZhengStep3VC

#pragma mark -- 禁止右滑返回
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.topTitleLale.text = @"认证";
    self.backImageView.hidden = YES;
    self.leftButton.hidden = YES;
    
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
    
    
    UILabel * step2Lable = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH_PingMu-22*BiLiWidth)/2, step1Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step2Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step2Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step2Lable.textAlignment = NSTextAlignmentCenter;
    step2Lable.layer.cornerRadius = 11*BiLiWidth;
    step2Lable.layer.masksToBounds = YES;
    step2Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step2Lable.text = @"2";
    [self.view addSubview:step2Lable];
    
    UILabel * step2TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step2Lable.left-30*BiLiWidth,step2Lable.top+step2Lable.height+8.5*BiLiWidth , step2Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step2TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step2TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step2TipLable.text = @"缴纳押金";
    step2TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step2TipLable];

    UIButton * step1BottomView = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-22*BiLiWidth-56*BiLiWidth, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
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

    
    UILabel * step3Lable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-22*BiLiWidth-56*BiLiWidth, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step3Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step3Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step3Lable.textAlignment = NSTextAlignmentCenter;
    step3Lable.layer.cornerRadius = 11*BiLiWidth;
    step3Lable.layer.masksToBounds = YES;
    step3Lable.text = @"3";
    [self.view addSubview:step3Lable];
    
    UILabel * step3TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step3Lable.left-30*BiLiWidth,step3Lable.top+step3Lable.height+8.5*BiLiWidth , step3Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step3TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step3TipLable.textColor = RGBFormUIColor(0x343434);
    step3TipLable.text = @"等待审核";
    step3TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step3TipLable];

    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-72*BiLiWidth)/2, step3TipLable.top+step3TipLable.height+43*BiLiWidth, 72*BiLiWidth, 72*BiLiWidth)];
    tipImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:tipImageView];
    
    UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, tipImageView.top+tipImageView.height+24*BiLiWidth, WIDTH_PingMu, 15*BiLiWidth)];
    tipLable1.textAlignment = NSTextAlignmentCenter;
    tipLable1.textColor = RGBFormUIColor(0x343434);
    tipLable1.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tipLable1.text = @"报名成功";
    [self.view addSubview:tipLable1];
    
    UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, tipLable1.top+tipLable1.height+11*BiLiWidth, WIDTH_PingMu, 13*BiLiWidth)];
    tipLable2.textAlignment = NSTextAlignmentCenter;
    tipLable2.textColor = RGBFormUIColor(0x9A9A9A);
    tipLable2.font = [UIFont systemFontOfSize:13*BiLiWidth];
    tipLable2.text = @"请耐心等待官方审核消息或直接联系官方客服";
    [self.view addSubview:tipLable2];

    

    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, tipLable2.top+tipLable2.height+100*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
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
    tiJiaoLable.text = @"确定";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [tiJiaoButton addSubview:tiJiaoLable];

    
}
-(void)nextButtonClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
