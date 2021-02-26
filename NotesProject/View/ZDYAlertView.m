//
//  ZDYAlertView.m
//  JianZhi
//
//  Created by tang bo on 2021/2/26.
//  Copyright © 2021 Meng. All rights reserved.
//

#import "ZDYAlertView.h"

@implementation ZDYAlertView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message1:(NSString *)message1 message2:(NSString *)message2 button1Title:(NSString *)button1Title button2Title:(NSString *)button2Title{
    
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu);
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-300*BiLiWidth)/2, 0, 300*BiLiWidth, 0)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 10*BiLiWidth;
        contentView.layer.masksToBounds = YES;
        [self addSubview:contentView];
        
//        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentView.width, 40*BiLiWidth)];
//        titleLable.font = [UIFont systemFontOfSize:18*BiLiWidth];
//        titleLable.textColor = RGBFormUIColor(0x333333);
//        titleLable.textAlignment = NSTextAlignmentCenter;
//        titleLable.text = @"温馨提示";
//        [contentView addSubview:titleLable];
//        if ([NormalUse isValidString:title]) {
//            
//            titleLable.text = title;
//        }
        UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentView.width, contentView.width*240/944)];
        topImageView.image = [UIImage imageNamed:@"ZDYAlertTop"];
        [contentView addSubview:topImageView];
        

        
        UILabel * messageLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15*BiLiWidth, topImageView.bottom+30*BiLiWidth, contentView.width-30*BiLiWidth, 0)];
        messageLable1.textAlignment = NSTextAlignmentCenter;
        messageLable1.textColor = RGBFormUIColor(0x666666);
        messageLable1.numberOfLines = 0;
        messageLable1.font = [UIFont systemFontOfSize:15*BiLiWidth];
        messageLable1.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:messageLable1];
        NSString * describle1 = message1;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle1];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle1 length])];
        messageLable1.attributedText = attributedString;
        [messageLable1  sizeToFit];
        messageLable1.left = (contentView.width-messageLable1.width)/2;

        float originY = messageLable1.bottom+30*BiLiWidth;
        
        if ([NormalUse isValidString:message2]) {
            
            UILabel * messageLable2 = [[UILabel alloc] initWithFrame:CGRectMake(15*BiLiWidth, messageLable1.bottom+20*BiLiWidth, contentView.width-30*BiLiWidth, 0)];
            messageLable2.textAlignment = NSTextAlignmentCenter;
            messageLable2.textColor = RGBFormUIColor(0x666666);
            messageLable2.numberOfLines = 0;
            messageLable2.font = [UIFont systemFontOfSize:15*BiLiWidth];
            messageLable2.textAlignment = NSTextAlignmentCenter;
            [contentView addSubview:messageLable2];
            NSString * describle1 = message2;
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle1];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:2];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle1 length])];
            messageLable2.attributedText = attributedString;
            [messageLable2  sizeToFit];
            
            messageLable2.left = (contentView.width-messageLable2.width)/2;

            originY = messageLable2.bottom+30*BiLiWidth;
        }

        if ([NormalUse isValidString:button2Title]) {
            
            UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake((contentView.width-115*2*BiLiWidth)/3, originY, 115*BiLiWidth, 40*BiLiWidth)];
            [button1 addTarget:self action:@selector(button1Touch) forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:button1];
            
            //渐变设置
            UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
            UIColor *colorTwo = RGBFormUIColor(0xFF0876);
            CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
            gradientLayer1.frame = button1.bounds;
            gradientLayer1.cornerRadius = 20*BiLiWidth;
            gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
            gradientLayer1.startPoint = CGPointMake(0, 0);
            gradientLayer1.endPoint = CGPointMake(0, 1);
            gradientLayer1.locations = @[@0,@1];
            [button1.layer addSublayer:gradientLayer1];
            
            UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button1.width, button1.height)];
            sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
            sureLable.text = button1Title;
            sureLable.textAlignment = NSTextAlignmentCenter;
            sureLable.textColor = [UIColor whiteColor];
            [button1 addSubview:sureLable];
            
            
            UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(button1.right+(contentView.width-115*2*BiLiWidth)/3, originY, 115*BiLiWidth, 40*BiLiWidth)];
            [button2 addTarget:self action:@selector(button2Touch) forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:button2];
            
            //渐变设置
//            UIColor *colorOne2 = RGBFormUIColor(0xFF6C6C);
//            UIColor *colorTwo2 = RGBFormUIColor(0xFF0876);
            CAGradientLayer * gradientLayer2 = [CAGradientLayer layer];
            gradientLayer2.frame = button2.bounds;
            gradientLayer2.cornerRadius = 20*BiLiWidth;
            gradientLayer2.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
            gradientLayer2.startPoint = CGPointMake(0, 0);
            gradientLayer2.endPoint = CGPointMake(0, 1);
            gradientLayer2.locations = @[@0,@1];
            [button2.layer addSublayer:gradientLayer2];
            
            UILabel * sureLable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button1.width, button1.height)];
            sureLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
            sureLable2.text = button2Title;
            sureLable2.textAlignment = NSTextAlignmentCenter;
            sureLable2.textColor = [UIColor whiteColor];
            [button2 addSubview:sureLable2];


        }
        else
        {
            UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake((contentView.width-115*BiLiWidth)/2, originY, 115*BiLiWidth, 40*BiLiWidth)];
            [button1 addTarget:self action:@selector(button1Touch) forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:button1];
            
            //渐变设置
            UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
            UIColor *colorTwo = RGBFormUIColor(0xFF0876);
            CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
            gradientLayer1.frame = button1.bounds;
            gradientLayer1.cornerRadius = 20*BiLiWidth;
            gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
            gradientLayer1.startPoint = CGPointMake(0, 0);
            gradientLayer1.endPoint = CGPointMake(0, 1);
            gradientLayer1.locations = @[@0,@1];
            [button1.layer addSublayer:gradientLayer1];
            
            UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button1.width, button1.height)];
            sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
            sureLable.text = button1Title;
            sureLable.textAlignment = NSTextAlignmentCenter;
            sureLable.textColor = [UIColor whiteColor];
            [button1 addSubview:sureLable];

        }
        
        contentView.height = originY+60*BiLiWidth;
        contentView.top = (HEIGHT_PingMu-contentView.height)/2;
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(contentView.right-33*BiLiWidth/2, contentView.top-33*BiLiWidth/2, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(quXiaoClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];

        
    }
    return self;
}
-(void)quXiaoClick
{
    [self removeFromSuperview];
}
-(void)button1Touch
{
    self.button1Click();
    [self removeFromSuperview];
}
-(void)button2Touch
{
    self.button2Click();
    [self removeFromSuperview];
}


@end
