//
//  JieSuoSuccessTipView.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/10/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "JieSuoSuccessTipView.h"

@implementation JieSuoSuccessTipView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu);
        
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-274*BiLiWidth)/2, 287*BiLiWidth, 274*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [self addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(quXiaoClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33.5*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"温馨提示";
        [kuangImageView addSubview:tipLable1];
        
        UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 80*BiLiWidth)];
        tipLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
        tipLable2.textColor = RGBFormUIColor(0x343434);
        tipLable2.numberOfLines = 4;
        tipLable2.text = @"恭喜您,已成功解锁联系方式,点击联系方式可在线与美女聊天哦~";
        [kuangImageView addSubview:tipLable2];
        
        
        UIButton * faTieButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-85.5*BiLiWidth-11.5*BiLiWidth-115*BiLiWidth)/2, tipLable2.top+tipLable2.height+25*BiLiWidth, 85.5*BiLiWidth, 40*BiLiWidth)];
        [faTieButton setTitle:@"取消" forState:UIControlStateNormal];
        faTieButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
        faTieButton.layer.cornerRadius = 20*BiLiWidth;
        [faTieButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        faTieButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [faTieButton addTarget:self action:@selector(quXiaoClick) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:faTieButton];
        
        UIButton * renZhengButton = [[UIButton alloc] initWithFrame:CGRectMake(faTieButton.left+faTieButton.width+11.5*BiLiWidth, faTieButton.top, 115*BiLiWidth, 40*BiLiWidth)];
        [renZhengButton addTarget:self action:@selector(lianXiClick) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:renZhengButton];
        
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = renZhengButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [renZhengButton.layer addSublayer:gradientLayer1];
        
        UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, renZhengButton.width, renZhengButton.height)];
        sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        sureLable.text = @"去联系";
        sureLable.textAlignment = NSTextAlignmentCenter;
        sureLable.textColor = [UIColor whiteColor];
        [renZhengButton addSubview:sureLable];
        
        
        
        
    }
    return self;
}
-(void)quXiaoClick
{
    [self removeFromSuperview];
}
-(void)lianXiClick
{
    [self removeFromSuperview];
    self.toConnect();
}


@end
