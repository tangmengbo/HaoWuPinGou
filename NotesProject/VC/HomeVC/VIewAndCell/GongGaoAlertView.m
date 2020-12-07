//
//  GongGaoAlertView.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/10.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GongGaoAlertView.h"

@implementation GongGaoAlertView

- (instancetype)initWithFrame:(CGRect)frame messageInfo:(NSDictionary *)mesageInfo{
    
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu);
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UIImageView * contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-319*BiLiWidth)/2, (HEIGHT_PingMu-401*BiLiWidth+20*BiLiWidth-60*BiLiHeight)/2, 319*BiLiWidth, 401*BiLiWidth-20*BiLiWidth+60*BiLiHeight)];
        contentImageView.image = [UIImage imageNamed:@"home_gongGao"];
        contentImageView.userInteractionEnabled = YES;
        [self addSubview:contentImageView];
        
        UIButton* closeButton = [[UIButton alloc] initWithFrame:CGRectMake(contentImageView.width-50*BiLiWidth, 20*BiLiWidth, 40*BiLiWidth, 50*BiLiWidth)];
        [closeButton setBackgroundColor:[UIColor clearColor]];
        [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [contentImageView addSubview:closeButton];
        
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 144.5*BiLiWidth, contentImageView.width, 17*BiLiWidth)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:17*BiLiWidth];
        titleLable.textColor = RGBFormUIColor(0x343434);
        titleLable.text = @"滴滴约公告：";
        [contentImageView addSubview:titleLable];
        
        UITextView * messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(50*BiLiWidth, titleLable.top+titleLable.height+15*BiLiWidth, contentImageView.width-100*BiLiWidth, 140*BiLiHeight+60*BiLiHeight)];
        messageTextView.textColor = RGBFormUIColor(0x343434);
        messageTextView.font = [UIFont systemFontOfSize:14*BiLiWidth];
        messageTextView.textAlignment = NSTextAlignmentCenter;
        messageTextView.editable = NO;
        [contentImageView addSubview:messageTextView];
        
        NSString * content = [mesageInfo objectForKey:@"message"];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        messageTextView.attributedText = attrStr;
//        [messageTextView sizeToFit];

        
//        UIButton * uploadButton = [[UIButton alloc] initWithFrame:CGRectMake((contentImageView.width-240*BiLiWidth)/2, contentImageView.height-89*BiLiWidth, 240*BiLiWidth, 40*BiLiWidth)];
//        [uploadButton addTarget:self action:@selector(uploadButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [contentImageView addSubview:uploadButton];
//        //渐变设置
//        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
//        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
//        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
//        gradientLayer1.frame = uploadButton.bounds;
//        gradientLayer1.cornerRadius = 20*BiLiWidth;
//        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
//        gradientLayer1.startPoint = CGPointMake(0, 0);
//        gradientLayer1.endPoint = CGPointMake(0, 1);
//        gradientLayer1.locations = @[@0,@1];
//        [uploadButton.layer addSublayer:gradientLayer1];
//
//        UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, uploadButton.width, uploadButton.height)];
//        tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
//        tiJiaoLable.text = @"马上更新";
//        tiJiaoLable.textAlignment = NSTextAlignmentCenter;
//        tiJiaoLable.textColor = [UIColor whiteColor];
//        [uploadButton addSubview:tiJiaoLable];

        
        

    }
    return self;
}
-(void)closeButtonClick
{
    self.closeView();
    [self removeFromSuperview];
}
-(void)uploadButtonClick
{
    self.toUpload();
}

@end
