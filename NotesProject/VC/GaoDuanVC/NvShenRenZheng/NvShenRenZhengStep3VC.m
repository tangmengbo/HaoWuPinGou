//
//  NvShenRenZhengStep3VC.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "NvShenRenZhengStep3VC.h"

@interface NvShenRenZhengStep3VC ()
{
    int payTypeIndex;
}
@property(nonatomic,strong)NSArray * paySourceArray;
@property(nonatomic,strong)NSMutableArray * payTypeList;
@property(nonatomic,strong)UIView * zhiFuView;
@property(nonatomic,strong)NSMutableArray * payTypeButtonArray;
@property(nonatomic,strong)NSString * orderId;

@property(nonatomic,strong)NSString * goddess_auth_coin;//女神认证所需金币
@property(nonatomic,strong)NSString * peripheral_auth_coin;//外围女认证所需金币
@property(nonatomic,strong)NSString * global_auth_coin;//全球陪玩认证所需金币


@end

@implementation NvShenRenZhengStep3VC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [HTTPModel getUserInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            NSNumber * coin = [responseObject objectForKey:@"coin"];
            
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前可用金币：%d",coin.intValue]];
            [str1 addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x343434) range:NSMakeRange(0, 7)];
            [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*BiLiWidth] range:NSMakeRange(0, 7)];
            self.yuELable.attributedText = str1;

        }
    }];
    
    self.goddess_auth_coin = [NormalUse getJinBiStr:@"goddess_auth_coin"];
    self.peripheral_auth_coin = [NormalUse getJinBiStr:@"peripheral_auth_coin"];
    self.global_auth_coin = [NormalUse getJinBiStr:@"global_auth_coin"];

    self.topTitleLale.text = @"认证";
    
     if ([@"1" isEqualToString:self.renZhengType])
     {
         needJinBiValue = self.goddess_auth_coin.intValue;

     }
     else if ([@"2" isEqualToString:self.renZhengType])
     {
         needJinBiValue = self.peripheral_auth_coin.intValue;

     }
    else
    {
        needJinBiValue = self.global_auth_coin.intValue;
    }
    
    self.loadingFullScreen= @"yes";
    
    [self initTopStepView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yanZhengOrder) name:@"YanZhengDingDanNotification" object:nil];
    
    payTypeIndex = -1;
    [NormalUse showMessageLoadView:@"Loading..." vc:self];
    [HTTPModel getCommonPayType:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse removeMessageLoadingView:self];
        if (status==1) {
            
             self.paySourceArray = responseObject;
        }
        
    }];

}
-(UIView *)zhiFuView
{
    if (!_zhiFuView) {

        _zhiFuView= [[UIView alloc] initWithFrame:CGRectMake(0,0, WIDTH_PingMu, HEIGHT_PingMu)];
        _zhiFuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self.view addSubview:_zhiFuView];
        
        UIView * whiteContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 0)];
        whiteContentView.backgroundColor = [UIColor whiteColor];
        [_zhiFuView addSubview:whiteContentView];

        UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BiLiWidth, 15*BiLiWidth, 200*BiLiWidth, 17*BiLiWidth)];
        tipLable.text = @"选择支付方式";
        tipLable.textColor = RGBFormUIColor(0xFFA218);
        tipLable.font = [UIFont systemFontOfSize:17*BiLiWidth];
        [whiteContentView addSubview:tipLable];

        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-28*BiLiWidth, 13*BiLiWidth, 14.5*BiLiWidth, 14.5*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"dianPu_tip_close"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeZhiFuView) forControlEvents:UIControlEventTouchUpInside];
        [whiteContentView addSubview:closeButton];
        
        float originY = tipLable.top+tipLable.height+10*BiLiWidth;
        self.payTypeButtonArray = [NSMutableArray array];
        for(int i=0;i<self.payTypeList.count;i++)
        {
            NSDictionary * info = [self.payTypeList objectAtIndex:i];
            
            Lable_ImageButton * button  = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, originY, WIDTH_PingMu, 21*BiLiWidth)];
            [button addTarget:self action:@selector(payTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.button_imageView.frame = CGRectMake(19*BiLiWidth, 0, 21*BiLiWidth, 21*BiLiWidth);
            button.button_lable.frame = CGRectMake(button.button_imageView.left+button.button_imageView.width+6.5*BiLiWidth, 0, 200*BiLiWidth, 21*BiLiWidth);
            button.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
            button.button_lable.textColor = RGBFormUIColor(0x343434);
            button.button_imageView1.frame = CGRectMake(WIDTH_PingMu-14.5*BiLiWidth-28.5*BiLiWidth, (button.height-14.5*BiLiWidth)/2, 14.5*BiLiWidth, 14.5*BiLiWidth);
            button.button_imageView1.layer.cornerRadius = 15.4*BiLiWidth/2;
            button.button_imageView1.layer.masksToBounds = YES;
            button.button_imageView1.layer.borderWidth = 1;
            button.button_imageView1.layer.borderColor = [RGBFormUIColor(0x343434) CGColor];
            button.tag = i;
            [whiteContentView addSubview:button];
            
            if ([@"微信支付" isEqualToString:[info objectForKey:@"pay_name"]]) {
                
                button.button_imageView.image = [UIImage imageNamed:@"zhangHu_Wx"];
                button.button_lable.text = [info objectForKey:@"pay_name"];
            }
            else if ([@"网银支付" isEqualToString:[info objectForKey:@"pay_name"]])
            {
                button.button_imageView.image = [UIImage imageNamed:@"zhangHu_yiLian"];
                button.button_lable.text = [info objectForKey:@"pay_name"];

            }
            else
            {
                button.button_imageView.image = [UIImage imageNamed:@"zhangHu_zfb"];
                button.button_lable.text = [info objectForKey:@"pay_name"];
            }
            
            [self.payTypeButtonArray addObject:button];
            originY = originY+40*BiLiWidth;
        }
        
        UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-280*BiLiWidth)/2, originY, 280*BiLiWidth, 40*BiLiWidth)];
//        chongZhiButton.layer.cornerRadius = 45*BiLiWidth/2;
//        chongZhiButton.backgroundColor = RGBFormUIColor(0xFF6B6C);
//        chongZhiButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
//        [chongZhiButton setTitle:@"立即支付" forState:UIControlStateNormal];
//        [chongZhiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chongZhiButton addTarget:self action:@selector(liJiZhiFuButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [whiteContentView addSubview:chongZhiButton];
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6B6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0A76);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = chongZhiButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [chongZhiButton.layer addSublayer:gradientLayer1];
        
         UILabel *  chongZhiButtonTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, chongZhiButton.width, chongZhiButton.height)];
        chongZhiButtonTipLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        chongZhiButtonTipLable.textAlignment = NSTextAlignmentCenter;
        chongZhiButtonTipLable.textColor = [UIColor whiteColor];
        chongZhiButtonTipLable.text = @"立即支付";
        [chongZhiButton addSubview:chongZhiButtonTipLable];

        whiteContentView.height = chongZhiButton.top+chongZhiButton.height+20*BiLiWidth;
        whiteContentView.top = HEIGHT_PingMu-whiteContentView.height;
        //某个角圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_zhiFuView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8*BiLiWidth, 8*BiLiWidth)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _zhiFuView.bounds;
        maskLayer.path = maskPath.CGPath;
        whiteContentView.layer.mask = maskLayer;

    }
    return _zhiFuView;
}
-(void)payTypeButtonClick:(Lable_ImageButton *)selectButton
{
    payTypeIndex = (int)selectButton.tag;
    
    for (Lable_ImageButton * button in self.payTypeButtonArray) {
        
        [button.button_imageView1 setImage:nil];
        button.button_imageView1.layer.borderWidth = 1;
    }
    [selectButton.button_imageView1 setImage:[UIImage imageNamed:@"zhangHu_select"]];
    selectButton.button_imageView1.layer.borderWidth = 0;

}
-(void)liJiZhiFuButtonClick
{
    [self closeZhiFuView];
    
    if (payTypeIndex==-1) {
        
        [NormalUse showToastView:@"请选择支付方式" view:self.view];
        return;
    }
        [self xianShiLoadingView:@"下单中..." view:self.view];
        [HTTPModel getZFOrderId:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
           
            [self yinCangLoadingView];

            if (status==1) {
                
                self.orderId = responseObject;
                NSDictionary * payTypeInfo = [self.payTypeList objectAtIndex:self->payTypeIndex];
                NSString * coin = [NSString stringWithFormat:@"%d",self->needJinBiValue];
                NSString *url;
                //type_id type_id(预约类型1真实会员贴  2仨角色贴 3普通茶贴)
                url   =  [NSString stringWithFormat:@"%@/%@",HTTP_REQUESTURL,[payTypeInfo objectForKey:@"auth_url"]];
                if([NormalUse isValidString:self.other_type])
                {
                    url = [url stringByAppendingString:[NSString stringWithFormat:@"?amount=%@&order_no=%@&logintoken=%@&pay_channel=%@&pay_code=%@&type=%@&other_type=%@&nums=%@&contact=%@&nprice_label=%@",[NSString stringWithFormat:@"%d",coin.intValue],self.orderId,[NormalUse defaultsGetObjectKey:LoginToken],[payTypeInfo objectForKey:@"pay_channel"],[payTypeInfo objectForKey:@"pay_code"],self.renZhengType,self.other_type,[self.info objectForKey:@"nums"],[self.info objectForKey:@"contact"],[self.info objectForKey:@"nprice_label"]]];

                }
                else
                {
                    url = [url stringByAppendingString:[NSString stringWithFormat:@"?amount=%@&order_no=%@&logintoken=%@&pay_channel=%@&pay_code=%@&type=%@&nums=%@&contact=%@&nprice_label=%@",[NSString stringWithFormat:@"%d",coin.intValue],self.orderId,[NormalUse defaultsGetObjectKey:LoginToken],[payTypeInfo objectForKey:@"pay_channel"],[payTypeInfo objectForKey:@"pay_code"],self.renZhengType,[self.info objectForKey:@"nums"],[self.info objectForKey:@"contact"],[self.info objectForKey:@"nprice_label"]]];

                }
                NSURL *cleanURL = [NSURL URLWithString:url];
                [[UIApplication sharedApplication] openURL:cleanURL options:nil completionHandler:^(BOOL success) {
                    
                }];
            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
            }
        }];
}
-(void)yanZhengOrder
{
    [self xianShiLoadingView:@"验证支付..." view:self.view];
    [HTTPModel checkZFStatus:[[NSDictionary alloc]initWithObjectsAndKeys:self.orderId,@"orderId", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [self yinCangLoadingView];
        if (status==1) {
            //0下单，1成功，2失败
            NSNumber * pay_status = [responseObject objectForKey:@"pay_status"];
            if (pay_status.intValue==0) {
                
                [NormalUse showToastView:@"订单正在处理中,请稍等" view:self.view];
            }
            else if (pay_status.intValue==1)
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
                [NormalUse showToastView:@"认证成功" view:[NormalUse getCurrentVC].view];

            }
            else
            {
                [NormalUse showToastView:@"订单支付失败" view:self.view];

            }
        }
    }];
    
}
-(void)closeZhiFuView
{
    self.zhiFuView.hidden = YES;
}

-(void)initTopStepView
{
    
    float distance = (WIDTH_PingMu-37*BiLiWidth*2-22*BiLiWidth*4)/3;
    
    /*
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
    
    
    UIButton * step1BottomView = [[UIButton alloc] initWithFrame:CGRectMake(step2Lable.left+step2Lable.width+distance, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
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

    UILabel * step3Lable = [[UILabel alloc] initWithFrame:CGRectMake(step2Lable.left+step2Lable.width+distance, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
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
    step3TipLable.text = @"认证费";
    step3TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step3TipLable];
    
    UILabel * step4Lable = [[UILabel alloc] initWithFrame:CGRectMake(step3Lable.left+step3Lable.width+distance, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step4Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step4Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step4Lable.textAlignment = NSTextAlignmentCenter;
    step4Lable.layer.cornerRadius = 11*BiLiWidth;
    step4Lable.layer.masksToBounds = YES;
    step4Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step4Lable.text = @"4";
    [self.view addSubview:step4Lable];
    
    UILabel * step4TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step4Lable.left-30*BiLiWidth,step4Lable.top+step4Lable.height+8.5*BiLiWidth , step3Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step4TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step4TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step4TipLable.text = @"等待审核";
    step4TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step4TipLable];
     */
    
    UILabel * step2Lable = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH_PingMu/2-22*BiLiWidth)/2, self.topNavView.top+self.topNavView.height+10*BiLiWidth, 22*BiLiWidth, 22*BiLiWidth)];
    step2Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step2Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step2Lable.textAlignment = NSTextAlignmentCenter;
    step2Lable.layer.cornerRadius = 11*BiLiWidth;
    step2Lable.layer.masksToBounds = YES;
    step2Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step2Lable.text = @"1";
    [self.view addSubview:step2Lable];
    
    UILabel * step2TipLable = [[UILabel alloc] initWithFrame:CGRectMake(0,step2Lable.top+step2Lable.height+8.5*BiLiWidth , WIDTH_PingMu/2, 12*BiLiWidth)];
    step2TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step2TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step2TipLable.text = @"填写个人资料";
    step2TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step2TipLable];
    
    
    UIButton * step1BottomView = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu/2-22*BiLiWidth)/2+WIDTH_PingMu/2, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
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

    UILabel * step3Lable = [[UILabel alloc] initWithFrame:CGRectMake(step1BottomView.left, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step3Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step3Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step3Lable.textAlignment = NSTextAlignmentCenter;
    step3Lable.layer.cornerRadius = 11*BiLiWidth;
    step3Lable.layer.masksToBounds = YES;
    step3Lable.text = @"2";
    [self.view addSubview:step3Lable];
    
    UILabel * step3TipLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu/2,step3Lable.top+step3Lable.height+8.5*BiLiWidth , WIDTH_PingMu/2, 12*BiLiWidth)];
    step3TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step3TipLable.textColor = RGBFormUIColor(0x343434);
    step3TipLable.text = @"认证费";
    step3TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step3TipLable];

    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-318*BiLiWidth)/2, step3TipLable.top+step3TipLable.height+30*BiLiWidth, 318*BiLiWidth, 206*BiLiWidth)];
    tipImageView.image = [UIImage imageNamed:@"jiaoLaYaJin_nvShen"];
    [self.view addSubview:tipImageView];
    
    self.jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, 160*BiLiWidth, 150*BiLiWidth, 24*BiLiWidth)];
    self.jinBiLable.font = [UIFont systemFontOfSize:24*BiLiWidth];
    self.jinBiLable.textColor = RGBFormUIColor(0x333333);
    [tipImageView addSubview:self.jinBiLable];
    
    NSString * jinBiStr = [NSString stringWithFormat:@"%d 金币",needJinBiValue];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:jinBiStr];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x999999) range:NSMakeRange(jinBiStr.length-2, 2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*BiLiWidth] range:NSMakeRange(jinBiStr.length-2, 2)];
    self.jinBiLable.attributedText = str;
    
    UILabel * renZhengTipLable = [[UILabel alloc] initWithFrame:CGRectMake(tipImageView.width-175*BiLiWidth, self.jinBiLable.top, 150*BiLiWidth, 24*BiLiWidth)];
    renZhengTipLable.textAlignment = NSTextAlignmentRight;
    renZhengTipLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    renZhengTipLable.text = @"申请认证所需费用";
    [tipImageView addSubview:renZhengTipLable];
    

    
    self.yuELable = [[UILabel alloc] initWithFrame:CGRectMake(0, tipImageView.top+tipImageView.height+9*BiLiWidth, WIDTH_PingMu, 18*BiLiWidth)];
    self.yuELable.font = [UIFont systemFontOfSize:18*BiLiWidth];
    self.yuELable.textColor = RGBFormUIColor(0xFED062);
    self.yuELable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.yuELable];
    
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(26.5*BiLiWidth, self.yuELable.top+self.yuELable.height+20*BiLiWidth, 100*BiLiWidth, 13*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0x333333);
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.text = @"您也可同时认证：";
    [self.view addSubview:tipLable];
    
    NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
    NSString * defaultsKey = [UserRole stringByAppendingString:token];
    NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
    NSNumber * auth_goddess = [userRoleDic objectForKey:@"auth_goddess"];//女神
    NSNumber * auth_peripheral = [userRoleDic objectForKey:@"auth_peripheral"];//外围
    NSNumber * auth_global = [userRoleDic objectForKey:@"auth_global"];//空降

    
    NSString * renZhengStr1;
    NSString * renZhengStr2;
    if ([@"4" isEqualToString:self.renZhengType]) {
        
        if(auth_peripheral.intValue==0)
        {
            renZhengStr1 = @"外围";
        }
        
        if(auth_global.intValue==0)
        {
            renZhengStr2 = @"全球陪玩";

        }

        if(auth_peripheral.intValue!=0 && auth_global.intValue!=0)
        {
            tipLable.hidden = YES;
        }

    }
    else if ([@"5" isEqualToString:self.renZhengType])
    {
        if(auth_goddess.intValue==0)
        {
            renZhengStr1 = @"女神";

        }
        
        if(auth_global.intValue==0)
        {
            renZhengStr2 = @"全球陪玩";

        }
        
        if(auth_goddess.intValue!=0 && auth_global.intValue!=0)
        {
            tipLable.hidden = YES;
        }


    }
    else
    {
        
        if(auth_goddess.intValue==0)
        {
            renZhengStr1 = @"女神";

        }
        
        if(auth_peripheral.intValue==0)
        {
            renZhengStr2 = @"外围";

        }

        if(auth_goddess.intValue!=0 && auth_peripheral.intValue!=0)
        {
            tipLable.hidden = YES;
        }

    }

    self.lableButton1 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(tipLable.left+tipLable.width+20*BiLiWidth, tipLable.top-6 *BiLiWidth,50*BiLiWidth,24*BiLiWidth)];
    [self.lableButton1 addTarget:self action:@selector(lableButton1Click) forControlEvents:UIControlEventTouchUpInside];
    self.lableButton1.tag = 0;
    self.lableButton1.button_imageView.frame = CGRectMake(0, 6*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth);
    self.lableButton1.button_imageView.layer.cornerRadius = 6*BiLiWidth;
    self.lableButton1.button_imageView.layer.masksToBounds = YES;
    self.lableButton1.button_imageView.layer.borderWidth = 1;
    self.lableButton1.button_imageView.layer.borderColor = [RGBFormUIColor(0x999999) CGColor];
    self.lableButton1.button_imageView1.frame = CGRectMake(self.lableButton1.button_imageView.left+1.5*BiLiWidth, self.lableButton1.button_imageView.top+1.5*BiLiWidth, 9*BiLiWidth, 9*BiLiWidth);
    self.lableButton1.button_imageView1.layer.cornerRadius = 4.5*BiLiWidth;
    self.lableButton1.button_imageView1.layer.masksToBounds = YES;
    self.lableButton1.button_lable.frame = CGRectMake(17*BiLiWidth, 0, 30*BiLiWidth, 24*BiLiWidth);
    self.lableButton1.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.lableButton1.button_lable.textColor = RGBFormUIColor(0x999999);
    self.lableButton1.button_lable.text = renZhengStr1;
    [self.view addSubview:self.lableButton1];
    
    if (![NormalUse isValidString:renZhengStr1]) {
        
        self.lableButton1.hidden = YES;
        self.lableButton1.width = 0;
    }
    
    
    self.lableButton2 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(self.lableButton1.left+self.lableButton1.width+24*BiLiWidth, self.lableButton1.top,110*BiLiWidth,24*BiLiWidth)];
    self.lableButton2.tag = 0;
    [self.lableButton2 addTarget:self action:@selector(lableButton2Click) forControlEvents:UIControlEventTouchUpInside];
    self.lableButton2.button_imageView.frame = CGRectMake(0, 6*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth);
    self.lableButton2.button_imageView.layer.cornerRadius = 6*BiLiWidth;
    self.lableButton2.button_imageView.layer.masksToBounds = YES;
    self.lableButton2.button_imageView.layer.borderWidth = 1;
    self.lableButton2.button_imageView.layer.borderColor = [RGBFormUIColor(0x999999) CGColor];
    self.lableButton2.button_imageView1.frame = CGRectMake(self.lableButton1.button_imageView.left+1.5*BiLiWidth, self.lableButton1.button_imageView.top+1.5*BiLiWidth, 9*BiLiWidth, 9*BiLiWidth);
    self.lableButton2.button_imageView1.layer.cornerRadius = 4.5*BiLiWidth;
    self.lableButton2.button_imageView1.layer.masksToBounds = YES;
    self.lableButton2.button_lable.frame = CGRectMake(17*BiLiWidth, 0, 90*BiLiWidth, 24*BiLiWidth);
    self.lableButton2.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.lableButton2.button_lable.textColor = RGBFormUIColor(0x999999);
    self.lableButton2.button_lable.text = renZhengStr2;
    [self.view addSubview:self.lableButton2];

    if (![NormalUse isValidString:renZhengStr2]) {
        
        self.lableButton2.hidden = YES;
        self.lableButton2.width = 0;
    }


    
    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, self.lableButton2.top+self.lableButton2.height+20*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
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
    
    
    UILabel * tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(20*BiLiWidth, tiJiaoButton.top+tiJiaoButton.height+15*BiLiWidth, WIDTH_PingMu-20*BiLiWidth*2, 50*BiLiWidth)];
    tipsLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    tipsLable.textColor = RGBFormUIColor(0x333333);
    tipsLable.numberOfLines = 3;
    tipsLable.userInteractionEnabled = YES;
    [self.view addSubview:tipsLable];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quRenZheng)];
    [tipsLable addGestureRecognizer:tap];

    
    NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc] initWithString:@"提示:认证的结果可在消息中查看，认证成功后发布的信息将带有“官方认证”标签，助力您快速开单，您在认证过程中遇到任何问题，可以联系在线客服>"];
    [str1 addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x0033FF) range:NSMakeRange(str1.length-5, 5)];
    tipsLable.attributedText = str1;

    
}
-(void)quRenZheng
{
    JinChanWebViewController * vc = [[JinChanWebViewController alloc] init];
    vc.forWhat = @"help";
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark--UIButtonClick

-(void)lableButton1Click
{
    if (self.lableButton1.tag==0) {
        
        self.lableButton1.tag = 1;
        self.lableButton1.button_imageView.layer.borderColor = [RGBFormUIColor(0xFF0876) CGColor];
        self.lableButton1.button_imageView1.backgroundColor = RGBFormUIColor(0xFF0876);
        self.lableButton1.button_lable.textColor = RGBFormUIColor(0x333333);
        
        
        if ([@"4" isEqualToString:self.renZhengType]) {
            
            self.renZhengType1 = @"5";
            needJinBiValue = needJinBiValue+self.peripheral_auth_coin.intValue;


        }
        else if ([@"5" isEqualToString:self.renZhengType])
        {
            self.renZhengType1 = @"4";
            needJinBiValue = needJinBiValue+self.goddess_auth_coin.intValue;

        }
        else
        {
            self.renZhengType1 = @"4";
            needJinBiValue = needJinBiValue+self.goddess_auth_coin.intValue;


        }

    }
    else
    {
        self.lableButton1.tag = 0;
        self.lableButton1.button_imageView.layer.borderColor = [RGBFormUIColor(0x999999) CGColor];
        self.lableButton1.button_imageView1.backgroundColor = [UIColor clearColor];
        self.lableButton1.button_lable.textColor = RGBFormUIColor(0x999999);
        
        
        self.renZhengType1 = @"";
        if ([@"4" isEqualToString:self.renZhengType]) {
            
            needJinBiValue = needJinBiValue-self.peripheral_auth_coin.intValue;


        }
        else if ([@"5" isEqualToString:self.renZhengType])
        {
            needJinBiValue = needJinBiValue-self.goddess_auth_coin.intValue;

        }
        else
        {
            needJinBiValue = needJinBiValue-self.goddess_auth_coin.intValue;


        }


    }
    NSString * jinBiStr = [NSString stringWithFormat:@"%d 金币",needJinBiValue];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:jinBiStr];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x999999) range:NSMakeRange(jinBiStr.length-2, 2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*BiLiWidth] range:NSMakeRange(jinBiStr.length-2, 2)];
    self.jinBiLable.attributedText = str;
    


}
-(void)lableButton2Click
{
    if (self.lableButton2.tag==0) {
        
        self.lableButton2.tag = 1;
        self.lableButton2.button_imageView.layer.borderColor = [RGBFormUIColor(0xFF0876) CGColor];
        self.lableButton2.button_imageView1.backgroundColor = RGBFormUIColor(0xFF0876);
        self.lableButton2.button_lable.textColor = RGBFormUIColor(0x333333);
        
        if ([@"4" isEqualToString:self.renZhengType]) {
            
            self.renZhengType2 = @"6";
            needJinBiValue = needJinBiValue+self.global_auth_coin.intValue;


        }
        else if ([@"5" isEqualToString:self.renZhengType])
        {
            self.renZhengType2 = @"6";
            needJinBiValue = needJinBiValue+self.global_auth_coin.intValue;

        }
        else
        {
            self.renZhengType2 = @"5";
            needJinBiValue = needJinBiValue+self.peripheral_auth_coin.intValue;

        }

    }
    else
    {
        self.lableButton2.tag = 0;
        self.lableButton2.button_imageView.layer.borderColor = [RGBFormUIColor(0x999999) CGColor];
        self.lableButton2.button_imageView1.backgroundColor = [UIColor clearColor];
        self.lableButton2.button_lable.textColor = RGBFormUIColor(0x999999);

        self.renZhengType2 = @"";
        if ([@"4" isEqualToString:self.renZhengType]) {
            
            needJinBiValue = needJinBiValue-self.global_auth_coin.intValue;


        }
        else if ([@"6" isEqualToString:self.renZhengType])
        {
            needJinBiValue = needJinBiValue-self.global_auth_coin.intValue;

        }
        else
        {
            needJinBiValue = needJinBiValue-self.peripheral_auth_coin.intValue;

        }


    }
    NSString * jinBiStr = [NSString stringWithFormat:@"%d 金币",needJinBiValue];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:jinBiStr];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x999999) range:NSMakeRange(jinBiStr.length-2, 2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*BiLiWidth] range:NSMakeRange(jinBiStr.length-2, 2)];
    self.jinBiLable.attributedText = str;

}
-(void)nextButtonClick
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:self.info];
    [dic setObject:self.renZhengType forKey:@"type"]; //1女神 2外围女 3全球空降
    NSMutableArray * other_typeArray = [NSMutableArray array];
    if ([NormalUse isValidString:self.renZhengType1]) {
        
        [other_typeArray addObject:self.renZhengType1];
    }
    if ([NormalUse isValidString:self.renZhengType2]) {
        
        [other_typeArray addObject:self.renZhengType2];
    }
    if ([NormalUse isValidArray:other_typeArray] && other_typeArray.count>0) {
        
        self.other_type = [other_typeArray objectAtIndex:0];
        for (int i=1; i<other_typeArray.count; i++) {
            
            self.other_type = [[self.other_type stringByAppendingString:@"|"] stringByAppendingString:[other_typeArray objectAtIndex:i]];
        }
        [dic setObject:self.other_type forKey:@"other_type"];

    }

    
    [self xianShiLoadingView:@"认证中..." view:self.view];
    
    [HTTPModel jiaoSeRenZhengNew:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [self yinCangLoadingView];
        
        if (status==1) {
            
//            NvShenRenZhengStep4VC * vc = [[NvShenRenZhengStep4VC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [NormalUse showToastView:@"认证成功" view:[NormalUse getCurrentVC].view];
        }
        else
        {
            if(status==11402)
            {
                self.zhiFuView = nil;
                self.payTypeList = [NSMutableArray array];
                for (NSDictionary * info in self.paySourceArray) {
                    
                    NSNumber * pay_type = [info objectForKey:@"pay_type"];
                    
                    NSNumber * max_valueNumber = [info objectForKey:@"max_value"];
                    NSNumber * min_valueNumber = [info objectForKey:@"min_value"];
                    NSString * unlock_npost_coin = [NSString stringWithFormat:@"%d",self->needJinBiValue];
                    
                    if (pay_type.intValue==3) {
                        
                        if(unlock_npost_coin.intValue>=min_valueNumber.intValue&&unlock_npost_coin.intValue<=max_valueNumber.intValue) {
                            
                            [self.payTypeList addObject:info];
                        }
                    }
                    else
                    {
                        if (unlock_npost_coin.intValue<=max_valueNumber.intValue) {
                            
                            [self.payTypeList addObject:info];
                        }
                    }
                }

                if ([NormalUse isValidArray:self.payTypeList]) {
                    
                    self.zhiFuView.hidden = NO;
                }
                else
                {
                    ChongZhiOrHuiYuanAlertView * view = [[ChongZhiOrHuiYuanAlertView alloc] initWithFrame:CGRectZero];
                    [view initData];
                    [self.view addSubview:view];

                }
            }
            else
            {
                [NormalUse showNewToastView:msg view:self.view];
            }
        }
        
    }];

}


@end
