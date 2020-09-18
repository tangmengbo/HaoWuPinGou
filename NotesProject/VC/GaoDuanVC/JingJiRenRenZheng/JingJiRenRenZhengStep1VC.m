//
//  JingJiRenRenZhengStep1VC.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "JingJiRenRenZhengStep1VC.h"

@interface JingJiRenRenZhengStep1VC ()<CityListViewControllerDelegate>

@end

@implementation JingJiRenRenZhengStep1VC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"认证";
    [self yinCangTabbar];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tap];
    
    [self initTopStepView];

}
-(void)viewTap
{
    [self.fuWuDiQuTF resignFirstResponder];
    [self.chanPinShuLiangTF resignFirstResponder];
    [self.beginPriceTF resignFirstResponder];
    [self.endPriceTF resignFirstResponder];
    [self.lianXiFangShiTF resignFirstResponder];
}
-(void)initTopStepView
{
    UIButton * step1BottomView = [[UIButton alloc] initWithFrame:CGRectMake(56*BiLiWidth, self.topNavView.top+self.topNavView.height+20*BiLiWidth, 22*BiLiWidth, 22*BiLiWidth)];
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
    
    UILabel * step1Lable = [[UILabel alloc] initWithFrame:step1BottomView.frame];
    step1Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step1Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step1Lable.textAlignment = NSTextAlignmentCenter;
    step1Lable.text = @"1";
    [self.view addSubview:step1Lable];
    
    UILabel * step1TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step1BottomView.left-30*BiLiWidth,step1BottomView.top+step1BottomView.height+8.5*BiLiWidth , step1BottomView.width+60*BiLiWidth, 12*BiLiWidth)];
    step1TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step1TipLable.textColor = RGBFormUIColor(0x343434);
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

    [self initMessageContentView:step3TipLable];
    
}
-(void)initMessageContentView:(UIView *)view
{
    UILabel * fuWuDiQuLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, view.top+view.height+45.5*BiLiWidth, 100*BiLiWidth, 39.5*BiLiWidth)];
    fuWuDiQuLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    fuWuDiQuLable.textColor = RGBFormUIColor(0x343434);
    fuWuDiQuLable.text = @"服务地区";
    [self.view addSubview:fuWuDiQuLable];

    self.fuWuDiQuTF = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, fuWuDiQuLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    self.fuWuDiQuTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.fuWuDiQuTF setTitle:@"" forState:UIControlStateNormal];
    
    self.fuWuDiQuTF.titleLabel.font = [UIFont systemFontOfSize:13*BiLiWidth];
    [self.fuWuDiQuTF setTitle:@"选择所在地区>" forState:UIControlStateNormal];
    [self.fuWuDiQuTF setTitleColor:RGBFormUIColor(0xDEDEDE) forState:UIControlStateNormal];
    self.fuWuDiQuTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.fuWuDiQuTF addTarget:self action:@selector(diQuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.fuWuDiQuTF];

    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, fuWuDiQuLable.top+fuWuDiQuLable.height, 270*BiLiWidth, 1)];
    lineView1.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.view addSubview:lineView1];
    
    UILabel * chanPinShuLiangLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView1.top+lineView1.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    chanPinShuLiangLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    chanPinShuLiangLable.textColor = RGBFormUIColor(0x343434);
    chanPinShuLiangLable.text = @"小姐数量";
    [self.view addSubview:chanPinShuLiangLable];

    self.chanPinShuLiangTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, chanPinShuLiangLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    self.chanPinShuLiangTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NormalUse setTextFieldPlaceholder:@"填写小姐数量" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.chanPinShuLiangTF];
    self.chanPinShuLiangTF.textAlignment = NSTextAlignmentRight;
    self.chanPinShuLiangTF.keyboardType = UIKeyboardTypeNumberPad;
    self.chanPinShuLiangTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.chanPinShuLiangTF.textColor = RGBFormUIColor(0x343434);
    [self.view addSubview:self.chanPinShuLiangTF];

    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, chanPinShuLiangLable.top+chanPinShuLiangLable.height, 270*BiLiWidth, 1)];
    lineView2.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.view addSubview:lineView2];

    UILabel * fuWuJiaGeLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView2.top+lineView2.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    fuWuJiaGeLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    fuWuJiaGeLable.textColor = RGBFormUIColor(0x343434);
    fuWuJiaGeLable.text = @"服务价格";
    [self.view addSubview:fuWuJiaGeLable];
    
    self.beginPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(200*BiLiWidth, lineView2.top+lineView2.height, 58*BiLiWidth, 39.5*BiLiWidth)];
    self.beginPriceTF.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.beginPriceTF.placeholder = @"最低价格";
    self.beginPriceTF.textColor  = RGBFormUIColor(0x343434);
    self.beginPriceTF.keyboardType = UIKeyboardTypeNumberPad;
    self.beginPriceTF.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.beginPriceTF];

    UIView * priceLineView = [[UIView alloc] initWithFrame:CGRectMake(self.beginPriceTF.left+self.beginPriceTF.width+14*BiLiWidth, (self.beginPriceTF.height-1)/2+self.beginPriceTF.top,7*BiLiWidth, 1)];
    priceLineView.backgroundColor = RGBFormUIColor(0x343434);
    [self.view addSubview:priceLineView];


    self.endPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(priceLineView.left+priceLineView.width+14*BiLiWidth, lineView2.top+lineView2.height, 58*BiLiWidth, 39.5*BiLiWidth)];
    self.endPriceTF.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.endPriceTF.placeholder = @"最高价格";
    self.endPriceTF.textColor  = RGBFormUIColor(0x343434);
    self.endPriceTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.endPriceTF];

    UIView * lineView3 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, fuWuJiaGeLable.top+fuWuJiaGeLable.height, 270*BiLiWidth, 1)];
    lineView3.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.view addSubview:lineView3];
    
    UILabel * lianXiFangShiLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView3.top+lineView3.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    lianXiFangShiLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    lianXiFangShiLable.textColor = RGBFormUIColor(0x343434);
    lianXiFangShiLable.text = @"联系方式";
    [self.view addSubview:lianXiFangShiLable];

    self.lianXiFangShiTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, lianXiFangShiLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    self.lianXiFangShiTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NormalUse setTextFieldPlaceholder:@"填写联系方式" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.lianXiFangShiTF];
    self.lianXiFangShiTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.lianXiFangShiTF.textColor = RGBFormUIColor(0x343434);
    [self.view addSubview:self.lianXiFangShiTF];

    UIView * lineView4 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, lianXiFangShiLable.top+lianXiFangShiLable.height, 270*BiLiWidth, 1)];
    lineView4.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.view addSubview:lineView4];

    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, lineView4.top+lineView4.height+23*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [tiJiaoButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tiJiaoButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = tiJiaoButton.bounds;
    gradientLayer.cornerRadius = 20*BiLiWidth;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    [tiJiaoButton.layer addSublayer:gradientLayer];
    
    UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tiJiaoButton.width, tiJiaoButton.height)];
    tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiJiaoLable.text = @"下一步";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [tiJiaoButton addSubview:tiJiaoLable];


}
-(void)diQuButtonClick
{
    CityListViewController * vc = [[CityListViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark--选择城市后的代理
-(void)citySelect:(NSDictionary *)info
{
    self.cityInfo = info;
    [self.fuWuDiQuTF setTitle:[info objectForKey:@"cityName"] forState:UIControlStateNormal];
    [self.fuWuDiQuTF setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
}

-(void)nextButtonClick
{
    
    if(![NormalUse isValidDictionary:self.cityInfo])
    {
        [NormalUse showToastView:@"请填写服务地区" view:self.view];
        return;
    }
    if(![NormalUse isValidString:self.chanPinShuLiangTF.text])
    {
        [NormalUse showToastView:@"请填写小姐数量" view:self.view];
        return;
    }
    if(![NormalUse isValidString:self.beginPriceTF.text])
    {
        [NormalUse showToastView:@"请设置最低价格" view:self.view];
        return;
    }
    if(![NormalUse isValidString:self.endPriceTF.text])
    {
        [NormalUse showToastView:@"请设置最高价格" view:self.view];
        return;
    }
    NSString * beginPrice = self.beginPriceTF.text;
    
    NSString * endPrice = self.endPriceTF.text;
    
    if(endPrice.intValue<beginPrice.intValue)
    {
        [NormalUse showToastView:@"最高价格不能小于最低价格" view:self.view];
        return;
    }
    if(![NormalUse isValidString:self.lianXiFangShiTF.text])
    {
        [NormalUse showToastView:@"请填写联系方式" view:self.view];
        return;
    }
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.renZhengType forKey:@"type"];//认证类型 1茶小二 2经纪人
    NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
    [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"city_code"];
    [dic setObject:self.chanPinShuLiangTF.text forKey:@"nums"];
    [dic setObject:self.beginPriceTF.text forKey:@"min_price"];
    [dic setObject:self.endPriceTF.text forKey:@"max_price"];
    [dic setObject:self.lianXiFangShiTF.text forKey:@"contact"];
    
    JingJiRenRenZhengStep2VC * vc = [[JingJiRenRenZhengStep2VC alloc] init];
    vc.info = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
