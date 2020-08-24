//
//  HomeListCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/20.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HomeListCell.h"

@implementation HomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 0, 134*BiLiWidth, 144*BiLiWidth)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.layer.cornerRadius = 5*BiLiWidth;
        [self addSubview:self.headerImageView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.width+self.headerImageView.left+13.5*BiLiWidth, 0, WIDTH_PingMu-(self.headerImageView.width+self.headerImageView.left+13.5*BiLiWidth+10*BiLiWidth), 15*BiLiWidth)];
        self.titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        self.titleLable.textColor = RGBFormUIColor(0x333333);
        [self addSubview:self.titleLable];
        
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

        self.pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.fuWuLable.top+self.fuWuLable.height+6*BiLiWidth, 50*BiLiWidth, 11*BiLiWidth)];
        self.pingFenLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.pingFenLable.textColor = RGBFormUIColor(0x999999);
        self.pingFenLable.text = @"综合评分：";
        [self addSubview:self.pingFenLable];
        
        self.pingFenStarView = [[UIView alloc] initWithFrame:CGRectMake(self.pingFenLable.left+self.pingFenLable.width+7.5*BiLiWidth, self.pingFenLable.top-1*BiLiWidth, 72*BiLiWidth, 12*BiLiWidth)];
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
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597827992453&di=89f2d23d41e7e650adec139e15eb8688&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853"]];
    self.titleLable.text = @"深圳高质量兼职";
    self.leiXingLable.text = [NSString stringWithFormat:@"类型：%@",@"洗浴桑拿"];
    self.diQuLable.text = [NSString stringWithFormat:@"所在地区：%@",@"深圳市"];
    self.fuWuLable.text = [NSString stringWithFormat:@"服务项目：%@",@"洗澡、擦背、采耳等"];
    self.xiaoFeiLable.text = [NSString stringWithFormat:@"消费情况：%@",@"1200-2000"];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
