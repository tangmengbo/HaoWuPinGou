//
//  DingZhiFuWuDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/16.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "DingZhiFuWuDetailViewController.h"

@interface DingZhiFuWuDetailViewController ()

@property(nonatomic,strong)NSDictionary * dingZhiInfo;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)Lable_ImageButton * jieSuoButton;


@end

@implementation DingZhiFuWuDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"详情";
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    
    [NormalUse xianShiGifLoadingView:self];
    [HTTPModel getDingZhiDetail:[[NSDictionary alloc]initWithObjectsAndKeys:self.idStr,@"id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse quXiaoGifLoadingView:self];
        
        if (status==1) {
            
            self.dingZhiInfo = responseObject;
            [self initView];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
}
-(void)initView
{
    NSDictionary * userinfo = [self.dingZhiInfo objectForKey:@"userinfo"];
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14*BiLiWidth, 14*BiLiWidth, 48*BiLiWidth, 48*BiLiWidth)];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    headerImageView.clipsToBounds = YES;
    headerImageView.layer.cornerRadius = 24*BiLiWidth;
    [self.mainScrollView addSubview:headerImageView];
    
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:[userinfo objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"moRen_header"]];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.width+headerImageView.left+13.5*BiLiWidth, headerImageView.top+6.5*BiLiWidth, 150*BiLiWidth, 15*BiLiWidth)];
    titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    titleLable.textColor = RGBFormUIColor(0x333333);
    [self.mainScrollView addSubview:titleLable];
    
    titleLable.text = [userinfo objectForKey:@"nickname"];
    
    UILabel * weiZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-115*BiLiWidth, titleLable.top, 100*BiLiWidth, titleLable.height)];
    weiZhiLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    weiZhiLable.textColor = RGBFormUIColor(0x999999);
    weiZhiLable.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:weiZhiLable];
    
    weiZhiLable.text = [NormalUse getobjectForKey:[self.dingZhiInfo objectForKey:@"city_name"]];
    
    UILabel * faBuTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(titleLable.left, titleLable.top+titleLable.height+10*BiLiWidth, 200*BiLiWidth, 12*BiLiWidth)];
    faBuTimeLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    faBuTimeLable.textColor = RGBFormUIColor(0x999999);
    [self.mainScrollView addSubview:faBuTimeLable];
    
    faBuTimeLable.text = [self.dingZhiInfo objectForKey:@"create_at"];
    
    UILabel * priceLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, headerImageView.top+headerImageView.height+25*BiLiWidth, 200*BiLiWidth, 17*BiLiWidth)];
    priceLable.font = [UIFont systemFontOfSize:17*BiLiWidth];
    priceLable.textColor = RGBFormUIColor(0xFFA217);
    [self.mainScrollView addSubview:priceLable];
    
//    if ([NormalUse isValidString:[self.dingZhiInfo objectForKey:@"min_price"]] && [NormalUse isValidString:[self.dingZhiInfo objectForKey:@"max_price"]]) {
//
//        priceLable.text = [NSString stringWithFormat:@"¥ %@~%@",[self.dingZhiInfo objectForKey:@"min_price"],[self.dingZhiInfo objectForKey:@"max_price"]];
//
//    }
    priceLable.text = [NSString stringWithFormat:@"价格: %@",[NormalUse getobjectForKey:[self.dingZhiInfo objectForKey:@"nprice_label"]]];

    
    UILabel * describleLable = [[UILabel alloc] initWithFrame:CGRectMake(priceLable.left, priceLable.top+priceLable.height+19*BiLiWidth, WIDTH_PingMu-priceLable.left*2, 0)];
    describleLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    describleLable.textColor = RGBFormUIColor(0x33333);
    describleLable.numberOfLines = 0;
    [self.mainScrollView addSubview:describleLable];
    
    NSString * neiRongStr = [self.dingZhiInfo objectForKey:@"describe"];
    if (![NormalUse isValidString:neiRongStr]) {
        
        neiRongStr = @"无特殊需求";
    }

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    describleLable.attributedText = attributedString;
    //设置自适应
    [describleLable  sizeToFit];

    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(priceLable.left, describleLable.top+describleLable.height+8*BiLiWidth, WIDTH_PingMu-priceLable.left*2, 14*BiLiWidth)];
    timeLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    timeLable.textColor = RGBFormUIColor(0x333333);
    [self.mainScrollView addSubview:timeLable];
    
    if ([NormalUse isValidString:[self.dingZhiInfo objectForKey:@"start_date"]] && [NormalUse isValidString:[self.dingZhiInfo objectForKey:@"end_date"]]) {
        
        timeLable.text = [NSString stringWithFormat:@"时间 %@~%@",[self.dingZhiInfo objectForKey:@"start_date"],[self.dingZhiInfo objectForKey:@"end_date"]];

    }

    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(timeLable.left, timeLable.top+timeLable.height+33*BiLiWidth, 200*BiLiWidth, 20*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:16*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0x333333);
    tipLable.text = @"需求描述";
    [self.mainScrollView addSubview:tipLable];
    
    UILabel * meiZiLeiXingTip = [[UILabel alloc] initWithFrame:CGRectMake(tipLable.left, tipLable.top+tipLable.height+13.5*BiLiWidth, 200*BiLiWidth, 14*BiLiWidth)];
    meiZiLeiXingTip.font = [UIFont systemFontOfSize:14*BiLiWidth];
    meiZiLeiXingTip.textColor = RGBFormUIColor(0x999999);
    meiZiLeiXingTip.text = @"喜欢的妹子类型";
    [self.mainScrollView addSubview:meiZiLeiXingTip];
    
    float originx = 18*BiLiWidth;
    float originy = meiZiLeiXingTip.top+meiZiLeiXingTip.height+10*BiLiWidth;
    float xDisTance =  10*BiLiWidth;
    float yDistance = 10*BiLiWidth;

    NSArray * love_typeArray = [self.dingZhiInfo objectForKey:@"love_type"];
    for (int i=0; i<love_typeArray.count; i++) {
        
        NSString * leiXingStr = [love_typeArray objectAtIndex:i];
        
        CGSize size = [NormalUse setSize:leiXingStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:11*BiLiWidth];
        
        if (originx+size.width+32*BiLiWidth>WIDTH_PingMu-36*BiLiWidth) {
            
            originx = 18*BiLiWidth;
            originy = originy+24*BiLiWidth+yDistance;
        }
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originx, originy,size.width+32*BiLiWidth, 24*BiLiWidth)];
        [button setTitle:leiXingStr forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
        button.tag=i;
        button.backgroundColor = RGBFormUIColor(0xEEEEEE);
        button.layer.cornerRadius = 12*BiLiWidth;
        [self.mainScrollView addSubview:button];
        
        originx = originx+button.width+xDisTance;
    }

    UILabel * fuWuLeiXingTip = [[UILabel alloc] initWithFrame:CGRectMake(18*BiLiWidth, originy+20*BiLiWidth+24*BiLiWidth, 200*BiLiWidth, 14*BiLiWidth)];
    fuWuLeiXingTip.font = [UIFont systemFontOfSize:14*BiLiWidth];
    fuWuLeiXingTip.textColor = RGBFormUIColor(0x999999);
    fuWuLeiXingTip.text = @"想要的服务项目";
    [self.mainScrollView addSubview:fuWuLeiXingTip];
    
    originx = 18*BiLiWidth;
    originy = fuWuLeiXingTip.top+fuWuLeiXingTip.height+10*BiLiWidth;
    
    NSArray * service_typeArray = [self.dingZhiInfo objectForKey:@"service_type"];
    for (int i=0; i<service_typeArray.count; i++) {
        
        NSString * leiXingStr = [service_typeArray objectAtIndex:i];
        
        CGSize size = [NormalUse setSize:leiXingStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:11*BiLiWidth];
        
        if (originx+size.width+32*BiLiWidth>WIDTH_PingMu-36*BiLiWidth) {
            
            originx = 18*BiLiWidth;
            originy = originy+24*BiLiWidth+yDistance;
        }
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originx, originy,size.width+32*BiLiWidth, 24*BiLiWidth)];
        [button setTitle:leiXingStr forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
        button.backgroundColor = RGBFormUIColor(0xEEEEEE);
        button.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
        button.tag=i;
        button.layer.cornerRadius = 12*BiLiWidth;
        [self.mainScrollView addSubview:button];
        
        originx = originx+button.width+xDisTance;
    }


    NSString * unlock_demand_coin = [NormalUse getJinBiStr:@"unlock_demand_coin"];
    
    self.jieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, originy+24*BiLiWidth+25*BiLiWidth, 321*BiLiWidth, 57*BiLiWidth)];
    [self.jieSuoButton setBackgroundImage:[UIImage imageNamed:@"jieSuo_bottomIMageView"] forState:UIControlStateNormal];
    self.jieSuoButton.button_lable.frame = CGRectMake(19.5*BiLiWidth, 0, 150*BiLiWidth, self.jieSuoButton.height);
    self.jieSuoButton.button_lable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.jieSuoButton.button_lable.textColor = RGBFormUIColor(0xFFE1B0);
    self.jieSuoButton.button_lable.text = @"查看地址联系方式";
    self.jieSuoButton.button_lable1.frame = CGRectMake(227*BiLiWidth, 0, 150*BiLiWidth, self.jieSuoButton.height);
    self.jieSuoButton.button_lable1.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.jieSuoButton.button_lable1.textColor = RGBFormUIColor(0xFFE1B0);
    self.jieSuoButton.button_lable1.text = [NSString stringWithFormat:@"%@金币解锁",[NormalUse getobjectForKey:unlock_demand_coin]];
    [self.jieSuoButton addTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.jieSuoButton];
    

    NSNumber * is_unlock = [self.dingZhiInfo objectForKey:@"is_unlock"];
    if([is_unlock isKindOfClass:[NSNumber class]])
    {
        if (is_unlock.intValue==1) {
            
            NSDictionary * contact = [self.dingZhiInfo objectForKey:@"contact"];
            [self.jieSuoButton removeTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.jieSuoButton addTarget:self action:@selector(chatButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];//初始化一个长按手势
            [longPress setMinimumPressDuration:1];//设置按多久之后触发事件
            [self.jieSuoButton addGestureRecognizer:longPress];


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
            self.jieSuoButton.button_lable.left = 10*BiLiWidth;
            self.jieSuoButton.button_lable.width = self.jieSuoButton.width-20*BiLiWidth;
            self.jieSuoButton.button_lable.adjustsFontSizeToFitWidth = YES;
            self.jieSuoButton.button_lable.text = lianXieFangShiStr;
            self.jieSuoButton.button_lable1.text = @"";


        }
    }
}
-(void)chatButtonClick
{
    if([NormalUse isValidString:[self.dingZhiInfo objectForKey:@"ryuser_id"]])
    {
        NSDictionary * ryInfo = [NormalUse defaultsGetObjectKey:UserRongYunInfo];
        if (![[ryInfo objectForKey:@"userid"] isEqualToString:[self.dingZhiInfo objectForKey:@"ryuser_id"]]) {
            
            RongYChatViewController *chatVC = [[RongYChatViewController alloc] initWithConversationType:
                                               ConversationType_PRIVATE targetId:[self.dingZhiInfo objectForKey:@"ryuser_id"]];
            [self.navigationController pushViewController:chatVC animated:YES];

        }


    }
}

-(void)jieSuoButtonClick
{
    [NormalUse showMessageLoadView:@"解锁中..." vc:self];
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:@"6" forKey:@"type_id"];
    [info setObject:self.idStr forKey:@"related_id"];
    [HTTPModel unlockMobile:info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse removeMessageLoadingView:self];
        if (status==1) {
            
            NSDictionary * contactInfo = responseObject;
            
            if([NormalUse isValidString:[self.dingZhiInfo objectForKey:@"ryuser_id"]])
            {
                JieSuoSuccessTipView * view = [[JieSuoSuccessTipView alloc] initWithFrame:CGRectZero];
                [self.view addSubview:view];
                
                view.toConnect = ^{
                    
                    [self chatButtonClick];
                };
            }
            
             [self.jieSuoButton removeTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.jieSuoButton addTarget:self action:@selector(chatButtonClick) forControlEvents:UIControlEventTouchUpInside];
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];//初始化一个长按手势
            [longPress setMinimumPressDuration:1];//设置按多久之后触发事件
            [self.jieSuoButton addGestureRecognizer:longPress];

            
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
                
                if (([NormalUse isValidString:mobile])) {
                    
                    lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"  电话:%@",mobile]];

                }

            }
            self.lianXieFangShiStr = lianXieFangShiStr;
             self.jieSuoButton.button_lable.left = 10*BiLiWidth;
             self.jieSuoButton.button_lable.width = self.jieSuoButton.width-20*BiLiWidth;
            self.jieSuoButton.button_lable.adjustsFontSizeToFitWidth = YES;
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
@end
