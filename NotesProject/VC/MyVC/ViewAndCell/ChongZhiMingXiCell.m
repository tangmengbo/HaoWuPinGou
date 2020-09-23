//
//  ChongZhiMingXiCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "ChongZhiMingXiCell.h"

@implementation ChongZhiMingXiCell

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

        
        
        self.dingDanBianHaoLable = [[UILabel alloc] initWithFrame:CGRectMake(20*BiLiWidth, 15*BiLiWidth, WIDTH_PingMu-40*BiLiWidth, 15*BiLiWidth)];
        self.dingDanBianHaoLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.dingDanBianHaoLable.textColor = RGBFormUIColor(0x9A9A9A);
        [self addSubview:self.dingDanBianHaoLable];
        
        self.typeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.dingDanBianHaoLable.left, self.dingDanBianHaoLable.top+self.dingDanBianHaoLable.height+15*BiLiWidth, 40*BiLiWidth, 14*BiLiWidth)];
        self.typeLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.typeLable.textColor = RGBFormUIColor(0x343434);
        [self addSubview:self.typeLable];
        

        self.jinELable = [[UILabel alloc] initWithFrame:CGRectMake(self.typeLable.left+self.typeLable.width+10*BiLiWidth, self.typeLable.top, 100*BiLiWidth, 14*BiLiWidth)];
        self.jinELable.textColor = RGBFormUIColor(0xFFA20A);
        self.jinELable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [self addSubview:self.jinELable];

        self.statusLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-98*BiLiWidth, self.jinELable.top, 98*BiLiWidth, 14*BiLiWidth)];
        self.statusLable.textColor = RGBFormUIColor(0xF43232);//F43232未支付  00BE00 已支付
        self.statusLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.statusLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.statusLable];
        
        self.timeLbale = [[UILabel alloc] initWithFrame:CGRectMake(self.typeLable.left, self.typeLable.top+self.typeLable.height+15*BiLiWidth, 200*BiLiWidth, 11*BiLiWidth)];
        self.statusLable.textColor = RGBFormUIColor(0x9A9A9A);
        self.statusLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        [self addSubview:self.statusLable];

        self.lianXikeFuButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-86*BiLiWidth, self.statusLable.top+self.statusLable.height+7.5*BiLiWidth, 72*BiLiWidth, 24*BiLiWidth)];
        self.lianXikeFuButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [self.lianXikeFuButton setTitle:@"联系客服" forState:UIControlStateNormal];
        [self.lianXikeFuButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
        self.lianXikeFuButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.lianXikeFuButton.layer.cornerRadius = 12*BiLiWidth;
        [self addSubview:self.lianXikeFuButton];
        

        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 94.5*BiLiWidth-1, WIDTH_PingMu, 1)];
        lineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [self addSubview:lineView];

    }
    return self;
}
-(void)initData:(NSDictionary *)info
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
