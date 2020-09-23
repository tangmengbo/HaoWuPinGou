//
//  GuanFangXiaoXiDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GuanFangXiaoXiDetailViewController.h"

@interface GuanFangXiaoXiDetailViewController ()

@end

@implementation GuanFangXiaoXiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topTitleLale.text = @"官方消息";
    
    [NormalUse xianShiGifLoadingView:self];
    [HTTPModel getGuanFangMessageDetail:[[NSDictionary alloc]initWithObjectsAndKeys:self.idStr,@"id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse quXiaoGifLoadingView:self];
        
        if (status==1) {
            
            [self initContentView:responseObject];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
}
-(void)initContentView:(NSDictionary *)info
{
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BiLiWidth, self.topNavView.top+self.topNavView.height+30*BiLiWidth, WIDTH_PingMu-50*BiLiWidth, 15*BiLiWidth)];
    titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    titleLable.textColor = RGBFormUIColor(0x343434);
    titleLable.text = [info objectForKey:@"title"];
    [self.view addSubview:titleLable];
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BiLiWidth, titleLable.top+titleLable.height+9.5*BiLiWidth, WIDTH_PingMu-50*BiLiWidth, 15*BiLiWidth)];
    timeLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    timeLable.textColor = RGBFormUIColor(0x343434);
    timeLable.text = [info objectForKey:@"create_at"];
    [self.view addSubview:timeLable];
    
    UITextView * contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(titleLable.left, timeLable.top+timeLable.height+20*BiLiWidth, titleLable.width, HEIGHT_PingMu-(timeLable.top+timeLable.height+20*BiLiWidth))];
    contentTextView.font = [UIFont systemFontOfSize:13*BiLiWidth];
    contentTextView.textColor = RGBFormUIColor(0x343434);
    [self.view addSubview:contentTextView];
    
    NSString * content = [info objectForKey:@"content"];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    contentTextView.attributedText = attrStr;
    [contentTextView sizeToFit];


    
}

@end
