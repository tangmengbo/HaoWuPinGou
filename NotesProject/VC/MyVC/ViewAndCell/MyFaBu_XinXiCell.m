//
//  MyFaBu_XinXiCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/15.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyFaBu_XinXiCell.h"

@implementation MyFaBu_XinXiCell

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
        
        self.faBuTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width-65*BiLiWidth, 0, 65*BiLiWidth, 16*BiLiWidth)];
        self.faBuTimeLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        self.faBuTimeLable.textColor = RGBFormUIColor(0xF6BC61);
        self.faBuTimeLable.backgroundColor = RGBFormUIColor(0x333333);
        self.faBuTimeLable.textAlignment = NSTextAlignmentCenter;
        self.faBuTimeLable.adjustsFontSizeToFitWidth = YES;
        [self.headerImageView addSubview:self.faBuTimeLable];
        
        self.guanFangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.headerImageView.width-16*171/42*BiLiWidth, 0, 16*171/42*BiLiWidth, 16*BiLiWidth)];
        self.guanFangImageView.image = [UIImage imageNamed:@"home_guanFangTip"];
        [self.headerImageView addSubview:self.guanFangImageView];
        self.guanFangImageView.hidden = YES;

        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width+self.headerImageView.left+13.5*BiLiWidth, 0, 190*BiLiWidth, 15*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x333333);
        [self.contentView addSubview:self.titleLable];
        
        self.statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-65*BiLiWidth, 0, 50*BiLiWidth, 50*BiLiWidth*60/150)];
        [self.contentView addSubview:self.statusImageView];
        
        self.leiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.top+self.titleLable.height+32*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
        self.leiXingLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.leiXingLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.leiXingLable];
        
        self.diQuLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.leiXingLable.top+self.leiXingLable.height+10*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
        self.diQuLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.diQuLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.diQuLable];

        
        self.fuWuLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.diQuLable.top+self.diQuLable.height+10*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
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

        
        self.xiaoFeiLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.pingFenLable.top+self.pingFenLable.height+10*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
        self.xiaoFeiLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.xiaoFeiLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.xiaoFeiLable];



    }
    return self;
}
-(void)contentViewSetData:(NSDictionary *)info
{
    if ([[info objectForKey:@"images"] isKindOfClass:[NSString class]]) {
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"images"]] placeholderImage:[UIImage imageNamed:@"header_kong"]];

    }
    if ([[info objectForKey:@"images"] isKindOfClass:[NSArray class]])
    {
        NSArray * images = [info objectForKey:@"images"];
        if ([NormalUse isValidArray:images]) {
            
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
            else{
                self.guanFangImageView.hidden = YES;
                
            }
        }
        
    }
    else
    {
        self.guanFangImageView.hidden = YES;

    }

        
    CGSize size = [NormalUse setSize:[info objectForKey:@"friendly_date"] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:10*BiLiWidth];
    self.faBuTimeLable.left = self.headerImageView.width-size.width-5*BiLiWidth;
    self.faBuTimeLable.width = size.width+5*BiLiWidth;
    self.faBuTimeLable.text = [info objectForKey:@"friendly_date"];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.faBuTimeLable.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(8*BiLiWidth, 0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.faBuTimeLable.bounds;
    maskLayer.path = maskPath.CGPath;
    self.faBuTimeLable.layer.mask = maskLayer;
        

    self.titleLable.text = [info objectForKey:@"title"] ;
    
    //1 已审核 0审核中 2已拒绝
    NSNumber * status = [info objectForKey:@"status"];
    if (status.intValue==0) {
        
        self.statusImageView.image = [UIImage imageNamed:@"shengHe_ing"];
    }
    else if (status.intValue==1)
    {
         self.statusImageView.image = [UIImage imageNamed:@"shengHe_success"];
    }
    else if (status.intValue==2)
    {
         self.statusImageView.image = [UIImage imageNamed:@"shengHe_fail"];
    }

    if (self.alsoYanZheng) {
        
        self.statusImageView.hidden = YES;
    }
    else
    {
        self.statusImageView.hidden = NO;
    }
    
    if ([NormalUse isValidString:[info objectForKey:@"message_type"]]) {
        
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
