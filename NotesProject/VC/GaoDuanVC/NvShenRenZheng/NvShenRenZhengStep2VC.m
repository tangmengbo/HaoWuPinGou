//
//  NvShenRenZhengStep2VC.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "NvShenRenZhengStep2VC.h"

@interface NvShenRenZhengStep2VC ()

@property(nonatomic,strong)UIScrollView * mainScrollView;

@end

@implementation NvShenRenZhengStep2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"认证";
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    [self.view addSubview:self.mainScrollView];
    
    [self initTopStepView];
}

-(void)initTopStepView
{
    float distance = (WIDTH_PingMu-37*BiLiWidth*2-22*BiLiWidth*4)/3;
    
    
    UILabel * step1Lable = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, 10*BiLiWidth, 22*BiLiWidth, 22*BiLiWidth)];
    step1Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step1Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step1Lable.textAlignment = NSTextAlignmentCenter;
    step1Lable.layer.cornerRadius = 11*BiLiWidth;
    step1Lable.layer.masksToBounds = YES;
    step1Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step1Lable.text = @"1";
    [self.mainScrollView addSubview:step1Lable];
    
    UILabel * step1TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step1Lable.left-30*BiLiWidth,step1Lable.top+step1Lable.height+8.5*BiLiWidth , step1Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step1TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step1TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step1TipLable.text = @"录制认证视频";
    step1TipLable.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:step1TipLable];
    
    UIButton * step1BottomView = [[UIButton alloc] initWithFrame:CGRectMake(step1Lable.left+step1Lable.width+distance, step1Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
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
    [self.mainScrollView addSubview:step1BottomView];

    
    UILabel * step2Lable = [[UILabel alloc] initWithFrame:CGRectMake(step1Lable.left+step1Lable.width+distance, step1Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step2Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step2Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step2Lable.textAlignment = NSTextAlignmentCenter;
    step2Lable.layer.cornerRadius = 11*BiLiWidth;
    step2Lable.layer.masksToBounds = YES;
    step2Lable.text = @"2";
    [self.mainScrollView addSubview:step2Lable];
    
    UILabel * step2TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step2Lable.left-30*BiLiWidth,step2Lable.top+step2Lable.height+8.5*BiLiWidth , step2Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step2TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step2TipLable.textColor = RGBFormUIColor(0x343434);
    step2TipLable.text = @"填写个人资料";
    step2TipLable.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:step2TipLable];
    
    
    UILabel * step3Lable = [[UILabel alloc] initWithFrame:CGRectMake(step2Lable.left+step2Lable.width+distance, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step3Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step3Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step3Lable.textAlignment = NSTextAlignmentCenter;
    step3Lable.layer.cornerRadius = 11*BiLiWidth;
    step3Lable.layer.masksToBounds = YES;
    step3Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step3Lable.text = @"3";
    [self.mainScrollView addSubview:step3Lable];
    
    UILabel * step3TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step3Lable.left-30*BiLiWidth,step3Lable.top+step3Lable.height+8.5*BiLiWidth , step3Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step3TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step3TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step3TipLable.text = @"缴纳押金";
    step3TipLable.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:step3TipLable];
    
    UILabel * step4Lable = [[UILabel alloc] initWithFrame:CGRectMake(step3Lable.left+step3Lable.width+distance, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step4Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step4Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step4Lable.textAlignment = NSTextAlignmentCenter;
    step4Lable.layer.cornerRadius = 11*BiLiWidth;
    step4Lable.layer.masksToBounds = YES;
    step4Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step4Lable.text = @"4";
    [self.mainScrollView addSubview:step4Lable];
    
    UILabel * step4TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step4Lable.left-30*BiLiWidth,step4Lable.top+step4Lable.height+8.5*BiLiWidth , step3Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step4TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step4TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step4TipLable.text = @"等待审核";
    step4TipLable.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:step4TipLable];

    
    UILabel * biaoTiXinXiLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, step4TipLable.top+step4TipLable.height+45.5*BiLiWidth, 100*BiLiWidth, 39.5*BiLiWidth)];
    biaoTiXinXiLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    biaoTiXinXiLable.textColor = RGBFormUIColor(0x343434);
    biaoTiXinXiLable.text = @"信息标题";
    [self.mainScrollView addSubview:biaoTiXinXiLable];

    self.biaoTiTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, biaoTiXinXiLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    self.biaoTiTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NormalUse setTextFieldPlaceholder:@"填写信息标题>" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.biaoTiTF];
    self.biaoTiTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.biaoTiTF.textColor = RGBFormUIColor(0x343434);
    self.biaoTiTF.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:self.biaoTiTF];

    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, biaoTiXinXiLable.top+biaoTiXinXiLable.height, 270*BiLiWidth, 1)];
    lineView1.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView1];

    
    UILabel * diquLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView1.top+lineView1.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    diquLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    diquLable.textColor = RGBFormUIColor(0x343434);
    diquLable.text = @"所在地区";
    [self.mainScrollView addSubview:diquLable];

    self.diQuTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, diquLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    self.diQuTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NormalUse setTextFieldPlaceholder:@"填写信息标题>" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.diQuTF];
    self.diQuTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.diQuTF.textColor = RGBFormUIColor(0x343434);
    self.diQuTF.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:self.diQuTF];

    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, biaoTiXinXiLable.top+biaoTiXinXiLable.height, 270*BiLiWidth, 1)];
    lineView2.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView2];

    
    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView2.top+lineView2.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    ageLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    ageLable.textColor = RGBFormUIColor(0x343434);
    ageLable.text = @"女神年龄";
    [self.mainScrollView addSubview:ageLable];

    self.ageTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, diquLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    self.ageTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NormalUse setTextFieldPlaceholder:@"选择产品年龄>" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.ageTF];
    self.ageTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.ageTF.textColor = RGBFormUIColor(0x343434);
    self.ageTF.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:self.ageTF];

    UIView * lineView3 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, biaoTiXinXiLable.top+biaoTiXinXiLable.height, 270*BiLiWidth, 1)];
    lineView3.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView3];
    
    UILabel * fuWuJiaGeLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView3.top+lineView3.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    fuWuJiaGeLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    fuWuJiaGeLable.textColor = RGBFormUIColor(0x343434);
    fuWuJiaGeLable.text = @"服务价格";
    [self.view addSubview:fuWuJiaGeLable];
    
    self.beginPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(200*BiLiWidth, lineView3.top+lineView3.height, 58*BiLiWidth, 39.5*BiLiWidth)];
    self.beginPriceTF.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.beginPriceTF.placeholder = @"最低价格";
    self.beginPriceTF.textColor  = RGBFormUIColor(0x343434);
    self.beginPriceTF.keyboardType = UIKeyboardTypeNumberPad;
    self.beginPriceTF.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.beginPriceTF];

    UIView * priceLineView = [[UIView alloc] initWithFrame:CGRectMake(self.beginPriceTF.left+self.beginPriceTF.width+14*BiLiWidth, (self.beginPriceTF.height-1)/2+self.beginPriceTF.top,7*BiLiWidth, 1)];
    priceLineView.backgroundColor = RGBFormUIColor(0x343434);
    [self.view addSubview:priceLineView];


    self.endPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(priceLineView.left+priceLineView.width+14*BiLiWidth, lineView3.top+lineView3.height, 58*BiLiWidth, 39.5*BiLiWidth)];
    self.endPriceTF.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.endPriceTF.placeholder = @"最高价格";
    self.endPriceTF.textColor  = RGBFormUIColor(0x343434);
    self.endPriceTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.endPriceTF];

    UIView * lineView4 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, fuWuJiaGeLable.top+fuWuJiaGeLable.height, 270*BiLiWidth, 1)];
    lineView4.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView4];


    UILabel * fuWuXiangMuLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView4.top+lineView4.height, 50*BiLiWidth, 39.5*BiLiWidth)];
    fuWuXiangMuLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    fuWuXiangMuLable.textColor = RGBFormUIColor(0x343434);
    fuWuXiangMuLable.text = @"服务项目";
    [self.mainScrollView addSubview:fuWuXiangMuLable];
    
    self.fuWuXiangMuButton = [[UIButton alloc] initWithFrame:CGRectMake(194*BiLiWidth, fuWuXiangMuLable.top, 105*BiLiWidth, 39.5*BiLiWidth)];
    self.fuWuXiangMuButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.fuWuXiangMuButton setTitle:@"选择服务项目>" forState:UIControlStateNormal];
    [self.fuWuXiangMuButton setTitleColor:RGBFormUIColor(0xDEDEDE) forState:UIControlStateNormal];
    self.fuWuXiangMuButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
    self.fuWuXiangMuButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.fuWuXiangMuButton addTarget:self action:@selector(xiangMuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.fuWuXiangMuButton];
    
    UIView * lineView5 = [[UIView alloc] initWithFrame:CGRectMake(25*BiLiWidth, lineView4.top+lineView4.height+39.5*BiLiWidth, 273.5*BiLiWidth, 1)];
    lineView5.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView5];
    
    UILabel * lianXiFangShiLable = [[UILabel alloc] initWithFrame:CGRectMake(lineView1.left, lineView5.top+lineView5.height+13*BiLiWidth, 50*BiLiWidth, 12*BiLiWidth)];
    lianXiFangShiLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    lianXiFangShiLable.textColor = RGBFormUIColor(0x343434);
    lianXiFangShiLable.text = @"联系方式";
    [self.mainScrollView addSubview:lianXiFangShiLable];
    
    UILabel * lianXiFangShiTipLable = [[UILabel alloc] initWithFrame:CGRectMake(lianXiFangShiLable.left, lianXiFangShiLable.top+lianXiFangShiLable.height+10*BiLiWidth, 63*BiLiWidth, 25*BiLiWidth)];
    lianXiFangShiTipLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
    lianXiFangShiTipLable.textColor = RGBFormUIColor(0xDEDEDE);
    lianXiFangShiTipLable.numberOfLines = 2;
    lianXiFangShiTipLable.text = @"(填写一种联系方式即可）";
    [self.mainScrollView addSubview:lianXiFangShiTipLable];
    
    
    self.weiXinTF = [[UITextField alloc] initWithFrame:CGRectMake(194*BiLiWidth, lineView5.top+lineView5.height, 105*BiLiWidth, 39.5*BiLiWidth)];
    self.weiXinTF.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [NormalUse setTextFieldPlaceholder:@"请填写微信号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.weiXinTF];
    self.weiXinTF.textAlignment = NSTextAlignmentRight;
    self.weiXinTF.textColor  = RGBFormUIColor(0x343434);
    [self.mainScrollView addSubview:self.weiXinTF];
    
    UIView * lineView6 = [[UIView alloc] initWithFrame:CGRectMake(101.5*BiLiWidth, lineView5.top+lineView5.height+39.5*BiLiWidth, 197*BiLiWidth, 1)];
    lineView6.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView6];
    
    self.qqTF = [[UITextField alloc] initWithFrame:CGRectMake(194*BiLiWidth, lineView6.top+lineView6.height, 105*BiLiWidth, 39.5*BiLiWidth)];
    self.qqTF.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [NormalUse setTextFieldPlaceholder:@"请填写QQ号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.qqTF];
    self.qqTF.textColor  = RGBFormUIColor(0x343434);
    self.qqTF.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:self.qqTF];
    
    UIView * lineView7 = [[UIView alloc] initWithFrame:CGRectMake(101.5*BiLiWidth, lineView6.top+lineView6.height+39.5*BiLiWidth, 197*BiLiWidth, 1)];
    lineView7.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView7];

    
    self.telTF = [[UITextField alloc] initWithFrame:CGRectMake(194*BiLiWidth, lineView7.top+lineView7.height, 105*BiLiWidth, 39.5*BiLiWidth)];
    self.telTF.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [NormalUse setTextFieldPlaceholder:@"请填写手机号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.telTF];
    self.telTF.textAlignment = NSTextAlignmentRight;
    self.telTF.textColor  = RGBFormUIColor(0x343434);
    [self.mainScrollView addSubview:self.telTF];
    
    UIView * lineView8 = [[UIView alloc] initWithFrame:CGRectMake(101.5*BiLiWidth, lineView7.top+lineView7.height+39.5*BiLiWidth, 197*BiLiWidth, 1)];
    lineView8.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView8];

    [self.mainScrollView setContentSize: CGSizeMake(WIDTH_PingMu, lineView8.top+lineView8.height)];
    
    
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
    NvShenRenZhengStep3VC * vc = [[NvShenRenZhengStep3VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
