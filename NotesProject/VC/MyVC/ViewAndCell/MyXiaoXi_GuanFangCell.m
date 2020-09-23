//
//  MyXiaoXi_GuanFangCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyXiaoXi_GuanFangCell.h"

@implementation MyXiaoXi_GuanFangCell

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

        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BiLiWidth, 18.5*BiLiWidth, 40*BiLiWidth, 40*BiLiWidth)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.layer.cornerRadius = 20*BiLiWidth;
        [self addSubview:self.headerImageView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.left+self.headerImageView.width+15*BiLiWidth, 22.5*BiLiWidth, 200*BiLiWidth, 15*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x343434);
        [self addSubview:self.titleLable];
        
        self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.top+self.titleLable.height+10*BiLiWidth, 200*BiLiWidth, 12*BiLiWidth)];
        self.timeLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.timeLable.textColor = RGBFormUIColor(0x9A9A9A);
        [self addSubview:self.timeLable];
        
        self.titleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.left, self.headerImageView.top+self.headerImageView.height+18.5*BiLiWidth, WIDTH_PingMu-36*BiLiWidth, 14*BiLiWidth)];
        self.titleLable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.titleLable1.textColor = RGBFormUIColor(0x343434);
        [self addSubview:self.titleLable1];

        self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable1.left, self.titleLable1.height+self.titleLable1.top+7.5*BiLiWidth, WIDTH_PingMu-36*BiLiWidth, 12*BiLiWidth)];
        self.messageLable.textColor = RGBFormUIColor(0x9A9A9A);
        self.messageLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.messageLable.numberOfLines = 0;
        [self addSubview:self.messageLable];

        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 1)];
        self.lineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [self addSubview:self.lineView];

    }
    return self;
}
-(void)initData:(NSDictionary *)info
{
    
    self.headerImageView.image = [UIImage imageNamed:@"guanFangMessage_image"];

    if (self.cellType==GuanFangMessage) {
        
        self.titleLable.text = @"官方消息";

    }
    else if (self.cellType==HuoDongMessage)
    {
        self.titleLable.text = @"活动消息";
    }
    self.timeLable.text = [info objectForKey:@"create_at"];
    self.titleLable1.text = [info objectForKey:@"title"];
    
    
    NSString * neiRongStr = [info objectForKey:@"message"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    self.messageLable.attributedText = attributedString;
    //设置自适应
    [self.messageLable  sizeToFit];
    
    self.lineView.top = self.messageLable.top+self.messageLable.height+17.5*BiLiWidth-1;

}

+(float)cellHegiht:(NSDictionary *)info
{
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(18*BiLiWidth, 98.5*BiLiWidth, WIDTH_PingMu-36*BiLiWidth, 12*BiLiWidth)];
    lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    lable.numberOfLines = 0;

    NSString * neiRongStr = [info objectForKey:@"message"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    lable.attributedText = attributedString;
    //设置自适应
    [lable  sizeToFit];
    
    return lable.height+lable.top+17.5*BiLiWidth;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
