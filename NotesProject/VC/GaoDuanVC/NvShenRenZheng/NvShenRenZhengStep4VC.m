//
//  NvShenRenZhengStep4VC.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "NvShenRenZhengStep4VC.h"

@interface NvShenRenZhengStep4VC ()

@end

@implementation NvShenRenZhengStep4VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"认证";
    [self initTopStepView];
}

-(void)initTopStepView
{
    float distance = (WIDTH_PingMu-37*BiLiWidth*2-22*BiLiWidth*4)/3;
    
    
    UILabel * step1Lable = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, self.topNavView.top+self.topNavView.height+10*BiLiWidth, 22*BiLiWidth, 22*BiLiWidth)];
    step1Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step1Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step1Lable.textAlignment = NSTextAlignmentCenter;
    step1Lable.layer.cornerRadius = 11*BiLiWidth;
    step1Lable.layer.masksToBounds = YES;
    step1Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step1Lable.text = @"1";
    [self.view addSubview:step1Lable];
    
    UILabel * step1TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step1Lable.left-30*BiLiWidth,step1Lable.top+step1Lable.height+8.5*BiLiWidth , step1Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step1TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step1TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step1TipLable.text = @"录制认证视频";
    step1TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step1TipLable];
    

    
    UILabel * step2Lable = [[UILabel alloc] initWithFrame:CGRectMake(step1Lable.left+step1Lable.width+distance, step1Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
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
    step2TipLable.text = @"填写个人资料";
    step2TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step2TipLable];
    
    

    UILabel * step3Lable = [[UILabel alloc] initWithFrame:CGRectMake(step2Lable.left+step2Lable.width+distance, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
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
    step3TipLable.text = @"缴纳押金";
    step3TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step3TipLable];
    
    UIButton * step1BottomView = [[UIButton alloc] initWithFrame:CGRectMake(step3Lable.left+step3Lable.width+distance, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
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

    
    UILabel * step4Lable = [[UILabel alloc] initWithFrame:CGRectMake(step3Lable.left+step3Lable.width+distance, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step4Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step4Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step4Lable.textAlignment = NSTextAlignmentCenter;
    step4Lable.layer.cornerRadius = 11*BiLiWidth;
    step4Lable.layer.masksToBounds = YES;
    step4Lable.text = @"4";
    [self.view addSubview:step4Lable];
    
    UILabel * step4TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step4Lable.left-30*BiLiWidth,step4Lable.top+step4Lable.height+8.5*BiLiWidth , step3Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step4TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step4TipLable.textColor = RGBFormUIColor(0x343434);
    step4TipLable.text = @"等待审核";
    step4TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step4TipLable];

    
    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, step4TipLable.top+step4TipLable.height+20*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [tiJiaoButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tiJiaoButton];
    //渐变设置
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = tiJiaoButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
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
    


    
}
-(void)nextButtonClick
{
    NvShenRenZhengStep4VC * vc = [[NvShenRenZhengStep4VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}



@end
