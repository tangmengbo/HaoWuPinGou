//
//  JinBiMingXiCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "JinBiMingXiCell.h"

@implementation JinBiMingXiCell

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

        
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20*BiLiWidth, 9*BiLiWidth, WIDTH_PingMu-100*BiLiWidth, 14*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x343434);
        [self addSubview:self.titleLable];
        
        self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.top+self.titleLable.height+7*BiLiWidth, 200*BiLiWidth, 11*BiLiWidth)];
        self.timeLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.timeLable.textColor = RGBFormUIColor(0x9A9A9A);
        [self addSubview:self.timeLable];
        

        self.jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-225*BiLiWidth, 25.5*BiLiWidth, 200*BiLiWidth, 15*BiLiWidth)];
        self.jinBiLable.textColor = RGBFormUIColor(0xFFA20B);
        self.jinBiLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        self.jinBiLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.jinBiLable];

        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 52*BiLiWidth-1, WIDTH_PingMu, 1)];
        lineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [self addSubview:lineView];

    }
    return self;
}
-(void)initData:(NSDictionary *)info
{
    self.titleLable.text = [info objectForKey:@"type"];
    self.timeLable.text = [info objectForKey:@"create_at"];
    self.jinBiLable.text = [info objectForKey:@"coin"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
