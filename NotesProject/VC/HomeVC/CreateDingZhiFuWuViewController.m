//
//  CreateDingZhiFuWuViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/31.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "CreateDingZhiFuWuViewController.h"
#import "CreateDingZhiFuWuKouFeiViewController.h"

@interface CreateDingZhiFuWuViewController ()<CityListViewControllerDelegate>

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIView *tipKuangView;

@end

@implementation CreateDingZhiFuWuViewController

-(UIView *)tipKuangView
{
    if (!_tipKuangView) {
        
        _tipKuangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _tipKuangView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self.view addSubview:_tipKuangView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-253*BiLiWidth)/2, 287*BiLiWidth, 253*BiLiWidth)];
        kuangImageView.backgroundColor = RGBFormUIColor(0xFFFFFF);
        kuangImageView.layer.cornerRadius = 8*BiLiWidth;
        kuangImageView.layer.masksToBounds = YES;
        kuangImageView.userInteractionEnabled = YES;
        [_tipKuangView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [_tipKuangView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"提示";
        [kuangImageView addSubview:tipLable1];
        
        UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 40*BiLiWidth)];
        tipLable2.font = [UIFont systemFontOfSize:12*BiLiWidth];
        tipLable2.textColor = RGBFormUIColor(0x343434);
        tipLable2.numberOfLines = 0;
        [kuangImageView addSubview:tipLable2];
        
        NSString * neiRongStr  = @"什么是定制服务：\n定制服务为用户提供个性化需求，用户可根据自己的喜好以及时间来发布自己的需求，发布完成后可展示在需求大厅，经纪人、女神、外围等来解锁信息。\n定制服务的发布规则：\n 1、定制服务为用户发布需求，有经纪人、女神、外围等解锁信息，解锁后可联系发帖的用户提供服务。\n 2、定制服务的发布需要支付相应的费用，发布之后不可修改和删除\n 3、定制服务特殊需求尽量描述详细，如是否需要提供上门服务等。";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
        tipLable2.attributedText = attributedString;
        [tipLable2  sizeToFit];

        UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable2.top+tipLable2.height+20*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 40*BiLiWidth)];
        [sureButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:sureButton];
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = sureButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [sureButton.layer addSublayer:gradientLayer1];
        
        UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sureButton.width, sureButton.height)];
        sureLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        sureLable.text = @"确定";
        sureLable.textAlignment = NSTextAlignmentCenter;
        sureLable.textColor = [UIColor whiteColor];
        [sureButton addSubview:sureLable];
        
        kuangImageView.height = sureButton.top+sureButton.height+20*BiLiWidth;
        kuangImageView.top = (HEIGHT_PingMu-kuangImageView.height)/2;
        closeButton.top = kuangImageView.top-33*BiLiWidth/3;
    }
    return _tipKuangView;
}

-(void)closeTipKuangView
{
    self.tipKuangView.hidden = YES;
}
-(void)rightClick
{
    self.tipKuangView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.mainScrollView addGestureRecognizer:tap];
    [self.view addSubview:self.mainScrollView];
    
    UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 180*BiLiWidth)];
    topImageView.image = [UIImage imageNamed:@"faBuDingZhiFuWu"];
    [self.mainScrollView addSubview:topImageView];
    
    self.backImageView.frame = CGRectMake(self.backImageView.left, (self.topNavView.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.backImageView.image = [UIImage imageNamed:@"white_back"];
    self.topNavView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.topNavView];
    
//    [self.rightButton setTitle:@"发布规则" forState:UIControlStateNormal];
//    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
//    self.rightButton.width = 50*BiLiWidth;
//    self.rightButton.left = self.rightButton.left-13*BiLiWidth;
//    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.whiteContentView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-320*BiLiWidth)/2, TopHeight_PingMu+85*BiLiWidth, 320*BiLiWidth, 362*BiLiWidth)];
    self.whiteContentView.backgroundColor = [UIColor whiteColor];
    self.whiteContentView.layer.cornerRadius = 8*BiLiWidth;
    self.whiteContentView.layer.shadowOpacity = 0.2f;
    self.whiteContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.whiteContentView.layer.shadowOffset = CGSizeMake(0, 3);//CGSizeZero; //设置偏移量为0,四周都有阴影
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.whiteContentView addGestureRecognizer:tap1];
    [self.mainScrollView addSubview:self.whiteContentView];
    
    [self initTopMessageView];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];

}

-(void)initTopMessageView
{
    self.cityLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BiLiWidth, 24*BiLiWidth, 200*BiLiWidth, 19*BiLiWidth)];
    self.cityLable.font = [UIFont systemFontOfSize:19*BiLiWidth];
    self.cityLable.textColor = RGBFormUIColor(0x343434);
    self.cityInfo = [NormalUse defaultsGetObjectKey:CurrentCity];
    self.cityLable.text = [self.cityInfo objectForKey:@"cityName"];
    [self.whiteContentView addSubview:self.cityLable];
    
    Lable_ImageButton * cityButton  = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(259.5*BiLiWidth, 19.5*BiLiWidth, 35*BiLiWidth, 27*BiLiWidth)];
    cityButton.button_imageView.frame = CGRectMake((cityButton.width-14*BiLiWidth)/2, 0, 14*BiLiWidth, 14*BiLiWidth);
    cityButton.button_imageView.image = [UIImage imageNamed:@"location_image"];
    cityButton.button_lable.frame = CGRectMake(0, cityButton.button_imageView.top+cityButton.button_imageView.height+4*BiLiWidth, cityButton.width, 9*BiLiWidth);
    cityButton.button_lable.font = [UIFont systemFontOfSize:9*BiLiWidth];
    cityButton.button_lable.textAlignment = NSTextAlignmentCenter;
    cityButton.button_lable.textColor = RGBFormUIColor(0x1396DC);
    cityButton.button_lable.text = @"当前位置";
    cityButton.button_lable.adjustsFontSizeToFitWidth = YES;
    [cityButton addTarget:self action:@selector(cityButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteContentView addSubview:cityButton];
    
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(25*BiLiWidth, 56*BiLiWidth, 273.5*BiLiWidth, 1)];
    lineView1.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.whiteContentView addSubview:lineView1];
    
    self.beginTimeButton = [[UIButton alloc] initWithFrame:CGRectMake(lineView1.left, lineView1.top+lineView1.height, 58*BiLiWidth, 37.5*BiLiWidth)];
    self.beginTimeButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.beginTimeButton setTitle:@"开始时间" forState:UIControlStateNormal];
    self.beginTimeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.beginTimeButton setTitleColor:RGBFormUIColor(0xDEDEDE) forState:UIControlStateNormal];
    [self.beginTimeButton addTarget:self action:@selector(beginTimeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteContentView addSubview:self.beginTimeButton];
    
    self.beginWeekLable = [[UILabel alloc] initWithFrame:CGRectMake(self.beginTimeButton.left+self.beginTimeButton.width+5*BiLiWidth, self.beginTimeButton.top, 20*BiLiWidth, self.beginTimeButton.height)];
    self.beginWeekLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
    self.beginWeekLable.textColor = RGBFormUIColor(0x9A9A9A);
    self.beginWeekLable.adjustsFontSizeToFitWidth = YES;
    [self.whiteContentView addSubview:self.beginWeekLable];
    
    UIView * timeLineView = [[UIView alloc] initWithFrame:CGRectMake(self.beginWeekLable.left+self.beginWeekLable.width+10*BiLiWidth, (self.beginTimeButton.height-1)/2+self.beginTimeButton.top,7*BiLiWidth, 1)];
    timeLineView.backgroundColor = RGBFormUIColor(0x343434);
    [self.whiteContentView addSubview:timeLineView];
    
    self.endTimeButton = [[UIButton alloc] initWithFrame:CGRectMake(timeLineView.left+timeLineView.width+10*BiLiWidth, lineView1.top+lineView1.height, 58*BiLiWidth, 37.5*BiLiWidth)];
    self.endTimeButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.endTimeButton setTitle:@"结束时间" forState:UIControlStateNormal];
    self.endTimeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.endTimeButton setTitleColor:RGBFormUIColor(0xDEDEDE) forState:UIControlStateNormal];
    [self.endTimeButton addTarget:self action:@selector(endTimeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteContentView addSubview:self.endTimeButton];
    
    self.endWeekLable = [[UILabel alloc] initWithFrame:CGRectMake(self.endTimeButton.left+self.endTimeButton.width+5*BiLiWidth, self.beginTimeButton.top, 20*BiLiWidth, self.beginTimeButton.height)];
    self.endWeekLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
    self.endWeekLable.textColor = RGBFormUIColor(0x9A9A9A);
    self.endWeekLable.adjustsFontSizeToFitWidth = YES;
    [self.whiteContentView addSubview:self.endWeekLable];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(25*BiLiWidth, lineView1.top+lineView1.height+37.5*BiLiWidth, 273.5*BiLiWidth, 1)];
    lineView2.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.whiteContentView addSubview:lineView2];

    UILabel * jiaGeLable = [[UILabel alloc] initWithFrame:CGRectMake(lineView1.left, lineView2.top+lineView2.height, 50*BiLiWidth, 39.5*BiLiWidth)];
    jiaGeLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    jiaGeLable.textColor = RGBFormUIColor(0x343434);
    jiaGeLable.text = @"价格区间";
    [self.whiteContentView addSubview:jiaGeLable];
    
    self.beginPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(jiaGeLable.left+jiaGeLable.width+16*BiLiWidth, lineView2.top+lineView2.height, 58*BiLiWidth, 39.5*BiLiWidth)];
    self.beginPriceTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.beginPriceTF.placeholder = @"最低价格";
    self.beginPriceTF.textColor  = RGBFormUIColor(0x343434);
    self.beginPriceTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.whiteContentView addSubview:self.beginPriceTF];

    UIView * priceLineView = [[UIView alloc] initWithFrame:CGRectMake(self.beginPriceTF.left+self.beginPriceTF.width+14*BiLiWidth, (self.beginPriceTF.height-1)/2+self.beginPriceTF.top,7*BiLiWidth, 1)];
    priceLineView.backgroundColor = RGBFormUIColor(0x343434);
    [self.whiteContentView addSubview:priceLineView];


    self.endPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(priceLineView.left+priceLineView.width+14*BiLiWidth, lineView2.top+lineView2.height, 58*BiLiWidth, 39.5*BiLiWidth)];
    self.endPriceTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.endPriceTF.placeholder = @"最高价格";
    self.endPriceTF.textColor  = RGBFormUIColor(0x343434);
    self.endPriceTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.whiteContentView addSubview:self.endPriceTF];

    UIView * lineView3 = [[UIView alloc] initWithFrame:CGRectMake(25*BiLiWidth, lineView2.top+lineView2.height+39.5*BiLiWidth, 273.5*BiLiWidth, 1)];
    lineView3.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.whiteContentView addSubview:lineView3];

    UILabel * meiZiLeiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(lineView1.left, lineView3.top+lineView3.height, 50*BiLiWidth, 39.5*BiLiWidth)];
    meiZiLeiXingLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    meiZiLeiXingLable.textColor = RGBFormUIColor(0x343434);
    meiZiLeiXingLable.text = @"妹子类型";
    [self.whiteContentView addSubview:meiZiLeiXingLable];
    
    self.leiXingButton = [[UIButton alloc] initWithFrame:CGRectMake(194*BiLiWidth-100*BiLiWidth, meiZiLeiXingLable.top, 105*BiLiWidth+100*BiLiWidth, 39.5*BiLiWidth)];
    self.leiXingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.leiXingButton setTitle:@"选择喜欢的妹子类型>" forState:UIControlStateNormal];
    [self.leiXingButton setTitleColor:RGBFormUIColor(0xDEDEDE) forState:UIControlStateNormal];
    self.leiXingButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
    self.leiXingButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.leiXingButton addTarget:self action:@selector(leiXingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteContentView addSubview:self.leiXingButton];
    
    UIView * lineView4 = [[UIView alloc] initWithFrame:CGRectMake(25*BiLiWidth, lineView3.top+lineView3.height+39.5*BiLiWidth, 273.5*BiLiWidth, 1)];
    lineView4.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.whiteContentView addSubview:lineView4];

    
    UILabel * fuWuXiangMuLable = [[UILabel alloc] initWithFrame:CGRectMake(lineView1.left, lineView4.top+lineView4.height, 50*BiLiWidth, 39.5*BiLiWidth)];
    fuWuXiangMuLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    fuWuXiangMuLable.textColor = RGBFormUIColor(0x343434);
    fuWuXiangMuLable.text = @"服务项目";
    [self.whiteContentView addSubview:fuWuXiangMuLable];
    
    self.xiangMuButton = [[UIButton alloc] initWithFrame:CGRectMake(194*BiLiWidth-100*BiLiWidth, fuWuXiangMuLable.top, 105*BiLiWidth+100*BiLiWidth, 39.5*BiLiWidth)];
    self.xiangMuButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.xiangMuButton setTitle:@"选择服务项目>" forState:UIControlStateNormal];
    [self.xiangMuButton setTitleColor:RGBFormUIColor(0xDEDEDE) forState:UIControlStateNormal];
    self.xiangMuButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
    self.xiangMuButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.xiangMuButton addTarget:self action:@selector(xiangMuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteContentView addSubview:self.xiangMuButton];
    
    UIView * lineView5 = [[UIView alloc] initWithFrame:CGRectMake(25*BiLiWidth, lineView4.top+lineView4.height+39.5*BiLiWidth, 273.5*BiLiWidth, 1)];
    lineView5.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.whiteContentView addSubview:lineView5];

    UILabel * lianXiFangShiLable = [[UILabel alloc] initWithFrame:CGRectMake(lineView1.left, lineView5.top+lineView5.height+13*BiLiWidth, 50*BiLiWidth, 12*BiLiWidth)];
    lianXiFangShiLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    lianXiFangShiLable.textColor = RGBFormUIColor(0x343434);
    lianXiFangShiLable.text = @"联系方式";
    [self.whiteContentView addSubview:lianXiFangShiLable];
    
    UILabel * lianXiFangShiTipLable = [[UILabel alloc] initWithFrame:CGRectMake(lianXiFangShiLable.left, lianXiFangShiLable.top+lianXiFangShiLable.height+10*BiLiWidth, 63*BiLiWidth, 25*BiLiWidth)];
    lianXiFangShiTipLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
    lianXiFangShiTipLable.textColor = RGBFormUIColor(0xDEDEDE);
    lianXiFangShiTipLable.numberOfLines = 2;
    lianXiFangShiTipLable.text = @"(填写一种联系方式即可）";
    [self.whiteContentView addSubview:lianXiFangShiTipLable];
    
    
    self.weiXinTF = [[UITextField alloc] initWithFrame:CGRectMake(194*BiLiWidth, lineView5.top+lineView5.height, 105*BiLiWidth, 39.5*BiLiWidth)];
    self.weiXinTF.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [NormalUse setTextFieldPlaceholder:@"请填写微信号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.weiXinTF];
    self.weiXinTF.textAlignment = NSTextAlignmentRight;
    self.weiXinTF.textColor  = RGBFormUIColor(0x343434);
    [self.whiteContentView addSubview:self.weiXinTF];
    
    UIView * lineView6 = [[UIView alloc] initWithFrame:CGRectMake(101.5*BiLiWidth, lineView5.top+lineView5.height+39.5*BiLiWidth, 197*BiLiWidth, 1)];
    lineView6.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.whiteContentView addSubview:lineView6];
    
    self.qqTF = [[UITextField alloc] initWithFrame:CGRectMake(194*BiLiWidth, lineView6.top+lineView6.height, 105*BiLiWidth, 39.5*BiLiWidth)];
    self.qqTF.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [NormalUse setTextFieldPlaceholder:@"请填写QQ号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.qqTF];
    self.qqTF.textColor  = RGBFormUIColor(0x343434);
    self.qqTF.textAlignment = NSTextAlignmentRight;
    [self.whiteContentView addSubview:self.qqTF];
    
    UIView * lineView7 = [[UIView alloc] initWithFrame:CGRectMake(101.5*BiLiWidth, lineView6.top+lineView6.height+39.5*BiLiWidth, 197*BiLiWidth, 1)];
    lineView7.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.whiteContentView addSubview:lineView7];

    
    self.telTF = [[UITextField alloc] initWithFrame:CGRectMake(194*BiLiWidth, lineView7.top+lineView7.height, 105*BiLiWidth, 39.5*BiLiWidth)];
    self.telTF.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [NormalUse setTextFieldPlaceholder:@"请填写手机号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.telTF];
    self.telTF.textAlignment = NSTextAlignmentRight;
    self.telTF.textColor  = RGBFormUIColor(0x343434);
    [self.whiteContentView addSubview:self.telTF];
    
    UIView * lineView8 = [[UIView alloc] initWithFrame:CGRectMake(101.5*BiLiWidth, lineView7.top+lineView7.height+39.5*BiLiWidth, 197*BiLiWidth, 1)];
    lineView8.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.whiteContentView addSubview:lineView8];


    UILabel * xuQiuMiaoShuLable = [[UILabel alloc] initWithFrame:CGRectMake(self.whiteContentView.left, self.whiteContentView.top+self.whiteContentView.height+32*BiLiWidth, 100*BiLiWidth, 13*BiLiWidth)];
    xuQiuMiaoShuLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    xuQiuMiaoShuLable.textColor = RGBFormUIColor(0x343434);
    xuQiuMiaoShuLable.text = @"*需求描述";
    [self.mainScrollView addSubview:xuQiuMiaoShuLable];
    
    self.describleTextView = [[UITextView alloc] initWithFrame:CGRectMake(xuQiuMiaoShuLable.left, xuQiuMiaoShuLable.top+xuQiuMiaoShuLable.height+13.5*BiLiWidth , 320*BiLiWidth, 83*BiLiWidth)];
    self.describleTextView.layer.borderWidth = 1;
    self.describleTextView.layer.borderColor = [RGBFormUIColor(0xDEDEDE) CGColor];
    self.describleTextView.layer.cornerRadius = 8*BiLiWidth;
    self.describleTextView.placeholder = @"请输入需求描述...";
    self.describleTextView.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.mainScrollView addSubview:self.describleTextView];

    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, self.describleTextView.top+self.describleTextView.height+23*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [tiJiaoButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:tiJiaoButton];
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
    tiJiaoLable.text = @"确认提交";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [tiJiaoButton addSubview:tiJiaoLable];
    

    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, tiJiaoButton.top+tiJiaoButton.height+20*BiLiWidth)];
    [self initPickView];
}
-(void)cityButtonClick
{
    CityListViewController * vc = [[CityListViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)citySelect:(NSDictionary *)info
{
    self.cityInfo = info;
    self.cityLable.text = [info objectForKey:@"cityName"];
}
-(void)initPickView
{
    self.pickRootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    self.pickRootView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:self.pickRootView];

    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickRootViewTap)];
    [self.pickRootView addGestureRecognizer:tapGesture];
    
    self.datePickView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu-162, WIDTH_PingMu, 162)];
    self.datePickView.datePickerMode=UIDatePickerModeDate;
    [self.pickRootView addSubview:self.datePickView];
    self.datePickView.maximumDate = [NSDate date];
    
    NSDate * currentDate = [NSDate date];
     [self.datePickView setDate:currentDate animated:YES];//设置滚动到的时间
        
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setYear:1];
    [lastMonthComps setMonth:1];// month = 1表示1月后的时间 month = -1为1月前的日期 year day 类推
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];

    [self.datePickView setMinimumDate:currentDate];//设置最小时间
    [self.datePickView setMaximumDate:newdate];//设置最大时间

    self.datePickView.backgroundColor = [UIColor whiteColor];
    [self.datePickView addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    self.pickRootView.hidden = YES;
}
-(void)oneDatePickerValueChanged:(UIDatePicker *) sender
{
    NSDate * select = [sender date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"MM月dd日";
    NSString * selectData = [selectDateFormatter stringFromDate:select];
    
    if (beiginOrEndTimeSelect==0) {
     
        self.beginDate = select;
    }
    else
    {
        self.endDate = select;
    }

    if([self.beginDate isKindOfClass:[NSDate class]] && [self.endDate isKindOfClass:[NSDate class]])
    {
    
        //laterDate 返回较晚的时间
        if ([[self.beginDate laterDate:self.endDate] isEqualToDate:self.beginDate]) {
            
            if (beiginOrEndTimeSelect==0) {
             
                self.beginDate = nil;
            }
            else
            {
                self.endDate = nil;
            }

            [NormalUse showToastView:@"结束时间不能早于开始时间" view:self.view];
        }
        else
        {
            if (beiginOrEndTimeSelect==0) {
             
                [self.beginTimeButton setTitle:selectData forState:UIControlStateNormal];
                [self.beginTimeButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
                self.beginWeekLable.text = [NormalUse weekdayStringWithDate:select];
            }
            else
            {
                [self.endTimeButton setTitle:selectData forState:UIControlStateNormal];
                [self.endTimeButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
                self.endWeekLable.text = [NormalUse weekdayStringWithDate:select];

            }

        }

    }
    else
    {
        if (beiginOrEndTimeSelect==0) {
         
            [self.beginTimeButton setTitle:selectData forState:UIControlStateNormal];
            [self.beginTimeButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
            self.beginWeekLable.text = [NormalUse weekdayStringWithDate:select];
        }
        else
        {
            [self.endTimeButton setTitle:selectData forState:UIControlStateNormal];
            [self.endTimeButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
            self.endWeekLable.text = [NormalUse weekdayStringWithDate:select];

        }

    }

    
    

}
-(void)pickRootViewTap
{
    self.pickRootView.hidden = YES;
}

-(void)viewTap
{
    [self.beginPriceTF resignFirstResponder];
    [self.endPriceTF resignFirstResponder];
    [self.weiXinTF resignFirstResponder];
    [self.qqTF resignFirstResponder];
    [self.telTF resignFirstResponder];
    [self.describleTextView resignFirstResponder];

}
#pragma mark--UIButtonClick
-(void)beginTimeButtonClick
{
    beiginOrEndTimeSelect = 0;
    self.pickRootView.hidden = NO;
}
-(void)endTimeButtonClick
{
    beiginOrEndTimeSelect = 1;
    self.pickRootView.hidden = NO;

}

-(void)leiXingButtonClick
{
    LeiXiangSelectViewController * vc = [[LeiXiangSelectViewController alloc] init];
    vc.type = @"meizi";
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)xiangMuButtonClick
{
    LeiXiangSelectViewController * vc = [[LeiXiangSelectViewController alloc] init];
    vc.type = @"fuwu";
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)itemSelected:(NSString *)str type:(NSString *)type
{
    if ([@"meizi" isEqualToString:type]) {
      
        self.leiXingStr = str;
        [self.leiXingButton setTitle:str forState:UIControlStateNormal];
        [self.leiXingButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    }
    else
    {
        self.xiangMuStr = str;
        [self.xiangMuButton setTitle:str forState:UIControlStateNormal];
        [self.xiangMuButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];

    }
}
-(void)tiJiaoButtonClick
{
    if (![self.beginDate isKindOfClass:[NSDate class]]) {
        
        [NormalUse showToastView:@"请选择开始时间" view:self.view];
        return;
    }
    if (![self.endDate isKindOfClass:[NSDate class]]) {
        
        [NormalUse showToastView:@"请选择结束时间" view:self.view];
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
    if (![NormalUse isValidString:self.leiXingStr]) {
        
        [NormalUse showToastView:@"请选择小姐类型" view:self.view];
         return;
    }
    if (![NormalUse isValidString:self.xiangMuStr]) {
        
        [NormalUse showToastView:@"请选择服务项目" view:self.view];
         return;
    }

    if(![NormalUse isValidString:self.weiXinTF.text]&&![NormalUse isValidString:self.qqTF.text]&&![NormalUse isValidString:self.telTF.text])
    {
        [NormalUse showToastView:@"请填写联系方式" view:self.view];
         return;

    }
    
    if (![NormalUse isValidString:self.describleTextView.text]) {
        
        [NormalUse showToastView:@"请填写描述类容" view:self.view];
         return;
    }
    
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString * beginStr = [selectDateFormatter stringFromDate:self.beginDate];
    NSString * endStr = [selectDateFormatter stringFromDate:self.endDate];


    CreateDingZhiFuWuKouFeiViewController * vc = [[CreateDingZhiFuWuKouFeiViewController alloc] init];
    NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
    vc.city_code = [NSString stringWithFormat:@"%d",cityCode.intValue];
    vc.start_date = beginStr;
    vc.end_date = endStr;
    vc.min_price = self.beginPriceTF.text;
    vc.max_price = self.endPriceTF.text;
    vc.love_type = self.leiXingStr;
    vc.service_type = self.xiangMuStr;
    vc.mobie = self.telTF.text;
    vc.qq = self.qqTF.text;
    vc.wechat = self.weiXinTF.text;
    vc.describe = self.describleTextView.text;
    [self.navigationController pushViewController:vc animated:YES];
    


}
#pragma mark--键盘弹出时的监听事件
- (void)keyboardWillShow:(NSNotification *) notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    //键盘高度
    float keyboardHeight = keyboardBounds.size.height;
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.describleTextView.top+self.describleTextView.height+keyboardHeight+100*BiLiWidth)];
}
- (void)keyboardWillHide
{
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.describleTextView.top+self.describleTextView.height+85*BiLiWidth)];
}


@end
