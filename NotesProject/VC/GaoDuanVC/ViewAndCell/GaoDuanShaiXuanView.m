//
//  GaoDuanShaiXuanView.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GaoDuanShaiXuanView.h"

@implementation GaoDuanShaiXuanView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.frame = CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu);
        [self initContentView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
        [self addGestureRecognizer:tap];

    }
    return self;
}
-(void)viewTap
{
    self.hidden = YES;
}
-(void)initContentView
{
    
    UIView * whiteContentView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu-240*BiLiWidth, WIDTH_PingMu, 240*BiLiWidth)];
    whiteContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteContentView];
    
    self.paiXuSourceArray = [[NSArray alloc] initWithObjects:@"最新",@"最热",@"评分从高到低",@"评分从低到高",@"价格从高到低",@"价格分从低到高", nil];
    
    self.paiButtonXuArray = [NSMutableArray array];
    for (int i=0; i<self.paiXuSourceArray.count; i++) {
        
        NSString * leiXingStr = [self.paiXuSourceArray objectAtIndex:i];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(10*BiLiWidth, 40*BiLiWidth*i,self.width-10*BiLiWidth ,40*BiLiWidth)];
        [button setTitle:leiXingStr forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        button.tag=i;
        [button addTarget:self action:@selector(paiXuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [whiteContentView addSubview:button];
        
        [self.paiButtonXuArray addObject:button];
                
    }

}
-(void)paiXuButtonClick:(UIButton *)selectButton
{
  //  'field'默认,'hot_value'热度,'complex_score'评分,'min_price'低价,'max_price'高价
//desc或者 asc(从低到高)
    NSString * str = [self.paiXuSourceArray objectAtIndex:selectButton.tag];
    if ([@"最新" isEqualToString:str]) {
        
        self.field = @"";
        self.order = @"";

    }
    else if ([@"最热" isEqualToString:str])
    {
        self.field = @"hot_value";
        self.order = @"";
    }
    else if ([@"评分从高到低" isEqualToString:str])
    {
        self.field = @"complex_score";
        self.order = @"desc";

    }
    else if ([@"评分从低到高" isEqualToString:str])
    {
        self.field = @"complex_score";
        self.order = @"asc";

    }
    else if ([@"价格从高到低" isEqualToString:str])
    {
        self.field = @"max_price";
        self.order = @"desc";

    }
    else if ([@"价格分从低到高" isEqualToString:str])
    {
        self.field = @"min_price";
        self.order = @"asc";

    }
    self.paiXuSelect(self.field, self.order);
    
    self.hidden = YES;
}
@end