//
//  ForeignCityListCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/11/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "ForeignCityListCell.h"

@implementation ForeignCityListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.selectedBackgroundView = [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];//RGBFormUIColor(0xF4F4F4);
        
        self.buttonContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 0)];
        [self.contentView addSubview:self.buttonContentView];
    }
    return self;
}

-(void)initContentView:(NSArray *)array
{

    [self.buttonContentView removeAllSubviews];
    
    self.array = array;
    
    float height = 0;

    float originx = 18.5*BiLiWidth;
    float originY = 0;

    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        NSString * cityName = [info objectForKey:@"cityName"];
        
        CGSize citySize = [NormalUse setSize:cityName withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:14*BiLiWidth];
        if (citySize.width+24*BiLiWidth+originx>WIDTH_PingMu-18.5*BiLiWidth) {
            
            originx = 18.5*BiLiWidth;
            originY = originY+50*BiLiWidth;
        }
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originx,originY ,citySize.width+24*BiLiWidth, 35*BiLiWidth)];
        [button setTitle:[info objectForKey:@"cityName"] forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [button setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
        button.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        button.tag=i;
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.layer.cornerRadius = 35*BiLiWidth/2;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonContentView addSubview:button];
        
        originx = button.left+button.width+15*BiLiWidth;
        
        height = button.top+button.height+16*BiLiWidth;

    }
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(19*BiLiWidth, height-1, WIDTH_PingMu-38*BiLiWidth, 1)];
    lineView.backgroundColor = [RGBFormUIColor(0x999999) colorWithAlphaComponent:0.5];
    [self.buttonContentView addSubview:lineView];
    
    self.buttonContentView.height = lineView.top;

}
-(void)buttonClick:(UIButton *)button
{
    [self.delegate cityButtonSelect:[self.array objectAtIndex:button.tag]];
}
+(float)cellHegiht:(NSArray *)array
{
    float height = 0;
    
    float originx = 18.5*BiLiWidth;
    float originY = 0;

    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        NSString * cityName = [info objectForKey:@"cityName"];
        
        CGSize citySize = [NormalUse setSize:cityName withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:14*BiLiWidth];
        if (citySize.width+24*BiLiWidth+originx>WIDTH_PingMu-18.5*BiLiWidth) {
            
            originx = 18.5*BiLiWidth;
            originY = originY+50*BiLiWidth;
        }

        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originx ,originY,citySize.width+24*BiLiWidth, 35*BiLiWidth)];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [button setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
        button.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        button.tag=i;
        button.layer.cornerRadius = 20*BiLiWidth;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        originx = button.left+button.width+15*BiLiWidth;

        height = button.top+button.height+16*BiLiWidth;
    }
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

}
@end
