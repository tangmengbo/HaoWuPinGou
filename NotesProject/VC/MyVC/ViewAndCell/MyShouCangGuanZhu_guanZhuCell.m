//
//  MyShouCangGuanZhu_guanZhuCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/15.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyShouCangGuanZhu_guanZhuCell.h"

@implementation MyShouCangGuanZhu_guanZhuCell

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

        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17*BiLiWidth, 16*BiLiWidth, 61*BiLiWidth, 61*BiLiWidth)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.layer.cornerRadius = 61*BiLiWidth/2;
        [self addSubview:self.headerImageView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width+self.headerImageView.left+11*BiLiWidth, 19*BiLiWidth, 120*BiLiWidth, 15*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x333333);
        [self addSubview:self.titleLable];
        
        self.pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.top+self.titleLable.height+10*BiLiWidth, 50*BiLiWidth, 18*BiLiWidth)];
        self.pingFenLable.font = [UIFont systemFontOfSize:18*BiLiWidth];
        self.pingFenLable.textColor = RGBFormUIColor(0xFFA217);
        [self addSubview:self.pingFenLable];
        
        self.cityLable = [[UILabel alloc] initWithFrame:CGRectMake(self.pingFenLable.left+self.pingFenLable.width, self.pingFenLable.top, 100*BiLiWidth, 18*BiLiWidth)];
        self.cityLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.cityLable.textColor = RGBFormUIColor(0x9A9A9A);
        [self addSubview:self.cityLable];
        
        self.renZhengLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.cityLable.top+self.cityLable.height+22*BiLiWidth, 45*BiLiWidth, 15*BiLiWidth)];
        self.renZhengLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        self.renZhengLable.textColor = RGBFormUIColor(0x666666);
        self.renZhengLable.backgroundColor = RGBFormUIColor(0xEEEEEE);
        self.renZhengLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.renZhengLable];

        
        self.chengJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(self.renZhengLable.left+self.renZhengLable.width+13*BiLiWidth, self.renZhengLable.top, self.renZhengLable.width, self.renZhengLable.height)];
        self.chengJiaoLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.chengJiaoLable.textColor = RGBFormUIColor(0x666666);
        self.chengJiaoLable.backgroundColor = RGBFormUIColor(0xEEEEEE);
        self.chengJiaoLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.chengJiaoLable];

        self.alsoDeleteButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-100*BiLiWidth, self.titleLable.top,100*BiLiWidth,24*BiLiWidth)];
        [self.alsoDeleteButton addTarget:self action:@selector(alsoDeleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.alsoDeleteButton.tag = 0;
        self.alsoDeleteButton.button_imageView.frame = CGRectMake((self.alsoDeleteButton.width-12*BiLiWidth)/2, 6*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth);
        self.alsoDeleteButton.button_imageView.layer.cornerRadius = 6*BiLiWidth;
        self.alsoDeleteButton.button_imageView.layer.masksToBounds = YES;
        self.alsoDeleteButton.button_imageView.layer.borderWidth = 1;
        self.alsoDeleteButton.button_imageView.layer.borderColor = [RGBFormUIColor(0x999999) CGColor];
        self.alsoDeleteButton.button_imageView1.frame = CGRectMake(self.alsoDeleteButton.button_imageView.left+1.5*BiLiWidth, self.alsoDeleteButton.button_imageView.top+1.5*BiLiWidth, 9*BiLiWidth, 9*BiLiWidth);
        self.alsoDeleteButton.button_imageView1.layer.cornerRadius = 4.5*BiLiWidth;
        self.alsoDeleteButton.button_imageView1.layer.masksToBounds = YES;
        [self addSubview:self.alsoDeleteButton];

        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 109*BiLiWidth-1, WIDTH_PingMu, 1)];
        lineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [self addSubview:lineView];

        self.alsoDeleteButton.hidden = YES;

    }
    return self;
}
-(void)alsoDeleteButtonClick
{
    if (self.alsoDeleteButton.tag==0) {
        
        self.alsoDeleteButton.tag = 1;
        self.alsoDeleteButton.button_imageView.layer.borderColor = [RGBFormUIColor(0xFF0876) CGColor];
        self.alsoDeleteButton.button_imageView1.backgroundColor = RGBFormUIColor(0xFF0876);
        self.alsoDeleteButton.button_lable.textColor = RGBFormUIColor(0x333333);
        
        NSNumber * post_id = [self.info objectForKey:@"id"];
        [self.delegate guanZhuTianJiaToDelet:[NSString stringWithFormat:@"%d",post_id.intValue]];

    }
    else
    {
        self.alsoDeleteButton.tag = 0;
        self.alsoDeleteButton.button_imageView.layer.borderColor = [RGBFormUIColor(0x999999) CGColor];
        self.alsoDeleteButton.button_imageView1.backgroundColor = [UIColor clearColor];
        self.alsoDeleteButton.button_lable.textColor = RGBFormUIColor(0x999999);
        NSNumber * post_id = [self.info objectForKey:@"id"];
        [self.delegate guanZhuQuXiaoToDelet:[NSString stringWithFormat:@"%d",post_id.intValue]];

    }

}
-(void)contentViewSetData:(NSDictionary *)info alsoDelete:(BOOL)alsoDelete
{
    self.info = info;
    
    if (alsoDelete) {
        
        self.alsoDeleteButton.hidden = NO;
    }
    else
    {
        self.alsoDeleteButton.hidden = YES;

    }
    if ([[info objectForKey:@"image"] isKindOfClass:[NSString class]]) {
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"image"]]];
        
    }
    
    self.titleLable.text = [info objectForKey:@"name"];
    
    self.cityLable.text = [NormalUse getobjectForKey:[info objectForKey:@"city_name"]];
    
    NSNumber * complex_score = [info objectForKey:@"complex_score"];
    self.pingFenLable.text = [NSString stringWithFormat:@"%d",complex_score.intValue];

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
