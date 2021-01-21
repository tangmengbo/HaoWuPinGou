//
//  HomeShaiXuanView.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/22.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HomeShaiXuanView.h"

@implementation HomeShaiXuanView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, HEIGHT_PingMu, WIDTH_PingMu, HEIGHT_PingMu);
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
        [self addGestureRecognizer:tap];
        
        [HTTPModel getXinXiLeiXing:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self.leiXingSourceArray = [[NSMutableArray alloc] initWithArray:responseObject];
                [self.leiXingSourceArray insertObject:@"全部" atIndex:0];
                [self initContentView];
            }

        }];


    }
    return self;
}
-(void)viewTap
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.top = HEIGHT_PingMu;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];

        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)shaiXuanButtonClick
{
    self.paiXuSelect(self.field, self.order);
    
    if([@"全部" isEqualToString:self.message_type])
    {
        self.leiXingSelect(@"");

    }
    else
    {
        self.leiXingSelect(self.message_type);

    }

    [UIView animateWithDuration:0.5 animations:^{
        
        self.top = HEIGHT_PingMu;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];

        
    } completion:^(BOOL finished) {
        
    }];

}
-(void)initContentView
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 0)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];

    
    UILabel * titleLable1  = [[UILabel alloc] initWithFrame:CGRectMake(14.5*BiLiWidth, 19.5*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    titleLable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
    titleLable1.textColor = RGBFormUIColor(0x9A9A9A);
    titleLable1.text = @"排序";
    [contentView addSubview:titleLable1];
    
    UIButton * shaiXuanButton = [[UIButton alloc] initWithFrame:CGRectMake(contentView.width-60*BiLiHeight, titleLable1.top-10*BiLiHeight, 60*BiLiWidth, 34*BiLiWidth)];
    [shaiXuanButton setTitle:@"确定" forState:UIControlStateNormal];
    [shaiXuanButton setTitleColor:RGBFormUIColor(0xFF0876) forState:UIControlStateNormal];
    shaiXuanButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [shaiXuanButton addTarget:self action:@selector(shaiXuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:shaiXuanButton];
    
    self.paiXuSourceArray = [[NSArray alloc] initWithObjects:@"最新",@"最热",@"评分从高到低",@"评分从低到高",@"价格从高到低",@"价格从低到高", nil];
    

    float originx = 15*BiLiWidth;
    float originy = titleLable1.top+titleLable1.height+18.5*BiLiWidth;
    float xDisTance =  10*BiLiWidth;
    float yDistance = 12*BiLiWidth;

    self.paiButtonXuArray = [NSMutableArray array];
    for (int i=0; i<self.paiXuSourceArray.count; i++) {
        
        NSString * leiXingStr = [self.paiXuSourceArray objectAtIndex:i];
        
        CGSize size = [NormalUse setSize:leiXingStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
        
        if (originx+size.width+25*BiLiWidth>WIDTH_PingMu-30*BiLiWidth) {
            
            originx = 15*BiLiWidth;
            originy = originy+24*BiLiWidth+yDistance;
        }
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originx, originy,size.width+25*BiLiWidth , 24*BiLiWidth)];
        [button setTitle:leiXingStr forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [button setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
        button.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        button.tag=i;
        button.layer.cornerRadius = 12*BiLiWidth;
        [button addTarget:self action:@selector(paiXuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button];
        
        [self.paiButtonXuArray addObject:button];
        
        originx = originx+button.width+xDisTance;
        
    }

    
    UILabel * titleLable2  = [[UILabel alloc] initWithFrame:CGRectMake(14.5*BiLiWidth, originy+24*BiLiWidth+33*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    titleLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
    titleLable2.textColor = RGBFormUIColor(0x9A9A9A);
    titleLable2.text = @"分类";
    [contentView addSubview:titleLable2];

    originy = titleLable2.top+titleLable2.height+18*BiLiWidth;
    originx = 15*BiLiWidth;
    
    self.leiXingButtonArray = [NSMutableArray array];
    for (int i=0; i<self.leiXingSourceArray.count; i++) {
        
        NSString * leiXingStr = [self.leiXingSourceArray objectAtIndex:i];
        
        CGSize size = [NormalUse setSize:leiXingStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
        
        if (originx+size.width+25*BiLiWidth>WIDTH_PingMu-30*BiLiWidth) {
            
            originx = 15*BiLiWidth;
            originy = originy+24*BiLiWidth+yDistance;
        }
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originx, originy,size.width+25*BiLiWidth , 24*BiLiWidth)];
        [button setTitle:leiXingStr forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [button setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
        button.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        button.tag=i;
        button.layer.cornerRadius = 12*BiLiWidth;
        [button addTarget:self action:@selector(leiXingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button];
        
        [self.leiXingButtonArray addObject:button];
        
        originx = originx+button.width+xDisTance;
        
    }

    contentView.height = originy+24*BiLiWidth+33*BiLiWidth;
    contentView.top = HEIGHT_PingMu-contentView.height;
}
-(void)paiXuButtonClick:(UIButton *)selectButton
{
  //  'field'默认,'hot_value'热度,'complex_score'评分,'min_price'低价,'max_price'高价
//desc或者 asc(从低到高)
    NSString * str = [self.paiXuSourceArray objectAtIndex:selectButton.tag];
    if ([@"最新" isEqualToString:str]) {
        
        self.field = @"id";
        self.order = @"desc";

    }
    else if ([@"最热" isEqualToString:str])
    {
        self.field = @"hot_value";
        self.order = @"desc";
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
    else if ([@"价格从低到高" isEqualToString:str])
    {
        self.field = @"min_price";
        self.order = @"asc";

    }

    for (UIButton * button in self.paiButtonXuArray) {
        
        if (button.tag==selectButton.tag) {
            
            [button setBackgroundColor:RGBFormUIColor(0xFF0876)];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        else
        {
            [button setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
            [button setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];

        }
    }
}
-(void)leiXingButtonClick:(UIButton *)selectButton
{
    self.message_type = [self.leiXingSourceArray objectAtIndex:selectButton.tag];
    
    for (UIButton * button in self.leiXingButtonArray) {
        
        if (button.tag==selectButton.tag) {
            
            [button setBackgroundColor:RGBFormUIColor(0xFF0876)];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        else
        {
            [button setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
            [button setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];

        }
    }

}
@end
