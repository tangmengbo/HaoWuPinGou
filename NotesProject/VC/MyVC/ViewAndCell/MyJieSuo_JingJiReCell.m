//
//  MyJieSuo_JingJiReCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/15.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyJieSuo_JingJiReCell.h"

@implementation MyJieSuo_JingJiReCell

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

        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17*BiLiWidth, 16*BiLiWidth, 76*BiLiWidth, 76*BiLiWidth)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.layer.cornerRadius = 76*BiLiWidth/2;
        [self.contentView addSubview:self.headerImageView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width+self.headerImageView.left+11*BiLiWidth, 19*BiLiWidth, 120*BiLiWidth, 15*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x333333);
        [self.contentView addSubview:self.titleLable];
        
        self.pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-120*BiLiWidth, self.titleLable.top-1.5*BiLiWidth, 100*BiLiWidth, 18*BiLiWidth)];
        self.pingFenLable.font = [UIFont systemFontOfSize:18*BiLiWidth];
        self.pingFenLable.textColor = RGBFormUIColor(0xFFA217);
        self.pingFenLable.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.pingFenLable];
        
        self.cityLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.top+self.titleLable.height+10*BiLiWidth, self.titleLable.width, 12*BiLiWidth)];
        self.cityLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.cityLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.cityLable];
        
        self.renZhengLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.cityLable.top+self.cityLable.height+22*BiLiWidth, 45*BiLiWidth, 15*BiLiWidth)];
        self.renZhengLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        self.renZhengLable.textColor = RGBFormUIColor(0x666666);
        self.renZhengLable.backgroundColor = RGBFormUIColor(0xEEEEEE);
        self.renZhengLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.renZhengLable];

        
        self.chengJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(self.renZhengLable.left+self.renZhengLable.width+13*BiLiWidth, self.renZhengLable.top, self.renZhengLable.width, self.renZhengLable.height)];
        self.chengJiaoLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.chengJiaoLable.textColor = RGBFormUIColor(0x666666);
        self.chengJiaoLable.backgroundColor = RGBFormUIColor(0xEEEEEE);
        self.chengJiaoLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.chengJiaoLable];

        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 109*BiLiWidth-1, WIDTH_PingMu, 1)];
        lineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [self.contentView addSubview:lineView];


    }
    return self;
}
-(void)contentViewSetData:(NSDictionary *)info
{
    if ([[info objectForKey:@"image"] isKindOfClass:[NSString class]]) {
        
      // [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"image"]]];
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"header_kong"]];

    }
    
    self.titleLable.text = [info objectForKey:@"name"];
    
    self.cityLable.text = [NormalUse getobjectForKey:[info objectForKey:@"city_name"]];
    
    NSNumber * complex_score = [info objectForKey:@"complex_score"];

    if ([complex_score isKindOfClass:[NSNumber class]]) {
        
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"综合评分 %d",complex_score.intValue]];
        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSForegroundColorAttributeName
                      value:RGBFormUIColor(0x999999)
                      range:NSMakeRange(0, 4)];

        [text1 addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12*BiLiWidth]
                      range:NSMakeRange(0, 4)];
        self.pingFenLable.attributedText = text1;

    }
    NSNumber * post_num = [info objectForKey:@"post_num"];
    
    if ([post_num isKindOfClass:[NSNumber class]]) {
        
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"认证 %d",post_num.intValue]];
        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSForegroundColorAttributeName
                      value:RGBFormUIColor(0x999999)
                      range:NSMakeRange(0, 2)];

        [text1 addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:9*BiLiWidth]
                      range:NSMakeRange(0, 2)];
        self.renZhengLable.attributedText = text1;

    }
    
    NSNumber * deal_num = [info objectForKey:@"deal_num"];
    
    if ([deal_num isKindOfClass:[NSNumber class]]) {
        
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"成交 %d",deal_num.intValue]];
        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSForegroundColorAttributeName
                      value:RGBFormUIColor(0x999999)
                      range:NSMakeRange(0, 2)];

        [text1 addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:9*BiLiWidth]
                      range:NSMakeRange(0, 2)];
        self.chengJiaoLable.attributedText = text1;

    }



    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
