//
//  FuQiJiaoHomeCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/20.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "FuQiJiaoHomeCell.h"

@implementation FuQiJiaoHomeCell

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

    }
    return self;
}
-(void)initData:(NSDictionary *)info1 info2:(NSDictionary * _Nullable)info2
{
    [self.headerImageView1 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597827992453&di=89f2d23d41e7e650adec139e15eb8688&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853"]];
    NSString * titleStr = @"飞机扣水电费";
    CGSize size = [NormalUse setSize:titleStr withCGSize:CGSizeMake(WIDTH_PingMu, HEIGHT_PingMu) withFontSize:14*BiLiWidth];
    self.cityLable1.width = size.width;
    self.cityLable1.text = titleStr;
    self.zuanShiImageView1.left = self.cityLable1.left+self.cityLable1.width+5*BiLiWidth;
    self.messageLable1.text = @"年龄：40/36";
    
    if ([NormalUse isValidDictionary:info2]) {
        
        self.contentView2.hidden = NO;

        [self.headerImageView2 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597827992453&di=89f2d23d41e7e650adec139e15eb8688&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853"]];
        NSString * titleStr = @"飞机扣水电费";
        CGSize size = [NormalUse setSize:titleStr withCGSize:CGSizeMake(WIDTH_PingMu, HEIGHT_PingMu) withFontSize:14*BiLiWidth];
        self.cityLable2.width = size.width;
        self.cityLable2.text = titleStr;
        self.zuanShiImageView2.left = self.cityLable1.left+self.cityLable1.width+5*BiLiWidth;
        self.messageLable2.text = @"年龄：40/36";

    }
    else
    {
        self.contentView2.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
