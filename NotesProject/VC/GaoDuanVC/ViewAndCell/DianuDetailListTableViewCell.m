//
//  DianuDetailListTableViewCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/2.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "DianuDetailListTableViewCell.h"

@implementation DianuDetailListTableViewCell

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
        [self addSubview:self.contentView1];
        
        
        self.headerImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 165*BiLiWidth, 137*BiLiWidth)];
        self.headerImageView1.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView1.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView1.clipsToBounds = YES;
        [self.contentView1 addSubview:self.headerImageView1];
        
        self.cityLable1 = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.headerImageView1.top+self.headerImageView1.height+10*BiLiWidth, 0, 14*BiLiWidth)];
        self.cityLable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.cityLable1.textColor = RGBFormUIColor(0x333333);
        [self.contentView1 addSubview:self.cityLable1];
        
        self.zuanShiImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.cityLable1.top, 16*BiLiWidth, 14*BiLiWidth)];
        self.zuanShiImageView1.backgroundColor = [UIColor redColor];
        [self.contentView1 addSubview:self.zuanShiImageView1];
        
        self.messageLable1 = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.cityLable1.top+self.cityLable1.height+7.5*BiLiWidth, 150*BiLiWidth, 11*BiLiWidth)];
        self.messageLable1.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.messageLable1.textColor = RGBFormUIColor(0x999999);
        [self.contentView1 addSubview:self.messageLable1];
        
        UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.contentView1.width, self.contentView1.height)];
        [button1 addTarget:self action:@selector(pushTuTieZiDetail1) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView1 addSubview:button1];


       
        self.contentView2 = [[UIView alloc] initWithFrame:CGRectMake(self.contentView1.left+self.contentView1.width+4.5*BiLiWidth, 0, 165*BiLiWidth, 192*BiLiWidth)];
        self.contentView2.layer.cornerRadius = 5*BiLiWidth;
        self.contentView2.layer.masksToBounds = YES;
        self.contentView2.layer.borderWidth = 1;
        self.contentView2.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
        [self addSubview:self.contentView2];
        
        self.headerImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 165*BiLiWidth, 137*BiLiWidth)];
        self.headerImageView2.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView2.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView2.clipsToBounds = YES;
        [self.contentView2 addSubview:self.headerImageView2];
        
        self.cityLable2 = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.headerImageView1.top+self.headerImageView1.height+10*BiLiWidth, 0, 14*BiLiWidth)];
        self.cityLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.cityLable2.textColor = RGBFormUIColor(0x333333);
        [self.contentView2 addSubview:self.cityLable2];
        
        self.zuanShiImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.cityLable1.top, 16*BiLiWidth, 14*BiLiWidth)];
        self.zuanShiImageView2.backgroundColor = [UIColor redColor];
        [self.contentView2 addSubview:self.zuanShiImageView2];
        
        self.messageLable2 = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.cityLable1.top+self.cityLable1.height+7.5*BiLiWidth, 150*BiLiWidth, 11*BiLiWidth)];
        self.messageLable2.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.messageLable2.textColor = RGBFormUIColor(0x999999);
        [self.contentView2 addSubview:self.messageLable2];
        
        UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.contentView1.width, self.contentView1.height)];
        [button2 addTarget:self action:@selector(pushTuTieZiDetail2) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView2 addSubview:button2];


    }
    return self;
}
-(void)initData:(NSDictionary *)info1 info2:(NSDictionary * _Nullable)info2
{
    self.info1 = info1;
    self.info2 = info2;
    if ([NormalUse isValidArray:[info1 objectForKey:@"images"]]) {
        
        NSArray * images = [info1 objectForKey:@"images"];
        [self.headerImageView1 sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]]];
        
    }
    else if ([NormalUse isValidString:[info1 objectForKey:@"images"]])
    {
        [self.headerImageView1 sd_setImageWithURL:[NSURL URLWithString:[info1 objectForKey:@"images"]]];
    }
    
    NSString * titleStr = [NormalUse getobjectForKey:[info1 objectForKey:@"city_name"]];
    CGSize size = [NormalUse setSize:titleStr withCGSize:CGSizeMake(WIDTH_PingMu, HEIGHT_PingMu) withFontSize:14*BiLiWidth];
    self.cityLable1.width = size.width;
    self.cityLable1.text = titleStr;
    self.zuanShiImageView1.left = self.cityLable1.left+self.cityLable1.width+5*BiLiWidth;
    
    NSNumber * age = [info1 objectForKey:@"age"];
    self.messageLable1.text = [NSString stringWithFormat:@"年龄：%d",age.intValue];
    
    if ([NormalUse isValidDictionary:info2]) {
        
        self.contentView2.hidden = NO;

        if ([NormalUse isValidArray:[info2 objectForKey:@"images"]]) {
            
            NSArray * images = [info2 objectForKey:@"images"];
            [self.headerImageView2 sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]]];
            
        }
        else if ([NormalUse isValidString:[info2 objectForKey:@"images"]])
        {
            [self.headerImageView2 sd_setImageWithURL:[NSURL URLWithString:[info1 objectForKey:@"images"]]];
        }
        
        NSString * titleStr = [NormalUse getobjectForKey:[info2 objectForKey:@"city_name"]];
        CGSize size = [NormalUse setSize:titleStr withCGSize:CGSizeMake(WIDTH_PingMu, HEIGHT_PingMu) withFontSize:14*BiLiWidth];
        self.cityLable2.width = size.width;
        self.cityLable2.text = titleStr;
        self.zuanShiImageView2.left = self.cityLable2.left+self.cityLable2.width+5*BiLiWidth;
        
        NSNumber * age = [info2 objectForKey:@"age"];
        self.messageLable2.text = [NSString stringWithFormat:@"年龄：%d",age.intValue];
    }
    else
    {
        self.contentView2.hidden = YES;
    }
}
-(void)pushTuTieZiDetail1
{
    TieZiDetailViewController * vc = [[TieZiDetailViewController alloc] init];
    [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];
}
-(void)pushTuTieZiDetail2
{
    TieZiDetailViewController * vc = [[TieZiDetailViewController alloc] init];
    [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
