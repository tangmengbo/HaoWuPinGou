//
//  TieZiDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/31.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "TieZiDetailViewController.h"
#import "VipTieZiJieSuoSuccseeTipView.h"

@interface TieZiDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSInteger sliderIndex;
    
    int payTypeIndex;
}

@property(nonatomic,strong)NSMutableDictionary * tieZiInfo;

@property(nonatomic,strong)NSMutableArray * images;

@property(nonatomic,strong)UIButton * videoButton;

@property(nonatomic,strong)AutoScrollLabel * autoLabel;

@property(nonatomic,strong)NSArray * payTypeList;
@property(nonatomic,strong)UIView * zhiFuView;
@property(nonatomic,strong)NSMutableArray * payTypeButtonArray;
@property(nonatomic,strong)NSString * orderId;

@end

@implementation TieZiDetailViewController

-(UIView *)zhiFuView
{
    if (!_zhiFuView) {

        _zhiFuView= [[UIView alloc] initWithFrame:CGRectMake(0,0, WIDTH_PingMu, HEIGHT_PingMu)];
        _zhiFuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self.view addSubview:_zhiFuView];
        
        UIView * whiteContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 0)];
        whiteContentView.backgroundColor = [UIColor whiteColor];
        [_zhiFuView addSubview:whiteContentView];

        UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BiLiWidth, 15*BiLiWidth, 200*BiLiWidth, 17*BiLiWidth)];
        tipLable.text = @"选择支付方式";
        tipLable.textColor = RGBFormUIColor(0xFFA218);
        tipLable.font = [UIFont systemFontOfSize:17*BiLiWidth];
        [whiteContentView addSubview:tipLable];

        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-28*BiLiWidth, 13*BiLiWidth, 14.5*BiLiWidth, 14.5*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"dianPu_tip_close"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeZhiFuView) forControlEvents:UIControlEventTouchUpInside];
        [whiteContentView addSubview:closeButton];
        
        float originY = tipLable.top+tipLable.height+10*BiLiWidth;
        self.payTypeButtonArray = [NSMutableArray array];
        for(int i=0;i<self.payTypeList.count;i++)
        {
            NSDictionary * info = [self.payTypeList objectAtIndex:i];
            
            Lable_ImageButton * button  = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, originY, WIDTH_PingMu, 21*BiLiWidth)];
            [button addTarget:self action:@selector(payTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.button_imageView.frame = CGRectMake(19*BiLiWidth, 0, 21*BiLiWidth, 21*BiLiWidth);
            button.button_lable.frame = CGRectMake(button.button_imageView.left+button.button_imageView.width+6.5*BiLiWidth, 0, 200*BiLiWidth, 21*BiLiWidth);
            button.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
            button.button_lable.textColor = RGBFormUIColor(0x343434);
            button.button_imageView1.frame = CGRectMake(WIDTH_PingMu-14.5*BiLiWidth-28.5*BiLiWidth, (button.height-14.5*BiLiWidth)/2, 14.5*BiLiWidth, 14.5*BiLiWidth);
            button.button_imageView1.layer.cornerRadius = 15.4*BiLiWidth/2;
            button.button_imageView1.layer.masksToBounds = YES;
            button.button_imageView1.layer.borderWidth = 1;
            button.button_imageView1.layer.borderColor = [RGBFormUIColor(0x343434) CGColor];
            button.tag = i;
            [whiteContentView addSubview:button];
            
            if ([@"微信支付" isEqualToString:[info objectForKey:@"pay_name"]]) {
                
                button.button_imageView.image = [UIImage imageNamed:@"zhangHu_Wx"];
                button.button_lable.text = [info objectForKey:@"pay_name"];
            }else
            {
                button.button_imageView.image = [UIImage imageNamed:@"zhangHu_zfb"];
                button.button_lable.text = [info objectForKey:@"pay_name"];

            }
            
            [self.payTypeButtonArray addObject:button];
            originY = originY+40*BiLiWidth;
        }
        
        UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-280*BiLiWidth)/2, originY, 280*BiLiWidth, 40*BiLiWidth)];
//        chongZhiButton.layer.cornerRadius = 45*BiLiWidth/2;
//        chongZhiButton.backgroundColor = RGBFormUIColor(0xFF6B6C);
//        chongZhiButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
//        [chongZhiButton setTitle:@"立即支付" forState:UIControlStateNormal];
//        [chongZhiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chongZhiButton addTarget:self action:@selector(liJiZhiFuButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [whiteContentView addSubview:chongZhiButton];
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6B6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0A76);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = chongZhiButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [chongZhiButton.layer addSublayer:gradientLayer1];
        
         UILabel *  chongZhiButtonTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, chongZhiButton.width, chongZhiButton.height)];
        chongZhiButtonTipLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        chongZhiButtonTipLable.textAlignment = NSTextAlignmentCenter;
        chongZhiButtonTipLable.textColor = [UIColor whiteColor];
        chongZhiButtonTipLable.text = @"立即支付";
        [chongZhiButton addSubview:chongZhiButtonTipLable];

        whiteContentView.height = chongZhiButton.top+chongZhiButton.height+20*BiLiWidth;
        whiteContentView.top = HEIGHT_PingMu-whiteContentView.height;
        //某个角圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_zhiFuView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8*BiLiWidth, 8*BiLiWidth)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _zhiFuView.bounds;
        maskLayer.path = maskPath.CGPath;
        whiteContentView.layer.mask = maskLayer;

    }
    return _zhiFuView;
}
-(void)payTypeButtonClick:(Lable_ImageButton *)selectButton
{
    payTypeIndex = (int)selectButton.tag;
    
    for (Lable_ImageButton * button in self.payTypeButtonArray) {
        
        [button.button_imageView1 setImage:nil];
        button.button_imageView1.layer.borderWidth = 1;
    }
    [selectButton.button_imageView1 setImage:[UIImage imageNamed:@"zhangHu_select"]];
    selectButton.button_imageView1.layer.borderWidth = 0;

}
-(void)liJiZhiFuButtonClick
{
    [self closeZhiFuView];
    
    if (payTypeIndex==-1) {
        
        [NormalUse showToastView:@"请选择支付方式" view:self.view];
        return;
    }
        [self xianShiLoadingView:@"下单中..." view:self.view];
        [HTTPModel getZFOrderId:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
           
            [self yinCangLoadingView];

            if (status==1) {
                
                self.orderId = responseObject;
                NSDictionary * payTypeInfo = [self.payTypeList objectAtIndex:self->payTypeIndex];
                NSString * coin = [NormalUse getJinBiStr:@"unlock_npost_coin"];
                NSString *url;
                //type_id type_id(预约类型1真实会员贴  2仨角色贴 3普通茶贴)
                url   =  [NSString stringWithFormat:@"%@/%@",HTTP_REQUESTURL,[payTypeInfo objectForKey:@"interview_url"]];
                url = [url stringByAppendingString:[NSString stringWithFormat:@"?amount=%@&orderId=%@&logintoken=%@&pay_channel=%@@&pay_code=%@&type_id=%@&related_id=%@",[NSString stringWithFormat:@"%d",coin.intValue],self.orderId,[NormalUse defaultsGetObjectKey:LoginToken],[payTypeInfo objectForKey:@"pay_channel"],[payTypeInfo objectForKey:@"pay_code"],@"3",self.post_id]];
                NSURL *cleanURL = [NSURL URLWithString:url];
                [[UIApplication sharedApplication] openURL:cleanURL options:nil completionHandler:^(BOOL success) {
                    
                }];
            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
            }
        }];
    
}
-(void)yanZhengOrder
{
    [self xianShiLoadingView:@"验证支付..." view:self.view];
    [HTTPModel checkZFStatus:[[NSDictionary alloc]initWithObjectsAndKeys:self.orderId,@"orderId", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [self yinCangLoadingView];
        if (status==1) {
            //0下单，1成功，2失败
            NSNumber * pay_status = [responseObject objectForKey:@"pay_status"];
            if (pay_status.intValue==0) {
                
                [NormalUse showToastView:@"订单正在处理中,请稍等" view:self.view];
            }
            else if (pay_status.intValue==1)
            {
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
                
                NSString * unlock_npost_coin = [NormalUse getJinBiStr:@"unlock_npost_coin"];
                NSString * str = [NSString stringWithFormat:@"成功缴纳%@预付金,平台担保真实信息,虚假包赔",unlock_npost_coin];
                NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
                NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
                [text1 addAttribute:NSForegroundColorAttributeName
                              value:RGBFormUIColor(0xFFFC02)
                              range:NSMakeRange(4, unlock_npost_coin.length)];
                jieSuoTipLable1.attributedText = text1;


            }
            else
            {
                [NormalUse showToastView:@"订单支付失败" view:self.view];

            }
        }
    }];
    
}
-(void)closeZhiFuView
{
    self.zhiFuView.hidden = YES;
}
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

-(void)rightClick
{
    NSNumber * is_unlock = [self.tieZiInfo objectForKey:@"is_unlock"];
    NSNumber * is_interview = [self.tieZiInfo objectForKey:@"is_unlock"];
    

    if([is_unlock isKindOfClass:[NSNumber class]])
    {
        if (is_unlock.intValue==1 || is_interview.intValue==1 || alsoUnlockSuccess) {

            ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:@"多次投诉无效,请上传有效截图,否则不予返还金币" message2:@"" button1Title:@"确定" button2Title:@"取消"];
            alertView.button1Click = ^{
                
                JvBaoViewController * vc = [[JvBaoViewController alloc] init];
                vc.post_id = self.post_id;
                vc.role = @"1";
                [self.navigationController pushViewController:vc animated:YES];

            };
            alertView.button2Click = ^{
              
                
            };
            [[UIApplication sharedApplication].keyWindow addSubview:alertView];

        }
        else
        {
            NSString * tipStr = @"解锁后才可以投诉该帖~";
            NSNumber * auth_nomal = [self.tieZiInfo objectForKey:@"auth_nomal"];
            if ([auth_nomal isKindOfClass:[NSNumber class]]&&auth_nomal.intValue==1)
            {
                tipStr = @"解锁或预约后才可以投诉该帖~";
            }

            
            ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:tipStr message2:@"" button1Title:@"知道了" button2Title:@""];
            alertView.button1Click = ^{
            };
            alertView.button2Click = ^{
              
            };
            [[UIApplication sharedApplication].keyWindow addSubview:alertView];


        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
    if (self.is_active.intValue!=1) {

        [self.autoLabel removeFromSuperview];
        self.autoLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 30)];
        self.autoLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        self.autoLabel.text = [self.tieZiInfo objectForKey:@"post_warning_tips"];
        self.autoLabel.textColor = RGBFormUIColor(0xFF0101);//默认白色
        [self.mainScrollView addSubview:self.autoLabel];

    }


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yanZhengOrder) name:@"YanZhengDingDanNotification" object:nil];

    
    [NormalUse xianShiGifLoadingView:self];
    [HTTPModel getTieZiDetail:[[NSDictionary alloc]initWithObjectsAndKeys:self.post_id,@"post_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse quXiaoGifLoadingView:self];
        
        if (status==1) {
            
            self.tieZiInfo = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
            
            UIButton * chatButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-62*BiLiWidth, HEIGHT_PingMu-68*BiLiWidth-243*BiLiWidth, 62*BiLiWidth, 68*BiLiWidth)];
            [chatButton setBackgroundImage:[UIImage imageNamed:@"tieZi_chat_blue"] forState:UIControlStateNormal];
            [chatButton addTarget:self action:@selector(chatButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:chatButton];

            self.shakeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-102*BiLiWidth, chatButton.bottom+4*BiLiWidth, 92*BiLiWidth, 44*BiLiWidth)];
            self.shakeImageView.image = [UIImage imageNamed:@"chatTipKuang"];
            [self.view addSubview:self.shakeImageView];
            [NormalUse shakeAnimationForView:self.shakeImageView];

            
            self.is_active = [self.tieZiInfo objectForKey:@"is_active"];
            if (![self.is_active isKindOfClass:[NSNumber class]]) {
                
                self.is_active = [NSNumber numberWithInt:0];
            }
            if (self.is_active.intValue==1) {
                self.rightButton.hidden = YES;
            }
            else
            {
                self.rightButton.hidden = NO;
            }
            [self initTopMessageView];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
    [self.rightButton setTitleColor:RGBFormUIColor(0xFF0876) forState:UIControlStateNormal];
    [self.rightButton setTitle:@"投诉" forState:UIControlStateNormal];
    self.topTitleLale.text = @"详情";
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.mainScrollView];
    
    payTypeIndex = -1;
    [HTTPModel getCommonPayType:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.payTypeList = responseObject;
            if(![NormalUse isValidArray:self.payTypeList])
            {
               // [NormalUse showToastView:@"支付通道维护中 请稍后充值" view:self.view];
            }
            else
            {
                self.zhiFuView.hidden = YES;
            }

        }
        else
        {
            //[NormalUse showToastView:@"支付通道维护中 请稍后充值" view:self.view];
        }

    }];

    
    
}
-(void)initTopMessageView
{
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:self.post_id forKey:@"post_id"];
    [info setObject:@"1" forKey:@"page"];
    [info setObject:@"1" forKey:@"type_id"];

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

    float topHeight;
    if (self.is_active.intValue==1) {
       
        topHeight = 0;
    }
    else
    {
        topHeight = 30;
    }
    
    JYCarousel *scrollLunBo = [[JYCarousel alloc] initWithFrame:CGRectMake(0, topHeight,WIDTH_PingMu,WIDTH_PingMu) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
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

    if (self.is_active.intValue!=1) {
        
        [self.autoLabel removeFromSuperview];
        self.autoLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 30)];
        self.autoLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        self.autoLabel.text = [self.tieZiInfo objectForKey:@"post_warning_tips"];
        self.autoLabel.textColor = RGBFormUIColor(0xFF0101);//默认白色
        [self.mainScrollView addSubview:self.autoLabel];

    }
    
    self.messageContentView  = [[UIView alloc] initWithFrame:CGRectMake(0, scrollLunBo.height-60*BiLiWidth, WIDTH_PingMu, 325*BiLiWidth-21*BiLiWidth-40*BiLiWidth)];
    self.messageContentView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.messageContentView];

    NSString * nickStr = [self.tieZiInfo objectForKey:@"title"];
    UILabel * nickLable = [[UILabel alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, 5*BiLiWidth, 250*BiLiWidth, 30*BiLiWidth)];
    nickLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    nickLable.textColor = RGBFormUIColor(0x343434);
    nickLable.text = nickStr;
    nickLable.numberOfLines = 0;
    [self.messageContentView addSubview:nickLable];
    if (self.is_active.intValue==1) {
        
        nickLable.textColor = RGBFormUIColor(0xFF0101);
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:nickStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [nickStr length])];
    nickLable.attributedText = attributedString;
    //设置自适应
    [nickLable  sizeToFit];
    
    //添加在线标识和和动画
    if ([NormalUse isValidString:[self.tieZiInfo objectForKey:@"ryuser_id"]]) {
        
        UILabel * onLineLable = [[UILabel alloc] initWithFrame:CGRectMake(nickLable.right+5*BiLiWidth, nickLable.top, 50*BiLiWidth, 20*BiLiWidth)];
        onLineLable.textColor = [UIColor whiteColor];
        onLineLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        onLineLable.layer.cornerRadius = 10*BiLiWidth;
        onLineLable.layer.masksToBounds = YES;
        onLineLable.textAlignment = NSTextAlignmentCenter;
        [self.messageContentView addSubview:onLineLable];
        onLineLable.hidden = YES;

        [HTTPModel getUserOnLineStatus:@{@"ryuser_id":[self.tieZiInfo objectForKey:@"ryuser_id"]} callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(35*BiLiWidth, 0, 1, 30)];
                [self.mainScrollView addSubview:lineView];
                
                UILabel * onLineAnimationLable = [[UILabel alloc] initWithFrame:CGRectMake(10*BiLiWidth, lineView.bottom, 50*BiLiWidth, 30*BiLiWidth)];
                onLineAnimationLable.textColor = [UIColor whiteColor];
                onLineAnimationLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:8*BiLiWidth];
                onLineAnimationLable.layer.cornerRadius = 5*BiLiWidth;
                onLineAnimationLable.layer.masksToBounds = YES;
                onLineAnimationLable.textAlignment = NSTextAlignmentCenter;
                onLineAnimationLable.numberOfLines = 2;
                [self.mainScrollView addSubview:onLineAnimationLable];

                if ([@"1" isEqualToString:[NormalUse getobjectForKey:[responseObject objectForKey:@"status"]]]) {
                    
                    onLineLable.backgroundColor = RGBFormUIColor(0xFF0101);
                    onLineLable.text = @"我在线哦";
                     
                    lineView.backgroundColor = RGBFormUIColor(0xFF0101);
                    onLineAnimationLable.backgroundColor = RGBFormUIColor(0xFF0101);
                    onLineAnimationLable.text = @"我在线哦\n快来私我";

                }
                else
                {
                    onLineLable.backgroundColor = RGBFormUIColor(0x8F97A2);
                    onLineLable.text = @"暂时离线";

                    lineView.backgroundColor = RGBFormUIColor(0x8F97A2);;
                    onLineAnimationLable.backgroundColor = RGBFormUIColor(0x8F97A2);
                    onLineAnimationLable.text = @"暂时离线\n哥哥可留言";

                }
                
                [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    
                    lineView.height = 90;
                    onLineAnimationLable.top = 90;

                    
                } completion:^(BOOL finished) {
                    

                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       
                        onLineLable.hidden = NO;

                        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                            
                            lineView.height = 30;
                            onLineAnimationLable.top = 30;

                        } completion:^(BOOL finished) {
                            
                        }];


                    });

                }];
                
            }
        }];
    }


    float originY = nickLable.bottom;
    float originX = nickLable.left;
    UIImageView * guanFangRenZhengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nickLable.left, nickLable.bottom+7.5*BiLiWidth, 20*269/66*BiLiWidth, 20*BiLiWidth)];
    [self.messageContentView addSubview:guanFangRenZhengImageView];

    NSNumber * auth_nomal = [self.tieZiInfo objectForKey:@"auth_nomal"];
    if ([auth_nomal isKindOfClass:[NSNumber class]]) {
        
        if (auth_nomal.intValue==1) {
            
            guanFangRenZhengImageView.width = 20*171/42*BiLiWidth;
            guanFangRenZhengImageView.image = [UIImage imageNamed:@"home_guanFangTip"];
            
            originY = guanFangRenZhengImageView.bottom;
            originX = guanFangRenZhengImageView.right+5*BiLiWidth;
        }
        else
        {
            originY = nickLable.bottom;
        }

    }
    else
    {
        originY = nickLable.bottom;
    }

    UIImageView * vImageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, nickLable.bottom+5*BiLiWidth, 25*BiLiWidth*170/60, 25*BiLiWidth)];
    [self.messageContentView addSubview:vImageView];

    NSNumber * auth_vip = [self.tieZiInfo objectForKey:@"auth_vip"];
    //2终身会员 1年会员 3蛟龙炮神 0非会员
    if ([auth_vip isKindOfClass:[NSNumber class]]) {
        
        originY = vImageView.bottom;
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
            
        }

    }
    
    
    UILabel * cityLable = [[UILabel alloc] initWithFrame:CGRectMake(nickLable.left, originY+10*BiLiWidth, WIDTH_PingMu-nickLable.left-50*BiLiWidth, 11*BiLiWidth)];
    cityLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    cityLable.textColor = RGBFormUIColor(0xFF0101);
    cityLable.adjustsFontSizeToFitWidth = YES;
    cityLable.text = [NSString stringWithFormat:@"%@ %@",[NormalUse getobjectForKey:[self.tieZiInfo objectForKey:@"city_name"]],[NormalUse getobjectForKey:[self.tieZiInfo objectForKey:@"address_detail"]]];
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

    

    NSString * unlock_post_coin = [NormalUse getJinBiStr:@"unlock_post_coin"];
    self.jieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, guangTangTipView.top+guangTangTipView.height+19*BiLiWidth, 321*BiLiWidth, 68*BiLiWidth)];
    [self.jieSuoButton setBackgroundImage:[UIImage imageNamed:@"sanJiaoSe_jieSuoBottom"] forState:UIControlStateNormal];
    self.jieSuoButton.button_lable.frame = CGRectMake(19.5*BiLiWidth, 0, 150*BiLiWidth, self.jieSuoButton.height);
    self.jieSuoButton.button_lable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.jieSuoButton.button_lable.numberOfLines = 2;
    self.jieSuoButton.button_lable.textColor = RGBFormUIColor(0xFFFFFF);
    self.jieSuoButton.button_lable.text = @"查看地址联系方式";
    if ([auth_nomal isKindOfClass:[NSNumber class]]&&auth_nomal.intValue==1)
    {
        self.jieSuoButton.button_lable.text = @"查看地址联系方式\n请先私聊后预付哦";

    }
    self.jieSuoButton.button_imageView.frame = CGRectMake(214*BiLiWidth, 11*BiLiWidth, 105*BiLiWidth, 46*BiLiWidth);
    self.jieSuoButton.button_imageView.image = [UIImage imageNamed:@"sanJiaoSe_jieSuo"];
    self.jieSuoButton.button_lable1.frame = CGRectMake(214*BiLiWidth, 0, 105*BiLiWidth, self.jieSuoButton.height);
    self.jieSuoButton.button_lable1.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.jieSuoButton.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.jieSuoButton.button_lable1.textColor = RGBFormUIColor(0xFFFFFF);
    self.jieSuoButton.button_lable1.text = [NSString stringWithFormat:@"%@金币解锁",[NormalUse getobjectForKey:unlock_post_coin]];
    [self.jieSuoButton addTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.messageContentView addSubview:self.jieSuoButton];
    
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
            self.jieSuoButton.button_lable.text = lianXieFangShiStr;
            self.jieSuoButton.button_lable1.text = @"";


        }
    }

    //    unlock_npost_coin 普通帖子预约金
    //    unlock_rpost_coin 仨角色预约金
    //    unlock_vpost_coin  会员+经纪人贴预约金

    float originy = self.jieSuoButton.top+self.jieSuoButton.height+10*BiLiWidth;
    //是否经过官方认证
    if ([auth_nomal isKindOfClass:[NSNumber class]]&&auth_nomal.intValue==1) {
        
        UIImageView * yuYueipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, self.jieSuoButton.top+self.jieSuoButton.height+19*BiLiWidth, 321*BiLiWidth, 68*BiLiWidth)];
        yuYueipImageView.image = [UIImage imageNamed:@"sanJiaoSe_yuYueBottom"];
        [self.messageContentView addSubview:yuYueipImageView];
        
        self.yuYueButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, self.jieSuoButton.top+self.jieSuoButton.height+19*BiLiWidth, 321*BiLiWidth, 68*BiLiWidth)];
        self.yuYueButton.backgroundColor = [UIColor clearColor];
        [self.messageContentView addSubview:self.yuYueButton];
        
        NSString * unlock_npost_coin = [NormalUse getJinBiStr:@"unlock_npost_coin"];
        UILabel * jieSuoTipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(19.5*BiLiWidth, 0, 150*BiLiWidth, self.yuYueButton.height)];
        jieSuoTipLable1.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*BiLiWidth];
        jieSuoTipLable1.numberOfLines =2;
        jieSuoTipLable1.textColor = RGBFormUIColor(0xFFFFFF);
        [self.yuYueButton addSubview:jieSuoTipLable1];
        
        NSString * str = [NSString stringWithFormat:@"预约金%@金币",unlock_npost_coin];
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSForegroundColorAttributeName
                      value:RGBFormUIColor(0xFFFC02)
                      range:NSMakeRange(3, unlock_npost_coin.length)];
        jieSuoTipLable1.attributedText = text1;

        
        UIButton * yueYueTipButton = [[UIButton alloc] initWithFrame:CGRectMake(self.jieSuoButton.width-107*BiLiWidth, (self.jieSuoButton.height-46*BiLiWidth)/2, 107*BiLiWidth, 46*BiLiWidth)];
        [yueYueTipButton setBackgroundImage:[UIImage imageNamed:@"sanJiaoSe_yuYue"] forState:UIControlStateNormal];
        [yueYueTipButton addTarget:self action:@selector(yuYueButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [yueYueTipButton setTitle:@"立即预约" forState:UIControlStateNormal];
        [yueYueTipButton setTitleColor:RGBFormUIColor(0xEE5500) forState:UIControlStateNormal];
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
                
                NSString * str = [NSString stringWithFormat:@"成功缴纳%@预付金,平台担保真实信息,虚假包赔",unlock_npost_coin];
                NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
                NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
                [text1 addAttribute:NSForegroundColorAttributeName
                              value:RGBFormUIColor(0xFFFC02)
                              range:NSMakeRange(4, unlock_npost_coin.length)];
                jieSuoTipLable1.attributedText = text1;
                
            }
        }
        originy = self.yuYueButton.top+self.yuYueButton.height+10*BiLiWidth;
    }


    
    
    self.tipLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BiLiWidth, originy, WIDTH_PingMu-10*BiLiWidth, 25*BiLiWidth)];
    
    if(self.is_active.intValue==1)
    {
        self.tipLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BiLiWidth, originy, WIDTH_PingMu-10*BiLiWidth, 25*BiLiWidth)];
//        self.tipLable.text = [self.tieZiInfo objectForKey:@"post_warning_tips"];
//        self.tipLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
//        self.tipLable.textColor = RGBFormUIColor(0xFF0101);
//        self.tipLable.adjustsFontSizeToFitWidth = YES;
//        self.tipLable.numberOfLines = 2;
        [self.messageContentView addSubview:self.tipLable];
        
        self.messageContentView.height = self.tipLable.top+10*BiLiWidth;
        
        //某个角圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.messageContentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8*BiLiWidth, 8*BiLiWidth)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.messageContentView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.messageContentView.layer.mask = maskLayer;

    }
    else
    {
        self.tipLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BiLiWidth, originy, WIDTH_PingMu-10*BiLiWidth, 25*BiLiWidth)];
        self.tipLable.text = [self.tieZiInfo objectForKey:@"post_warning_tips"];
        self.tipLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        self.tipLable.textColor = RGBFormUIColor(0xFF0101);
        self.tipLable.adjustsFontSizeToFitWidth = YES;
        self.tipLable.numberOfLines = 2;
        [self.messageContentView addSubview:self.tipLable];
        
        self.messageContentView.height = self.tipLable.top+self.tipLable.height+10*BiLiWidth;
        
        //某个角圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.messageContentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8*BiLiWidth, 8*BiLiWidth)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.messageContentView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.messageContentView.layer.mask = maskLayer;

    }

    [self initJiBenZiLiaoView:self.messageContentView.top+self.messageContentView.height];
    
    UIImageView * touSuShakeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-92*BiLiWidth, self.topNavView.bottom-4*BiLiWidth, 92*BiLiWidth, 49*BiLiWidth)];
    touSuShakeImageView.image = [UIImage imageNamed:@"touSuTipKuang"];
    [self.view addSubview:touSuShakeImageView];
    [NormalUse shakeAnimationForView:touSuShakeImageView];

    
}
-(void)chatButtonClick
{
    [self.shakeImageView removeFromSuperview];
    
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
            NSString * tipStr = @"先解锁才能在线聊天";
            NSNumber * auth_nomal = [self.tieZiInfo objectForKey:@"auth_nomal"];
            if ([auth_nomal isKindOfClass:[NSNumber class]]&&auth_nomal.intValue==1)
            {
                tipStr = @"先解锁或者预约才能在线聊天";
            }
            
            ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:tipStr message2:@"" button1Title:@"确定" button2Title:@""];
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
    ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:[NSString stringWithFormat:@"您正在预付定金%@金币",[NormalUse getJinBiStr:@"unlock_npost_coin"]] message2:@"" button1Title:@"取消" button2Title:@"确定"];
    alertView.button1Click = ^{
        
    };
    alertView.button2Click = ^{
        
        [NormalUse showMessageLoadView:@"预约中..." vc:self];
        
        NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
        [info setObject:@"3" forKey:@"type_id"];
        [info setObject:self.post_id forKey:@"related_id"];
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
                
                NSString * unlock_npost_coin = [NormalUse getJinBiStr:@"unlock_npost_coin"];
                NSString * str = [NSString stringWithFormat:@"成功缴纳%@预付金,平台担保真实信息,虚假包赔",unlock_npost_coin];
                NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
                NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
                [text1 addAttribute:NSForegroundColorAttributeName
                              value:RGBFormUIColor(0xFFFC02)
                              range:NSMakeRange(4, unlock_npost_coin.length)];
                jieSuoTipLable1.attributedText = text1;
            }
            else if (status==11402)
            {
                if ([NormalUse isValidArray:self.payTypeList]) {
                    
                    self.zhiFuView.hidden = NO;
                }
                else
                {
                    [NormalUse showToastView:msg view:self.view];
                }
            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
                
            }
        }];

    };
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];

}
-(void)jieSuoButtonClick
{
    [NormalUse showMessageLoadView:@"解锁中..." vc:self];
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    if (self.is_active.intValue==1) {
        
        [info setObject:@"8" forKey:@"type_id"];

    }
    else
    {
        [info setObject:@"2" forKey:@"type_id"];

    }
    [info setObject:self.post_id forKey:@"related_id"];
    [HTTPModel unlockMobile:info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse removeMessageLoadingView:self];
        if (status==1) {
            
            self.jieSuoButton.button_imageView.hidden = YES;
            NSNumber * is_unlock = [NSNumber numberWithInt:1];
            [self.tieZiInfo setObject:is_unlock forKey:@"is_unlock"];

            self->alsoUnlockSuccess = YES;
            NSDictionary * contactInfo = responseObject;
            
            if([NormalUse isValidString:[self.tieZiInfo objectForKey:@"ryuser_id"]])
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
                
                if ([NormalUse isValidString:mobile]) {
                    
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
-(void)initJiBenZiLiaoView:(float)oyiginY
{
    self.jiBenXinXiContentView = [[UIView alloc] initWithFrame:CGRectMake(0, oyiginY, WIDTH_PingMu, 0)];
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
    
    UILabel * jiaGeLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, jiaGeImageView.top, 200*BiLiWidth, 12*BiLiWidth)];
    jiaGeLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    jiaGeLable.textColor = RGBFormUIColor(0x666666);
//    jiaGeLable.text = [NSString stringWithFormat:@"价格：%@-%@",[self.tieZiInfo objectForKey:@"min_price"],[self.tieZiInfo objectForKey:@"max_price"]];
    [self.jiBenXinXiContentView addSubview:jiaGeLable];
    jiaGeLable.text = [NSString stringWithFormat:@"价格: %@",[NormalUse getobjectForKey:[self.tieZiInfo objectForKey:@"nprice_label"]]];
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
    
    if (self.is_active.intValue==1) {
        
        shuLiangImageView.hidden = YES;
        shuLiangLableLable.hidden = YES;
        ageImageView.frame = shuLiangImageView.frame;
        ageLable.frame = shuLiangLableLable.frame;
    }


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
    
    
    NSNumber * face_value = [self.tieZiInfo objectForKey:@"face_value"];
    yanZhiLable.text = [NSString stringWithFormat:@"颜值:%d",face_value.intValue];
    NSNumber * skill_value = [self.tieZiInfo objectForKey:@"skill_value"];
    jiShuLable.text = [NSString stringWithFormat:@"技术:%d",skill_value.intValue];
    NSNumber * ambience_value = [self.tieZiInfo objectForKey:@"ambience_value"];
    huanJingLable.text = [NSString stringWithFormat:@"环境:%d",ambience_value.intValue];

        
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
    
//    if (self.alsoFromYanCheBaoGao) {
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.cheYouPingJiaButton sendActionsForControlEvents:UIControlEventTouchUpInside];
//        });
//
//    }

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
        
        [HTTPModel tieZiFollow:[[NSDictionary alloc]initWithObjectsAndKeys:self.post_id,@"post_id",@"1",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
           
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
        NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:self.post_id,@"post_id",@"1",@"type_id", nil];
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
            if ([NormalUse isValidString:[info objectForKey:@"fframe"]]) {
                
                MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[info objectForKey:@"fframe"]]];
                photo.videoURL = [NSURL URLWithString:[info objectForKey:@"url"]];
                [photos addObject:photo];

            }
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
