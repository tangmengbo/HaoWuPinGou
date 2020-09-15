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
        [self addSubview:self.headerImageView];
        
        self.faBuTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width-65*BiLiWidth, 0, 65*BiLiWidth, 16*BiLiWidth)];
        self.faBuTimeLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        self.faBuTimeLable.textColor = RGBFormUIColor(0xF6BC61);
        self.faBuTimeLable.backgroundColor = RGBFormUIColor(0x333333);
        self.faBuTimeLable.textAlignment = NSTextAlignmentCenter;
        self.faBuTimeLable.adjustsFontSizeToFitWidth = YES;
        [self.headerImageView addSubview:self.faBuTimeLable];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width+self.headerImageView.left+13.5*BiLiWidth, 0, 190*BiLiWidth, 15*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x333333);
        [self addSubview:self.titleLable];
        
        self.statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-65*BiLiWidth, 0, 50*BiLiWidth, 17*BiLiWidth)];
        [self addSubview:self.statusImageView];
        
        self.leiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.top+self.titleLable.height+27*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
        self.leiXingLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.leiXingLable.textColor = RGBFormUIColor(0x999999);
        [self addSubview:self.leiXingLable];
        
        self.diQuLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.leiXingLable.top+self.leiXingLable.height+6*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
        self.diQuLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.diQuLable.textColor = RGBFormUIColor(0x999999);
        [self addSubview:self.diQuLable];

        
        self.fuWuLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.diQuLable.top+self.diQuLable.height+6*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
        self.fuWuLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.fuWuLable.textColor = RGBFormUIColor(0x999999);
        [self addSubview:self.fuWuLable];

        self.pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.fuWuLable.top+self.fuWuLable.height+6*BiLiWidth, 51*BiLiWidth, 11*BiLiWidth)];
        self.pingFenLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.pingFenLable.textColor = RGBFormUIColor(0x999999);
        self.pingFenLable.text = @"综合评分: ";
        [self addSubview:self.pingFenLable];
        
        self.pingFenStarView = [[UIView alloc] initWithFrame:CGRectMake(self.pingFenLable.left+self.pingFenLable.width+3.5*BiLiWidth, self.pingFenLable.top-1*BiLiWidth, 72*BiLiWidth, 12*BiLiWidth)];
        [self addSubview:self.pingFenStarView];

        
        self.xiaoFeiLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.pingFenLable.top+self.pingFenLable.height+6*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
        self.xiaoFeiLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.xiaoFeiLable.textColor = RGBFormUIColor(0x999999);
        [self addSubview:self.xiaoFeiLable];



    }
    return self;
}
-(void)contentViewSetData:(NSDictionary *)info
{
    if ([[info objectForKey:@"images"] isKindOfClass:[NSString class]]) {
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"images"]]];
        
    }
    if ([[info objectForKey:@"images"] isKindOfClass:[NSArray class]])
    {
        NSArray * images = [info objectForKey:@"images"];
        if ([NormalUse isValidArray:images]) {
            
            [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]]];

        }
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
    
    //1 已审核 0审核中 2已拒绝
    NSNumber * status = [info objectForKey:@"status"];
    if (status.intValue==0) {
        
        self.statusImageView.backgroundColor = [UIColor yellowColor];
    }
    else if (status.intValue==1)
    {
         self.statusImageView.backgroundColor = [UIColor greenColor];
    }
    else if (status.intValue==2)
    {
         self.statusImageView.backgroundColor = [UIColor redColor];
    }

    
    self.leiXingLable.text = [NSString stringWithFormat:@"类型: %@",[info objectForKey:@"message_type"]];
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
