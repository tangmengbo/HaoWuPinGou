//
//  GaoDuanHomeCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/20.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GaoDuanHomeCell.h"

@implementation GaoDuanHomeCell

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

        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth, 21.5*BiLiWidth, 48*BiLiWidth, 48*BiLiWidth)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.layer.cornerRadius = 24*BiLiWidth;
        [self addSubview:self.headerImageView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width+self.headerImageView.left+15*BiLiWidth, 25*BiLiWidth, 170*BiLiWidth, 14*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x333333);
        [self addSubview:self.titleLable];
        
        self.starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.top+self.titleLable.height+13*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
        self.starImageView.image = [UIImage imageNamed:@"star_yellow"];
        [self addSubview:self.starImageView];

        self.starLable = [[UILabel alloc] initWithFrame:CGRectMake(self.starImageView.left+self.starImageView.width+5*BiLiWidth, self.starImageView.top, 19*BiLiWidth, 12*BiLiWidth)];
        self.starLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.starLable.textColor = RGBFormUIColor(0xF5BB61);
        [self addSubview:self.starLable];

        
        self.cityLable = [[UILabel alloc] initWithFrame:CGRectMake(self.starLable.left+self.starLable.width+12*BiLiWidth, self.starImageView.top, 60*BiLiWidth, 12*BiLiWidth)];
        self.cityLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.cityLable.textColor = RGBFormUIColor(0x999999);
        [self addSubview:self.cityLable];
        
        self.jinRuButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-72*BiLiWidth-12*BiLiWidth, 24*BiLiWidth, 72*BiLiWidth, 24*BiLiWidth)];
        self.jinRuButton.layer.cornerRadius = 12*BiLiWidth;
        self.jinRuButton.layer.borderWidth = 1;
        self.jinRuButton.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
        [self.jinRuButton setTitle:@"进店看看" forState:UIControlStateNormal];
        [self.jinRuButton setTitleColor:RGBFormUIColor(0xDDDDDD) forState:UIControlStateNormal];
        self.jinRuButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        [self.jinRuButton addTarget:self action:@selector(jinDianKanKanButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_jinRuButton];

        self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerImageView.top+self.headerImageView.height+18*BiLiWidth, WIDTH_PingMu, 132*BiLiWidth)];
        [self addSubview:self.contentScrollView];
        
        self.jiaoYiBaoZhengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.contentScrollView.top+self.contentScrollView.height+12*BiLiWidth, 109*BiLiWidth, 16.5*BiLiWidth)];
        self.jiaoYiBaoZhengImageView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.jiaoYiBaoZhengImageView];
        
        self.renZhengLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-144*BiLiWidth,self.jiaoYiBaoZhengImageView.top+1, 60*BiLiWidth, 14.5*BiLiWidth)];
        self.renZhengLable.textColor = RGBFormUIColor(0x656565);
        self.renZhengLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        self.renZhengLable.adjustsFontSizeToFitWidth = YES;
        self.renZhengLable.backgroundColor = RGBFormUIColor(0xEDEDED);
        self.renZhengLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.renZhengLable];



        self.chengJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(self.renZhengLable.left+self.renZhengLable.width+12*BiLiWidth, self.renZhengLable.top, 60*BiLiWidth, 14.5*BiLiWidth)];
        self.chengJiaoLable.textColor = RGBFormUIColor(0x656565);
        self.chengJiaoLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        self.chengJiaoLable.adjustsFontSizeToFitWidth = YES;
        self.chengJiaoLable.backgroundColor = RGBFormUIColor(0xEDEDED);
        self.chengJiaoLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.chengJiaoLable];

        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.chengJiaoLable.top+self.chengJiaoLable.height+20*BiLiWidth, WIDTH_PingMu, 8*BiLiWidth)];
        self.lineView.backgroundColor = RGBFormUIColor(0xEDEDED);
        [self addSubview:self.lineView];
        


    }
    return self;
}
-(void)contentViewSetData:(NSDictionary *)info
{
    self.info = info;
    if ([NormalUse isValidString:[info objectForKey:@"image"]]) {
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"image"]]];

    }
    self.titleLable.text = [info objectForKey:@"user_name"];
    NSNumber * complex_score = [info objectForKey:@"complex_score"];
    if ([complex_score isKindOfClass:[NSNumber class]]) {
        
        self.starLable.text = [NSString stringWithFormat:@"%d",complex_score.intValue];

    }
    self.cityLable.text = [info objectForKey:@"city_name"];
    
    [self.contentScrollView removeAllSubviews];
    
    NSArray * post_list = [info objectForKey:@"post_list"];
    for (int i=0; i<post_list.count; i++) {
        
        NSDictionary * info = [post_list objectAtIndex:i];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth+113*BiLiWidth*i, 0, 109*BiLiWidth, 131*BiLiWidth)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingNone;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 5*BiLiWidth;
        
        if ([NormalUse isValidString:[info objectForKey:@"images"]]) {
            
            [imageView sd_setImageWithURL:[info objectForKey:@"images"]];

            
        }
        else if ([NormalUse isValidArray:[info objectForKey:@"images"]])
        {
            NSArray * images = [info objectForKey:@"images"];
            [imageView sd_setImageWithURL:[images objectAtIndex:0]];

            
        }
        [self.contentScrollView addSubview:imageView];
        
        [self.contentScrollView setContentSize:CGSizeMake(imageView.left+imageView.width+12*BiLiWidth, self.contentScrollView.height)];

    }
    
    NSNumber * post_num = [info objectForKey:@"post_num"];
    if ([post_num isKindOfClass:[NSNumber class]]) {
        
        NSString * renZhengStr = [NSString stringWithFormat:@"认证 %d",post_num.intValue];
        NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:renZhengStr];
        [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x999999) range:NSMakeRange(0, 2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9*BiLiWidth] range:NSMakeRange(0, 2)];
        self.renZhengLable.attributedText = str;


    }

    NSNumber * deal_num = [info objectForKey:@"deal_num"];
    if ([post_num isKindOfClass:[NSNumber class]]) {
        
        NSString * chengJiaoStr = [NSString stringWithFormat:@"成交 %d",deal_num.intValue];
        NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:chengJiaoStr];
        [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x999999) range:NSMakeRange(0, 2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9*BiLiWidth] range:NSMakeRange(0, 2)];
        self.chengJiaoLable.attributedText = str;


    }


}
-(void)jinDianKanKanButtonClick
{
    DianPuDetailViewController * vc = [[DianPuDetailViewController alloc] init];
    NSNumber * idNumber = [self.info objectForKey:@"id"];
    vc.dianPuId = [NSString stringWithFormat:@"%d",idNumber.intValue];
    [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
