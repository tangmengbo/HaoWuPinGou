//
//  GaoDuanHomeCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/20.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GaoDuanHomeCell.h"

@implementation GaoDuanHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth, 21.5*BiLiWidth, 48*BiLiWidth, 48*BiLiWidth)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.layer.cornerRadius = 24*BiLiWidth;
        [self addSubview:self.headerImageView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width+self.headerImageView.left+15*BiLiWidth, 25*BiLiWidth, 170*BiLiWidth, 14*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x333333);
        [self addSubview:self.titleLable];
        
        self.starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.top+self.titleLable.height+13*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
        self.starImageView.image = [UIImage imageNamed:@""];
        [self addSubview:self.starImageView];
        
        self.starLable = [[UILabel alloc] initWithFrame:CGRectMake(self.starImageView.left+self.starImageView.width+5*BiLiWidth, self.starImageView.top, 19*BiLiWidth, 12*BiLiWidth)];
        self.starLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.starLable.textColor = RGBFormUIColor(0xF5BB61);
        [self addSubview:self.starLable];

        
        self.cityLable = [[UILabel alloc] initWithFrame:CGRectMake(self.starLable.left+self.starLable.width+12*BiLiWidth, self.starImageView.top, 60*BiLiWidth, 12*BiLiWidth)];
        self.cityLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.cityLable.textColor = RGBFormUIColor(0x999999);
        [self addSubview:self.cityLable];
        
        self.jinRuButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-72*BiLiWidth-12*BiLiWidth, 24*BiLiWidth, 72*BiLiWidth, 24*BiLiWidth)];
        self.jinRuButton.layer.cornerRadius = 12*BiLiWidth;
        self.jinRuButton.layer.borderWidth = 1;
        self.jinRuButton.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
        [self.jinRuButton setTitle:@"进店看看" forState:UIControlStateNormal];
        [self.jinRuButton setTitleColor:RGBFormUIColor(0xDDDDDD) forState:UIControlStateNormal];
        self.jinRuButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        [self addSubview:_jinRuButton];

        self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerImageView.top+self.headerImageView.height+18*BiLiWidth, WIDTH_PingMu, 132*BiLiWidth)];
        [self addSubview:self.contentScrollView];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentScrollView.top+self.contentScrollView.height+48*BiLiWidth, WIDTH_PingMu, 8*BiLiWidth)];
        self.lineView.backgroundColor = RGBFormUIColor(0xEDEDED);
        [self addSubview:self.lineView];
        


    }
    return self;
}
-(void)contentViewSetData:(NSDictionary *)info
{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597827992453&di=89f2d23d41e7e650adec139e15eb8688&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853"]];
    self.titleLable.text = @"深圳高质量兼职";
    self.starImageView.backgroundColor = [UIColor redColor];
    self.starLable.text = @"4.6";
    self.cityLable.text = @"深圳市";
    
    [self.contentScrollView removeAllSubviews];
    
    int number = arc4random()%3+1;
    for (int i=0; i<number; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth+113*BiLiWidth*i, 0, 109*BiLiWidth, 131*BiLiWidth)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingNone;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 5*BiLiWidth;
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597827992453&di=89f2d23d41e7e650adec139e15eb8688&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853"]];
        [self.contentScrollView addSubview:imageView];
        
        [self.contentScrollView setContentSize:CGSizeMake(imageView.left+imageView.width+12*BiLiWidth, self.contentScrollView.height)];

    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
