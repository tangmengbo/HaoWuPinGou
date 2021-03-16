//
//  JingJiRenRenZhengStep2VC.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "JingJiRenRenZhengStep2VC.h"

@interface JingJiRenRenZhengStep2VC ()
{
    int payTypeIndex;

}

@property(nonatomic,strong)NSMutableArray * payTypeList;
@property(nonatomic,strong)UIView * zhiFuView;
@property(nonatomic,strong)NSMutableArray * payTypeButtonArray;
@property(nonatomic,strong)NSString * orderId;

@end

@implementation JingJiRenRenZhengStep2VC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topTitleLale.text = @"认证";
    self.loadingFullScreen = @"yes";
    [self initTopStepView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yanZhengOrder) name:@"YanZhengDingDanNotification" object:nil];

    
    payTypeIndex = -1;
    [NormalUse showMessageLoadView:@"Loading..." vc:self];
    [HTTPModel getCommonPayType:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        [NormalUse removeMessageLoadingView:self];
        if (status==1) {
            
            NSArray * array = responseObject;
            
            self.payTypeList = [NSMutableArray array];
            for (NSDictionary * info in array) {
                
                NSNumber * pay_type = [info objectForKey:@"pay_type"];
                
                NSNumber * max_valueNumber = [info objectForKey:@"max_value"];
                NSNumber * min_valueNumber = [info objectForKey:@"min_value"];
                NSString * unlock_npost_coin = self.jinBiStr;
                
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
            
            if(![NormalUse isValidArray:self.payTypeList])
            {
                // [NormalUse showToastView:@"支付通道维护中 请稍后充值" view:self.view];
            }
            else
            {
                self.zhiFuView.hidden = YES;
            }
            
        }
        else
        {
            //[NormalUse showToastView:@"支付通道维护中 请稍后充值" view:self.view];
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
                NSString * coin = [NormalUse getJinBiStr:@"unlock_npost_coin"];
                NSString *url;
                //type_id type_id(预约类型1真实会员贴  2仨角色贴 3普通茶贴)
                url   =  [NSString stringWithFormat:@"%@/%@",HTTP_REQUESTURL,[payTypeInfo objectForKey:@"interview_url"]];
//                url = [url stringByAppendingString:[NSString stringWithFormat:@"?amount=%@&orderId=%@&logintoken=%@&pay_channel=%@@&pay_code=%@&type_id=%@&related_id=%@",[NSString stringWithFormat:@"%d",coin.intValue],self.orderId,[NormalUse defaultsGetObjectKey:LoginToken],[payTypeInfo objectForKey:@"pay_channel"],[payTypeInfo objectForKey:@"pay_code"],@"3",self.post_id]];
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
    /*
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
    
    
    UIButton * step1BottomView = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-22*BiLiWidth)/2, step1Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
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

    
    UILabel * step2Lable = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH_PingMu-22*BiLiWidth)/2, step1Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step2Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step2Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step2Lable.textAlignment = NSTextAlignmentCenter;
    step2Lable.layer.cornerRadius = 11*BiLiWidth;
    step2Lable.layer.masksToBounds = YES;
    step2Lable.text = @"2";
    [self.view addSubview:step2Lable];
    
    UILabel * step2TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step2Lable.left-30*BiLiWidth,step2Lable.top+step2Lable.height+8.5*BiLiWidth , step2Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step2TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step2TipLable.textColor = RGBFormUIColor(0x343434);
    step2TipLable.text = @"认证费";
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
    tipImageView.image = [UIImage imageNamed:@"jiaoLaYaJin_jingJiRen"];
    [self.view addSubview:tipImageView];
    
    self.jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, 160*BiLiWidth, 150*BiLiWidth, 24*BiLiWidth)];
    self.jinBiLable.font = [UIFont systemFontOfSize:24*BiLiWidth];
    self.jinBiLable.textColor = RGBFormUIColor(0x333333);
    [tipImageView addSubview:self.jinBiLable];
    
    NSString * type = [self.info objectForKey:@"type"];
    NSString * jinBiStr;
    if ([@"1" isEqualToString:type]) {
        
        self.jinBiStr = [NormalUse getJinBiStr:@"normal_auth_coin"];
        jinBiStr = [NSString stringWithFormat:@"%@ 金币",[NormalUse getJinBiStr:@"normal_auth_coin"]];
    }
    else if([@"2" isEqualToString:type])
    {
        self.jinBiStr = [NormalUse getJinBiStr:@"agent_auth_coin"];
        jinBiStr = [NSString stringWithFormat:@"%@ 金币",[NormalUse getJinBiStr:@"agent_auth_coin"]];

    }
    else
    {
        self.jinBiStr = [NormalUse getJinBiStr:@"normal_vip_coin"];
        jinBiStr = [NSString stringWithFormat:@"%@ 金币",[NormalUse getJinBiStr:@"normal_vip_coin"]];
    }
    
     
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:jinBiStr];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x999999) range:NSMakeRange(jinBiStr.length-2, 2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*BiLiWidth] range:NSMakeRange(jinBiStr.length-2, 2)];
    self.jinBiLable.attributedText = str;
    
    UILabel * renZhengTipLable = [[UILabel alloc] initWithFrame:CGRectMake(tipImageView.width-175*BiLiWidth, self.jinBiLable.top, 150*BiLiWidth, 24*BiLiWidth)];
    renZhengTipLable.textAlignment = NSTextAlignmentRight;
    renZhengTipLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    renZhengTipLable.text = @"申请认证所需费用";
    [tipImageView addSubview:renZhengTipLable];
    

    
    UILabel * yuELable = [[UILabel alloc] initWithFrame:CGRectMake(0, tipImageView.top+tipImageView.height+9*BiLiWidth, WIDTH_PingMu, 18*BiLiWidth)];
    yuELable.font = [UIFont systemFontOfSize:18*BiLiWidth];
    yuELable.textColor = RGBFormUIColor(0xFED062);
    yuELable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:yuELable];
    

    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, yuELable.top+yuELable.height+36*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
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

    
    
    [HTTPModel getUserInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            NSNumber * coin = [responseObject objectForKey:@"coin"];
            
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前可用金币：%d",coin.intValue]];
            [str1 addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x343434) range:NSMakeRange(0, 7)];
            [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*BiLiWidth] range:NSMakeRange(0, 7)];
            yuELable.attributedText = str1;

        }
    }];

    
}
-(void)quRenZheng
{
    JinChanWebViewController * vc = [[JinChanWebViewController alloc] init];
    vc.forWhat = @"help";
    [self.navigationController pushViewController:vc animated:YES];

}


-(void)nextButtonClick
{
    
    [self xianShiLoadingView:@"提交中..." view:self.view];
    NSString * type = [self.info objectForKey:@"type"];

    if([@"3" isEqualToString:type])
    {
        //会员认证
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:self.info];
        [dic removeObjectForKey:@"type"];
        [HTTPModel vipRenRenZheng:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
//                JingJiRenRenZhengStep3VC * vc = [[JingJiRenRenZhengStep3VC alloc] init];
//                [self.navigationController pushViewController:vc animated:YES];
                [self.navigationController popToRootViewControllerAnimated:YES];
                [NormalUse showToastView:@"认证成功" view:[NormalUse getCurrentVC].view];
            }
            else
            {
                [self yinCangLoadingView];
                if(status==11402)
                {
                    if([NormalUse isValidArray:self.payTypeList])
                    {
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
                    [NormalUse showToastView:msg view:self.view];

                }
            }
        }];
        
    }
    else
    {
        //经纪人 茶小二认证
        [HTTPModel jingJiRenRenZheng:self.info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                JingJiRenRenZhengStep3VC * vc = [[JingJiRenRenZhengStep3VC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];

            }
            else
            {
                [self yinCangLoadingView];
                if(status==11402)
                {
                    ChongZhiOrHuiYuanAlertView * view = [[ChongZhiOrHuiYuanAlertView alloc] initWithFrame:CGRectZero];
                    [view initData];
                    [self.view addSubview:view];

                }
                else
                {
                    [NormalUse showToastView:msg view:self.view];

                }
            }
        }];

    }
}

@end
