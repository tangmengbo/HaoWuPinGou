//
//  JingCaiFuLiViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "JingCaiFuLiViewController.h"

@interface JingCaiFuLiViewController ()

@property(nonatomic,strong)NSDictionary * messageInfo;

@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)UILabel * jinBiLable;
@property(nonatomic,strong)UILabel * danWeiLable;
@property(nonatomic,strong)UILabel * daoJiShiLable;

@property(nonatomic,strong)UILabel * numberLable;
@property(nonatomic,strong)UIButton * jinBiGouMaiButton;

@end

@implementation JingCaiFuLiViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self xianShiTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    number = 1;
    [HTTPModel getHuoDongHomeInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.messageInfo = responseObject;
            
            NSNumber * base_coinNumber = [self.messageInfo objectForKey:@"base_coin"];
            NSString * base_coinStr = [NSString stringWithFormat:@"%d",base_coinNumber.intValue];
            
            CGSize size = [NormalUse setSize:base_coinStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:22*BiLiWidth];
            self.jinBiLable.left = (WIDTH_PingMu-size.width)/2;
            self.jinBiLable.width = size.width;
            self.jinBiLable.text = base_coinStr;
            self.danWeiLable.left = self.jinBiLable.left+self.jinBiLable.width+12*BiLiWidth;
            //当前时间
            NSString *timeSpNow = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970])];
            NSNumber * draw_time = [self.messageInfo objectForKey:@"draw_time"];//开奖时间
            NSTimeInterval timeSpNowInt = [timeSpNow doubleValue];
            NSTimeInterval timeSpInt = [draw_time doubleValue];
            
            self->shengYuTime = (int)difftime(timeSpInt, timeSpNowInt);
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRecord) userInfo:nil repeats:YES];

        }
    }];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu-BottomHeight_PingMu)];
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu*767/360)];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
    }
    [self.view addSubview:self.mainScrollView];
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, WIDTH_PingMu*767/360)];
    bottomImageView.image = [UIImage imageNamed:@"fuLi_bg"];
    bottomImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:bottomImageView];
    
    self.topNavView.backgroundColor = [UIColor clearColor];
    self.lineView.hidden = YES;
    self.backImageView.hidden = YES;
    [bottomImageView addSubview:self.topNavView];

    self.topTitleLale.text = @"精彩福利";
    self.topTitleLale.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.topTitleLale.textColor = RGBFormUIColor(0xFFFFFF);
    
    
    Lable_ImageButton * kaiJiangJiLuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-11.5*BiLiWidth-69.5*BiLiWidth, 0, 69*BiLiWidth, self.topNavView.height)];
    kaiJiangJiLuButton.button_imageView.frame = CGRectMake(0, (kaiJiangJiLuButton.height-14*BiLiWidth)/2, 14*BiLiWidth, 14*BiLiWidth);
    kaiJiangJiLuButton.button_imageView.backgroundColor = [UIColor redColor];
    kaiJiangJiLuButton.button_lable.frame = CGRectMake(kaiJiangJiLuButton.button_imageView.left+kaiJiangJiLuButton.button_imageView.width+5*BiLiWidth, 0, 50*BiLiWidth, kaiJiangJiLuButton.height);
    kaiJiangJiLuButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    kaiJiangJiLuButton.button_lable.textColor = RGBFormUIColor(0xFFFFFF);
    kaiJiangJiLuButton.button_lable.text = @"开奖记录";
    [kaiJiangJiLuButton addTarget:self action:@selector(kaiJiangListButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topNavView addSubview:kaiJiangJiLuButton];


    
    UILabel * jiangJinTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+28*BiLiWidth, WIDTH_PingMu, 12*BiLiWidth)];
    jiangJinTipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    jiangJinTipLable.textAlignment = NSTextAlignmentCenter;
    jiangJinTipLable.textColor = RGBFormUIColor(0x333333);
    jiangJinTipLable.text = @"奖金累积";
    [bottomImageView addSubview:jiangJinTipLable];
    
    CGSize size = [NormalUse setSize:@"0" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:22*BiLiWidth];
    self.jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH_PingMu-size.width)/2, jiangJinTipLable.top+jiangJinTipLable.height+15*BiLiWidth, size.width, 22*BiLiWidth)];
    self.jinBiLable.textColor = RGBFormUIColor(0xFFA217);
    self.jinBiLable.font = [UIFont systemFontOfSize:22*BiLiWidth];
    [bottomImageView addSubview:self.jinBiLable];
    
    self.danWeiLable = [[UILabel alloc] initWithFrame:CGRectMake(self.jinBiLable.left+self.jinBiLable.width+12*BiLiWidth, self.jinBiLable.top+6*BiLiWidth, 50, 13*BiLiWidth)];
    self.danWeiLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.danWeiLable.textColor = RGBFormUIColor(0x333333);
    self.danWeiLable.text = @"金币";
    [bottomImageView addSubview:self.danWeiLable];
    
    self.daoJiShiLable = [[UILabel alloc] initWithFrame:CGRectMake(26.5*BiLiWidth, self.jinBiLable.top+self.jinBiLable.height+21*BiLiWidth, 250*BiLiWidth, 11*BiLiWidth)];
    self.daoJiShiLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    self.daoJiShiLable.textColor = RGBFormUIColor(0x999999);
    [bottomImageView addSubview:self.daoJiShiLable];

    
    UIView * controlView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-171.5*BiLiWidth-137*BiLiWidth)/2, self.daoJiShiLable.top+self.daoJiShiLable.height+5.5*BiLiWidth, 171.5*BiLiWidth+137*BiLiWidth, 40*BiLiWidth)];
    controlView.layer.cornerRadius = 5*BiLiWidth;
    controlView.layer.masksToBounds = YES;
    controlView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [bottomImageView addSubview:controlView];
    
    UIButton * jianButton = [[UIButton alloc] initWithFrame:CGRectMake(17*BiLiWidth, 10*BiLiWidth, 20*BiLiWidth, 20*BiLiWidth)];
    jianButton.backgroundColor = [UIColor redColor];
    [jianButton addTarget:self action:@selector(jianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:jianButton];
    
    self.numberLable = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, 0, 97.5*BiLiWidth, controlView.height)];
    self.numberLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.numberLable.textColor = RGBFormUIColor(0xFFA217);
    self.numberLable.textAlignment = NSTextAlignmentCenter;
    self.numberLable.text = @"1";
    [controlView addSubview:self.numberLable];
    
    UIButton * jiaButton = [[UIButton alloc] initWithFrame:CGRectMake(self.numberLable.left+self.numberLable.width, 10*BiLiWidth, 20*BiLiWidth, 20*BiLiWidth)];
    jiaButton.backgroundColor = [UIColor redColor];
    [jiaButton addTarget:self action:@selector(jiaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:jiaButton];

    self.jinBiGouMaiButton = [[UIButton alloc] initWithFrame:CGRectMake(171.5*BiLiWidth, 0, 137*BiLiWidth, 40*BiLiWidth)];
    self.jinBiGouMaiButton.backgroundColor = RGBFormUIColor(0x333333);
    [self.jinBiGouMaiButton setTitleColor:RGBFormUIColor(0xFFFFFF) forState:UIControlStateNormal];
    [self.jinBiGouMaiButton setTitle:@"50金币购买" forState:UIControlStateNormal];
    self.jinBiGouMaiButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.jinBiGouMaiButton addTarget:self action:@selector(jinBiGouMaiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:self.jinBiGouMaiButton];
    
    
    Lable_ImageButton * shuoMingButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(23*BiLiWidth, controlView.top+controlView.height+42*BiLiWidth, 69*BiLiWidth, 14*BiLiWidth)];
    shuoMingButton.button_imageView.frame = CGRectMake(0, 0, 14*BiLiWidth, 14*BiLiWidth);
    shuoMingButton.button_imageView.backgroundColor = [UIColor redColor];
    shuoMingButton.button_lable.frame = CGRectMake(shuoMingButton.button_imageView.left+shuoMingButton.button_imageView.width+5*BiLiWidth, shuoMingButton.button_imageView.top, 50*BiLiWidth, 14*BiLiWidth);
    shuoMingButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    shuoMingButton.button_lable.textColor = RGBFormUIColor(0xFFFFFF);
    shuoMingButton.button_lable.text = @"规则说明";
    [shuoMingButton addTarget:self action:@selector(shuoMingButton) forControlEvents:UIControlEventTouchUpInside];
    [bottomImageView addSubview:shuoMingButton];
    
    
    Lable_ImageButton * gouMaiJiLuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(271*BiLiWidth, controlView.top+controlView.height+42*BiLiWidth, 69*BiLiWidth, 14*BiLiWidth)];
    gouMaiJiLuButton.button_imageView.frame = CGRectMake(0, 0, 14*BiLiWidth, 14*BiLiWidth);
    gouMaiJiLuButton.button_imageView.backgroundColor = [UIColor redColor];
    gouMaiJiLuButton.button_lable.frame = CGRectMake(shuoMingButton.button_imageView.left+shuoMingButton.button_imageView.width+5*BiLiWidth, shuoMingButton.button_imageView.top, 50*BiLiWidth, 14*BiLiWidth);
    gouMaiJiLuButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    gouMaiJiLuButton.button_lable.textColor = RGBFormUIColor(0xFFFFFF);
    gouMaiJiLuButton.button_lable.text = @"购买记录";
    [bottomImageView addSubview:gouMaiJiLuButton];
    [gouMaiJiLuButton addTarget:self action:@selector(gouMaiJiLuButtonClick) forControlEvents:UIControlEventTouchUpInside];

    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(32*BiLiWidth, gouMaiJiLuButton.top+gouMaiJiLuButton.height+90*BiLiWidth, 100*BiLiWidth, 15*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0x333333);
    tipLable.text = @"免费领取金币";
    [bottomImageView addSubview:tipLable];
    
    //VIP免费领取1组兑奖号码
    Lable_ImageButton * vipButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, tipLable.top+tipLable.height+20*BiLiWidth, WIDTH_PingMu, 33*BiLiWidth)];
    vipButton.button_imageView.frame = CGRectMake(32*BiLiWidth, 0, 33*BiLiWidth, 33*BiLiWidth);
    vipButton.button_imageView.backgroundColor = [UIColor redColor];
    vipButton.button_lable.frame = CGRectMake(vipButton.button_imageView.left+vipButton.button_imageView.width+7*BiLiWidth, 0, 200*BiLiWidth, 12*BiLiWidth);
    vipButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    vipButton.button_lable.textColor = RGBFormUIColor(0x333333);
    vipButton.button_lable.text = @"VIP免费领取1组兑奖号码";
    vipButton.button_lable1.frame = CGRectMake(vipButton.button_lable.left, vipButton.button_lable.top+vipButton.button_lable.height+5.5*BiLiWidth, 200*BiLiWidth, 10*BiLiWidth);
    vipButton.button_lable1.font = [UIFont systemFontOfSize:10*BiLiWidth];
    vipButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    vipButton.button_lable1.text = @"VIP用户每日可免费领取1组兑奖号码";
    [bottomImageView addSubview:vipButton];

    UIButton * vipLingQuButton = [[UIButton alloc] initWithFrame:CGRectMake(271*BiLiWidth, (vipButton.height-21*BiLiWidth)/2, 52*BiLiWidth, 21*BiLiWidth)];
    vipLingQuButton.layer.cornerRadius = 21*BiLiWidth/2;
    vipLingQuButton.backgroundColor = RGBFormUIColor(0xFFA217);
    [vipLingQuButton setTitle:@"领取" forState:UIControlStateNormal];
    [vipLingQuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    vipLingQuButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [vipButton addSubview:vipLingQuButton];
    
    
    //好友每日上线1次获得50金币
    Lable_ImageButton * haoYouShangXianButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, vipButton.top+vipButton.height+23*BiLiWidth, WIDTH_PingMu, 33*BiLiWidth)];
    haoYouShangXianButton.button_imageView.frame = CGRectMake(32*BiLiWidth, 0, 33*BiLiWidth, 33*BiLiWidth);
    haoYouShangXianButton.button_imageView.backgroundColor = [UIColor redColor];
    haoYouShangXianButton.button_lable.frame = CGRectMake(vipButton.button_imageView.left+vipButton.button_imageView.width+7*BiLiWidth, 0, 200*BiLiWidth, 12*BiLiWidth);
    haoYouShangXianButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    haoYouShangXianButton.button_lable.textColor = RGBFormUIColor(0x333333);
    haoYouShangXianButton.button_lable.text = @"好友每日上线1次获得50金币";
    haoYouShangXianButton.button_lable1.frame = CGRectMake(vipButton.button_lable.left, vipButton.button_lable.top+vipButton.button_lable.height+5.5*BiLiWidth, 200*BiLiWidth, 10*BiLiWidth);
    haoYouShangXianButton.button_lable1.font = [UIFont systemFontOfSize:10*BiLiWidth];
    haoYouShangXianButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    haoYouShangXianButton.button_lable1.text = @"今日上线人数0人";
    [bottomImageView addSubview:haoYouShangXianButton];

    UIButton * haoYouShangXianLingQuButton = [[UIButton alloc] initWithFrame:CGRectMake(271*BiLiWidth, (vipButton.height-21*BiLiWidth)/2, 52*BiLiWidth, 21*BiLiWidth)];
    haoYouShangXianLingQuButton.layer.cornerRadius = 21*BiLiWidth/2;
    haoYouShangXianLingQuButton.backgroundColor = RGBFormUIColor(0xFFA217);
    [haoYouShangXianLingQuButton setTitle:@"领取" forState:UIControlStateNormal];
    [haoYouShangXianLingQuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    haoYouShangXianLingQuButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [haoYouShangXianButton addSubview:haoYouShangXianLingQuButton];
    
    
    //每4小时可领取50金币一次
    Lable_ImageButton * fourHoursLingQuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, haoYouShangXianButton.top+haoYouShangXianButton.height+23*BiLiWidth, WIDTH_PingMu, 33*BiLiWidth)];
    fourHoursLingQuButton.button_imageView.frame = CGRectMake(32*BiLiWidth, 0, 33*BiLiWidth, 33*BiLiWidth);
    fourHoursLingQuButton.button_imageView.backgroundColor = [UIColor redColor];
    fourHoursLingQuButton.button_lable.frame = CGRectMake(vipButton.button_imageView.left+vipButton.button_imageView.width+7*BiLiWidth, 0, 200*BiLiWidth, 12*BiLiWidth);
    fourHoursLingQuButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    fourHoursLingQuButton.button_lable.textColor = RGBFormUIColor(0x333333);
    fourHoursLingQuButton.button_lable.text = @"每4小时可领取50金币一次";
    fourHoursLingQuButton.button_lable1.frame = CGRectMake(vipButton.button_lable.left, vipButton.button_lable.top+vipButton.button_lable.height+5.5*BiLiWidth, 160*BiLiWidth, 10*BiLiWidth);
    fourHoursLingQuButton.button_lable1.font = [UIFont systemFontOfSize:10*BiLiWidth];
    fourHoursLingQuButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    fourHoursLingQuButton.button_lable1.text = @"邀请好友一名以上可免费领取，最高可得5000金币";
    [bottomImageView addSubview:fourHoursLingQuButton];

    UIButton * fhLingQuButton = [[UIButton alloc] initWithFrame:CGRectMake(271*BiLiWidth, (vipButton.height-21*BiLiWidth)/2, 52*BiLiWidth, 21*BiLiWidth)];
    fhLingQuButton.layer.cornerRadius = 21*BiLiWidth/2;
    fhLingQuButton.backgroundColor = RGBFormUIColor(0xFFA217);
    [fhLingQuButton setTitle:@"领取" forState:UIControlStateNormal];
    [fhLingQuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fhLingQuButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [fourHoursLingQuButton addSubview:fhLingQuButton];


    
}

#pragma mark -- NSTimer_Action
-(void)timerRecord
{
    //eg:总共十分钟 600秒
    shengYuTime --;
    
    int shengYuDay = shengYuTime/(3600*24);
    
    NSString *  dayStr = shengYuDay >= 10 ? [NSString stringWithFormat:@"%d",shengYuDay] : [NSString stringWithFormat:@"0%d",shengYuDay];

    
    int shengYuHour = (shengYuTime%(3600*24))/3600;
    
    NSString *  hourStr = shengYuHour >= 10 ? [NSString stringWithFormat:@"%d",shengYuHour] : [NSString stringWithFormat:@"0%d",shengYuHour];

    
    int shengYuMinutes = (shengYuTime%3600)/60;
    
    NSString *  minutesStr = shengYuMinutes >= 10 ? [NSString stringWithFormat:@"%d",shengYuMinutes] : [NSString stringWithFormat:@"0%d",shengYuMinutes];
    
    int shengYusecond = shengYuTime%60;
    
    NSString * secondStr = shengYusecond >= 10 ? [NSString stringWithFormat:@"%d",shengYusecond] : [NSString stringWithFormat:@"0%d",shengYusecond];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"距离下次开奖时间还有%@天%@时%@分%@秒",dayStr,hourStr,minutesStr,secondStr]];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(10, 2)];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(13, 2)];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(16, 2)];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(19, 2)];
    self.daoJiShiLable.attributedText = str;
}

#pragma mark -- UIButtonClick

-(void)jianButtonClick
{
    if (number>1) {
     
        number --;
        self.numberLable.text = [NSString stringWithFormat:@"%d",number];
        [self.jinBiGouMaiButton setTitle:[NSString stringWithFormat:@"%d金币购买",number*50] forState:UIControlStateNormal];

    }
}
-(void)jiaButtonClick
{
    number ++;
    self.numberLable.text = [NSString stringWithFormat:@"%d",number];
    [self.jinBiGouMaiButton setTitle:[NSString stringWithFormat:@"%d金币购买",number*50] forState:UIControlStateNormal];

}
-(void)jinBiGouMaiButtonClick
{
    NSNumber * idNumber = [self.messageInfo objectForKey:@"id"];
    [HTTPModel buyTicket:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",number],@"nums",[NSString stringWithFormat:@"%d",idNumber.intValue],@"ticket_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            [NormalUse showToastView:@"购买成功" view:self.view];
        }
    }];
}
-(void)shuoMingButton
{
    UITextView * contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 60*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-60*BiLiWidth)];
    contentTextView.font = [UIFont systemFontOfSize:15*BiLiWidth];
    contentTextView.textColor = RGBFormUIColor(0x868686);
    contentTextView.editable = NO;
    contentTextView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:contentTextView];
    
    NSString * contentStr = [self.messageInfo objectForKey:@"rules"];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    contentTextView.attributedText = attrStr;


}
-(void)kaiJiangListButtonClick
{
    KaiJiangJiLuListViewController * vc = [[KaiJiangJiLuListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)gouMaiJiLuButtonClick
{
    GouMaiJiLuListViewController * vc = [[GouMaiJiLuListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
