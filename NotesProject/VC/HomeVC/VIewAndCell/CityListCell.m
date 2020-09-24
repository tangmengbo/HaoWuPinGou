//
//  CityListCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/24.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "CityListCell.h"

@implementation CityListCell

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
        [self addSubview:self.buttonContentView];
    }
    return self;
}

-(void)initContentView:(NSArray *)array
{

    [self.buttonContentView removeAllSubviews];
    
    self.array = array;
    
    float height = 0;

    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
                
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(18.5+(85+19)*BiLiWidth*(i%3),50*BiLiWidth*(i/3) ,85*BiLiWidth, 35*BiLiWidth)];
        NSString * cityName = [info objectForKey:@"cityName"];
        
        if (cityName.length>5) {
            
            cityName = [cityName substringWithRange:NSMakeRange(0, 4)];
            [button setTitle:cityName forState:UIControlStateNormal];

        }
        else
        {
            [button setTitle:[info objectForKey:@"cityName"] forState:UIControlStateNormal];

        }
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [button setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
        button.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        button.tag=i;
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.layer.cornerRadius = 35*BiLiWidth/2;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonContentView addSubview:button];
        
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
    
    for (int i=0; i<array.count; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(18.5+(85+19)*BiLiWidth*i*(i%3),50*BiLiWidth*(i/3) ,85*BiLiWidth, 35*BiLiWidth)];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [button setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
        button.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        button.tag=i;
        button.layer.cornerRadius = 20*BiLiWidth;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        height = button.top+button.height+16*BiLiWidth;
    }
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

}

@end
