//
//  ZhangHuDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "ZhangHuDetailViewController.h"
#import "ChongZhiMingXiViewController.h"
#import "JinBiMingXiViewController.h"
#import "TiXianViewController.h"

@interface ZhangHuDetailViewController ()
{
    int payTypeIndex;
}

@property(nonatomic,strong)UILabel * yuELable;

@property(nonatomic,strong)UIScrollView * contentScrollView;

@property(nonatomic,strong)UIButton * zaiXianZhiFuButton;
@property(nonatomic,strong)UIButton * daiLiZhiFuButton;
@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)NSMutableArray * buttonArray;
@property(nonatomic,strong)UIButton * jinBiButtonBottom;

@property(nonatomic,strong)NSArray * products;

@property(nonatomic,strong)NSArray * payTypeList;
@property(nonatomic,strong)NSMutableArray * payTypeButtonArray;

@property(nonatomic,strong)NSString * orderId;


@end

@implementation ZhangHuDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [HTTPModel getUserInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * base_coinNumber = [responseObject objectForKey:@"coin"];
            NSString * base_coinStr = [NSString stringWithFormat:@"%d",base_coinNumber.intValue];
            self.yuELable.text = base_coinStr;
            self.yuEStr = base_coinStr;
        }
    }];

    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yanZhengOrder) name:@"YanZhengDingDanNotification" object:nil];
    
    UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 155.5*BiLiWidth+TopHeight_PingMu)];
    topImageView.image = [UIImage imageNamed:@"zhangHu_topBG"];
    [self.view addSubview:topImageView];
    
    self.topTitleLale.text = @"充值";
    self.topTitleLale.textColor = [UIColor whiteColor];
    self.backImageView.frame = CGRectMake(self.backImageView.left, (self.topNavView.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.backImageView.image = [UIImage imageNamed:@"white_back"];
    [self.rightButton setTitle:@"充值明细" forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.rightButton.width = 55*BiLiWidth;
    self.rightButton.left = WIDTH_PingMu-55*BiLiWidth-18*BiLiWidth;
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.topNavView.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:self.topNavView];
    
    self.yuELable = [[UILabel alloc] initWithFrame:CGRectMake(0, topImageView.height-67.5*BiLiWidth-28*BiLiWidth, WIDTH_PingMu, 28*BiLiWidth)];
    self.yuELable.font = [UIFont systemFontOfSize:28*BiLiWidth];
    self.yuELable.textColor = [UIColor whiteColor];
    self.yuELable.textAlignment = NSTextAlignmentCenter;
    [topImageView addSubview:self.yuELable];
    
    Lable_ImageButton * button = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-68*BiLiWidth)/2, self.yuELable.top+self.yuELable.height+10*BiLiWidth, 75*BiLiWidth, 17*BiLiWidth)];
    button.button_imageView.frame = CGRectMake(0, 0, 19*BiLiWidth, 17*BiLiWidth);
    button.button_imageView.image = [UIImage imageNamed:@"zhangHu_qianBao"];
    button.button_lable.frame = CGRectMake(21.5*BiLiWidth, 0, 55*BiLiWidth, 17*BiLiWidth);
    button.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    button.button_lable.textColor = [UIColor whiteColor];
    button.button_lable.text = @"剩余金币";
    [topImageView addSubview:button];
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topImageView.top+topImageView.height+23*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(topImageView.top+topImageView.height+23*BiLiWidth))];
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.contentScrollView];
    
    UIButton * tiXianButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-137*BiLiWidth*2-51*BiLiWidth)/2, 0, 137*BiLiWidth, 40*BiLiWidth)];
    [tiXianButton setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
    [tiXianButton setTitle:@"金币提现" forState:UIControlStateNormal];
    tiXianButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
    [tiXianButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    tiXianButton.layer.cornerRadius = 20*BiLiWidth;
    [tiXianButton addTarget:self action:@selector(tiXianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollView addSubview:tiXianButton];
    
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = tiXianButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [tiXianButton.layer addSublayer:gradientLayer1];
    
    UILabel * tiXianLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tiXianButton.width, tiXianButton.height)];
    tiXianLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiXianLable.text = @"金币提现";
    tiXianLable.textAlignment = NSTextAlignmentCenter;
    tiXianLable.textColor = [UIColor whiteColor];
    [tiXianButton addSubview:tiXianLable];


    
    UIButton * mingXiButton = [[UIButton alloc] initWithFrame:CGRectMake(tiXianButton.top+tiXianButton.width+51*BiLiWidth, 0, 137*BiLiWidth, 40*BiLiWidth)];
    [mingXiButton setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
    [mingXiButton setTitle:@"金币明细" forState:UIControlStateNormal];
    mingXiButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
    [mingXiButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    mingXiButton.layer.cornerRadius = 20*BiLiWidth;
    [mingXiButton addTarget:self action:@selector(mingXiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollView addSubview:mingXiButton];
    
    CAGradientLayer * gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = mingXiButton.bounds;
    gradientLayer2.cornerRadius = 20*BiLiWidth;
    gradientLayer2.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer2.startPoint = CGPointMake(0, 0);
    gradientLayer2.endPoint = CGPointMake(0, 1);
    gradientLayer2.locations = @[@0,@1];
    [mingXiButton.layer addSublayer:gradientLayer2];
    
    UILabel * mingXiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mingXiButton.width, mingXiButton.height)];
    mingXiLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    mingXiLable.text = @"金币明细";
    mingXiLable.textAlignment = NSTextAlignmentCenter;
    mingXiLable.textColor = [UIColor whiteColor];
    [mingXiButton addSubview:mingXiLable];


    
    CGSize size =  [NormalUse setSize:@"官方消息" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
    
    self.zaiXianZhiFuButton = [[UIButton alloc] initWithFrame:CGRectMake(17*BiLiWidth, tiXianButton.height+tiXianButton.top+35*BiLiWidth, size.width, 17*BiLiWidth)];
    [self.zaiXianZhiFuButton setTitle:@"在线支付" forState:UIControlStateNormal];
    [self.zaiXianZhiFuButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.zaiXianZhiFuButton.tag = 0;
    self.zaiXianZhiFuButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.zaiXianZhiFuButton addTarget:self action:@selector(zhiFuMethodClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.zaiXianZhiFuButton.titleLabel sizeToFit];
    [self.contentScrollView addSubview:self.zaiXianZhiFuButton];
    
    
    self.daiLiZhiFuButton = [[UIButton alloc] initWithFrame:CGRectMake(self.zaiXianZhiFuButton.left+self.zaiXianZhiFuButton.width+25*BiLiWidth, tiXianButton.height+tiXianButton.top+35*BiLiWidth, size.width, 17*BiLiWidth)];
    [self.daiLiZhiFuButton setTitle:@"代理支付" forState:UIControlStateNormal];
    [self.daiLiZhiFuButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.daiLiZhiFuButton.tag = 1;
    self.daiLiZhiFuButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.daiLiZhiFuButton addTarget:self action:@selector(zhiFuMethodClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.daiLiZhiFuButton.titleLabel sizeToFit];
    [self.contentScrollView addSubview:self.daiLiZhiFuButton];
    
    [self.zaiXianZhiFuButton sendActionsForControlEvents:UIControlEventTouchUpInside];

    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake((self.zaiXianZhiFuButton.width-53*BiLiWidth)/2+self.zaiXianZhiFuButton.left,self.zaiXianZhiFuButton.top+15*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
    self.sliderView.layer.cornerRadius = 7*BiLiWidth/2;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.alpha = 0.8;
    [self.contentScrollView addSubview:self.sliderView];
    //渐变设置
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.sliderView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    [self.sliderView.layer addSublayer:gradientLayer];
    
    self.buttonArray = [NSMutableArray array];
    

    [HTTPModel getZFJinBiList:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            self.products = [responseObject objectForKey:@"products"];
//            self.payTypeList = [responseObject objectForKey:@"pay_type"];
            [self initChongZhiItemView];
        }
        else
        {
            //[NormalUse showToastView:msg view:self.view];
            [NormalUse showToastView:@"支付通道维护中 请稍后充值" view:self.view];
        }
    }];
    
    [HTTPModel getCommonPayType:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.payTypeList = responseObject;//[responseObject objectForKey:@"pay_type"];
            if(![NormalUse isValidArray:self.payTypeList])
            {
                [NormalUse showToastView:@"支付通道维护中 请稍后充值" view:self.view];
            }
        }
        else
        {
            [NormalUse showToastView:@"支付通道维护中 请稍后充值" view:self.view];
        }

    }];
    
}
-(void)initChongZhiItemView
{
    float originX = (WIDTH_PingMu-100*BiLiWidth*3-20*BiLiWidth)/2;
    float originY = 0;

    for (int i=0; i<self.products.count; i++) {
        
        NSDictionary * info = [self.products objectAtIndex:i];
        if (i==0) {
            
            self.jinBiButtonBottom = [[UIButton alloc] initWithFrame:CGRectMake(originX+110*BiLiWidth*(i%3), self.zaiXianZhiFuButton.top+self.zaiXianZhiFuButton.height+25*BiLiWidth+64*BiLiWidth*(i/3), 100*BiLiWidth, 54*BiLiWidth)];
            self.jinBiButtonBottom.tag = 0;
            //渐变设置
            UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
            UIColor *colorTwo = RGBFormUIColor(0xFF0876);
            CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
            gradientLayer1.frame = self.jinBiButtonBottom.bounds;
            gradientLayer1.cornerRadius = 4*BiLiWidth;
            gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
            gradientLayer1.startPoint = CGPointMake(0, 0);
            gradientLayer1.endPoint = CGPointMake(0, 1);
            gradientLayer1.locations = @[@0,@1];
            [self.jinBiButtonBottom.layer addSublayer:gradientLayer1];
            [self.contentScrollView addSubview:self.jinBiButtonBottom];
            
            self.jinBiButtonBottom.hidden = YES;
        }
        
        Lable_ImageButton * button = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(originX+110*BiLiWidth*(i%3), self.zaiXianZhiFuButton.top+self.zaiXianZhiFuButton.height+25*BiLiWidth+64*BiLiWidth*(i/3), 100*BiLiWidth, 54*BiLiWidth)];
        button.tag = i;
        button.backgroundColor = [UIColor clearColor];
        button.layer.cornerRadius = 4*BiLiWidth;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [RGBFormUIColor(0xDEDEDE) CGColor];
        [button addTarget:self action:@selector(jinEItemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.button_lable.frame = CGRectMake(0, 11*BiLiWidth, button.width, 15*BiLiWidth);
        button.button_lable.textAlignment = NSTextAlignmentCenter;
        button.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        button.button_lable.textColor = RGBFormUIColor(0x343434);
        button.button_lable1.frame = CGRectMake(0, 32.5*BiLiWidth, button.width, 13*BiLiWidth);
        button.button_lable1.textAlignment = NSTextAlignmentCenter;
        button.button_lable1.font = [UIFont systemFontOfSize:13*BiLiWidth];
        button.button_lable1.textColor = RGBFormUIColor(0xFF2474);
        [self.contentScrollView addSubview:button];
        [self.buttonArray addObject:button];
        
        if (i==0) {
         
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
        NSNumber * cny = [info objectForKey:@"cny"];
        NSNumber * coin = [info objectForKey:@"coin"];
        button.button_lable.text = [NSString stringWithFormat:@"%d金币",coin.intValue];
        button.button_lable1.text = [NSString stringWithFormat:@"¥%d",cny.intValue];
        
        originY = button.top+button.height+20*BiLiWidth;
        
    }
    payTypeIndex = 0;
    self.payTypeButtonArray = [NSMutableArray array];
    for(int i=0;i<self.payTypeList.count;i++)
    {
        NSDictionary * info = [self.payTypeList objectAtIndex:i];
        NSString * pay_channel = [info objectForKey:@"pay_channel"];
        
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
        [self.contentScrollView addSubview:button];
        
        if (i==0) {
            
            [button.button_imageView1 setImage:[UIImage imageNamed:@"zhangHu_select"]];
            button.button_imageView1.layer.borderWidth = 0;

        }
        if ([@"微信支付" isEqualToString:[info objectForKey:@"pay_name"]]) {
            
            button.button_imageView.image = [UIImage imageNamed:@"zhangHu_Wx"];
            button.button_lable.text = [info objectForKey:@"pay_name"];
        }else
        {
            button.button_imageView.image = [UIImage imageNamed:@"zhangHu_zfb"];
            button.button_lable.text = [info objectForKey:@"pay_name"];

        }
        
        [self.payTypeButtonArray addObject:button];
        originY = originY+40*BiLiWidth;
    }
    
    UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, originY+35*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [chongZhiButton addTarget:self action:@selector(chongZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollView addSubview:chongZhiButton];
    
    [self.contentScrollView setContentSize:CGSizeMake(WIDTH_PingMu, chongZhiButton.top+chongZhiButton.height+40*BiLiWidth)];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = chongZhiButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [chongZhiButton.layer addSublayer:gradientLayer1];
    
    UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, chongZhiButton.width, chongZhiButton.height)];
    tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiJiaoLable.text = @"立即支付";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [chongZhiButton addSubview:tiJiaoLable];


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
#pragma mark--UIButtonClick
-(void)rightClick
{
    ChongZhiMingXiViewController * vc = [[ChongZhiMingXiViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)tiXianButtonClick
{
    TiXianViewController * vc = [[TiXianViewController alloc] init];
    vc.yuEStr = self.yuEStr;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)mingXiButtonClick
{
    JinBiMingXiViewController * vc = [[JinBiMingXiViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)zhiFuMethodClick:(UIButton *)button
{

    if (button.tag==0) {

        [self.daiLiZhiFuButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        
        [button setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{

        button.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.daiLiZhiFuButton.transform = CGAffineTransformMakeScale(1.3, 1.3);

            self.sliderView.left = button.left+(button.width-self.sliderView.width)/2;

        }];

    }
    else if (button.tag==1)
    {
//        self.zaiXianZhiFuButton.transform = CGAffineTransformIdentity;
//        [self.zaiXianZhiFuButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        JinChanWebViewController * vc = [[JinChanWebViewController alloc] init];
        vc.forWhat = @"mall";
        [self.navigationController pushViewController:vc animated:YES];

    }
}

-(void)jinEItemButtonClick:(Lable_ImageButton *)selectButton
{
    NSLog(@"%d",selectButton.tag);
    for (Lable_ImageButton * button in self.buttonArray) {
        
        self.jinBiButtonBottom.hidden = NO;
        self.jinBiButtonBottom.frame = selectButton.frame;
        self.jinBiButtonBottom.tag = selectButton.tag;
        if (button.tag == selectButton.tag) {
            
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            button.button_lable.textColor = [UIColor whiteColor];
            button.button_lable1.textColor = [UIColor whiteColor];
            

        }
        else
        {
            button.button_lable.textColor = RGBFormUIColor(0x343434);
            button.button_lable1.textColor = RGBFormUIColor(0xFF2474);
            button.layer.borderColor = [RGBFormUIColor(0xDEDEDE) CGColor];

        }
    }
}


-(void)chongZhiButtonClick
{
    [self xianShiLoadingView:@"下单中..." view:self.view];
    [HTTPModel getZFOrderId:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        [self yinCangLoadingView];

        if (status==1) {
            
            self.orderId = responseObject;
            NSDictionary * payTypeInfo = [self.payTypeList objectAtIndex:self->payTypeIndex];
            NSDictionary * info = [self.products objectAtIndex:self.jinBiButtonBottom.tag];
            NSNumber * coin = [info objectForKey:@"coin"];
            NSString *url;
            
            url   =  [NSString stringWithFormat:@"%@/%@",HTTP_REQUESTURL,[payTypeInfo objectForKey:@"pay_url"]];
            url = [url stringByAppendingString:[NSString stringWithFormat:@"?amount=%@&orderId=%@&logintoken=%@&pay_channel=%@@&pay_code=%@",[NSString stringWithFormat:@"%d",coin.intValue],self.orderId,[NormalUse defaultsGetObjectKey:LoginToken],[payTypeInfo objectForKey:@"pay_channel"],[payTypeInfo objectForKey:@"pay_code"]]];

//            if ([@"1" isEqualToString:[payTypeInfo objectForKey:@"pay_channel"]]) {
//
//             url   =  [NSString stringWithFormat:@"%@/appi/mlpay/ddyOrdering",HTTP_REQUESTURL];
//                           url = [url stringByAppendingString:[NSString stringWithFormat:@"?amount=%@&orderId=%@&logintoken=%@&pay_channel=%@&pay_code=%@",[NSString stringWithFormat:@"%d",coin.intValue],self.orderId,[NormalUse defaultsGetObjectKey:LoginToken],[payTypeInfo objectForKey:@"pay_channel"],[payTypeInfo objectForKey:@"pay_code"]]];
//            }
//            else
//            {
//                url   =  [NSString stringWithFormat:@"%@/appi/mlpay/dd2Ordering",HTTP_REQUESTURL];
//                url = [url stringByAppendingString:[NSString stringWithFormat:@"?amount=%@&orderId=%@&logintoken=%@&pay_channel=%@@&pay_code=%@",[NSString stringWithFormat:@"%d",coin.intValue],self.orderId,[NormalUse defaultsGetObjectKey:LoginToken],[payTypeInfo objectForKey:@"pay_channel"],[payTypeInfo objectForKey:@"pay_code"]]];
//            }
           
            
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
                [NormalUse showToastView:@"订单支付成功" view:self.view];

            }
            else
            {
                [NormalUse showToastView:@"订单支付失败" view:self.view];

            }
        }
    }];
    
    [HTTPModel getUserInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * base_coinNumber = [responseObject objectForKey:@"coin"];
            NSString * base_coinStr = [NSString stringWithFormat:@"%d",base_coinNumber.intValue];
            self.yuELable.text = base_coinStr;

        }
    }];

}
@end
