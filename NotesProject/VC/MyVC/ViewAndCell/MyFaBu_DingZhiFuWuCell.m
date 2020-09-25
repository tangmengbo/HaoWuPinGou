//
//  MyFaBu_DingZhiFuWuCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/15.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyFaBu_DingZhiFuWuCell.h"

@implementation MyFaBu_DingZhiFuWuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentMessageView = [[UIView alloc] initWithFrame:CGRectMake(19*BiLiWidth, 0, WIDTH_PingMu-38*BiLiWidth, 205*BiLiWidth)];
        self.contentMessageView.layer.borderWidth = 1;
        self.contentMessageView.layer.borderColor = [RGBFormUIColor(0xEEEEEE) CGColor];
        self.contentMessageView.layer.cornerRadius = 5*BiLiWidth;
        self.contentMessageView.layer.masksToBounds = NO;
        self.contentMessageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentMessageView];
        self.contentMessageView.layer.shadowOpacity = 0.2f;
        self.contentMessageView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.contentMessageView.layer.shadowOffset = CGSizeMake(0, 3);//CGSizeZero; //设置偏移量为0,四周都有阴影

        self.priceLable = [[UILabel alloc] initWithFrame:CGRectMake(21.5*BiLiWidth, 18*BiLiWidth, 300*BiLiWidth, 14*BiLiWidth)];
        self.priceLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.priceLable.textColor = RGBFormUIColor(0xFFA217);
        [self.contentMessageView addSubview:self.priceLable];

        
        
        self.weiZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(self.contentMessageView.width-115*BiLiWidth, 17*BiLiWidth, 100*BiLiWidth, 12*BiLiWidth)];
        self.weiZhiLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.weiZhiLable.textColor = RGBFormUIColor(0x999999);
        [self.contentMessageView addSubview:self.weiZhiLable];
        
        self.neiRongView = [[UIView alloc] initWithFrame:CGRectMake(21.5*BiLiWidth, self.priceLable.top+self.priceLable.height+11*BiLiWidth, self.contentMessageView.width-21.5*BiLiWidth*2, 0)];
        self.neiRongView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [self.contentMessageView addSubview:self.neiRongView];

        self.dingZhiNeiRongLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, 9*BiLiWidth, self.neiRongView.width-26*BiLiWidth, 0*BiLiWidth)];
        self.dingZhiNeiRongLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.dingZhiNeiRongLable.textColor = RGBFormUIColor(0x666666);
        [self.neiRongView addSubview:self.dingZhiNeiRongLable];

        
        self.dingZhiTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, self.dingZhiNeiRongLable.top+self.dingZhiNeiRongLable.height+9*BiLiWidth, self.dingZhiNeiRongLable.width, 13*BiLiWidth)];
        self.dingZhiTimeLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.dingZhiTimeLable.textColor = RGBFormUIColor(0x666666);
        [self.neiRongView addSubview:self.dingZhiTimeLable];

        
        self.leiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, self.dingZhiTimeLable.height+self.dingZhiTimeLable.height+9*BiLiWidth, self.dingZhiNeiRongLable.width, 13*BiLiWidth)];
        self.leiXingLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.leiXingLable.textColor = RGBFormUIColor(0x666666);
        [self.neiRongView addSubview:self.leiXingLable];
        
        self.fuWuXiangMuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, self.leiXingLable.top+self.leiXingLable.height+9*BiLiWidth, self.dingZhiNeiRongLable.width, 13*BiLiWidth)];
        self.fuWuXiangMuLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.fuWuXiangMuLable.textColor = RGBFormUIColor(0x666666);
        [self.neiRongView addSubview:self.fuWuXiangMuLable];
        
        
        self.createTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, self.fuWuXiangMuLable.top+self.fuWuXiangMuLable.height+9*BiLiWidth, self.dingZhiNeiRongLable.width, 13*BiLiWidth)];
        self.createTimeLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.createTimeLable.textColor = RGBFormUIColor(0x666666);
        [self.neiRongView addSubview:self.createTimeLable];

        

        self.statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentMessageView.width-71*BiLiWidth, self.neiRongView.top+self.neiRongView.height+17.5*BiLiWidth, 50*BiLiWidth, 50*BiLiWidth*60/150)];
        [self.contentMessageView addSubview:self.statusImageView];

    }
    return self;
}
-(void)contentViewSetData:(NSDictionary *)info
{
    
    self.priceLable.text = [NSString stringWithFormat:@"¥%@~¥%@",[info objectForKey:@"min_price"],[info objectForKey:@"max_price"]];

    self.weiZhiLable.text = [NormalUse getobjectForKey:[info objectForKey:@"city_name"]];
    
    NSString * neiRongStr = [info objectForKey:@"describe"];
    if (![NormalUse isValidString:neiRongStr]) {
        
        neiRongStr = @"无特殊需求";
    }

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    self.dingZhiNeiRongLable.attributedText = attributedString;
    //设置自适应
    [self.dingZhiNeiRongLable  sizeToFit];
    
    NSString * start_date = [info objectForKey:@"start_date"];
    
    NSDateFormatter* dateFormatOld = [[NSDateFormatter alloc] init];
    [dateFormatOld setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * startDate =[dateFormatOld dateFromString:start_date];
    
    NSDateFormatter* dateFormatNew = [[NSDateFormatter alloc] init];
    [dateFormatNew setDateFormat:@"MM/dd"];
    start_date = [dateFormatNew stringFromDate:startDate];
    
    NSString * end_date = [info objectForKey:@"end_date"];
    NSDate *  endDate = [dateFormatOld dateFromString:end_date];
    end_date = [dateFormatNew stringFromDate:endDate];


    
    self.dingZhiTimeLable.text = [NSString stringWithFormat:@"预定时间：%@ - %@",start_date,end_date];
    self.leiXingLable.text = [NSString stringWithFormat:@"妹子类型：%@",[info objectForKey:@"love_type"]];
    self.fuWuXiangMuLable.text = [NSString stringWithFormat:@"服务项目：%@",[info objectForKey:@"service_type"]];
    self.createTimeLable.text = [NSString stringWithFormat:@"发布时间：%@",[info objectForKey:@"create_at"]];
    
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

    
    self.dingZhiTimeLable.top = self.dingZhiNeiRongLable.top+self.dingZhiNeiRongLable.height+9*BiLiWidth;

    self.leiXingLable.top = self.dingZhiTimeLable.top+self.dingZhiTimeLable.height+9*BiLiWidth;
    
    self.fuWuXiangMuLable.top = self.leiXingLable.top+self.leiXingLable.height+9*BiLiWidth;
    
    self.createTimeLable.top = self.fuWuXiangMuLable.top+self.fuWuXiangMuLable.height+9*BiLiWidth;
    
    self.neiRongView.height = self.createTimeLable.top+self.createTimeLable.height+9*BiLiWidth;
    
    self.statusImageView.top = self.neiRongView.top+self.neiRongView.height+17.5*BiLiWidth;
    
    self.contentMessageView.height = self.neiRongView.top+self.neiRongView.height+53*BiLiWidth;
    
    
}
+(float)cellHegiht:(NSDictionary *)info
{
    
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, 9*BiLiWidth,250*BiLiWidth, 12*BiLiWidth)];
    lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    lable.numberOfLines = 0;

    NSString * neiRongStr = [info objectForKey:@"description"];
    if (![NormalUse isValidString:neiRongStr]) {
        
        neiRongStr = @"无特殊需求";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    lable.attributedText = attributedString;
    //设置自适应
    [lable  sizeToFit];
    
    return lable.height+55*BiLiWidth+148*BiLiWidth+21*BiLiWidth;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
