//
//  HomeNvShenShaiXuanView.m
//  JianZhi
//
//  Created by tang bo on 2021/1/22.
//  Copyright © 2021 Meng. All rights reserved.
//

#import "HomeNvShenShaiXuanView.h"

@implementation HomeNvShenShaiXuanView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
        self.frame = CGRectMake(0, HEIGHT_PingMu, WIDTH_PingMu, HEIGHT_PingMu);
        [self initContentView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
        [self addGestureRecognizer:tap];

    }
    return self;
}
-(void)viewTap
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.top = HEIGHT_PingMu;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];

    }];
}

-(void)initContentView
{
    
    UIView * whiteContentView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu-100*BiLiWidth, WIDTH_PingMu, 100*BiLiWidth)];
    whiteContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteContentView];
    whiteContentView.layer.shadowOpacity = 0.2f;
    whiteContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    whiteContentView.layer.shadowOffset = CGSizeMake(0, 3);//CGSizeZero; //设置偏移量为0,四周都有阴影
    //某个角圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:whiteContentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8*BiLiWidth, 8*BiLiWidth)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = whiteContentView.bounds;
    maskLayer.path = maskPath.CGPath;
    whiteContentView.layer.mask = maskLayer;

    
    self.paiXuSourceArray = [[NSArray alloc] initWithObjects:@"最新",@"最热",nil];//[[NSArray alloc] initWithObjects:@"最新",@"最热",@"评分从高到低",@"评分从低到高",@"价格从高到低",@"价格从低到高", nil];
    
    self.paiButtonXuArray = [NSMutableArray array];
    for (int i=0; i<self.paiXuSourceArray.count; i++) {
        
        NSString * leiXingStr = [self.paiXuSourceArray objectAtIndex:i];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(10*BiLiWidth, 50*BiLiWidth*i,self.width-10*BiLiWidth ,50*BiLiWidth)];
        [button setTitle:leiXingStr forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        button.tag=i;
        [button addTarget:self action:@selector(paiXuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [whiteContentView addSubview:button];
        
        [self.paiButtonXuArray addObject:button];
                
    }

}
-(void)paiXuButtonClick:(UIButton *)selectButton
{
  //  'field'默认,'hot_value'热度,'complex_score'评分,'min_price'低价,'max_price'高价
 //desc或者 asc(从低到高)  排序字段 'id'最新 'hot_value'热度 'complex_score'评分
    NSString * str = [self.paiXuSourceArray objectAtIndex:selectButton.tag];
    if ([@"最新" isEqualToString:str]) {
        
        self.field = @"";

    }
    else if ([@"最热" isEqualToString:str])
    {
        self.field = @"hot_value";
    }
    self.paiXuSelect(self.field);
    [self viewTap];
}

@end
