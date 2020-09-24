//
//  CheYouPingJiaCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/31.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "CheYouPingJiaCell.h"

@implementation CheYouPingJiaCell

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
        self.selectedBackgroundView.backgroundColor = RGBFormUIColor(0xF4F4F4);

        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13*BiLiWidth, 0, 48*BiLiWidth, 48*BiLiWidth)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.layer.cornerRadius = 24*BiLiWidth;
        [self addSubview:self.headerImageView];
        
        self.nickLable = [[UILabel alloc] initWithFrame:CGRectMake(74.5*BiLiWidth, 6.5*BiLiWidth, 200*BiLiWidth, 14*BiLiWidth)];
        self.nickLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.nickLable.textColor = RGBFormUIColor(0x343434);
        self.nickLable.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.nickLable];
        
        self.tiYanTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.nickLable.left, self.nickLable.top+self.nickLable.height+10*BiLiWidth, 200*BiLiWidth, 11*BiLiWidth)];
        self.tiYanTimeLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.tiYanTimeLable.textColor = RGBFormUIColor(0x9A9A9A);
        [self addSubview:self.tiYanTimeLable];
        
        self.toolButton = [[UIButton alloc] initWithFrame:CGRectMake(291*BiLiWidth,9.5,55.5*BiLiWidth,42*BiLiWidth)];
        [self.toolButton setBackgroundImage:[UIImage imageNamed:@"yiYanZheng"] forState:UIControlStateNormal];
        [self addSubview:self.toolButton];

        
        self.pingFenTipLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.left, self.headerImageView.top+self.headerImageView.height+20.5*BiLiWidth, 45*BiLiWidth, 11*BiLiWidth)];
        self.pingFenTipLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.pingFenTipLable.textColor = RGBFormUIColor(0x9A9A9A);
        self.pingFenTipLable.text = @"综合评分";
        [self addSubview:self.pingFenTipLable];
        
        self.pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(self.pingFenTipLable.left+self.pingFenTipLable.width+12*BiLiWidth, self.headerImageView.top+self.headerImageView.height+17.5*BiLiWidth, 30*BiLiWidth, 18*BiLiWidth)];
        self.pingFenLable.font = [UIFont systemFontOfSize:18*BiLiWidth];
        self.pingFenLable.textColor = RGBFormUIColor(0x343434);
        [self addSubview:self.pingFenLable];

        
        self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.pingFenTipLable.top+self.pingFenTipLable.height+16*BiLiWidth, WIDTH_PingMu, 90*BiLiWidth)];
        [self addSubview:self.contentScrollView];

//        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, self.pingFenTipLable.top+self.pingFenTipLable.height+16*BiLiWidth, 76.8*BiLiWidth, 90*BiLiWidth)];
//        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
//        self.imageView1.autoresizingMask = UIViewAutoresizingNone;
//        self.imageView1.clipsToBounds = YES;
//        self.imageView1.layer.cornerRadius = 8*BiLiWidth;
//        [self addSubview:self.imageView1];
//
//        self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.imageView1.left+self.imageView1.width+6.5*BiLiWidth, self.pingFenTipLable.top+self.pingFenTipLable.height+16*BiLiWidth, 76.8*BiLiWidth, 90*BiLiWidth)];
//        self.imageView2.contentMode = UIViewContentModeScaleAspectFill;
//        self.imageView2.autoresizingMask = UIViewAutoresizingNone;
//        self.imageView2.clipsToBounds = YES;
//        self.imageView2.layer.cornerRadius = 8*BiLiWidth;
//        [self addSubview:self.imageView2];
//
//
//        self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(self.imageView2.left+self.imageView2.width+6.5*BiLiWidth, self.pingFenTipLable.top+self.pingFenTipLable.height+16*BiLiWidth, 76.8*BiLiWidth, 90*BiLiWidth)];
//        self.imageView3.contentMode = UIViewContentModeScaleAspectFill;
//        self.imageView3.autoresizingMask = UIViewAutoresizingNone;
//        self.imageView3.clipsToBounds = YES;
//        self.imageView3.layer.cornerRadius = 8*BiLiWidth;
//        [self addSubview:self.imageView3];
//
//
//        self.imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(self.imageView3.left+self.imageView3.width+6.5*BiLiWidth, self.pingFenTipLable.top+self.pingFenTipLable.height+16*BiLiWidth, 76.8*BiLiWidth, 90*BiLiWidth)];
//        self.imageView4.contentMode = UIViewContentModeScaleAspectFill;
//        self.imageView4.autoresizingMask = UIViewAutoresizingNone;
//        self.imageView4.clipsToBounds = YES;
//        self.imageView4.layer.cornerRadius = 8*BiLiWidth;
//        [self addSubview:self.imageView4];

        
        self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(14*BiLiWidth, self.contentScrollView.top+self.contentScrollView.height+18.5*BiLiWidth, WIDTH_PingMu-28*BiLiWidth, 11*BiLiWidth)];
        self.messageLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.messageLable.textColor = RGBFormUIColor(0x343434);
        self.messageLable.numberOfLines = 0;
        [self addSubview:self.messageLable];


    }
    return self;
}

-(void)initContentView:(NSDictionary *)info
{
    self.info = info;
    
    if ([NormalUse isValidString:[info objectForKey:@"avatar"]]) {
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"avatar"]]];

    }

    self.nickLable.text = [info objectForKey:@"nickname"];
    self.tiYanTimeLable.text = [NSString stringWithFormat:@"体验时间：%@",[info objectForKey:@"create_at"]];
    NSNumber * avg_value = [info objectForKey:@"avg_value"];
    self.pingFenLable.text = [NSString stringWithFormat:@"%.1f",avg_value.floatValue];
    
    NSArray * array = [info objectForKey:@"images"];
    if ([NormalUse isValidArray:array]) {
        
        self.contentScrollView.hidden = NO;
        for (int i=0; i<array.count; i++) {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth+(76.8*BiLiWidth+6.5*BiLiWidth)*i, 0, 76.8*BiLiWidth, 90*BiLiWidth)];
            imageView.tag = i;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.clipsToBounds = YES;
            imageView.layer.cornerRadius = 8*BiLiWidth;
            imageView.userInteractionEnabled = YES;
            [imageView sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:i]]];
            [self.contentScrollView addSubview:imageView];

            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            [imageView addGestureRecognizer:tap];
            
            [self.contentScrollView setContentSize:CGSizeMake(imageView.left+imageView.width+11.5*BiLiWidth, self.contentScrollView.height)];

        }

    }
    else
    {
        self.contentScrollView.hidden = YES;
    }

    
//    if ([[info objectForKey:@"images"] isKindOfClass:[NSString class]]) {
//
//        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"images"]]];
//        self.imageView2.hidden = YES;
//        self.imageView3.hidden = YES;
//        self.imageView4.hidden = YES;
//    }
//    else
//    {
//        NSArray * array = [info objectForKey:@"images"];
//        for (int i=0; i<array.count; i++) {
//
//            if (i==0) {
//
//                [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:i]]];
//                self.imageView1.hidden = NO;
//
//            }
//            else if (i==1)
//            {
//                [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:i]]];
//                self.imageView2.hidden = NO;
//
//            }
//            else if (i==2)
//            {
//                [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:i]]];
//                self.imageView3.hidden = NO;
//
//            }
//            else if (i==3)
//            {
//                [self.imageView4 sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:i]]];
//                self.imageView4.hidden = NO;
//
//                break;
//            }
//        }
//    }
    self.messageLable.width = WIDTH_PingMu-28*BiLiWidth;
    NSString * neiRongStr = [NormalUse getobjectForKey:[info objectForKey:@"decription"]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    self.messageLable.attributedText = attributedString;
    //设置自适应
    [self.messageLable  sizeToFit];

    
}
-(void)imageTap:(UITapGestureRecognizer *)tap
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate yinCangTabbar];
    
    UIImageView * imageView = (UIImageView *)tap.view;
    NSArray * array = [self.info objectForKey:@"images"];

    NSMutableArray * photos = [NSMutableArray array];
    for (NSString * path in array) {
        
        MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:path]];
        [photos addObject:photo];

    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser setCurrentPhotoIndex:imageView.tag];
    [[NormalUse getCurrentVC].navigationController pushViewController:browser animated:YES];

}
+(float)cellHegiht:(NSDictionary *)info;
{
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(14*BiLiWidth, 156*BiLiWidth+48*BiLiWidth, WIDTH_PingMu-28*BiLiWidth, 0)];
    lable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    lable.numberOfLines = 0;

    NSString * neiRongStr = [NormalUse getobjectForKey:[info objectForKey:@"decription"]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    lable.attributedText = attributedString;
    //设置自适应
    [lable  sizeToFit];
    
    return lable.height+lable.top+23*BiLiWidth;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
