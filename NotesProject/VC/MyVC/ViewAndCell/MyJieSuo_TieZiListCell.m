//
//  MyJieSuoListCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/11.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyJieSuo_TieZiListCell.h"

@implementation MyJieSuo_TieZiListCell

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

        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 0, 134*BiLiWidth, 144*BiLiWidth)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.layer.cornerRadius = 5*BiLiWidth;
        [self.contentView addSubview:self.headerImageView];
        
        self.guanFangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.headerImageView.width-6*171/42*BiLiWidth, 0, 16*171/42*BiLiWidth, 16*BiLiWidth)];
        self.guanFangImageView.image = [UIImage imageNamed:@"home_guanFangTip"];
        [self.headerImageView addSubview:self.guanFangImageView];
        self.guanFangImageView.hidden = YES;

        
        self.faBuYanZhengButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-72*BiLiWidth-14*BiLiWidth, self.headerImageView.top, 72*BiLiWidth, 24*BiLiWidth)];
        self.faBuYanZhengButton.layer.cornerRadius = 12*BiLiWidth;
        self.faBuYanZhengButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
        [self.faBuYanZhengButton addTarget:self action:@selector(faBuYanZhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.faBuYanZhengButton];
        
//        self.faBuTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width-65*BiLiWidth, 0, 65*BiLiWidth, 16*BiLiWidth)];
//        self.faBuTimeLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
//        self.faBuTimeLable.textColor = RGBFormUIColor(0xF6BC61);
//        self.faBuTimeLable.backgroundColor = RGBFormUIColor(0x333333);
//        self.faBuTimeLable.textAlignment = NSTextAlignmentCenter;
//        self.faBuTimeLable.adjustsFontSizeToFitWidth = YES;
//        [self.headerImageView addSubview:self.faBuTimeLable];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width+self.headerImageView.left+13.5*BiLiWidth, 0, WIDTH_PingMu-(self.headerImageView.width+self.headerImageView.left+13.5*BiLiWidth+90*BiLiWidth), 17*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x333333);
        [self.contentView addSubview:self.titleLable];
        
        self.leiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.top+self.titleLable.height+32*BiLiWidth, WIDTH_PingMu-(self.headerImageView.width+self.headerImageView.left+13.5*BiLiWidth+10*BiLiWidth), 11*BiLiWidth)];
        self.leiXingLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.leiXingLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.leiXingLable];
        
        self.diQuLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.leiXingLable.top+self.leiXingLable.height+10*BiLiWidth, self.leiXingLable.width, 11*BiLiWidth)];
        self.diQuLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.diQuLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.diQuLable];

        
        self.fuWuLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.diQuLable.top+self.diQuLable.height+10*BiLiWidth, self.leiXingLable.width, 11*BiLiWidth)];
        self.fuWuLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.fuWuLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.fuWuLable];

        self.pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.fuWuLable.top+self.fuWuLable.height+10*BiLiWidth, 51*BiLiWidth, 11*BiLiWidth)];
        self.pingFenLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.pingFenLable.textColor = RGBFormUIColor(0x999999);
        self.pingFenLable.text = @"综合评分: ";
        [self.contentView addSubview:self.pingFenLable];
        
        self.pingFenStarView = [[UIView alloc] initWithFrame:CGRectMake(self.pingFenLable.left+self.pingFenLable.width+3.5*BiLiWidth, self.pingFenLable.top-1*BiLiWidth, 72*BiLiWidth, 12*BiLiWidth)];
        [self.contentView addSubview:self.pingFenStarView];

        
        self.xiaoFeiLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.pingFenLable.top+self.pingFenLable.height+10*BiLiWidth, self.leiXingLable.width, 11*BiLiWidth)];
        self.xiaoFeiLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.xiaoFeiLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.xiaoFeiLable];



    }
    return self;
}
-(void)contentViewSetData:(NSDictionary *)info type_id:(NSString *)type_id
{
    self.info = info;
    self.type_id = type_id;
    if ([[info objectForKey:@"images"] isKindOfClass:[NSString class]]) {
        
       // [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"images"]]];
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"images"]] placeholderImage:[UIImage imageNamed:@"header_kong"]];

    }
    if ([[info objectForKey:@"images"] isKindOfClass:[NSArray class]])
    {
        NSArray * images = [info objectForKey:@"images"];
        if ([NormalUse isValidArray:images]) {
            
            //[self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]]];
            [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"header_kong"]];

        }
    }
    NSNumber * post_type = [info objectForKey:@"post_type"];//2会员贴 1 普通贴
    if (post_type.intValue==2) {
        
        NSNumber * auth_nomal = [info objectForKey:@"auth_nomal"];
        if ([auth_nomal isKindOfClass:[NSNumber class]]) {
            
            if (auth_nomal.intValue==1) {
                self.guanFangImageView.hidden = NO;
                
            }
            else
            {
                self.guanFangImageView.hidden = YES;
                
            }
        }
    }
    else
    {
        self.guanFangImageView.hidden = YES;

    }
    
    NSNumber * is_report = [info objectForKey:@"is_report"];
    if (is_report.intValue==0) {
        
        self.faBuYanZhengButton.layer.borderWidth = 1;
        self.faBuYanZhengButton.layer.borderColor = [RGBFormUIColor(0xFF0877) CGColor];
        [self.faBuYanZhengButton setTitleColor:RGBFormUIColor(0xFF0877) forState:UIControlStateNormal];
        [self.faBuYanZhengButton setTitle:@"发布验证" forState:UIControlStateNormal];
        
        self.faBuYanZhengButton.backgroundColor = [UIColor clearColor];
        
        self.faBuYanZhengButton.enabled = YES;
    }
    else
    {
        self.faBuYanZhengButton.layer.borderColor = [[UIColor clearColor] CGColor];
        [self.faBuYanZhengButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        [self.faBuYanZhengButton setTitle:@"已验证" forState:UIControlStateNormal];
        
        self.faBuYanZhengButton.backgroundColor = RGBFormUIColor(0xEEEEEE);

        self.faBuYanZhengButton.enabled = NO;
    }
    
        
    CGSize size = [NormalUse setSize:[info objectForKey:@"create_at"] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:10*BiLiWidth];
    self.faBuTimeLable.left = self.headerImageView.width-size.width-5*BiLiWidth;
    self.faBuTimeLable.width = size.width+5*BiLiWidth;
    self.faBuTimeLable.text = [info objectForKey:@"create_at"];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.faBuTimeLable.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(8*BiLiWidth, 0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.faBuTimeLable.bounds;
    maskLayer.path = maskPath.CGPath;
    self.faBuTimeLable.layer.mask = maskLayer;
        

    
    self.titleLable.text = [info objectForKey:@"title"] ;
    
    if([NormalUse isValidString:[info objectForKey:@"message_type"]])
    {
        self.leiXingLable.text = [NSString stringWithFormat:@"类型: %@",[info objectForKey:@"message_type"]];

    }
    self.diQuLable.text = [NSString stringWithFormat:@"所在地区: %@",[info objectForKey:@"city_name"]];
    self.fuWuLable.text = [NSString stringWithFormat:@"服务项目: %@",[info objectForKey:@"service_type"]];
        
    self.xiaoFeiLable.text = [NSString stringWithFormat:@"消费情况: %@",[info objectForKey:@"trade_money"]];
    
    
    [self.pingFenStarView removeAllSubviews];
    
    
    NSNumber * complex_score = [info objectForKey:@"complex_score"];
    if ([complex_score isKindOfClass:[NSNumber class]]) {
        
        for(int i=1;i<=5;i++)
        {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BiLiWidth*(i-1), 0, 12*BiLiWidth, 12*BiLiWidth)];
            [self.pingFenStarView addSubview:imageView];
            
            if (i<=complex_score.intValue) {
                
                imageView.image = [UIImage imageNamed:@"star_yellow"];

            }
            else
            {
                imageView.image = [UIImage imageNamed:@"star_hui"];

            }

        }
        
    }
    
    
    
}
-(void)faBuYanZhengButtonClick
{
    FaBuYanZhengViewController * vc = [[FaBuYanZhengViewController alloc] init];
    vc.type_id = self.type_id;
    NSNumber * post_id = [self.info objectForKey:@"id"];
    vc.post_id = [NSString stringWithFormat:@"%d",post_id.intValue];
    vc.delegate = self;
    [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];
}
-(void)faBuYanZhengSuccess
{
    self.faBuYanZhengButton.layer.borderColor = [[UIColor clearColor] CGColor];
    [self.faBuYanZhengButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    [self.faBuYanZhengButton setTitle:@"已验证" forState:UIControlStateNormal];
    self.faBuYanZhengButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
    self.faBuYanZhengButton.enabled = NO;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
