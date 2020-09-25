//
//  DingZhiFuWuTableViewCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "DingZhiFuWuTableViewCell.h"

@implementation DingZhiFuWuTableViewCell

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

        self.contentMessageView = [[UIView alloc] initWithFrame:CGRectMake(19*BiLiWidth, 0, WIDTH_PingMu-38*BiLiWidth, 185*BiLiWidth)];
        self.contentMessageView.layer.borderWidth = 1;
        self.contentMessageView.layer.borderColor = [RGBFormUIColor(0xEEEEEE) CGColor];
        self.contentMessageView.layer.cornerRadius = 5*BiLiWidth;
        self.contentMessageView.layer.masksToBounds = NO;
        self.contentMessageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentMessageView];
        self.contentMessageView.layer.shadowOpacity = 0.2f;
        self.contentMessageView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.contentMessageView.layer.shadowOffset = CGSizeMake(0, 3);//CGSizeZero; //设置偏移量为0,四周都有阴影

        //shz

        
        
        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21.5*BiLiWidth, 13.5*BiLiWidth, 38*BiLiWidth, 38*BiLiWidth)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.layer.cornerRadius = 19*BiLiWidth;
        [self.contentMessageView addSubview:self.headerImageView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width+self.headerImageView.left+10*BiLiWidth, 15.5*BiLiWidth, 150*BiLiWidth, 15*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x333333);
        [self.contentMessageView addSubview:self.titleLable];
        
        self.weiZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(self.contentMessageView.width-115*BiLiWidth, self.titleLable.top, 100*BiLiWidth, self.titleLable.height)];
        self.weiZhiLable.textAlignment = NSTextAlignmentRight;
        self.weiZhiLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        self.weiZhiLable.textColor = RGBFormUIColor(0x999999);
        [self.contentMessageView addSubview:self.weiZhiLable];
        
        self.faBuTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.top+self.titleLable.height+6.5*BiLiWidth, 200*BiLiWidth, 10*BiLiWidth)];
        self.faBuTimeLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        self.faBuTimeLable.textColor = RGBFormUIColor(0x999999);
        [self.contentMessageView addSubview:self.faBuTimeLable];

        
        self.priceLable = [[UILabel alloc] initWithFrame:CGRectMake(21.5*BiLiWidth, self.headerImageView.top+self.headerImageView.height+13*BiLiWidth, 300*BiLiWidth, 14*BiLiWidth)];
        self.priceLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.priceLable.textColor = RGBFormUIColor(0xFFA217);
        [self.contentMessageView addSubview:self.priceLable];
        
        self.neiRongView = [[UIView alloc] initWithFrame:CGRectMake(21.5*BiLiWidth, self.priceLable.top+self.priceLable.height+15.5*BiLiWidth, self.contentView.width-21.5*BiLiWidth*2, 0)];
        self.neiRongView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [self.contentMessageView addSubview:self.neiRongView];


        self.dingZhiNeiRongLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, 15*BiLiWidth, self.neiRongView.width-26*BiLiWidth, 13*BiLiWidth)];
        self.dingZhiNeiRongLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.dingZhiNeiRongLable.textColor = RGBFormUIColor(0x666666);
        self.dingZhiNeiRongLable.numberOfLines = 0;
        [self.neiRongView addSubview:self.dingZhiNeiRongLable];
        
        self.dingZhiTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, self.dingZhiNeiRongLable.top+self.dingZhiNeiRongLable.height+8.5*BiLiWidth, 200*BiLiWidth, 13*BiLiWidth)];
        self.dingZhiTimeLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.dingZhiTimeLable.textColor = RGBFormUIColor(0x666666);
        self.dingZhiTimeLable.adjustsFontSizeToFitWidth = YES;
        [self.neiRongView addSubview:self.dingZhiTimeLable];



    }
    return self;
}
-(void)contentViewSetData:(NSDictionary *)info
{
    NSDictionary * userinfo = [info objectForKey:@"userinfo"];
    if ([NormalUse isValidDictionary:userinfo]) {
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[userinfo objectForKey:@"avatar"]]];
        self.titleLable.text = [userinfo objectForKey:@"nickname"];

    }
    
    self.weiZhiLable.text = [NormalUse getobjectForKey:[info objectForKey:@"city_name"]];
    self.faBuTimeLable.text = [info objectForKey:@"create_at"];
    self.priceLable.text = [NSString stringWithFormat:@"¥%@~¥%@",[info objectForKey:@"min_price"],[info objectForKey:@"max_price"]];
    
    self.dingZhiNeiRongLable.width = self.neiRongView.width-26*BiLiWidth;
    
    NSString * neiRongStr = [info objectForKey:@"love_type"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    self.dingZhiNeiRongLable.attributedText = attributedString;
    //设置自适应
    [self.dingZhiNeiRongLable  sizeToFit];
    
    self.dingZhiTimeLable.top = self.dingZhiNeiRongLable.top+self.dingZhiNeiRongLable.height+8.5*BiLiWidth;
    self.neiRongView.height = self.dingZhiTimeLable.top+self.dingZhiTimeLable.height+10.5*BiLiWidth;
    
    self.contentMessageView.height = self.neiRongView.top+self.neiRongView.height+14*BiLiWidth;
    
    self.dingZhiNeiRongLable.text = neiRongStr;
    self.dingZhiTimeLable.text = [NSString stringWithFormat:@"预定时间：%@ - %@",[info objectForKey:@"start_date"],[info objectForKey:@"end_date"]];
    
}
+(float)cellHegiht:(NSDictionary *)info
{
    
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, 15*BiLiWidth, 250*BiLiWidth, 12*BiLiWidth)];
    lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    lable.numberOfLines = 0;

    NSString * neiRongStr = [info objectForKey:@"love_type"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    lable.attributedText = attributedString;
    //设置自适应
    [lable  sizeToFit];
    
    return lable.height+112.5*BiLiWidth+66*BiLiWidth;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end
