//
//  MyShouCangGuanZhu_ShouCangCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/15.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyShouCangGuanZhu_ShouCangCell.h"

@implementation MyShouCangGuanZhu_ShouCangCell

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
        
//        self.faBuYanZhengButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-72*BiLiWidth-14*BiLiWidth, self.headerImageView.top, 72*BiLiWidth, 24*BiLiWidth)];
//        self.faBuYanZhengButton.layer.cornerRadius = 12*BiLiWidth;
//        self.faBuYanZhengButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
//        [self.faBuYanZhengButton addTarget:self action:@selector(faBuYanZhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.faBuYanZhengButton];
        
        self.faBuTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width-65*BiLiWidth, 0, 65*BiLiWidth, 16*BiLiWidth)];
        self.faBuTimeLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        self.faBuTimeLable.textColor = RGBFormUIColor(0xF6BC61);
        self.faBuTimeLable.backgroundColor = RGBFormUIColor(0x333333);
        self.faBuTimeLable.textAlignment = NSTextAlignmentCenter;
        self.faBuTimeLable.adjustsFontSizeToFitWidth = YES;
        [self.headerImageView addSubview:self.faBuTimeLable];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width+self.headerImageView.left+13.5*BiLiWidth, 0, WIDTH_PingMu-(self.headerImageView.width+self.headerImageView.left+13.5*BiLiWidth+10*BiLiWidth), 15*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x333333);
        [self.contentView addSubview:self.titleLable];
        
        self.leiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.top+self.titleLable.height+27*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
        self.leiXingLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.leiXingLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.leiXingLable];
        
        self.diQuLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.leiXingLable.top+self.leiXingLable.height+6*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
        self.diQuLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.diQuLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.diQuLable];

        
        self.fuWuLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.diQuLable.top+self.diQuLable.height+6*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
        self.fuWuLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.fuWuLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.fuWuLable];

        self.pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.fuWuLable.top+self.fuWuLable.height+6*BiLiWidth, 51*BiLiWidth, 11*BiLiWidth)];
        self.pingFenLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.pingFenLable.textColor = RGBFormUIColor(0x999999);
        self.pingFenLable.text = @"综合评分: ";
        [self.contentView addSubview:self.pingFenLable];
        
        self.pingFenStarView = [[UIView alloc] initWithFrame:CGRectMake(self.pingFenLable.left+self.pingFenLable.width+3.5*BiLiWidth, self.pingFenLable.top-1*BiLiWidth, 72*BiLiWidth, 12*BiLiWidth)];
        [self.contentView addSubview:self.pingFenStarView];

        
        self.xiaoFeiLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.pingFenLable.top+self.pingFenLable.height+6*BiLiWidth, self.titleLable.width, 11*BiLiWidth)];
        self.xiaoFeiLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.xiaoFeiLable.textColor = RGBFormUIColor(0x999999);
        [self.contentView addSubview:self.xiaoFeiLable];

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
        [self.contentView addSubview:self.alsoDeleteButton];

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
        [self.delegate shouCangTianJiaToDelet:[NSString stringWithFormat:@"%d",post_id.intValue]];
    }
    else
    {
        self.alsoDeleteButton.tag = 0;
        self.alsoDeleteButton.button_imageView.layer.borderColor = [RGBFormUIColor(0x999999) CGColor];
        self.alsoDeleteButton.button_imageView1.backgroundColor = [UIColor clearColor];
        self.alsoDeleteButton.button_lable.textColor = RGBFormUIColor(0x999999);
        
        NSNumber * post_id = [self.info objectForKey:@"id"];
        [self.delegate shouCangTianJiaToDelet:[NSString stringWithFormat:@"%d",post_id.intValue]];

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

    if ([[info objectForKey:@"images"] isKindOfClass:[NSString class]]) {
        
//        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"images"]]];
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
    
//    if (1==1) {
//
//        self.faBuYanZhengButton.layer.borderWidth = 1;
//        self.faBuYanZhengButton.layer.borderColor = [RGBFormUIColor(0xFF0877) CGColor];
//        [self.faBuYanZhengButton setTitleColor:RGBFormUIColor(0xFF0877) forState:UIControlStateNormal];
//        [self.faBuYanZhengButton setTitle:@"发布验证" forState:UIControlStateNormal];
//
//        self.faBuYanZhengButton.backgroundColor = [UIColor clearColor];
//
//        self.faBuYanZhengButton.enabled = YES;
//    }
//    else
//    {
//        self.faBuYanZhengButton.layer.borderColor = [[UIColor clearColor] CGColor];
//        [self.faBuYanZhengButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
//        [self.faBuYanZhengButton setTitle:@"已验证" forState:UIControlStateNormal];
//
//        self.faBuYanZhengButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
//
//        self.faBuYanZhengButton.enabled = NO;
//    }
    
        
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
//-(void)faBuYanZhengButtonClick
//{
//    FaBuYanZhengViewController * vc = [[FaBuYanZhengViewController alloc] init];
//    NSNumber * post_id = [self.info objectForKey:@"id"];
//    vc.post_id = [NSString stringWithFormat:@"%d",post_id.intValue];
//    vc.delegate = self;
//    [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];
//}
//-(void)faBuYanZhengSuccess
//{
//    self.faBuYanZhengButton.layer.borderColor = [[UIColor clearColor] CGColor];
//    [self.faBuYanZhengButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
//    [self.faBuYanZhengButton setTitle:@"已验证" forState:UIControlStateNormal];
//    self.faBuYanZhengButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
//    self.faBuYanZhengButton.enabled = NO;
//
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
