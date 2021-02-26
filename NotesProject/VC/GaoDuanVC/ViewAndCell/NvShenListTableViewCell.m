//
//  NvShenListTableViewCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/3.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "NvShenListTableViewCell.h"

@implementation NvShenListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.contentView1 = [[UIView alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, 0, 165*BiLiWidth, 192*BiLiWidth)];
        self.contentView1.layer.cornerRadius = 5*BiLiWidth;
        self.contentView1.layer.masksToBounds = YES;
        self.contentView1.layer.borderWidth = 1;
        self.contentView1.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
        [self.contentView addSubview:self.contentView1];
        
        self.headerImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 165*BiLiWidth, 137*BiLiWidth)];
        self.headerImageView1.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView1.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView1.clipsToBounds = YES;
        [self.contentView1 addSubview:self.headerImageView1];
        
        self.cityLable1 = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.headerImageView1.top+self.headerImageView1.height+10*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
        self.cityLable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.cityLable1.textColor = RGBFormUIColor(0x333333);
        [self.contentView1 addSubview:self.cityLable1];
        
        self.ageLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView1.width-52*BiLiWidth, self.cityLable1.top, 50*BiLiWidth, 14*BiLiWidth)];
        self.ageLable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.ageLable1.textColor = RGBFormUIColor(0x333333);
        self.ageLable1.textAlignment = NSTextAlignmentRight;
        [self.contentView1 addSubview:self.ageLable1];
        
        self.messageLable1 = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.cityLable1.top+self.cityLable1.height+7.5*BiLiWidth, 150*BiLiWidth, 11*BiLiWidth)];
        self.messageLable1.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.messageLable1.textColor = RGBFormUIColor(0x333333);
        [self.contentView1 addSubview:self.messageLable1];

        self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.contentView1.width, self.contentView1.height)];
        [self.button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView1 addSubview:self.button1];
        
        self.contentView2 = [[UIView alloc] initWithFrame:CGRectMake(self.contentView1.left+self.contentView1.width+4.5*BiLiWidth, 0, 165*BiLiWidth, 192*BiLiWidth)];
        self.contentView2.layer.cornerRadius = 5*BiLiWidth;
        self.contentView2.layer.masksToBounds = YES;
        self.contentView2.layer.borderWidth = 1;
        self.contentView2.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
        [self.contentView addSubview:self.contentView2];
        
        self.headerImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 165*BiLiWidth, 137*BiLiWidth)];
        self.headerImageView2.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView2.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView2.clipsToBounds = YES;
        [self.contentView2 addSubview:self.headerImageView2];
        
        self.cityLable2 = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.headerImageView1.top+self.headerImageView1.height+10*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
        self.cityLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.cityLable2.textColor = RGBFormUIColor(0x333333);
        [self.contentView2 addSubview:self.cityLable2];
        
        self.ageLable2 = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView1.width-62*BiLiWidth, self.cityLable1.top, 50*BiLiWidth, 14*BiLiWidth)];
        self.ageLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.ageLable2.textColor = RGBFormUIColor(0x333333);
        self.ageLable2.textAlignment = NSTextAlignmentRight;
        [self.contentView2 addSubview:self.ageLable2];
        

        self.messageLable2 = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.cityLable1.top+self.cityLable1.height+7.5*BiLiWidth, 150*BiLiWidth, 11*BiLiWidth)];
        self.messageLable2.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.messageLable2.textColor = RGBFormUIColor(0x999999);
        [self.contentView2 addSubview:self.messageLable2];
        
        self.button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.contentView1.width, self.contentView1.height)];
        [self.button2 addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView2 addSubview:self.button2];


    }
    return self;
}
-(void)initData:(NSDictionary *)info1 info2:(NSDictionary * _Nullable)info2
{
    self.info1 = info1;
    if ([[info1 objectForKey:@"images"] isKindOfClass:[NSString class]]) {
        
       // [self.headerImageView1 sd_setImageWithURL:[NSURL URLWithString:[info1 objectForKey:@"images"]]];
        [self.headerImageView1 sd_setImageWithURL:[NSURL URLWithString:[info1 objectForKey:@"images"]] placeholderImage:[UIImage imageNamed:@"header_kong"]];

    }
    if ([[info1 objectForKey:@"images"] isKindOfClass:[NSArray class]])
    {
        NSArray * images = [info1 objectForKey:@"images"];
        if ([NormalUse isValidArray:images]) {
            
           // [self.headerImageView1 sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]]];
            [self.headerImageView1 sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"header_kong"]];

        }
    }

    self.cityLable1.text = [info1 objectForKey:@"city_name"];
    NSNumber * age = [info1 objectForKey:@"age"];
    if ([age isKindOfClass:[NSNumber class]]) {
        
        self.ageLable1.text = [NSString stringWithFormat:@"%d岁",age.intValue];
    }
//    NSNumber * min_price = [info1 objectForKey:@"min_price"];
//    NSNumber * max_price = [info1 objectForKey:@"max_price"];
//    if ([min_price isKindOfClass:[NSNumber class]]&&[max_price isKindOfClass:[NSNumber class]]) {
//
//        self.messageLable1.text = [NSString stringWithFormat:@"价格 %d-%d",min_price.intValue,max_price.intValue];
//    }
    self.messageLable1.text = [NSString stringWithFormat:@"价格 %@",[NormalUse getobjectForKey:[info1 objectForKey:@"nprice_label"]]];

    
    if ([NormalUse isValidDictionary:info2]) {
        
        self.info2 = info2;
        self.contentView2.hidden = NO;

        if ([[info2 objectForKey:@"images"] isKindOfClass:[NSString class]]) {
            
           // [self.headerImageView2 sd_setImageWithURL:[NSURL URLWithString:[info2 objectForKey:@"images"]]];
            [self.headerImageView2 sd_setImageWithURL:[NSURL URLWithString:[info2 objectForKey:@"images"]] placeholderImage:[UIImage imageNamed:@"header_kong"]];

        }
        if ([[info2 objectForKey:@"images"] isKindOfClass:[NSArray class]])
        {
            NSArray * images = [info2 objectForKey:@"images"];
            if ([NormalUse isValidArray:images]) {
                
               // [self.headerImageView2 sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]]];
                [self.headerImageView2 sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"header_kong"]];

            }
        }
        self.cityLable2.text = [info2 objectForKey:@"city_name"];
        NSNumber * age = [info2 objectForKey:@"age"];
        if ([age isKindOfClass:[NSNumber class]]) {
            
            self.ageLable2.text = [NSString stringWithFormat:@"%d岁",age.intValue];
        }
//        NSNumber * min_price = [info2 objectForKey:@"min_price"];
//        NSNumber * max_price = [info2 objectForKey:@"max_price"];
//        if ([min_price isKindOfClass:[NSNumber class]]&&[max_price isKindOfClass:[NSNumber class]]) {
//
//            self.messageLable2.text = [NSString stringWithFormat:@"价格 %d-%d",min_price.intValue,max_price.intValue];
//        }
        self.messageLable2.text = [NSString stringWithFormat:@"价格 %@",[NormalUse getobjectForKey:[info2 objectForKey:@"nprice_label"]]];


    }
    else
    {
        self.contentView2.hidden = YES;
    }
}
#pragma mark--buttonClick
-(void)button1Click
{
    NSNumber * girlId = [self.info1 objectForKey:@"id"];
    SanDaJiaoSeDetailViewController * vc = [[SanDaJiaoSeDetailViewController alloc] init];
    vc.girl_id = [NSString stringWithFormat:@"%d",girlId.intValue];
    vc.type = self.type;
    [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];
}
-(void)button2Click
{
    NSNumber * girlId = [self.info2 objectForKey:@"id"];
    SanDaJiaoSeDetailViewController * vc = [[SanDaJiaoSeDetailViewController alloc] init];
    vc.girl_id = [NSString stringWithFormat:@"%d",girlId.intValue];
    vc.type = self.type;
    [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
