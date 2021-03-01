//
//  SanDaJiaoSeDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/9.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "SanDaJiaoSeDetailViewController.h"
#import "VipTieZiJieSuoSuccseeTipView.h"

@interface SanDaJiaoSeDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,JYCarouselDelegate>
{
    NSInteger sliderIndex;

}

@property(nonatomic,strong)NSMutableDictionary * tieZiInfo;

@property(nonatomic,strong)NSMutableArray * images;

@property(nonatomic,strong)UIButton * videoButton;

@property(nonatomic,strong)AutoScrollLabel * autoLabel;


@end

@implementation SanDaJiaoSeDetailViewController

-(UIImageView *)noMessageTipButotn
{
    if (!_noMessageTipButotn) {
        
        _noMessageTipButotn = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-200*BiLiWidth)/2, 0*BiLiWidth, 200*BiLiWidth, 200*BiLiWidth*1280/720)];
        _noMessageTipButotn.image =[UIImage imageNamed:@"NoMessageTip"];
//        _noMessageTipButotn.button_imageView.frame = CGRectMake((_noMessageTipButotn.width-60*BiLiWidth)/2, 0, 60*BiLiWidth, 60*BiLiWidth);
//        _noMessageTipButotn.button_imageView.image = [UIImage imageNamed:@"noMessage_tip"];
//        _noMessageTipButotn.button_lable.frame = CGRectMake(0, _noMessageTipButotn.button_imageView.top+_noMessageTipButotn.button_imageView.height+10*BiLiWidth, _noMessageTipButotn.width, 12*BiLiWidth);
//        _noMessageTipButotn.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
//        _noMessageTipButotn.button_lable.textColor = RGBFormUIColor(0x343434);
//        _noMessageTipButotn.button_lable.textAlignment = NSTextAlignmentCenter;
//        _noMessageTipButotn.button_lable.text = @"暂无评论";
        
    }
    return _noMessageTipButotn;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
    [self.autoLabel removeFromSuperview];
    self.autoLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 30)];
    self.autoLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    self.autoLabel.text = [self.tieZiInfo objectForKey:@"post_warning_tips"];
    self.autoLabel.textColor = RGBFormUIColor(0xFF0101);//默认白色
    [self.mainScrollView addSubview:self.autoLabel];

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.rightButton setTitleColor:RGBFormUIColor(0xFF0876) forState:UIControlStateNormal];
    [self.rightButton setTitle:@"投诉" forState:UIControlStateNormal];
    self.topTitleLale.text = @"详情";

    [self yinCangTabbar];
    
    [NormalUse xianShiGifLoadingView:self];

    [HTTPModel getSanDaGirlDetail:[[NSDictionary alloc]initWithObjectsAndKeys:self.girl_id,@"girl_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
            [NormalUse quXiaoGifLoadingView:self];
        
        if (status==1) {
            
            self.tieZiInfo = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
            [self initTopMessageView];
            
            UIButton * chatButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-60*BiLiWidth, HEIGHT_PingMu-55*BiLiWidth-243*BiLiWidth, 55*BiLiWidth*184/204, 55*BiLiWidth)];
            [chatButton setBackgroundImage:[UIImage imageNamed:@"tieZi_chat_blue"] forState:UIControlStateNormal];
            [chatButton addTarget:self action:@selector(chatButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:chatButton];

        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }

        
    }];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.mainScrollView];
    

}
-(void)rightClick
{
    NSNumber * is_unlock = [self.tieZiInfo objectForKey:@"is_unlock"];
    NSNumber * is_interview = [self.tieZiInfo objectForKey:@"is_unlock"];
    if([is_unlock isKindOfClass:[NSNumber class]])
    {
        if (is_unlock.intValue==1 ||is_interview.intValue==1 || alsoUnlockSuccess) {

            JvBaoViewController * vc = [[JvBaoViewController alloc] init];
            vc.post_id = self.girl_id;
            vc.role = @"2";
            [self.navigationController pushViewController:vc animated:YES];

        }
        else
        {
            
            ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:@"解锁或预约后才可以投诉该帖~" message2:@"" button1Title:@"知道了" button2Title:@""];
            alertView.button1Click = ^{

            };
            alertView.button2Click = ^{
              
            };
            [[UIApplication sharedApplication].keyWindow addSubview:alertView];

        }
    }
}

-(void)initTopMessageView
{
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:self.girl_id forKey:@"post_id"];
    [info setObject:@"1" forKey:@"page"];
    [info setObject:@"2" forKey:@"type_id"];


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

                [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.cheYouPingJiaTableView.top+self.cheYouPingJiaTableView.height)];

            }
        }
        
    }];

    
    JYCarousel *scrollLunBo = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 0,WIDTH_PingMu,WIDTH_PingMu) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
        carouselConfig.pageContollType = MiddlePageControl;
        carouselConfig.pageTintColor = [UIColor whiteColor];
        carouselConfig.currentPageTintColor = [UIColor lightGrayColor];
        carouselConfig.placeholder = [UIImage imageNamed:@"banner_kong"];
        carouselConfig.faileReloadTimes = 5;
        carouselConfig.contentMode = UIViewContentModeScaleAspectFill;
        return carouselConfig;
    } target:self];
    scrollLunBo.layer.masksToBounds = YES;
    [self.mainScrollView addSubview:scrollLunBo];
    
    self.videoButton = [[UIButton alloc] initWithFrame:CGRectMake((scrollLunBo.width-50*BiLiWidth)/2, (scrollLunBo.height-60*BiLiWidth-50*BiLiWidth)/2, 50*BiLiWidth, 50*BiLiWidth)];
    [self.videoButton setBackgroundImage:[UIImage imageNamed:@"boFang"] forState:UIControlStateNormal];
    self.videoButton.hidden = YES;
    [self.videoButton addTarget:self action:@selector(videoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollLunBo addSubview:self.videoButton];

    
    self.images = [NSMutableArray array];
    if ([NormalUse isValidArray:[self.tieZiInfo objectForKey:@"images"]]) {
        
        self.images = [[NSMutableArray alloc] initWithArray:[self.tieZiInfo objectForKey:@"images"]] ;
    }
    
    if ([NormalUse isValidArray:[self.tieZiInfo objectForKey:@"videos"]])
    {
        for (NSDictionary * info in [self.tieZiInfo objectForKey:@"videos"]) {
            
            UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[info objectForKey:@"fframe"]]]];
            if (image!=nil) {
                
                [self.images addObject:image];

            }
        }
    }
    
    self.pageControll = [[FengZhuangUIPageControll alloc] initWithFrame:CGRectMake(WIDTH_PingMu-self.images.count*18,scrollLunBo.height-20*BiLiWidth-60*BiLiWidth, self.images.count*18, 15)];
    self.pageControll.currentPageIndicatorTintColor = RGBFormUIColor(0xFFFFFF);
    self.pageControll.pageIndicatorTintColor = RGBFormUIColor(0x999999);
    self.pageControll.numberOfPages = self.images.count;
    self.pageControll.currentPage = 0;
    [scrollLunBo addSubview:self.pageControll];

    [scrollLunBo startCarouselWithArray:self.images];

    self.autoLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 30)];
    self.autoLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    self.autoLabel.text = [self.tieZiInfo objectForKey:@"post_warning_tips"];
    self.autoLabel.textColor = RGBFormUIColor(0xFF0101);//默认白色
    [self.mainScrollView addSubview:self.autoLabel];


    self.messageContentView  = [[UIView alloc] initWithFrame:CGRectMake(0, scrollLunBo.height-60*BiLiWidth, WIDTH_PingMu, 325*BiLiWidth-21*BiLiWidth-40*BiLiWidth)];
    self.messageContentView.backgroundColor = [UIColor whiteColor];
    self.messageContentView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:self.messageContentView];
    

    NSString * nickStr = [self.tieZiInfo objectForKey:@"title"];
    CGSize size = [NormalUse setSize:nickStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
    UILabel * nickLable = [[UILabel alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, 11*BiLiWidth, size.width, 17*BiLiWidth)];
    nickLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    nickLable.textColor = RGBFormUIColor(0x343434);
    nickLable.text = nickStr;
    [self.messageContentView addSubview:nickLable];
    
    UIImageView * vImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nickLable.left+nickLable.width+4.5*BiLiWidth, nickLable.top+(nickLable.height-25*BiLiWidth)/2, 25*BiLiWidth*170/60, 25*BiLiWidth)];
    [self.messageContentView addSubview:vImageView];

    NSNumber * auth_vip = [self.tieZiInfo objectForKey:@"auth_vip"];
    if ([auth_vip isKindOfClass:[NSNumber class]]) {
        
        if (auth_vip.intValue==1) {
            
            vImageView.image = [UIImage imageNamed:@"vip_zuanShi"];

        }
        else if (auth_vip.intValue==2)
        {
            vImageView.image = [UIImage imageNamed:@"vip_wangZhe"];

        }
        else if (auth_vip.intValue==3)
        {
            vImageView.image = [UIImage imageNamed:@"vip_paoShen"];

        }
        else if (auth_vip.intValue==0)
        {
            vImageView.left = nickLable.left+nickLable.width;
            vImageView.width = 0;

        }

    }
    else
    {
        vImageView.left = nickLable.left+nickLable.width;
        vImageView.width = 0;
    }
    
    UIImageView * guanFangRenZhengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(vImageView.left+vImageView.width+7.5*BiLiWidth, nickLable.top+(nickLable.height-20*BiLiWidth)/2, 20*269/66*BiLiWidth, 20*BiLiWidth)];
//    guanFangRenZhengImageView.image = [UIImage imageNamed:@"guanFangWeiRenZheng"];
    [self.messageContentView addSubview:guanFangRenZhengImageView];
    
    NSNumber * auth_nomal = [self.tieZiInfo objectForKey:@"auth_nomal"];
    if ([auth_nomal isKindOfClass:[NSNumber class]]) {
        
        if (auth_nomal.intValue==1) {
            
            guanFangRenZhengImageView.width = 20*171/42*BiLiWidth;
            guanFangRenZhengImageView.image = [UIImage imageNamed:@"home_guanFangTip"];


        }

    }

    UILabel * cityLable = [[UILabel alloc] initWithFrame:CGRectMake(nickLable.left, nickLable.top+nickLable.height+10*BiLiWidth, 200*BiLiWidth, 11*BiLiWidth)];
    cityLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    cityLable.textColor = RGBFormUIColor(0xFF0101);
    cityLable.text = [NormalUse getobjectForKey:[self.tieZiInfo objectForKey:@"city_name"]];//[NSString stringWithFormat:@"%@ %@",[NormalUse getobjectForKey:[self.tieZiInfo objectForKey:@"city_name"]],[NormalUse getobjectForKey:[self.tieZiInfo objectForKey:@"address_detail"]]];
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


    UIImageView * guangTangTipView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, cityLable.top+cityLable.height+16.5*BiLiWidth, 321*BiLiWidth, 95*BiLiWidth)];
    [self.messageContentView addSubview:guangTangTipView];
    
    //是否经过官方认证
    if ([auth_nomal isKindOfClass:[NSNumber class]]) {
        
        if (auth_nomal.intValue==1) {
            guangTangTipView.frame = CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, cityLable.top+cityLable.height+16.5*BiLiWidth, 321*BiLiWidth, 321*BiLiWidth*230/965);
            guangTangTipView.image = [UIImage imageNamed:@"huiYuanTie_tip"];

        }
        else
        {
            guangTangTipView.frame = CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, cityLable.top+cityLable.height+16.5*BiLiWidth, 321*BiLiWidth, 111*BiLiWidth);
            guangTangTipView.image = [UIImage imageNamed:@"vipTieZi_weiRenZheng"];
        }
    }
    else
    {
        guangTangTipView.frame = CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, cityLable.top+cityLable.height+16.5*BiLiWidth, 321*BiLiWidth, 111*BiLiWidth);
        guangTangTipView.image = [UIImage imageNamed:@"vipTieZi_weiRenZheng"];
    }
    
    self.jieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, guangTangTipView.top+guangTangTipView.height+19*BiLiWidth, 321*BiLiWidth, 68*BiLiWidth)];
    
    NSString * unlock_mobile_coin;
    if([@"3" isEqualToString:self.type])
    {
       unlock_mobile_coin = [NormalUse getJinBiStr:@"unlock_goddess_coin"];
    }
    else if ([@"4" isEqualToString:self.type])
    {
        unlock_mobile_coin = [NormalUse getJinBiStr:@"unlock_peripheral_coin"];

    }
    else if ([@"5" isEqualToString:self.type])
    {
        unlock_mobile_coin = [NormalUse getJinBiStr:@"unlock_global_coin"];

    }
    [self.jieSuoButton setBackgroundImage:[UIImage imageNamed:@"sanJiaoSe_jieSuoBottom"] forState:UIControlStateNormal];
    self.jieSuoButton.button_lable.frame = CGRectMake(19.5*BiLiWidth, 0, 150*BiLiWidth, self.jieSuoButton.height);
    self.jieSuoButton.button_lable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.jieSuoButton.button_lable.textColor = RGBFormUIColor(0xFFFFFF);
    self.jieSuoButton.button_lable.text = @"查看地址联系方式";
    self.jieSuoButton.button_imageView.frame = CGRectMake(214*BiLiWidth, 11*BiLiWidth, 105*BiLiWidth, 46*BiLiWidth);
    self.jieSuoButton.button_imageView.image = [UIImage imageNamed:@"sanJiaoSe_jieSuo"];
    self.jieSuoButton.button_lable1.frame = CGRectMake(214*BiLiWidth, 0, 105*BiLiWidth, self.jieSuoButton.height);
    self.jieSuoButton.button_lable1.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.jieSuoButton.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.jieSuoButton.button_lable1.textColor = RGBFormUIColor(0xFFFFFF);
    self.jieSuoButton.button_lable1.text = [NSString stringWithFormat:@"%@金币解锁",[NormalUse getobjectForKey:unlock_mobile_coin]];
    [self.jieSuoButton addTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.messageContentView addSubview:self.jieSuoButton];
    
//    unlock_rpost_coin 仨角色预约金
//    unlock_vpost_coin  会员+经纪人贴预约金
    NSNumber * is_unlock = [self.tieZiInfo objectForKey:@"is_unlock"];
    if([is_unlock isKindOfClass:[NSNumber class]])
    {
        if (is_unlock.intValue==1) {
            
            self.jieSuoButton.button_imageView.hidden = YES;
            NSDictionary * contact = [self.tieZiInfo objectForKey:@"contact"];

            [self.jieSuoButton removeTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.jieSuoButton addTarget:self action:@selector(chatButtonClick) forControlEvents:UIControlEventTouchUpInside];
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];//初始化一个长按手势
            [longPress setMinimumPressDuration:1];//设置按多久之后触发事件
            [self.jieSuoButton addGestureRecognizer:longPress];

           // [16]    (null)    @"mobile" : (long)0    [19]    (null)    @"qq" : (no summary)
            NSString * wechat = [contact objectForKey:@"wechat"];
            NSString * qq = [contact objectForKey:@"qq"];
            NSString * mobile = [contact objectForKey:@"mobile"];
            NSString * lianXieFangShiStr = @"";
            if ([NormalUse isValidString:wechat]) {
                
                lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"微信:%@",wechat]];
            }
            if ([NormalUse isValidString:qq]) {
                
                lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"  QQ:%@",qq]];
            }
            
            if ([NormalUse isValidString:mobile]) {
                
                lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"  电话:%@",mobile]];

            }
            self.lianXieFangShiStr = lianXieFangShiStr;
            self.jieSuoButton.button_lable.adjustsFontSizeToFitWidth = YES;
            self.jieSuoButton.button_lable.left = 10*BiLiWidth;
            self.jieSuoButton.button_lable.width = self.jieSuoButton.width-20*BiLiWidth;
            self.self.jieSuoButton.button_lable.text = lianXieFangShiStr;
            self.self.jieSuoButton.button_lable1.text = @"";


        }
    }

    float originy = self.jieSuoButton.top+self.jieSuoButton.height+10*BiLiWidth;
    //是否经过官方认证
    if ([auth_nomal isKindOfClass:[NSNumber class]]&&auth_nomal.intValue==1) {
        
        UIImageView * yuYueipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, self.jieSuoButton.top+self.jieSuoButton.height+19*BiLiWidth, 321*BiLiWidth, 68*BiLiWidth)];
        yuYueipImageView.image = [UIImage imageNamed:@"sanJiaoSe_yuYueBottom"];
        [self.messageContentView addSubview:yuYueipImageView];
        
        self.yuYueButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, self.jieSuoButton.top+self.jieSuoButton.height+19*BiLiWidth, 321*BiLiWidth, 68*BiLiWidth)];
        self.yuYueButton.backgroundColor = [UIColor clearColor];
        [self.messageContentView addSubview:self.yuYueButton];
        
        NSString * unlock_rpost_coin = [NormalUse getJinBiStr:@"unlock_rpost_coin"];
        UILabel * jieSuoTipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(19.5*BiLiWidth, 0, 150*BiLiWidth, self.yuYueButton.height)];
        jieSuoTipLable1.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*BiLiWidth];
        jieSuoTipLable1.numberOfLines =2;
        jieSuoTipLable1.textColor = RGBFormUIColor(0xFFFFFF);
        [self.yuYueButton addSubview:jieSuoTipLable1];
        
        NSString * str = [NSString stringWithFormat:@"预约金%@金币",unlock_rpost_coin];
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSForegroundColorAttributeName
                      value:RGBFormUIColor(0xFFFC02)
                      range:NSMakeRange(3, unlock_rpost_coin.length)];
        jieSuoTipLable1.attributedText = text1;

        
        UIButton * yueYueTipButton = [[UIButton alloc] initWithFrame:CGRectMake(self.jieSuoButton.width-107*BiLiWidth, (self.jieSuoButton.height-46*BiLiWidth)/2, 107*BiLiWidth, 46*BiLiWidth)];
        [yueYueTipButton setBackgroundImage:[UIImage imageNamed:@"sanJiaoSe_yuYue"] forState:UIControlStateNormal];
        [yueYueTipButton addTarget:self action:@selector(yuYueButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [yueYueTipButton setTitle:@"立即预约" forState:UIControlStateNormal];
        [yueYueTipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        yueYueTipButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        [self.yuYueButton addSubview:yueYueTipButton];

        NSNumber * is_interview = [self.tieZiInfo objectForKey:@"is_interview"];
        if([is_interview isKindOfClass:[NSNumber class]])
        {
            if (is_interview.intValue==1) {

                [self.yuYueButton removeAllSubviews];
                
                UILabel * jieSuoTipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(10*BiLiWidth, 0, self.yuYueButton.width-20*BiLiWidth, self.yuYueButton.height)];
                jieSuoTipLable1.font = [UIFont fontWithName:@"Helvetica-Bold" size:20*BiLiWidth];
                jieSuoTipLable1.numberOfLines =2;
                jieSuoTipLable1.textColor = [UIColor whiteColor];
                [self.yuYueButton addSubview:jieSuoTipLable1];
                
                NSString * str = [NSString stringWithFormat:@"成功缴纳%@预付金,平台担保真实信息,虚假包赔",unlock_rpost_coin];
                NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
                NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
                [text1 addAttribute:NSForegroundColorAttributeName
                              value:RGBFormUIColor(0xFFFC02)
                              range:NSMakeRange(4, unlock_rpost_coin.length)];
                jieSuoTipLable1.attributedText = text1;
                
            }
        }
        
        originy = self.yuYueButton.top+self.yuYueButton.height+10*BiLiWidth;

    }


    
    
    self.tipLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BiLiWidth, originy, WIDTH_PingMu-10*BiLiWidth, 25*BiLiWidth)];
    self.tipLable.text = [self.tieZiInfo objectForKey:@"post_warning_tips"];
    self.tipLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
    self.tipLable.textColor = RGBFormUIColor(0xFF0101);
    self.tipLable.numberOfLines = 2;
    [self.messageContentView addSubview:self.tipLable];
    
    self.messageContentView.height = self.tipLable.bottom+10*BiLiWidth;
    //某个角圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.messageContentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8*BiLiWidth, 8*BiLiWidth)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.messageContentView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.messageContentView.layer.mask = maskLayer;

    
   [self initJiBenZiLiaoView:self.messageContentView.top+self.messageContentView.height];


}
-(void)chatButtonClick
{
    NSNumber * from = [self.tieZiInfo objectForKey:@"from"];
    
    if (from.intValue==2) {
        
        
        ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:@"此帖不支持在线聊天" message2:@"" button1Title:@"确定" button2Title:@""];
        alertView.button1Click = ^{

        };
        alertView.button2Click = ^{
          
        };
        [[UIApplication sharedApplication].keyWindow addSubview:alertView];


    }
    else
    {
        NSNumber * is_unlock = [self.tieZiInfo objectForKey:@"is_unlock"];
        NSNumber * is_interview = [self.tieZiInfo objectForKey:@"is_interview"];
        
        if (is_unlock.intValue==1||is_interview.intValue==1) {
            
            if([NormalUse isValidString:[self.tieZiInfo objectForKey:@"ryuser_id"]])
            {
                NSDictionary * ryInfo = [NormalUse defaultsGetObjectKey:UserRongYunInfo];
                NSLog(@"%@",ryInfo);
                if (![[ryInfo objectForKey:@"userid"] isEqualToString:[self.tieZiInfo objectForKey:@"ryuser_id"]]) {
                    
                    RongYChatViewController *chatVC = [[RongYChatViewController alloc] initWithConversationType:
                                                       ConversationType_PRIVATE targetId:[self.tieZiInfo objectForKey:@"ryuser_id"]];
                    [self.navigationController pushViewController:chatVC animated:YES];

                }

            }
            else
            {
                [NormalUse showToastView:@"该帖子不支持在线聊天" view:self.view];
            }

        }
        else
        {
            ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:@"先解锁或者预约才能在线聊天" message2:@"" button1Title:@"确定" button2Title:@""];
            alertView.button1Click = ^{

            };
            alertView.button2Click = ^{
              
            };
            [[UIApplication sharedApplication].keyWindow addSubview:alertView];

        }

    }

}
-(void)yuYueButtonClick
{
    [NormalUse showMessageLoadView:@"预约中..." vc:self];
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:@"2" forKey:@"type_id"];
    [info setObject:self.girl_id forKey:@"related_id"];
    [HTTPModel yuYueTieZi:info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse removeMessageLoadingView:self];
        if (status==1) {
            
            NSNumber * is_interview = [NSNumber numberWithInt:1];
            [self.tieZiInfo setObject:is_interview forKey:@"is_interview"];

            self->alsoUnlockSuccess = YES;
            if([NormalUse isValidString:[self.tieZiInfo objectForKey:@"ryuser_id"]])
            {
                VipTieZiJieSuoSuccseeTipView * view = [[VipTieZiJieSuoSuccseeTipView alloc] initWithFrame:CGRectZero];
                [self.view addSubview:view];
                view.toConnect = ^{
                    
                    [self chatButtonClick];
                };
            }
            
            [self.yuYueButton removeAllSubviews];
            
            UILabel * jieSuoTipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(10*BiLiWidth, 0, self.yuYueButton.width-20*BiLiWidth, self.yuYueButton.height)];
            jieSuoTipLable1.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*BiLiWidth];
            jieSuoTipLable1.numberOfLines =2;
            jieSuoTipLable1.textColor = [UIColor whiteColor];
            [self.yuYueButton addSubview:jieSuoTipLable1];
            
            NSString * unlock_vpost_coin = [NormalUse getJinBiStr:@"unlock_vpost_coin"];
            NSString * str = [NSString stringWithFormat:@"成功缴纳%@预付金,平台担保真实信息,虚假包赔",unlock_vpost_coin];
            NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
            NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
            [text1 addAttribute:NSForegroundColorAttributeName
                          value:RGBFormUIColor(0xFFFC02)
                          range:NSMakeRange(4, unlock_vpost_coin.length)];
            jieSuoTipLable1.attributedText = text1;
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
            
        }
    }];
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
            
            self->alsoUnlockSuccess = YES;
            NSDictionary * contactInfo = responseObject;
            
            NSNumber * is_unlock = [NSNumber numberWithInt:1];
            [self.tieZiInfo setObject:is_unlock forKey:@"is_unlock"];

            self.jieSuoButton.button_imageView.hidden = YES;
            
             [self.jieSuoButton removeTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.jieSuoButton addTarget:self action:@selector(chatButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];//初始化一个长按手势
            [longPress setMinimumPressDuration:1];//设置按多久之后触发事件
            [self.jieSuoButton addGestureRecognizer:longPress];

            if([NormalUse isValidString:[self.tieZiInfo objectForKey:@"ryuser_id"]])
            {

                JieSuoSuccessTipView * view = [[JieSuoSuccessTipView alloc] initWithFrame:CGRectZero];
                [self.view addSubview:view];
                
                view.toConnect = ^{
                    
                    [self chatButtonClick];
                };

            }

            NSString * lianXieFangShiStr = @"";

            if ([NormalUse isValidDictionary:contactInfo]) {
                
                NSString * wechat = [contactInfo objectForKey:@"wechat"];
                NSString * qq = [contactInfo objectForKey:@"qq"];
                NSString * mobile = [contactInfo objectForKey:@"mobile"];
                if ([NormalUse isValidString:wechat]) {
                    
                    lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"微信:%@",wechat]];
                }
                if ([NormalUse isValidString:qq]) {
                    
                    lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"  QQ:%@",qq]];
                }
                
                if ([NormalUse isValidString:mobile]) {
                    
                    lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"  电话:%@",mobile]];

                }

            }
            self.lianXieFangShiStr = lianXieFangShiStr;
            self.jieSuoButton.button_lable.adjustsFontSizeToFitWidth = YES;
             self.jieSuoButton.button_lable.left = 10*BiLiWidth;
             self.jieSuoButton.button_lable.width = self.jieSuoButton.width-20*BiLiWidth;
             self.jieSuoButton.button_lable.text = lianXieFangShiStr;
             self.jieSuoButton.button_lable1.text = @"";

            [NormalUse showToastView:@"解锁成功" view:self.view];
        }
        else
        {
            if(status==11402)
            {
                ChongZhiOrHuiYuanAlertView * view = [[ChongZhiOrHuiYuanAlertView alloc] initWithFrame:CGRectZero];
                [view initData];
                [self.view addSubview:view];

            }
            else
            {
                [NormalUse showToastView:msg view:self.view];

            }
            
        }
        
    }];
    
}
-(void)longPressAction:(UILongPressGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateBegan) {
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.lianXieFangShiStr;

        [NormalUse showToastView:@"已复制到剪切板" view:self.view];
        
        
        }else {
            NSLog(@"long pressTap state :end");
        }

}
-(void)initJiBenZiLiaoView:(float)originY
{
    self.jiBenXinXiContentView = [[UIView alloc] initWithFrame:CGRectMake(0, originY, WIDTH_PingMu, 0)];
    self.jiBenXinXiContentView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.jiBenXinXiContentView];
    
    UILabel * xiangQingJieShaoLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 0, 70*BiLiWidth, 16*BiLiWidth)];
    xiangQingJieShaoLable.textColor = RGBFormUIColor(0x343434);
    xiangQingJieShaoLable.font = [UIFont systemFontOfSize:16*BiLiWidth];
    xiangQingJieShaoLable.text = @"基本资料";
    [self.jiBenXinXiContentView addSubview:xiangQingJieShaoLable];

    //价格
    UIImageView * jiaGeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, xiangQingJieShaoLable.top+xiangQingJieShaoLable.height+10*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
    jiaGeImageView.image = [UIImage imageNamed:@"ziLiao_jiaGe"];
    [self.jiBenXinXiContentView addSubview:jiaGeImageView];
    
    UILabel * jiaGeLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, xiangQingJieShaoLable.top+xiangQingJieShaoLable.height+10*BiLiWidth, 200*BiLiWidth, 12*BiLiWidth)];
    jiaGeLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    jiaGeLable.textColor = RGBFormUIColor(0x666666);
//    jiaGeLable.text = [NSString stringWithFormat:@"价格：%@-%@",[self.tieZiInfo objectForKey:@"min_price"],[self.tieZiInfo objectForKey:@"max_price"]];
    jiaGeLable.text = [NSString stringWithFormat:@"价格：%@",[NormalUse getobjectForKey:[self.tieZiInfo objectForKey:@"nprice_label"]]];
    [self.jiBenXinXiContentView addSubview:jiaGeLable];
    
    //年龄
    UIImageView * ageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, jiaGeImageView.top+jiaGeImageView.height+14*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
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
    xiangMuLable.text = [NSString stringWithFormat:@"项目：%@",[self.tieZiInfo objectForKey:@"service_type"]];
//    xiangMuLable.adjustsFontSizeToFitWidth = YES;
    [self.jiBenXinXiContentView addSubview:xiangMuLable];

    UILabel * zongHePingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, xiangMuLable.bottom+10*BiLiWidth, 70*BiLiWidth, 16*BiLiWidth)];
        zongHePingFenLable.textColor = RGBFormUIColor(0x343434);
        zongHePingFenLable.font = [UIFont systemFontOfSize:16*BiLiWidth];
        zongHePingFenLable.text = @"综合评分";
        [self.jiBenXinXiContentView addSubview:zongHePingFenLable];
        
        UIImageView * yanZhiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, zongHePingFenLable.top+zongHePingFenLable.height+14*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
        yanZhiImageView.image = [UIImage imageNamed:@"vipTie_yanZhi"];
        [self.jiBenXinXiContentView addSubview:yanZhiImageView];
        
        UILabel * yanZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, yanZhiImageView.top, 300*BiLiWidth, 12*BiLiWidth)];
        yanZhiLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        yanZhiLable.textColor = RGBFormUIColor(0x666666);
        yanZhiLable.text = @"颜值";
        yanZhiLable.adjustsFontSizeToFitWidth = YES;
        [self.jiBenXinXiContentView addSubview:yanZhiLable];
        
        UIImageView * jiShuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, yanZhiLable.top+yanZhiLable.height+14*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
        jiShuImageView.image = [UIImage imageNamed:@"vipTie_jiShu"];
        [self.jiBenXinXiContentView addSubview:jiShuImageView];
        
        UILabel * jiShuLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, jiShuImageView.top, 300*BiLiWidth, 12*BiLiWidth)];
        jiShuLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        jiShuLable.textColor = RGBFormUIColor(0x666666);
        jiShuLable.text = @"技术";
        jiShuLable.adjustsFontSizeToFitWidth = YES;
        [self.jiBenXinXiContentView addSubview:jiShuLable];

        
        UIImageView * huanJingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, jiShuLable.top+jiShuLable.height+14*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
        huanJingImageView.image = [UIImage imageNamed:@"vipTie_huanJing"];
        [self.jiBenXinXiContentView addSubview:huanJingImageView];
        
        UILabel * huanJingLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, huanJingImageView.top, 300*BiLiWidth, 12*BiLiWidth)];
        huanJingLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        huanJingLable.textColor = RGBFormUIColor(0x666666);
        huanJingLable.text = @"环境";
        huanJingLable.adjustsFontSizeToFitWidth = YES;
        [self.jiBenXinXiContentView addSubview:huanJingLable];
        
        UILabel * pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(0, zongHePingFenLable.bottom+18*BiLiWidth, WIDTH_PingMu, 33*BiLiWidth)];
        pingFenLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:33*BiLiWidth];
        pingFenLable.textColor = RGBFormUIColor(0xFFA217);
        pingFenLable.textAlignment = NSTextAlignmentCenter;
        pingFenLable.adjustsFontSizeToFitWidth = YES;
        NSNumber * complex_score= [self.tieZiInfo objectForKey:@"complex_score"];
        if ([complex_score isKindOfClass:[NSNumber class]]) {
            
            pingFenLable.text = [NSString stringWithFormat:@"%d",complex_score.intValue];

        }
        [self.jiBenXinXiContentView addSubview:pingFenLable];

        UILabel * pingFenTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, pingFenLable.bottom+12*BiLiWidth, WIDTH_PingMu, 14*BiLiWidth)];
        pingFenTipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        pingFenTipLable.textColor = RGBFormUIColor(0x666666);
        pingFenTipLable.textAlignment = NSTextAlignmentCenter;
        pingFenTipLable.adjustsFontSizeToFitWidth = YES;
        pingFenTipLable.text = @"综合评分（满分5分）";
        [self.jiBenXinXiContentView addSubview:pingFenTipLable];


        self.jiBenXinXiContentView.height = huanJingLable.bottom+20*BiLiWidth;

    
    [self initXiangQingJieShaoView:self.jiBenXinXiContentView.top+self.jiBenXinXiContentView.height];

}
-(void)initXiangQingJieShaoView:(float)originY
{
    self.xiangQingJieShaoContentView = [[UIView alloc] initWithFrame:CGRectMake(0, originY, WIDTH_PingMu, 0)];
    [self.mainScrollView addSubview:self.xiangQingJieShaoContentView];
    
    UILabel * xiangQingJieShaoLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 0, 70*BiLiWidth, 16*BiLiWidth)];
    xiangQingJieShaoLable.textColor = RGBFormUIColor(0x343434);
    xiangQingJieShaoLable.font = [UIFont systemFontOfSize:16*BiLiWidth];
    xiangQingJieShaoLable.text = @"详情介绍";
    [self.xiangQingJieShaoContentView addSubview:xiangQingJieShaoLable];

    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, xiangQingJieShaoLable.top+xiangQingJieShaoLable.height+10*BiLiWidth, 333*BiLiWidth, 0)];
    messageLable.numberOfLines = 0;
    messageLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    messageLable.textColor = RGBFormUIColor(0x343434);
    [self.xiangQingJieShaoContentView addSubview:messageLable];

//    NSString * neiRongStr = [NormalUse getobjectForKey:[self.tieZiInfo objectForKey:@"decription"]];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    //调整行间距
//    [paragraphStyle setLineSpacing:2];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
//    messageLable.attributedText = attributedString;
//    //设置自适应
//    [messageLable  sizeToFit];
    
    NSString * content = [NormalUse getobjectForKey:[self.tieZiInfo objectForKey:@"decription"]];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    messageLable.attributedText = attrStr;
    [messageLable sizeToFit];

    
    self.xiangQingJieShaoContentView.height = messageLable.top+messageLable.height+10*BiLiWidth;

    [self initChenYouPingJiaTableView:self.xiangQingJieShaoContentView.top+self.xiangQingJieShaoContentView.height];

}
-(void)initChenYouPingJiaTableView:(float)originY
{
    
    float tableViewHeight = 0;
    for (NSDictionary * info in self.pingLunArray) {
        
        tableViewHeight = tableViewHeight+[CheYouPingJiaCell cellHegiht:info];
    }
    UILabel * chenYouPingJiaLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, originY, 70*BiLiWidth, 16*BiLiWidth)];
    chenYouPingJiaLable.textColor = RGBFormUIColor(0x343434);
    chenYouPingJiaLable.font = [UIFont systemFontOfSize:16*BiLiWidth];
    chenYouPingJiaLable.text = @"车友评价";
    [self.mainScrollView addSubview:chenYouPingJiaLable];

    self.cheYouPingJiaTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, chenYouPingJiaLable.top+chenYouPingJiaLable.height+10*BiLiWidth, WIDTH_PingMu, tableViewHeight)];
    self.cheYouPingJiaTableView.delegate = self;
    self.cheYouPingJiaTableView.dataSource = self;
    self.cheYouPingJiaTableView.scrollEnabled = NO;
    self.cheYouPingJiaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainScrollView addSubview:self.cheYouPingJiaTableView];
    
    if (tableViewHeight==0) {
        
        tableViewHeight = self.noMessageTipButotn.height;
        self.cheYouPingJiaTableView.height = tableViewHeight;
        [self.cheYouPingJiaTableView addSubview:self.noMessageTipButotn];
    }
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.cheYouPingJiaTableView.top+self.cheYouPingJiaTableView.height)];

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
        
        [HTTPModel tieZiFollow:[[NSDictionary alloc]initWithObjectsAndKeys:self.girl_id,@"post_id",@"2",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
           
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
        NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:self.girl_id,@"post_id",@"2",@"type_id", nil];
        [HTTPModel tieZiUnFollow:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
           
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
// 获取网络视频第一帧
- (UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

#pragma mark--JYCarouselDelegate
-(void)carouseScrollToIndex:(NSInteger)index
{
    if (index>0) {
        
        self.pageControll.currentPage = index-1;

    }else
    {
        self.pageControll.currentPage = 0;
    }

    sliderIndex = index;
    if ([[self.images objectAtIndex:index] isKindOfClass:[UIImage class]]) {
        
        self.videoButton.hidden = NO;
    }
    else
    {
        self.videoButton.hidden = YES;
    }

}
-(void)videoButtonClick
{
    [self carouselViewClick:sliderIndex];
}
- (void)carouselViewClick:(NSInteger)index
{
    
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate yinCangTabbar];
    
    
    NSMutableArray * photos = [NSMutableArray array];
    
    NSArray * images = [self.tieZiInfo objectForKey:@"images"];
    if ([NormalUse isValidArray:images]) {
        
        for (int i=0;i<images.count;i++) {
            
            MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[images objectAtIndex:i]]];
            [photos addObject:photo];
        }

    }
    
    NSArray * videos = [self.tieZiInfo objectForKey:@"videos"];
    if ([NormalUse isValidArray:videos]) {
        for (int i=0;i<videos.count;i++) {
            NSDictionary * info = [videos objectAtIndex:i];
            MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[info objectForKey:@"fframe"]]];
            photo.videoURL = [NSURL URLWithString:[info objectForKey:@"url"]];
            [photos addObject:photo];
        }

    }

    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser setCurrentPhotoIndex:index];
    [[NormalUse getCurrentVC].navigationController pushViewController:browser animated:YES];

}


@end
