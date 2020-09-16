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
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21.5*BiLiWidth, 13.5*BiLiWidth, 38*BiLiWidth, 38*BiLiWidth)];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    headerImageView.clipsToBounds = YES;
    headerImageView.layer.cornerRadius = 19*BiLiWidth;
    [self.mainScrollView addSubview:headerImageView];
    
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:[userinfo objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"moRen_header"]];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.width+headerImageView.left+10*BiLiWidth, 15.5*BiLiWidth, 150*BiLiWidth, 15*BiLiWidth)];
    titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    titleLable.textColor = RGBFormUIColor(0x333333);
    [self.mainScrollView addSubview:titleLable];
    
    titleLable.text = [userinfo objectForKey:@"nickname"];
    
    UILabel * weiZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-120*BiLiWidth, titleLable.top, 100*BiLiWidth, titleLable.height)];
    weiZhiLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
    weiZhiLable.textColor = RGBFormUIColor(0x999999);
    weiZhiLable.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:weiZhiLable];
    
    weiZhiLable.text = [NormalUse getobjectForKey:[self.dingZhiInfo objectForKey:@"city_name"]];
    
    UILabel * faBuTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(titleLable.left, titleLable.top+titleLable.height+6.5*BiLiWidth, 200*BiLiWidth, 10*BiLiWidth)];
    faBuTimeLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
    faBuTimeLable.textColor = RGBFormUIColor(0x999999);
    [self.mainScrollView addSubview:faBuTimeLable];
    
    faBuTimeLable.text = [self.dingZhiInfo objectForKey:@"create_at"];
    
    UILabel * priceLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, headerImageView.top+headerImageView.height+15*BiLiWidth, 200*BiLiWidth, 20*BiLiWidth)];
    priceLable.font = [UIFont systemFontOfSize:20*BiLiWidth];
    priceLable.textColor = RGBFormUIColor(0x343434);
    [self.mainScrollView addSubview:priceLable];
    
    if ([NormalUse isValidString:[self.dingZhiInfo objectForKey:@"min_price"]] && [NormalUse isValidString:[self.dingZhiInfo objectForKey:@"max_price"]]) {
        
        priceLable.text = [NSString stringWithFormat:@"¥ %@~%@",[self.dingZhiInfo objectForKey:@"min_price"],[self.dingZhiInfo objectForKey:@"max_price"]];

    }
    
    UILabel * describleLable = [[UILabel alloc] initWithFrame:CGRectMake(priceLable.left, priceLable.top+priceLable.height+15*BiLiWidth, WIDTH_PingMu-priceLable.left*2, 0)];
    describleLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    describleLable.textColor = RGBFormUIColor(0x343434);
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

    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(priceLable.left, describleLable.top+describleLable.height+15*BiLiWidth, WIDTH_PingMu-priceLable.left*2, 12*BiLiWidth)];
    timeLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    timeLable.textColor = RGBFormUIColor(0x343434);
    [self.mainScrollView addSubview:timeLable];
    
    if ([NormalUse isValidString:[self.dingZhiInfo objectForKey:@"start_date"]] && [NormalUse isValidString:[self.dingZhiInfo objectForKey:@"end_date"]]) {
        
        timeLable.text = [NSString stringWithFormat:@"时间 %@~%@",[self.dingZhiInfo objectForKey:@"start_date"],[self.dingZhiInfo objectForKey:@"end_date"]];

    }

    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(timeLable.left, timeLable.top+timeLable.height+20*BiLiWidth, 200*BiLiWidth, 20*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:20*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0x333333);
    tipLable.text = @"需求描述";
    [self.mainScrollView addSubview:tipLable];
    
    UILabel * meiZiLeiXingTip = [[UILabel alloc] initWithFrame:CGRectMake(40*BiLiWidth, tipLable.top+tipLable.height+15*BiLiWidth, 200*BiLiWidth, 12*BiLiWidth)];
    meiZiLeiXingTip.font = [UIFont systemFontOfSize:12*BiLiWidth];
    meiZiLeiXingTip.textColor = RGBFormUIColor(0x343434);
    meiZiLeiXingTip.text = @"喜欢的妹子类型";
    [self.mainScrollView addSubview:meiZiLeiXingTip];
    
    float originx = 40*BiLiWidth;
    float originy = meiZiLeiXingTip.top+meiZiLeiXingTip.height+10*BiLiWidth;
    float xDisTance =  10*BiLiWidth;
    float yDistance = 20*BiLiWidth;

    NSArray * love_typeArray = [self.dingZhiInfo objectForKey:@"love_type"];
    for (int i=0; i<love_typeArray.count; i++) {
        
        NSString * leiXingStr = [love_typeArray objectAtIndex:i];
        
        CGSize size = [NormalUse setSize:leiXingStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
        
        if (originx+size.width>WIDTH_PingMu-40*BiLiWidth) {
            
            originx = 40*BiLiWidth;
            originy = originy+20*BiLiWidth+yDistance;
        }
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originx, originy,size.width+10*BiLiWidth, 20*BiLiWidth)];
        [button setTitle:leiXingStr forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        button.tag=i;
        button.layer.cornerRadius = 10*BiLiWidth;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [RGBFormUIColor(0x343434) CGColor];
        [self.mainScrollView addSubview:button];
        
        originx = originx+button.width+xDisTance;
    }

    UILabel * fuWuLeiXingTip = [[UILabel alloc] initWithFrame:CGRectMake(40*BiLiWidth, originy+20*BiLiWidth+30*BiLiWidth, 200*BiLiWidth, 12*BiLiWidth)];
    fuWuLeiXingTip.font = [UIFont systemFontOfSize:12*BiLiWidth];
    fuWuLeiXingTip.textColor = RGBFormUIColor(0x343434);
    fuWuLeiXingTip.text = @"想要的服务项目";
    [self.mainScrollView addSubview:fuWuLeiXingTip];
    
    originx = 40*BiLiWidth;
    originy = fuWuLeiXingTip.top+fuWuLeiXingTip.height+10*BiLiWidth;
    
    NSArray * service_typeArray = [self.dingZhiInfo objectForKey:@"service_type"];
    for (int i=0; i<service_typeArray.count; i++) {
        
        NSString * leiXingStr = [service_typeArray objectAtIndex:i];
        
        CGSize size = [NormalUse setSize:leiXingStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
        
        if (originx+size.width>WIDTH_PingMu-40*BiLiWidth) {
            
            originx = 40*BiLiWidth;
            originy = originy+20*BiLiWidth+yDistance;
        }
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originx, originy,size.width+10*BiLiWidth, 20*BiLiWidth)];
        [button setTitle:leiXingStr forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        button.tag=i;
        button.layer.cornerRadius = 10*BiLiWidth;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [RGBFormUIColor(0x343434) CGColor];
        [self.mainScrollView addSubview:button];
        
        originx = originx+button.width+xDisTance;
    }


    NSString * unlock_mobile_coin = [NormalUse getJinBiStr:@"unlock_mobile_coin"];
    
    self.jieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, originy+20*BiLiWidth+50*BiLiWidth, 321*BiLiWidth, 57*BiLiWidth)];
    [self.jieSuoButton setBackgroundImage:[UIImage imageNamed:@"jieSuo_bottomIMageView"] forState:UIControlStateNormal];
    self.jieSuoButton.button_lable.frame = CGRectMake(19.5*BiLiWidth, 0, 150*BiLiWidth, self.jieSuoButton.height);
    self.jieSuoButton.button_lable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.jieSuoButton.button_lable.textColor = RGBFormUIColor(0xFFE1B0);
    self.jieSuoButton.button_lable.text = @"查看地址联系方式";
    self.jieSuoButton.button_lable1.frame = CGRectMake(227*BiLiWidth, 0, 150*BiLiWidth, self.jieSuoButton.height);
    self.jieSuoButton.button_lable1.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.jieSuoButton.button_lable1.textColor = RGBFormUIColor(0xFFE1B0);
    self.jieSuoButton.button_lable1.text = [NSString stringWithFormat:@"%@金币解锁",[NormalUse getobjectForKey:unlock_mobile_coin]];
    [self.jieSuoButton addTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.jieSuoButton];
    

    NSNumber * is_unlock = [self.dingZhiInfo objectForKey:@"is_unlock"];
    if([is_unlock isKindOfClass:[NSNumber class]])
    {
        if (is_unlock.intValue==1) {
            
            NSDictionary * contact = [self.dingZhiInfo objectForKey:@"contact"];
            [self.jieSuoButton removeTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
            self.jieSuoButton.button_lable.width = 300*BiLiWidth;
            self.jieSuoButton.button_lable.adjustsFontSizeToFitWidth = YES;
            self.jieSuoButton.button_lable.text = lianXieFangShiStr;
            self.jieSuoButton.button_lable1.text = @"";


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
             self.jieSuoButton.button_lable.width = 300*BiLiWidth;
            self.jieSuoButton.button_lable.adjustsFontSizeToFitWidth = YES;
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
@end
