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

@property(nonatomic,strong)UILabel * yuELable;

@property(nonatomic,strong)UIScrollView * contentScrollView;

@property(nonatomic,strong)UIButton * zaiXianZhiFuButton;
@property(nonatomic,strong)UIButton * daiLiZhiFuButton;
@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)NSMutableArray * buttonArray;
@property(nonatomic,strong)UIButton * jinBiButtonBottom;

@property(nonatomic,strong)Lable_ImageButton * zfbButton;
@property(nonatomic,strong)Lable_ImageButton * wxButton;

@end

@implementation ZhangHuDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [HTTPModel getHuoDongHomeInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * base_coinNumber = [responseObject objectForKey:@"base_coin"];
            NSString * base_coinStr = [NSString stringWithFormat:@"%d",base_coinNumber.intValue];
            self.yuELable.text = base_coinStr;

        }
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];

    
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
    
    UIButton * mingXiButton = [[UIButton alloc] initWithFrame:CGRectMake(tiXianButton.top+tiXianButton.width+51*BiLiWidth, 0, 137*BiLiWidth, 40*BiLiWidth)];
    [mingXiButton setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
    [mingXiButton setTitle:@"金币明细" forState:UIControlStateNormal];
    mingXiButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
    [mingXiButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    mingXiButton.layer.cornerRadius = 20*BiLiWidth;
    [mingXiButton addTarget:self action:@selector(mingXiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollView addSubview:mingXiButton];
    
    CGSize size =  [NormalUse setSize:@"官方消息" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
    
    self.zaiXianZhiFuButton = [[UIButton alloc] initWithFrame:CGRectMake(17*BiLiWidth, tiXianButton.height+tiXianButton.top+35*BiLiWidth, size.width, 17*BiLiWidth)];
    [self.zaiXianZhiFuButton setTitle:@"在线支付" forState:UIControlStateNormal];
    [self.zaiXianZhiFuButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.zaiXianZhiFuButton.tag = 0;
    self.zaiXianZhiFuButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.zaiXianZhiFuButton addTarget:self action:@selector(zhiFuMethodClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.zaiXianZhiFuButton.titleLabel sizeToFit];
    [self.contentScrollView addSubview:self.zaiXianZhiFuButton];
    
    [self.zaiXianZhiFuButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    self.daiLiZhiFuButton = [[UIButton alloc] initWithFrame:CGRectMake(self.zaiXianZhiFuButton.left+self.zaiXianZhiFuButton.width+17*BiLiWidth, tiXianButton.height+tiXianButton.top+35*BiLiWidth, size.width, 17*BiLiWidth)];
    [self.daiLiZhiFuButton setTitle:@"代理支付" forState:UIControlStateNormal];
    [self.daiLiZhiFuButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.daiLiZhiFuButton.tag = 1;
    self.daiLiZhiFuButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.daiLiZhiFuButton addTarget:self action:@selector(zhiFuMethodClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.daiLiZhiFuButton.titleLabel sizeToFit];
    [self.contentScrollView addSubview:self.daiLiZhiFuButton];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake((self.zaiXianZhiFuButton.width-53*BiLiWidth)/2+self.zaiXianZhiFuButton.left,self.zaiXianZhiFuButton.top+15*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
    self.sliderView.layer.cornerRadius = 7*BiLiWidth/2;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.alpha = 0.8;
    [self.contentScrollView addSubview:self.sliderView];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.sliderView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    [self.sliderView.layer addSublayer:gradientLayer];
    
    self.buttonArray = [NSMutableArray array];
    
    float originX = (WIDTH_PingMu-100*BiLiWidth*3-20*BiLiWidth)/2;
    float originY = 0;
    for (int i=0; i<6; i++) {
        
        if (i==0) {
            
            self.jinBiButtonBottom = [[UIButton alloc] initWithFrame:CGRectMake(originX+110*BiLiWidth*(i%3), self.zaiXianZhiFuButton.top+self.zaiXianZhiFuButton.height+25*BiLiWidth+64*BiLiWidth*(i/3), 100*BiLiWidth, 54*BiLiWidth)];
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
        
        button.button_lable.text = @"100金币";
        button.button_lable1.text = @"¥100";
        
        originY = button.top+button.height+20*BiLiWidth;
        
    }
    
    self.zfbButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, originY, WIDTH_PingMu, 21*BiLiWidth)];
    self.zfbButton.button_imageView.frame = CGRectMake(19*BiLiWidth, 0, 21*BiLiWidth, 21*BiLiWidth);
    [self.zfbButton addTarget:self action:@selector(zfbButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.zfbButton.button_imageView.image = [UIImage imageNamed:@"zhangHu_zfb"];
    self.zfbButton.button_lable.frame = CGRectMake(self.zfbButton.button_imageView.left+self.zfbButton.button_imageView.width+6.5*BiLiWidth, 0, 200*BiLiWidth, 21*BiLiWidth);
    self.zfbButton.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.zfbButton.button_lable.textColor = RGBFormUIColor(0x343434);
    self.zfbButton.button_lable.text = @"支付宝支付";
    self.zfbButton.button_imageView1.frame = CGRectMake(WIDTH_PingMu-14.5*BiLiWidth-28.5*BiLiWidth, (self.zfbButton.height-14.5*BiLiWidth)/2, 14.5*BiLiWidth, 14.5*BiLiWidth);
    self.zfbButton.button_imageView1.layer.cornerRadius = 15.4*BiLiWidth/2;
    self.zfbButton.button_imageView1.layer.masksToBounds = YES;
    self.zfbButton.button_imageView1.layer.borderColor = [RGBFormUIColor(0x343434) CGColor];
    self.zfbButton.button_imageView1.layer.borderWidth = 1;
    [self.contentScrollView addSubview:self.zfbButton];
    
    self.wxButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.zfbButton.top+self.zfbButton.height+23*BiLiWidth, WIDTH_PingMu, 21*BiLiWidth)];
    [self.wxButton addTarget:self action:@selector(wxButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.wxButton.button_imageView.frame = CGRectMake(19*BiLiWidth, 0, 21*BiLiWidth, 21*BiLiWidth);
    self.wxButton.button_imageView.image = [UIImage imageNamed:@"zhangHu_Wx"];
    self.wxButton.button_lable.frame = CGRectMake(self.wxButton.button_imageView.left+self.wxButton.button_imageView.width+6.5*BiLiWidth, 0, 200*BiLiWidth, 21*BiLiWidth);
    self.wxButton.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.wxButton.button_lable.textColor = RGBFormUIColor(0x343434);
    self.wxButton.button_lable.text = @"微信支付";
    self.wxButton.button_imageView1.frame = CGRectMake(WIDTH_PingMu-14.5*BiLiWidth-28.5*BiLiWidth, (self.zfbButton.height-14.5*BiLiWidth)/2, 14.5*BiLiWidth, 14.5*BiLiWidth);
    self.wxButton.button_imageView1.layer.cornerRadius = 15.4*BiLiWidth/2;
    self.wxButton.button_imageView1.layer.masksToBounds = YES;
    self.wxButton.button_imageView1.layer.borderWidth = 1;
    self.wxButton.button_imageView1.layer.borderColor = [RGBFormUIColor(0x343434) CGColor];
    [self.contentScrollView addSubview:self.wxButton];
    
    UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, self.wxButton.top+self.wxButton.height+35*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [chongZhiButton addTarget:self action:@selector(chongZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentScrollView addSubview:chongZhiButton];
    
    [self.contentScrollView setContentSize:CGSizeMake(WIDTH_PingMu, chongZhiButton.top+chongZhiButton.height+40*BiLiWidth)];
    //渐变设置
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
        
        self.daiLiZhiFuButton.transform = CGAffineTransformIdentity;
        [self.daiLiZhiFuButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        
    }
    else if (button.tag==1)
    {
        self.zaiXianZhiFuButton.transform = CGAffineTransformIdentity;
        [self.zaiXianZhiFuButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];

    }
    [button setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        
        button.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.sliderView.left = button.left+(button.width-self.sliderView.width)/2;
        
    }];
}

-(void)jinEItemButtonClick:(UIButton *)selectButton
{
    for (Lable_ImageButton * button in self.buttonArray) {
        
        self.jinBiButtonBottom.hidden = NO;
        self.jinBiButtonBottom.frame = selectButton.frame;
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
-(void)zfbButtonClick
{
    [self.zfbButton.button_imageView1 setImage:[UIImage imageNamed:@"zhangHu_select"]];
    self.zfbButton.button_imageView1.layer.borderWidth = 0;

    [self.wxButton.button_imageView1 setImage:nil];
    self.wxButton.button_imageView1.layer.borderWidth = 1;


}
-(void)wxButtonClick
{
    [self.zfbButton.button_imageView1 setImage:nil];
    self.zfbButton.button_imageView1.layer.borderWidth = 1;

    [self.wxButton.button_imageView1 setImage:[UIImage imageNamed:@"zhangHu_select"]];
    self.wxButton.button_imageView1.layer.borderWidth = 0;
}
-(void)chongZhiButtonClick
{
    
}
@end