//
//  SanDaJiaoSeDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/9.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "SanDaJiaoSeDetailViewController.h"

@interface SanDaJiaoSeDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,JYCarouselDelegate>

@property(nonatomic,strong)NSDictionary * tieZiInfo;


@end

@implementation SanDaJiaoSeDetailViewController

-(Lable_ImageButton *)noMessageTipButotn
{
    if (!_noMessageTipButotn) {
        
        _noMessageTipButotn = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, 10*BiLiWidth, WIDTH_PingMu, 90*BiLiWidth)];
        _noMessageTipButotn.button_imageView.frame = CGRectMake((_noMessageTipButotn.width-60*BiLiWidth)/2, 0, 60*BiLiWidth, 60*BiLiWidth);
        _noMessageTipButotn.button_imageView.image = [UIImage imageNamed:@"noMessage_tip"];
        _noMessageTipButotn.button_lable.frame = CGRectMake(0, _noMessageTipButotn.button_imageView.top+_noMessageTipButotn.button_imageView.height+10*BiLiWidth, _noMessageTipButotn.width, 12*BiLiWidth);
        _noMessageTipButotn.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        _noMessageTipButotn.button_lable.textColor = RGBFormUIColor(0x343434);
        _noMessageTipButotn.button_lable.textAlignment = NSTextAlignmentCenter;
        _noMessageTipButotn.button_lable.text = @"暂无评论";
        
    }
    return _noMessageTipButotn;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    [NormalUse xianShiGifLoadingView:self];

    [HTTPModel getSanDaGirlDetail:[[NSDictionary alloc]initWithObjectsAndKeys:self.girl_id,@"girl_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
               [NormalUse quXiaoGifLoadingView:self];
        
        if (status==1) {
            
            self.tieZiInfo = responseObject;
            [self initTopMessageView];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }

        
    }];
    
    self.backImageView.frame = CGRectMake(self.backImageView.left, (self.topNavView.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.backImageView.image = [UIImage imageNamed:@"white_back"];

    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.mainScrollView];
    
    [self.rightButton setTitle:@"投诉" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.topNavView.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:self.topNavView];

}

-(void)initTopMessageView
{
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:self.girl_id forKey:@"post_id"];
    [info setObject:@"1" forKey:@"page"];

    [HTTPModel getYanCheBaoGaoList:info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if(status==1)
        {
            self.pingLunArray = [responseObject objectForKey:@"data"];
            if([NormalUse isValidArray:self.pingLunArray])
            {
                [self.noMessageTipButotn removeFromSuperview];
                float tableViewHeight = 0;
                for (NSDictionary * info in self.pingLunArray) {
                    
                    tableViewHeight = tableViewHeight+[CheYouPingJiaCell cellHegiht:info];
                }
                self.cheYouPingJiaTableView.height = tableViewHeight;
                [self.cheYouPingJiaTableView reloadData];

            }
        }
        
    }];

    
    JYCarousel *scrollLunBo = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 0,WIDTH_PingMu,WIDTH_PingMu) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
        carouselConfig.pageContollType = MiddlePageControl;
        carouselConfig.pageTintColor = [UIColor whiteColor];
        carouselConfig.currentPageTintColor = [UIColor lightGrayColor];
        carouselConfig.placeholder = [UIImage imageNamed:@"default"];
        carouselConfig.faileReloadTimes = 5;
        carouselConfig.contentMode = UIViewContentModeScaleAspectFill;
        return carouselConfig;
    } target:self];
    scrollLunBo.layer.masksToBounds = YES;
    [self.mainScrollView addSubview:scrollLunBo];
    
    if ([NormalUse isValidArray:[self.tieZiInfo objectForKey:@"images"]]) {
        
        NSMutableArray * images = [[NSMutableArray alloc] initWithArray:[self.tieZiInfo objectForKey:@"images"]] ;
        [scrollLunBo startCarouselWithArray:images];

    }

    self.messageContentView  = [[UIView alloc] initWithFrame:CGRectMake(0, scrollLunBo.height-60*BiLiWidth, WIDTH_PingMu, 325*BiLiWidth)];
    self.messageContentView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.messageContentView];
    //某个角圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.messageContentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8*BiLiWidth, 8*BiLiWidth)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.messageContentView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.messageContentView.layer.mask = maskLayer;

    NSString * nickStr = [self.tieZiInfo objectForKey:@"title"];
    CGSize size = [NormalUse setSize:nickStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
    UILabel * nickLable = [[UILabel alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, 11*BiLiWidth, size.width, 17*BiLiWidth)];
    nickLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    nickLable.textColor = RGBFormUIColor(0x343434);
    nickLable.text = nickStr;
    [self.messageContentView addSubview:nickLable];
    
    UIImageView * vImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nickLable.left+nickLable.width+4.5*BiLiWidth, nickLable.top+(nickLable.height-14.5*BiLiWidth)/2, 16*BiLiWidth, 14.5*BiLiWidth)];
    vImageView.image = [UIImage imageNamed:@"vip_black"];
    [self.messageContentView addSubview:vImageView];
    
    UIImageView * guanFangRenZhengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(vImageView.left+vImageView.width+7.5*BiLiWidth, nickLable.top+(nickLable.height-13.5*BiLiWidth)/2, 56*BiLiWidth, 13.5*BiLiWidth)];
    guanFangRenZhengImageView.image = [UIImage imageNamed:@"guanFangRenZheng"];
    [self.messageContentView addSubview:guanFangRenZhengImageView];
    
    NSNumber * auth_nomal = [self.tieZiInfo objectForKey:@"auth_nomal"];
    if ([auth_nomal isKindOfClass:[NSNumber class]]) {
        
        if (auth_nomal.intValue==0) {
            
            guanFangRenZhengImageView.width = 13.5*BiLiWidth*126/39;
            guanFangRenZhengImageView.image = [UIImage imageNamed:@"guanFangWeiRenZheng"];


        }

    }
    
    UILabel * cityLable = [[UILabel alloc] initWithFrame:CGRectMake(nickLable.left, nickLable.top+nickLable.height+10*BiLiWidth, 200*BiLiWidth, 11*BiLiWidth)];
    cityLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    cityLable.textColor = RGBFormUIColor(0x9A9A9A);
    cityLable.text = [self.tieZiInfo objectForKey:@"city_name"];
    [self.messageContentView addSubview:cityLable];
    
    Lable_ImageButton * shouCangButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-21*BiLiWidth-14*BiLiWidth, 14*BiLiWidth, 21*BiLiWidth, 35.5*BiLiWidth)];
    shouCangButton.button_imageView.frame = CGRectMake((shouCangButton.width-19.5*BiLiWidth)/2, 0, 19.5*BiLiWidth, 18*BiLiWidth);
    shouCangButton.button_imageView.image = [UIImage imageNamed:@"shouCang_n"];
    shouCangButton.button_lable.frame = CGRectMake(-10*BiLiWidth, shouCangButton.button_imageView.top+shouCangButton.button_imageView.height+6.5*BiLiWidth, 21*BiLiWidth+20*BiLiWidth, 11*BiLiWidth);
    shouCangButton.button_lable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    shouCangButton.button_lable.textAlignment = NSTextAlignmentCenter;
    shouCangButton.button_lable.textColor = RGBFormUIColor(0x9A9A9A);
    shouCangButton.button_lable.text = @"收藏";
    shouCangButton.tag = 0;
    [shouCangButton addTarget:self action:@selector(shouCangOrQuXiaoShouCang:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageContentView addSubview:shouCangButton];
    
    NSNumber * is_like = [self.tieZiInfo objectForKey:@"is_like"];
    if ([is_like isKindOfClass:[NSNumber class]]) {
        
        if (is_like.intValue!=0) {
            
            shouCangButton.tag = 1;
            shouCangButton.button_imageView.image = [UIImage imageNamed:@"shouCang_h"];
            shouCangButton.button_lable.text = @"已收藏";

        }
    }


    UIView * pingFenView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, cityLable.top+cityLable.height+16.5*BiLiWidth, 321*BiLiWidth, 95*BiLiWidth)];
    pingFenView.layer.cornerRadius = 5*BiLiWidth;
    pingFenView.layer.masksToBounds = NO;
    pingFenView.backgroundColor = [UIColor whiteColor];
    [self.messageContentView addSubview:pingFenView];
    pingFenView.layer.shadowOpacity = 0.2f;
    pingFenView.layer.shadowColor = [UIColor blackColor].CGColor;
    pingFenView.layer.shadowOffset = CGSizeMake(0, 3);//CGSizeZero; //设置偏移量为0,四周都有阴影
    
    UILabel * pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(53.5*BiLiWidth, 25.5*BiLiWidth, 50*BiLiWidth, 33*BiLiWidth)];
    pingFenLable.font = [UIFont systemFontOfSize:33*BiLiWidth];
    pingFenLable.textColor = RGBFormUIColor(0xFFA218);
    NSNumber * complex_score= [self.tieZiInfo objectForKey:@"complex_score"];
    if ([complex_score isKindOfClass:[NSNumber class]]) {
        
        pingFenLable.text = [NSString stringWithFormat:@"%d",complex_score.intValue];

    }
    [pingFenView addSubview:pingFenLable];
    
    UILabel * pingFenTipLable = [[UILabel alloc] initWithFrame:CGRectMake(pingFenLable.left, 63.5*BiLiWidth, pingFenLable.width, 11*BiLiWidth)];
    pingFenTipLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    pingFenTipLable.textColor = RGBFormUIColor(0x9A9A9A);
    pingFenTipLable.text = @"综合评分";
    pingFenLable.textAlignment = NSTextAlignmentCenter;
    [pingFenView addSubview:pingFenTipLable];
    
    UILabel * yanZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(160*BiLiWidth, 15*BiLiWidth,24*BiLiWidth, 12*BiLiWidth)];
    yanZhiLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    yanZhiLable.textColor = RGBFormUIColor(0x9A9A9A);
    yanZhiLable.text = @"颜值";
    yanZhiLable.textAlignment = NSTextAlignmentCenter;
    [pingFenView addSubview:yanZhiLable];

    NSNumber * face_value = [self.tieZiInfo objectForKey:@"face_value"];
    
    for (int i=0; i<5; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(yanZhiLable.left+yanZhiLable.width+19*BiLiWidth+20*BiLiWidth*i, yanZhiLable.top, 12*BiLiWidth, 12*BiLiWidth)];
        [pingFenView addSubview:imageView];
        
        if ([face_value isKindOfClass:[NSNumber class]]) {
            
            if (i<=face_value.intValue) {
                
                imageView.image = [UIImage imageNamed:@"star_yellow"];

            }
            else
            {
                imageView.image = [UIImage imageNamed:@"star_hui"];

            }

        }
        
    }
    
    UILabel * jiShuLable = [[UILabel alloc] initWithFrame:CGRectMake(160*BiLiWidth, yanZhiLable.top+yanZhiLable.height+15*BiLiWidth,24*BiLiWidth, 12*BiLiWidth)];
    jiShuLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    jiShuLable.textColor = RGBFormUIColor(0x9A9A9A);
    jiShuLable.text = @"技术";
    jiShuLable.textAlignment = NSTextAlignmentCenter;
    [pingFenView addSubview:jiShuLable];

    NSNumber * skill_value = [self.tieZiInfo objectForKey:@"skill_value"];

    for (int i=0; i<5; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(jiShuLable.left+jiShuLable.width+19*BiLiWidth+20*BiLiWidth*i, jiShuLable.top, 12*BiLiWidth, 12*BiLiWidth)];
        [pingFenView addSubview:imageView];
        
        if ([skill_value isKindOfClass:[NSNumber class]]) {
            
            if (i<=skill_value.intValue) {
                
                imageView.image = [UIImage imageNamed:@"star_yellow"];

            }
            else
            {
                imageView.image = [UIImage imageNamed:@"star_hui"];

            }

        }

        
    }

    
    UILabel * huanJingLable = [[UILabel alloc] initWithFrame:CGRectMake(160*BiLiWidth, jiShuLable.top+jiShuLable.height+15*BiLiWidth,24*BiLiWidth, 12*BiLiWidth)];
    huanJingLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    huanJingLable.textColor = RGBFormUIColor(0x9A9A9A);
    huanJingLable.text = @"环境";
    huanJingLable.textAlignment = NSTextAlignmentCenter;
    [pingFenView addSubview:huanJingLable];

    NSNumber * ambience_value = [self.tieZiInfo objectForKey:@"ambience_value"];

    for (int i=0; i<5; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(huanJingLable.left+huanJingLable.width+19*BiLiWidth+20*BiLiWidth*i, huanJingLable.top, 12*BiLiWidth, 12*BiLiWidth)];
        [pingFenView addSubview:imageView];
        
        if ([ambience_value isKindOfClass:[NSNumber class]]) {
            
            if (i<=ambience_value.intValue) {
                
                imageView.image = [UIImage imageNamed:@"star_yellow"];

            }
            else
            {
                imageView.image = [UIImage imageNamed:@"star_hui"];

            }

        }

        
    }

    NSString * unlock_mobile_coin = [NormalUse getJinBiStr:@"unlock_mobile_coin"];

    self.jieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, pingFenView.top+pingFenView.height+19*BiLiWidth, 321*BiLiWidth, 57*BiLiWidth)];
    [self.jieSuoButton setBackgroundImage:[UIImage imageNamed:@"jieSuo_bottomIMageView"] forState:UIControlStateNormal];
    self.jieSuoButton.button_lable.frame = CGRectMake(19.5*BiLiWidth, 0, 150*BiLiWidth, self.jieSuoButton.height);
    self.jieSuoButton.button_lable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.jieSuoButton.button_lable.textColor = RGBFormUIColor(0xFFE1B0);
    self.jieSuoButton.button_lable.text = @"查看地址联系方式";
    self.jieSuoButton.button_lable1.frame = CGRectMake(227*BiLiWidth, 0, 150*BiLiWidth, self.jieSuoButton.height);
    self.jieSuoButton.button_lable1.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.jieSuoButton.button_lable1.textColor = RGBFormUIColor(0xFFE1B0);
    self.jieSuoButton.button_lable1.text = [NSString stringWithFormat:@"%@金币解锁",[NormalUse getobjectForKey:unlock_mobile_coin]];
    [self.messageContentView addSubview:self.jieSuoButton];
    
    NSNumber * is_unlock = [self.tieZiInfo objectForKey:@"is_unlock"];
    if([is_unlock isKindOfClass:[NSNumber class]])
    {
        if (is_unlock.intValue==1) {
            
            NSDictionary * contact = [self.tieZiInfo objectForKey:@"contact"];

            [self.self.jieSuoButton removeTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
           // [16]    (null)    @"mobile" : (long)0    [19]    (null)    @"qq" : (no summary)
            NSString * wechat = [contact objectForKey:@"wechat"];
            NSString * qq = [contact objectForKey:@"qq"];
            NSNumber * mobile = [contact objectForKey:@"mobile"];
            NSString * lianXieFangShiStr = @"";
            if ([NormalUse isValidString:wechat]) {
                
                lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"微信:%@",wechat]];
            }
            if ([NormalUse isValidString:qq]) {
                
                lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"  QQ:%@",qq]];
            }
            
            if ([mobile isKindOfClass:[NSNumber class]]) {
                
                lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"  电话:%d",mobile.intValue]];

            }
            self.jieSuoButton.button_lable.adjustsFontSizeToFitWidth = YES;
            self.self.jieSuoButton.button_lable.width = 300*BiLiWidth;
            self.self.jieSuoButton.button_lable.text = lianXieFangShiStr;
            self.self.jieSuoButton.button_lable1.text = @"";


        }
    }

    
    self.tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.jieSuoButton.top+self.jieSuoButton.height+11*BiLiWidth, WIDTH_PingMu, 10*BiLiWidth)];
    self.tipLable.textAlignment = NSTextAlignmentCenter;
    self.tipLable.text = @"未见本人就要定金 、押金 、路费的。100%是骗子，切记！";
    self.tipLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
    self.tipLable.textColor = RGBFormUIColor(0xFF0101);
    [self.messageContentView addSubview:self.tipLable];
    
    

    self.jiBenXinXiButton = [[UIButton alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, self.tipLable.top+self.tipLable.height+25*BiLiWidth, 70*BiLiWidth, 16*BiLiWidth)];
    [self.jiBenXinXiButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.jiBenXinXiButton.titleLabel.font = [UIFont systemFontOfSize:16*BiLiWidth];
    [self.jiBenXinXiButton setTitle:@"基本资料" forState:UIControlStateNormal];
    self.jiBenXinXiButton.tag = 0;
    self.jiBenXinXiButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.jiBenXinXiButton addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageContentView addSubview:self.jiBenXinXiButton];
    
    self.xiangQingJieShaoButton = [[UIButton alloc] initWithFrame:CGRectMake(self.jiBenXinXiButton.left+self.jiBenXinXiButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth)];
    [self.xiangQingJieShaoButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.xiangQingJieShaoButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.xiangQingJieShaoButton setTitle:@"详情介绍" forState:UIControlStateNormal];
    self.xiangQingJieShaoButton.tag = 1;
    self.xiangQingJieShaoButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.xiangQingJieShaoButton addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageContentView addSubview:self.xiangQingJieShaoButton];

    
    self.cheYouPingJiaButton = [[UIButton alloc] initWithFrame:CGRectMake(self.xiangQingJieShaoButton.left+self.xiangQingJieShaoButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth)];
    [self.cheYouPingJiaButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.cheYouPingJiaButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.cheYouPingJiaButton setTitle:@"车友评价" forState:UIControlStateNormal];
    self.cheYouPingJiaButton.tag = 2;
    self.cheYouPingJiaButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.cheYouPingJiaButton addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageContentView addSubview:self.cheYouPingJiaButton];


    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(19.5*BiLiWidth,self.tipLable.top+self.tipLable.height+36.5*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
    self.sliderView.layer.cornerRadius = 7*BiLiWidth/2;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.alpha = 0.8;
    [self.messageContentView addSubview:self.sliderView];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.sliderView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    [self.sliderView.layer addSublayer:gradientLayer];


    self.bottomContentScollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.messageContentView.top+self.messageContentView.height, WIDTH_PingMu, 0)];
    self.bottomContentScollView.pagingEnabled = YES;
    [self.bottomContentScollView setContentSize:CGSizeMake(WIDTH_PingMu*3, 0)];
    self.bottomContentScollView.tag = 1001;
    self.bottomContentScollView.delegate = self;
    [self.mainScrollView addSubview:self.bottomContentScollView];

    [self initJiBenZiLiaoView];
    [self initXiangQingJieShaoView];
    [self initChenYouPingJiaTableView];
}
-(void)jieSuoButtonClick
{
    [NormalUse showMessageLoadView:@"解锁中..." vc:self];
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:self.type forKey:@"type_id"];
    [info setObject:self.girl_id forKey:@"related_id"];
    [HTTPModel unlockMobile:info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse removeMessageLoadingView:self];
        if (status==1) {
            
            NSDictionary * contactInfo = responseObject;
            
             [self.jieSuoButton removeTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
             NSString * wechat = [contactInfo objectForKey:@"wechat"];
             NSString * qq = [contactInfo objectForKey:@"qq"];
             NSNumber * mobile = [contactInfo objectForKey:@"mobile"];
             NSString * lianXieFangShiStr = @"";
             if ([NormalUse isValidString:wechat]) {
                 
                 lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"微信:%@",wechat]];
             }
             if ([NormalUse isValidString:qq]) {
                 
                 lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"  QQ:%@",qq]];
             }
             
             if ([mobile isKindOfClass:[NSNumber class]]) {
                 
                 lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"  电话:%d",mobile.intValue]];

             }
            self.jieSuoButton.button_lable.adjustsFontSizeToFitWidth = YES;
             self.jieSuoButton.button_lable.width = 300*BiLiWidth;
             self.jieSuoButton.button_lable.text = lianXieFangShiStr;
             self.jieSuoButton.button_lable1.text = @"";

            [NormalUse showToastView:@"解锁成功" view:self.view];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
        
    }];
    
}
-(void)initJiBenZiLiaoView
{
    self.jiBenXinXiContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 0)];
    [self.bottomContentScollView addSubview:self.jiBenXinXiContentView];
    
    //价格
    UIImageView * jiaGeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 0, 12*BiLiWidth, 12*BiLiWidth)];
    jiaGeImageView.image = [UIImage imageNamed:@"ziLiao_jiaGe"];
    [self.jiBenXinXiContentView addSubview:jiaGeImageView];
    
    UILabel * jiaGeLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, 0, 200*BiLiWidth, 12*BiLiWidth)];
    jiaGeLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    jiaGeLable.textColor = RGBFormUIColor(0x666666);
    jiaGeLable.text = [NSString stringWithFormat:@"价格：%@-%@",[self.tieZiInfo objectForKey:@"min_price"],[self.tieZiInfo objectForKey:@"max_price"]];
    [self.jiBenXinXiContentView addSubview:jiaGeLable];
    
    //数量
    UIImageView * shuLiangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, jiaGeImageView.top+jiaGeImageView.height+14*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
    shuLiangImageView.image = [UIImage imageNamed:@"ziLiao_renShu"];
    [self.jiBenXinXiContentView addSubview:shuLiangImageView];
    
    UILabel * shuLiangLableLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, shuLiangImageView.top, 200*BiLiWidth, 12*BiLiWidth)];
    shuLiangLableLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    shuLiangLableLable.textColor = RGBFormUIColor(0x666666);
    NSNumber *  nums = [self.tieZiInfo objectForKey:@"nums"];
    if ([nums isKindOfClass:[NSNumber class]]) {
        
        shuLiangLableLable.text = [NSString stringWithFormat:@"数量：%d",nums.intValue];

    }
    [self.jiBenXinXiContentView addSubview:shuLiangLableLable];

    //年龄
    UIImageView * ageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, shuLiangImageView.top+shuLiangImageView.height+14*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
    ageImageView.image = [UIImage imageNamed:@"ziLiao_age"];
    [self.jiBenXinXiContentView addSubview:ageImageView];
    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth,ageImageView.top , 200*BiLiWidth, 12*BiLiWidth)];
    ageLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    ageLable.textColor = RGBFormUIColor(0x666666);
    NSNumber *  age = [self.tieZiInfo objectForKey:@"age"];
    if ([age isKindOfClass:[NSNumber class]]) {
        
        ageLable.text = [NSString stringWithFormat:@"年龄：%d",age.intValue];

    }

    [self.jiBenXinXiContentView addSubview:ageLable];

    //项目
    UIImageView * xiangMuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, ageImageView.top+ageImageView.height+14*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
    xiangMuImageView.image = [UIImage imageNamed:@"ziLiao_xiangMu"];
    [self.jiBenXinXiContentView addSubview:xiangMuImageView];
    
    UILabel * xiangMuLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, xiangMuImageView.top, 300*BiLiWidth, 12*BiLiWidth)];
    xiangMuLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    xiangMuLable.textColor = RGBFormUIColor(0x666666);
    xiangMuLable.text = [self.tieZiInfo objectForKey:@"service_type"];
    xiangMuLable.adjustsFontSizeToFitWidth = YES;
    [self.jiBenXinXiContentView addSubview:xiangMuLable];

    self.jiBenXinXiContentView.height = xiangMuLable.top+xiangMuLable.height+20*BiLiWidth;
    
    self.bottomContentScollView.height = self.jiBenXinXiContentView.height;
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.bottomContentScollView.top+self.bottomContentScollView.height)];
    
}
-(void)initXiangQingJieShaoView
{
    self.xiangQingJieShaoContentView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_PingMu, 0, WIDTH_PingMu, 0)];
    [self.bottomContentScollView addSubview:self.xiangQingJieShaoContentView];
    
//    UIImageView * headerImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth, 0, 48*BiLiWidth, 48*BiLiWidth)];
//    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
//    headerImageView.autoresizingMask = UIViewAutoresizingNone;
//    headerImageView.clipsToBounds = YES;
//    headerImageView.layer.cornerRadius = 24*BiLiWidth;
//    headerImageView.backgroundColor = [UIColor redColor];
//    [self.xiangQingJieShaoContentView addSubview:headerImageView];
//
//    NSString * nickStr = [self.tieZiInfo objectForKey:@"title"];
//    CGSize size = [NormalUse setSize:nickStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:14*BiLiWidth];
//    UILabel * nickLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left+headerImageView.width+13.5*BiLiWidth, 6*BiLiWidth, size.width, 14*BiLiWidth)];
//    nickLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
//    nickLable.textColor = RGBFormUIColor(0x343434);
//    nickLable.text = nickStr;
//    [self.xiangQingJieShaoContentView addSubview:nickLable];
//
//    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(nickLable.left+nickLable.width+9*BiLiWidth, 6*BiLiWidth, 26*BiLiWidth, 14*BiLiWidth)];
//    tipLable.font = [UIFont systemFontOfSize:9*BiLiWidth];
//    tipLable.textColor = RGBFormUIColor(0xFFFFFF);
//    tipLable.layer.cornerRadius = 4*BiLiWidth;
//    tipLable.clipsToBounds = YES;
//    tipLable.text = @"作者";
//    [self.xiangQingJieShaoContentView addSubview:tipLable];
//
//
//    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(nickLable.left, tipLable.top+tipLable.height+11.5*BiLiWidth, 100*BiLiWidth, 11*BiLiWidth)];
//    timeLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
//    timeLable.textColor = RGBFormUIColor(0x9A9A9A);
//    timeLable.text = @"2020-08-28";
//    [self.xiangQingJieShaoContentView addSubview:timeLable];
//
//
//    UILabel * pingFenTipLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, headerImageView.top+headerImageView.height+20.5*BiLiWidth, 45*BiLiWidth, 11*BiLiWidth)];
//    pingFenTipLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
//    pingFenTipLable.textColor = RGBFormUIColor(0x9A9A9A);
//    pingFenTipLable.text = @"综合评分";
//    [self.xiangQingJieShaoContentView addSubview:pingFenTipLable];
//
//
//    UILabel * pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(pingFenTipLable.left+pingFenTipLable.width+12*BiLiWidth, headerImageView.top+headerImageView.height+17.5*BiLiWidth, 45*BiLiWidth, 18*BiLiWidth)];
//    pingFenLable.font = [UIFont systemFontOfSize:18*BiLiWidth];
//    pingFenLable.textColor = RGBFormUIColor(0x343434);
//    NSNumber *  complex_score = [self.tieZiInfo objectForKey:@"complex_score"];
//    if ([complex_score isKindOfClass:[NSNumber class]]) {
//
//        pingFenLable.text = [NSString stringWithFormat:@"%.1f",complex_score.floatValue];
//
//    }
//
//
//    [self.xiangQingJieShaoContentView addSubview:pingFenLable];
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, 7.5*BiLiWidth, 333*BiLiWidth, 0)];
    messageLable.numberOfLines = 0;
    messageLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    messageLable.textColor = RGBFormUIColor(0x343434);
    [self.xiangQingJieShaoContentView addSubview:messageLable];

    NSString * neiRongStr = [NormalUse getobjectForKey:[self.tieZiInfo objectForKey:@"decription"]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    messageLable.attributedText = attributedString;
    //设置自适应
    [messageLable  sizeToFit];
    
    self.xiangQingJieShaoContentView.height = messageLable.top+messageLable.height+20*BiLiWidth;


}
-(void)initChenYouPingJiaTableView
{
    
    float tableViewHeight = 0;
    for (NSDictionary * info in self.pingLunArray) {
        
        tableViewHeight = tableViewHeight+[CheYouPingJiaCell cellHegiht:info];
    }
    
    self.cheYouPingJiaTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*2, 0, WIDTH_PingMu, tableViewHeight)];
    self.cheYouPingJiaTableView.delegate = self;
    self.cheYouPingJiaTableView.dataSource = self;
    self.cheYouPingJiaTableView.scrollEnabled = NO;
    self.cheYouPingJiaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.bottomContentScollView addSubview:self.cheYouPingJiaTableView];
    
    if (tableViewHeight==0) {
        
        tableViewHeight = 100*BiLiWidth;
        self.cheYouPingJiaTableView.height = tableViewHeight;
        [self.cheYouPingJiaTableView addSubview:self.noMessageTipButotn];
    }
    
}
#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.pingLunArray.count;

    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return  [CheYouPingJiaCell cellHegiht:[self.pingLunArray objectAtIndex:indexPath.row]];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"CheYouPingJiaCell"] ;
    CheYouPingJiaCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[CheYouPingJiaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    [cell initContentView:[self.pingLunArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark---scrollviewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (scrollView.tag==1001) {
        
        int  specialIndex = scrollView.contentOffset.x/WIDTH_PingMu;
            
        if (specialIndex==0) {
            
            [self.jiBenXinXiButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        else if (specialIndex==1)
        {
            [self.xiangQingJieShaoButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [self.cheYouPingJiaButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }

}

#pragma mark--UIButtonClick

-(void)shouCangOrQuXiaoShouCang:(Lable_ImageButton *)button
{
    button.enabled = NO;
    if (button.tag==0) {
        
        [HTTPModel tieZiFollow:[[NSDictionary alloc]initWithObjectsAndKeys:self.girl_id,@"post_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
           
            button.enabled = YES;

            if (status==1) {
                button.tag = 1;
                button.button_imageView.image = [UIImage imageNamed:@"shouCang_h"];
                button.button_lable.text = @"已收藏";
            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
            }
            
        }];
    }
    else
    {
        //NSArray * array = [[NSArray alloc] initWithObjects:self.post_id, nil];
        NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:self.girl_id,@"ids", nil];
        [HTTPModel tieZiFollow:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
           
            button.enabled = YES;
            if (status==1) {
                button.tag = 0;

                button.button_imageView.image = [UIImage imageNamed:@"shouCang_n"];
                button.button_lable.text = @"收藏";

            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
            }
            
        }];

    }
    
}

-(void)listTopButtonClick:(UIButton *)button
{
    if (button.tag==0) {
        
        self.jiBenXinXiButton.frame = CGRectMake(11.5*BiLiWidth, self.tipLable.top+self.tipLable.height+25*BiLiWidth, 70*BiLiWidth, 16*BiLiWidth);
        self.jiBenXinXiButton.titleLabel.font = [UIFont systemFontOfSize:16*BiLiWidth];
        
        self.xiangQingJieShaoButton.frame = CGRectMake(self.jiBenXinXiButton.left+self.jiBenXinXiButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.xiangQingJieShaoButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];

        self.cheYouPingJiaButton.frame = CGRectMake(self.xiangQingJieShaoButton.left+self.xiangQingJieShaoButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.cheYouPingJiaButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];

        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.sliderView.left = self.jiBenXinXiButton.left+(self.jiBenXinXiButton.width-self.sliderView.width)/2;
        }];
        
        [self.bottomContentScollView setContentOffset:CGPointMake(0, 0)];
        self.bottomContentScollView.height = self.jiBenXinXiContentView.height;
        

        
    }
    else if (button.tag==1)
    {
        self.jiBenXinXiButton.frame = CGRectMake(11.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.jiBenXinXiButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];

        
        self.xiangQingJieShaoButton.frame = CGRectMake(self.jiBenXinXiButton.left+self.jiBenXinXiButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+25*BiLiWidth, 70*BiLiWidth, 16*BiLiWidth);
        self.xiangQingJieShaoButton.titleLabel.font = [UIFont systemFontOfSize:16*BiLiWidth];

        
        self.cheYouPingJiaButton.frame = CGRectMake(self.xiangQingJieShaoButton.left+self.xiangQingJieShaoButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.cheYouPingJiaButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];


        [UIView animateWithDuration:0.5 animations:^{
            
            self.sliderView.left = self.xiangQingJieShaoButton.left+(self.xiangQingJieShaoButton.width-self.sliderView.width)/2;
        }];
        
        [self.bottomContentScollView setContentOffset:CGPointMake(WIDTH_PingMu, 0)];
        
        self.bottomContentScollView.height = self.xiangQingJieShaoContentView.height;
        


    }
    else
    {
        self.jiBenXinXiButton.frame = CGRectMake(11.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.jiBenXinXiButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];

        self.xiangQingJieShaoButton.frame = CGRectMake(self.jiBenXinXiButton.left+self.jiBenXinXiButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.xiangQingJieShaoButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];

        self.cheYouPingJiaButton.frame = CGRectMake(self.xiangQingJieShaoButton.left+self.xiangQingJieShaoButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+25*BiLiWidth, 70*BiLiWidth, 16*BiLiWidth);
        self.cheYouPingJiaButton.titleLabel.font = [UIFont systemFontOfSize:16*BiLiWidth];


        [UIView animateWithDuration:0.5 animations:^{
            
            self.sliderView.left = self.cheYouPingJiaButton.left+(self.cheYouPingJiaButton.width-self.sliderView.width)/2;
        }];
        
        [self.bottomContentScollView setContentOffset:CGPointMake(HEIGHT_PingMu*2, 0)];


        self.bottomContentScollView.height = self.cheYouPingJiaTableView.height;
        

    }
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.bottomContentScollView.top+self.bottomContentScollView.height)];

}

#pragma mark--JYCarouselDelegate
-(void)carouseScrollToIndex:(NSInteger)index
{
    
}
- (void)carouselViewClick:(NSInteger)index
{
    
}


@end
