//
//  GouMaiJiLuCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GouMaiJiLuCell.h"

@implementation GouMaiJiLuCell

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

        self.qiShuLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu/4, 34.5*BiLiWidth)];
        self.qiShuLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.qiShuLable.textColor = RGBFormUIColor(0x666666);
        self.qiShuLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.qiShuLable];
        
        self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu/4, 0, WIDTH_PingMu/4, 34.5*BiLiWidth)];
        self.timeLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.timeLable.textColor = RGBFormUIColor(0x666666);
        self.timeLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.timeLable];

        
        self.duiJiangHaoMaLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu/4*2, 0, WIDTH_PingMu/4, 34.5*BiLiWidth)];
        self.duiJiangHaoMaLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.duiJiangHaoMaLable.textColor = RGBFormUIColor(0x666666);
        self.duiJiangHaoMaLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.duiJiangHaoMaLable];

        
        self.resultLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu/4*3, 0, WIDTH_PingMu/4, 34.5*BiLiWidth)];
        self.resultLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.resultLable.textColor = RGBFormUIColor(0x666666);
        self.resultLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.resultLable];


        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 34.5*BiLiWidth-1, WIDTH_PingMu, 1)];
        lineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [self.contentView addSubview:lineView];

    }
    return self;
}
-(void)initData:(NSDictionary *)info
{
    self.qiShuLable.text = [info objectForKey:@"period_title"];
    self.timeLable.text = [info objectForKey:@"draw_time"];
    NSNumber * ticket_code = [info objectForKey:@"ticket_code"];
    self.duiJiangHaoMaLable.text = [NSString stringWithFormat:@"%d",ticket_code.intValue];
    
    NSNumber * is_finish = [info objectForKey:@"is_finish"];
    if (is_finish.intValue==0) {
        
        self.resultLable.text = @"等待开奖";
        self.resultLable.textColor = RGBFormUIColor(0xFFA20A);
    }
    else
    {
        self.resultLable.text = @"已开奖";
        self.resultLable.textColor = RGBFormUIColor(0x666666);

    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
