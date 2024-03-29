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
        [self.contentView addSubview:self.dingDanBianHaoLable];
        
        UIButton * fuZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-86*BiLiWidth, self.dingDanBianHaoLable.top-4.5*BiLiWidth, 72*BiLiWidth, 24*BiLiWidth)];
        fuZhiButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [fuZhiButton setTitle:@"复制订单" forState:UIControlStateNormal];
        [fuZhiButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
        fuZhiButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
        fuZhiButton.layer.cornerRadius = 12*BiLiWidth;
        [fuZhiButton addTarget:self action:@selector(fuZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:fuZhiButton];

        
        self.typeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.dingDanBianHaoLable.left, self.dingDanBianHaoLable.top+self.dingDanBianHaoLable.height+15*BiLiWidth, 50*BiLiWidth, 14*BiLiWidth)];
        self.typeLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.typeLable.textColor = RGBFormUIColor(0x343434);
        [self.contentView addSubview:self.typeLable];
        

        self.jinELable = [[UILabel alloc] initWithFrame:CGRectMake(self.typeLable.left+self.typeLable.width+10*BiLiWidth, self.typeLable.top, 100*BiLiWidth, 14*BiLiWidth)];
        self.jinELable.textColor = RGBFormUIColor(0xFFA20A);
        self.jinELable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [self.contentView addSubview:self.jinELable];

        self.statusLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-98*BiLiWidth, self.jinELable.top, 98*BiLiWidth, 14*BiLiWidth)];
        self.statusLable.textColor = RGBFormUIColor(0xF43232);//F43232未支付  00BE00 已支付
        self.statusLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.statusLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.statusLable];
        
        self.timeLbale = [[UILabel alloc] initWithFrame:CGRectMake(self.typeLable.left, self.typeLable.top+self.typeLable.height+15*BiLiWidth, 200*BiLiWidth, 11*BiLiWidth)];
        self.timeLbale.textColor = RGBFormUIColor(0x9A9A9A);
        self.timeLbale.font = [UIFont systemFontOfSize:11*BiLiWidth];
        [self.contentView addSubview:self.timeLbale];

        self.lianXikeFuButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-86*BiLiWidth, self.statusLable.top+self.statusLable.height+7.5*BiLiWidth, 72*BiLiWidth, 24*BiLiWidth)];
        self.lianXikeFuButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [self.lianXikeFuButton setTitle:@"联系客服" forState:UIControlStateNormal];
        [self.lianXikeFuButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
        self.lianXikeFuButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.lianXikeFuButton.layer.cornerRadius = 12*BiLiWidth;
        [self.lianXikeFuButton addTarget:self action:@selector(liaXiJeFuButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.lianXikeFuButton];
        

        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 94.5*BiLiWidth-1, WIDTH_PingMu, 1)];
        lineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [self.contentView addSubview:lineView];

    }
    return self;
}
-(void)initData:(NSDictionary *)info
{
    self.info = info;
    
    self.dingDanBianHaoLable.text = [NSString stringWithFormat:@"订单号: %@",[info objectForKey:@"order_no"]];
    self.typeLable.text = [info objectForKey:@"pay_type"];
    self.jinELable.text = [info objectForKey:@"amount"];
    self.timeLbale.text = [info objectForKey:@"create_at"];
    self.statusLable.text = [info objectForKey:@"pay_text"];
    if ([@"充值成功" isEqualToString:[info objectForKey:@"pay_text"]]) {
        
        self.statusLable.textColor = RGBFormUIColor(0x00BE00);
    }
    else
    {
        self.statusLable.textColor = RGBFormUIColor(0xF43232);

    }
}
-(void)fuZhiButtonClick
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [self.info objectForKey:@"order_no"];
    
    [NormalUse showToastView:@"链接已复制" view:[NormalUse getCurrentVC].view];


}
-(void)liaXiJeFuButtonClick
{
    JinChanWebViewController * vc = [[JinChanWebViewController alloc] init];
    vc.forWhat = @"help";
    [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
