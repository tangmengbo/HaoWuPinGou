//
//  MyCenterViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyCenterViewController.h"
#import "ZhangHuDetailViewController.h"
#import "EditUserMessageViewController.h"
#import "TuiGuangZhuanQianViewController.h"
#import "JinBiMingXiViewController.h"
#import "TiXianViewController.h"
#import "ChatListViewController.h"
#import "InputMobileViewController.h"


@interface MyCenterViewController ()

@property(nonatomic,strong)NSDictionary * userInfo;

@property(nonatomic,strong)UIView * tianXieYaoQingMaView;
@property(nonatomic,strong)UITextField * yaoQingMaTF;

@property(nonatomic,strong)NSDictionary * xiaoXiWeiDuInfo;

@end

@implementation MyCenterViewController

-(UIView *)tianXieYaoQingMaView
{
    if (!_tianXieYaoQingMaView) {
        
        _tianXieYaoQingMaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _tianXieYaoQingMaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self.view addSubview:_tianXieYaoQingMaView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-244*BiLiWidth)/2, 287*BiLiWidth, 244*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [_tianXieYaoQingMaView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [_tianXieYaoQingMaView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33.5*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"请输入邀请码";
        [kuangImageView addSubview:tipLable1];
        
        
        self.yaoQingMaTF = [[UITextField alloc] initWithFrame:CGRectMake(20*BiLiWidth, tipLable1.top+tipLable1.height+30*BiLiWidth, kuangImageView.width-40*BiLiWidth, 40*BiLiWidth)];
        self.yaoQingMaTF.layer.borderWidth = 1;
        self.yaoQingMaTF.layer.borderColor = [RGBFormUIColor(0xEEEEEE) CGColor];
        self.yaoQingMaTF.textColor = RGBFormUIColor(0x343434);
        self.yaoQingMaTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
        self.yaoQingMaTF.textAlignment = NSTextAlignmentCenter;
        [kuangImageView addSubview:self.yaoQingMaTF];
        

        UIButton * renZhengButton = [[UIButton alloc] initWithFrame:CGRectMake(20*BiLiWidth, self.yaoQingMaTF.top+self.yaoQingMaTF.height+20*BiLiWidth, kuangImageView.width-40*BiLiWidth, 40*BiLiWidth)];
        [renZhengButton addTarget:self action:@selector(tiJiaoYanZhengMa) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:renZhengButton];
        
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = renZhengButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [renZhengButton.layer addSublayer:gradientLayer1];
        
        UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, renZhengButton.width, renZhengButton.height)];
        sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        sureLable.text = @"确定";
        sureLable.textAlignment = NSTextAlignmentCenter;
        sureLable.textColor = [UIColor whiteColor];
        [renZhengButton addSubview:sureLable];
        

        

    }
    return _tianXieYaoQingMaView;
}
-(void)tiJiaoYanZhengMa
{
    if (![NormalUse isValidString:self.yaoQingMaTF.text]) {
        
        [NormalUse showToastView:@"请输入邀请码" view:self.view];
        return;
    }
    [HTTPModel tianXieYaoQingMa:[[NSDictionary alloc] initWithObjectsAndKeys:self.yaoQingMaTF.text,@"share_code", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.tianXieYaoQingMaButton.button_lable1.text = self.yaoQingMaTF.text;
            self.tianXieYaoQingMaButton.button_imageView1.image = nil;
            self.tianXieYaoQingMaButton.enabled = NO;
            [NormalUse showToastView:@"邀请码已填写" view:self.view];
            [self closeTipKuangView];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
}
-(void)closeTipKuangView
{
    self.tianXieYaoQingMaView.hidden = YES;
    [self.yaoQingMaTF resignFirstResponder];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

    [HTTPModel getNewMessageCount:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
        
        if (status==1) {
            
            self.xiaoXiWeiDuInfo = responseObject;
            //消息类型 0官方 1审核 2活动
            NSNumber * official_msgcnt = [responseObject objectForKey:@"official_msgcnt"];
            NSNumber * active_msgcnt = [responseObject objectForKey:@"active_msgcnt"];
            NSNumber * review_msgcnt = [responseObject objectForKey:@"review_msgcnt"];

            if (official_msgcnt.intValue+active_msgcnt.intValue+review_msgcnt.intValue==0) {
                
                self.redPointView.hidden = YES;
                self.chaKanMessageButtonRedPointView.hidden = YES;
            }
            else
            {
                self.redPointView.hidden = NO;
                self.chaKanMessageButtonRedPointView.hidden = NO;

            }
        }
    }];
    
    int unReadMesNumber = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]];
    if (unReadMesNumber<=0) {

        self.chatOnlineButtonRedPointView.hidden = YES;
    }
    else
    {
        self.chatOnlineButtonRedPointView.hidden = NO;
    }

    
    [self xianShiTabBar];
    
    NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
    NSString * defaultsKey = [UserRole stringByAppendingString:[NormalUse getobjectForKey:token]];
    NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
    if ([NormalUse isValidDictionary:userRoleDic]) {
        
        NSNumber * auth_agent = [userRoleDic objectForKey:@"auth_agent"];
        
        if (auth_agent.intValue==1) {
            
            self.jingJiRenButton.hidden = NO;
            self.myJieSuoButton.top = self.jingJiRenButton.top+self.jingJiRenButton.height;
            self.myFaBuButton.top = self.myJieSuoButton.top+self.myJieSuoButton.height;
            self.myKeFuButton.top = self.myFaBuButton.top+self.myFaBuButton.height;
            self.chatOnlineButton.top = self.myKeFuButton.top+self.myKeFuButton.height;
            self.chaKanMessageButton.top = self.chatOnlineButton.top+self.chatOnlineButton.height;
            self.tuiGuangButton.top = self.chaKanMessageButton.top+self.chaKanMessageButton.height;
            self.tianXieYaoQingMaButton.top = self.tuiGuangButton.top+self.tuiGuangButton.height;
            self.bangDingShouJiButton.top = self.tianXieYaoQingMaButton.top+self.tianXieYaoQingMaButton.height;
            self.qieHuanZhangHao.top = self.bangDingShouJiButton.top+self.bangDingShouJiButton.height+20*BiLiWidth;
//            self.tiXianButton.top = self.tianXieYaoQingMaButton.top+self.tianXieYaoQingMaButton.height;
//            self.jinBiMingXiButton.top = self.tiXianButton.top+self.tiXianButton.height;
        }
        else
        {
            self.jingJiRenButton.hidden = YES;
            self.myJieSuoButton.top = self.jingJiRenButton.top;
            self.myFaBuButton.top = self.myJieSuoButton.top+self.myJieSuoButton.height;
            self.myKeFuButton.top = self.myFaBuButton.top+self.myFaBuButton.height;
            self.chatOnlineButton.top = self.myKeFuButton.top+self.myKeFuButton.height;
            self.chaKanMessageButton.top = self.chatOnlineButton.top+self.chatOnlineButton.height;
            self.tuiGuangButton.top = self.chaKanMessageButton.top+self.chaKanMessageButton.height;
            self.tianXieYaoQingMaButton.top = self.tuiGuangButton.top+self.tuiGuangButton.height;
            self.bangDingShouJiButton.top = self.tianXieYaoQingMaButton.top+self.tianXieYaoQingMaButton.height;
            self.qieHuanZhangHao.top = self.bangDingShouJiButton.top+self.bangDingShouJiButton.height+20*BiLiWidth;


//            self.tiXianButton.top = self.tianXieYaoQingMaButton.top+self.tianXieYaoQingMaButton.height;
//            self.jinBiMingXiButton.top = self.tiXianButton.top+self.tiXianButton.height;

        }

    }
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.qieHuanZhangHao.top+self.qieHuanZhangHao.height+20*BiLiWidth)];

    [self getUserInfo];

}
-(void)getUserInfo
{
    [HTTPModel getUserInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            NSDictionary * userYongYunInfo = [NormalUse defaultsGetObjectKey:UserRongYunInfo];
            
            [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[userYongYunInfo objectForKey:@"userid"] name:[NormalUse getCurrentUserName] portrait:[NormalUse getCurrentAvatarpath]];

            self.userInfo = responseObject;
            [NormalUse defaultsSetObject:[NormalUse removeNullFromDictionary:self.userInfo] forKey:UserInformation];
            
            NSNumber * total_unlock_num = [self.userInfo objectForKey:@"total_unlock_num"];//总解锁次数
            NSNumber * had_unlock_num = [self.userInfo objectForKey:@"had_unlock_num"];//已解锁次数
            self.mianFeiJieSuoButton.button_lable.text = [NSString stringWithFormat:@"%d/%d",had_unlock_num.intValue,total_unlock_num.intValue];
            
            NSNumber * total_post_num = [self.userInfo objectForKey:@"total_post_num"];//总发帖次数
            NSNumber * had_post_num = [self.userInfo objectForKey:@"had_post_num"];//已发帖数
            self.mianFeiFaBuButton.button_lable.text = [NSString stringWithFormat:@"%d/%d",had_post_num.intValue,total_post_num.intValue];

            
            NSNumber * favorite_num = [self.userInfo objectForKey:@"favorite_num"];//总收藏数
            NSNumber * follow_num = [self.userInfo objectForKey:@"follow_num"];//总关注数
            self.shouCangGuanZhuButton.button_lable.text = [NSString stringWithFormat:@"%d/%d",favorite_num.intValue,follow_num.intValue];

            self.nickLable.text = [self.userInfo objectForKey:@"nickname"];
            [self.headerImageView sd_setImageWithURL:[self.userInfo objectForKey:@"avatar"] placeholderImage:[UIImage imageNamed:@"moRen_header"]];
            NSNumber * coin = [self.userInfo objectForKey:@"coin"];
            self.yuELable.text = [NSString stringWithFormat:@"%d",coin.intValue];

            //auth_vip 2终身会员 1年会员 3蛟龙炮神 0非会员
            NSNumber * auth_vip = [self.userInfo objectForKey:@"auth_vip"];
            
            [NormalUse defaultsSetObject:auth_vip forKey:@"UserAlsoVip"];//本地存储会员身份

            self.mianFeiJieSuoButton.button_lable.hidden = NO;
            self.mianFeiJieSuoButton.button_imageView.hidden = YES;
            self.mianFeiFaBuButton.button_lable.hidden = NO;
            self.mianFeiFaBuButton.button_imageView.hidden = YES;

            if ([auth_vip isKindOfClass:[NSNumber class]]) {
                
                if (auth_vip.intValue==0) {
                    
                    self.messageLable.text = @"非VIP暂无免费解锁次数";
                    

                    [self.huiYuanButton setBackgroundImage:[UIImage imageNamed:@"my_weiKaiTong"] forState:UIControlStateNormal];


                }
                else if(auth_vip.intValue==1)
                {
                    self.messageLable.text = [NSString stringWithFormat:@"%@到期",[self.userInfo objectForKey:@"vip_expiration_date"]];//@"年卡";
                    
                    CGSize size = [NormalUse setSize:self.messageLable.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
                    self.messageLable.width = size.width;
                    self.vipImageView.left = self.messageLable.width+self.messageLable.left+3*BiLiWidth;
                    self.vipImageView.image = [UIImage imageNamed:@"vip_zuanShi"];

                    [self.huiYuanButton setBackgroundImage:[UIImage imageNamed:@"my_yearVip"] forState:UIControlStateNormal];

                    self.huiYuanTitleLable.text = @"";
                    self.huiYuanTitleLable.textColor = [UIColor whiteColor];
                    self.huiYuanDaoQiLable.textColor = [UIColor whiteColor];
                    self.huiYuanDaoQiLable.text = @"";


                }
                else if (auth_vip.intValue==2)
                {
                    self.messageLable.text = @"永久卡";
                    
                    CGSize size = [NormalUse setSize:self.messageLable.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
                    self.messageLable.width = size.width;
                    self.vipImageView.left = self.messageLable.width+self.messageLable.left+3*BiLiWidth;
                    self.vipImageView.image = [UIImage imageNamed:@"vip_wangZhe"];


                    [self.huiYuanButton setBackgroundImage:[UIImage imageNamed:@"my_yongJiuVip_new"] forState:UIControlStateNormal];
                    
                    self.huiYuanTitleLable.textColor = [UIColor whiteColor];
                    self.huiYuanDaoQiLable.textColor = [UIColor whiteColor];

                    self.huiYuanTitleLable.text = @"";//@"会员到期时间";
                    self.huiYuanDaoQiLable.text = @"";//[self.userInfo objectForKey:@"vip_expiration_date"];
                    
                    self.mianFeiJieSuoButton.button_lable.hidden = YES;
                    self.mianFeiJieSuoButton.button_imageView.hidden = NO;


                }
                else if (auth_vip.intValue==3)
                {
                    self.messageLable.text = @"永久卡";
                    
                    CGSize size = [NormalUse setSize:self.messageLable.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
                    self.messageLable.width = size.width;
                    self.vipImageView.left = self.messageLable.width+self.messageLable.left+3*BiLiWidth;
                    self.vipImageView.image = [UIImage imageNamed:@"vip_paoShen"];


                    [self.huiYuanButton setBackgroundImage:[UIImage imageNamed:@"my_jiaolongVip"] forState:UIControlStateNormal];
                    
                    self.huiYuanTitleLable.text = @"";//@"会员到期时间";
                    self.huiYuanDaoQiLable.text = @"";//[self.userInfo objectForKey:@"vip_expiration_date"];

                    self.mianFeiJieSuoButton.button_lable.hidden = YES;
                    self.mianFeiJieSuoButton.button_imageView.hidden = NO;
                    self.mianFeiFaBuButton.button_lable.hidden = YES;
                    self.mianFeiFaBuButton.button_imageView.hidden = NO;

                }
                
            }
            
            if ([NormalUse isValidString:[self.userInfo objectForKey:@"mobile"]]) {

                self.mobileButton.button_lable.text = [self.userInfo objectForKey:@"mobile"];
                self.mobileButton.button_lable1.text = @"解绑";
                self.mobileButton.button_lable1.textColor = RGBFormUIColor(0x00AEFF);
                self.mobileButton.button_imageView.hidden = YES;
            }
            else
            {
                self.mobileButton.button_lable.text = @"";
                self.mobileButton.button_lable1.text = @"";
                self.mobileButton.button_imageView.hidden = NO;
                self.mobileButton.button_lable1.left = self.mobileButton.button_lable1.left-50*BiLiWidth-18*BiLiWidth;
                self.mobileButton.button_lable1.width = self.mobileButton.button_lable1.width+50*BiLiWidth;
                self.mobileButton.button_lable1.textColor = RGBFormUIColor(0x343434);

            }


            if([NormalUse isValidString:[self.userInfo objectForKey:@"from_share_code"]])
            {
                self.tianXieYaoQingMaButton.button_lable1.text = [self.userInfo objectForKey:@"from_share_code"];
                self.tianXieYaoQingMaButton.button_imageView1.image = nil;
                self.tianXieYaoQingMaButton.enabled = NO;

            }

        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HTTPModel huiYuanMiaoShuXinXi:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.vipListInfo =  responseObject;
        }
    }];
    self.topNavView.hidden = YES;
    
    self.mainScrollView = [[MyScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu-BottomHeight_PingMu)];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.mainScrollView];
    
    
    [self initContentView];
}
-(void)initContentView
{

    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14*BiLiWidth, TopHeight_PingMu+12.5*BiLiWidth, 61*BiLiWidth, 61*BiLiWidth)];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
    self.headerImageView.clipsToBounds = YES;
    self.headerImageView.layer.cornerRadius = 61*BiLiWidth/2;
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:self.headerImageView];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NormalUse getCurrentAvatarpath]] placeholderImage:[UIImage imageNamed:@"moRen_header"]];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editUserMessage)];
    [self.headerImageView addGestureRecognizer:tap];
    

    self.nickLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.left+self.headerImageView.width+14*BiLiWidth, TopHeight_PingMu+19*BiLiWidth, 150*BiLiWidth, 17*BiLiWidth)];
    self.nickLable.textColor = RGBFormUIColor(0x333333);
    self.nickLable.font = [UIFont systemFontOfSize:17*BiLiWidth];
    [self.mainScrollView addSubview:self.nickLable];
    self.nickLable.text = [NormalUse getCurrentUserName];
    
    
    self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(self.nickLable.left, self.nickLable.top+self.nickLable.height+1.5*BiLiWidth, 150*BiLiWidth, 30*BiLiWidth)];
    self.messageLable.textColor = RGBFormUIColor(0x999999);
    self.messageLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.messageLable.text = @"非VIP暂无免费解锁次数";
    [self.mainScrollView addSubview:self.messageLable];
    
    self.vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.messageLable.left+self.messageLable.width+3*BiLiWidth, self.messageLable.top+2.5*BiLiWidth, 25*BiLiWidth*170/60, 25*BiLiWidth)];
    [self.mainScrollView addSubview:self.vipImageView];

    
//    UIButton * xiaoXiButton = [[UIButton alloc] initWithFrame:CGRectMake(277*BiLiWidth, TopHeight_PingMu+12.5*BiLiWidth, 19*BiLiWidth, 22*BiLiWidth)];
//    [xiaoXiButton setImage:[UIImage imageNamed:@"my_xiaoXi"] forState:UIControlStateNormal];
//    [xiaoXiButton addTarget:self action:@selector(xiaoXiButonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.mainScrollView addSubview:xiaoXiButton];
//    
//    self.redPointView = [[UIView alloc] initWithFrame:CGRectMake(xiaoXiButton.left+xiaoXiButton.width-4*BiLiWidth, xiaoXiButton.top-4*BiLiWidth, 8*BiLiWidth, 8*BiLiWidth)];
//    self.redPointView.backgroundColor = [UIColor redColor];
//    self.redPointView.layer.cornerRadius = 4*BiLiWidth;
//    self.redPointView.layer.masksToBounds = YES;
//    [self.mainScrollView addSubview:self.redPointView];
//    self.redPointView.hidden = YES;
    
    UIButton * sheZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-30*BiLiWidth, TopHeight_PingMu+12.5*BiLiWidth, 20*BiLiWidth, 22*BiLiWidth)];
    [sheZhiButton setImage:[UIImage imageNamed:@"my_setting"] forState:UIControlStateNormal];
    [sheZhiButton addTarget:self action:@selector(sheZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:sheZhiButton];
    
    

    
    self.mianFeiJieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.headerImageView.top+self.headerImageView.height+24*BiLiWidth, WIDTH_PingMu/3, 40*BiLiWidth)];
    self.mianFeiJieSuoButton.button_imageView.frame = CGRectMake((self.mianFeiJieSuoButton.width-26*BiLiWidth)/2, 0, 26*BiLiWidth, 13.5*BiLiWidth);
    self.mianFeiJieSuoButton.button_imageView.image = [UIImage imageNamed:@"my_vipWuXian"];
    self.mianFeiJieSuoButton.button_lable.frame = CGRectMake(0, 0, self.mianFeiJieSuoButton.width, 17*BiLiWidth);
    self.mianFeiJieSuoButton.button_lable.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.mianFeiJieSuoButton.button_lable.textColor = RGBFormUIColor(0x343434);
    self.mianFeiJieSuoButton.button_lable.textAlignment = NSTextAlignmentCenter;
    self.mianFeiJieSuoButton.button_lable1.frame = CGRectMake(0, 28*BiLiWidth, self.mianFeiJieSuoButton.width, 12*BiLiWidth);
    self.mianFeiJieSuoButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.mianFeiJieSuoButton.button_lable1.textColor = RGBFormUIColor(0x9A9A9A);
    self.mianFeiJieSuoButton.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.mianFeiJieSuoButton.button_lable1.text = @"每日免费解锁";
    [self.mainScrollView addSubview:self.mianFeiJieSuoButton];
    
    self.mianFeiFaBuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/3, self.headerImageView.top+self.headerImageView.height+24*BiLiWidth, WIDTH_PingMu/3, 40*BiLiWidth)];
    self.mianFeiFaBuButton.button_imageView.frame = CGRectMake((self.mianFeiJieSuoButton.width-26*BiLiWidth)/2, 0, 26*BiLiWidth, 13.5*BiLiWidth);
    self.mianFeiFaBuButton.button_imageView.image = [UIImage imageNamed:@"my_vipWuXian"];
    self.mianFeiFaBuButton.button_lable.frame = CGRectMake(0, 0, self.mianFeiJieSuoButton.width, 17*BiLiWidth);
    self.mianFeiFaBuButton.button_lable.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.mianFeiFaBuButton.button_lable.textColor = RGBFormUIColor(0x343434);
    self.mianFeiFaBuButton.button_lable.textAlignment = NSTextAlignmentCenter;
    self.mianFeiFaBuButton.button_lable1.frame = CGRectMake(0, 28*BiLiWidth, self.mianFeiJieSuoButton.width, 12*BiLiWidth);
    self.mianFeiFaBuButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.mianFeiFaBuButton.button_lable1.textColor = RGBFormUIColor(0x9A9A9A);
    self.mianFeiFaBuButton.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.mianFeiFaBuButton.button_lable1.text = @"每日免费发布";
    [self.mainScrollView addSubview:self.mianFeiFaBuButton];

    self.shouCangGuanZhuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/3*2, self.headerImageView.top+self.headerImageView.height+24*BiLiWidth, WIDTH_PingMu/3, 40*BiLiWidth)];
    [self.shouCangGuanZhuButton addTarget:self action:@selector(shouCangGuanZhuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.shouCangGuanZhuButton.button_lable.frame = CGRectMake(0, 0, self.mianFeiJieSuoButton.width, 17*BiLiWidth);
    self.shouCangGuanZhuButton.button_lable.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.shouCangGuanZhuButton.button_lable.textColor = RGBFormUIColor(0x343434);
    self.shouCangGuanZhuButton.button_lable.textAlignment = NSTextAlignmentCenter;
    self.shouCangGuanZhuButton.button_lable1.frame = CGRectMake(0, 28*BiLiWidth, self.mianFeiJieSuoButton.width, 12*BiLiWidth);
    self.shouCangGuanZhuButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.shouCangGuanZhuButton.button_lable1.textColor = RGBFormUIColor(0x9A9A9A);
    self.shouCangGuanZhuButton.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.shouCangGuanZhuButton.button_lable1.text = @"收藏关注";
    [self.mainScrollView addSubview:self.shouCangGuanZhuButton];


    
    
    self.huiYuanButton = [[UIButton alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.shouCangGuanZhuButton.top+self.shouCangGuanZhuButton.height+18.5*BiLiWidth, 160*BiLiWidth, 78*BiLiWidth)];
    [self.huiYuanButton addTarget:self action:@selector(huiYuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.huiYuanButton];
    
    self.huiYuanTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(8.5*BiLiWidth, 23*BiLiWidth, 90*BiLiWidth, 14*BiLiWidth)];
    self.huiYuanTitleLable.textColor = RGBFormUIColor(0x865A0A);
    self.huiYuanTitleLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.huiYuanButton addSubview:self.huiYuanTitleLable];
    
    self.huiYuanDaoQiLable = [[UILabel alloc] initWithFrame:CGRectMake(8.5*BiLiWidth, self.huiYuanTitleLable.top+self.huiYuanTitleLable.height+8*BiLiWidth, 90*BiLiWidth, 11*BiLiWidth)];
    self.huiYuanDaoQiLable.textColor = RGBFormUIColor(0xC49A47);
    self.huiYuanDaoQiLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [self.huiYuanButton addSubview:self.huiYuanDaoQiLable];

    
    UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(self.huiYuanButton.left+self.huiYuanButton.width+16*BiLiWidth, self.huiYuanButton.top, self.huiYuanButton.width, self.huiYuanButton.height)];
    [chongZhiButton setBackgroundImage:[UIImage imageNamed:@"my_jinBiBottom"] forState:UIControlStateNormal];
    [chongZhiButton addTarget:self action:@selector(myZhangHuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    chongZhiButton.layer.cornerRadius = 5*BiLiWidth;
    [self.mainScrollView addSubview:chongZhiButton];
    
    UIImageView *  jinBiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7*BiLiWidth, 8.5*BiLiWidth, 58*BiLiWidth, 66*BiLiWidth)];
    jinBiImageView.image = [UIImage imageNamed:@"vip_jinBiLogo"];
    [chongZhiButton addSubview:jinBiImageView];
//
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(71.5*BiLiWidth, 20*BiLiWidth, 70*BiLiWidth, 17*BiLiWidth)];
    tipLable.textColor = [UIColor whiteColor];//RGBFormUIColor(0x5d3f14);
    tipLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tipLable.text = @"金币充值";
    [chongZhiButton addSubview:tipLable];
//
    UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(71.5*BiLiWidth, 44.5*BiLiWidth, 30*BiLiWidth, 17*BiLiWidth)];
    tipLable1.textColor = [UIColor whiteColor];//RGBFormUIColor(0x5d3f14);
    tipLable1.font = [UIFont systemFontOfSize:11*BiLiWidth];
    tipLable1.text = @"余额:";
    [chongZhiButton addSubview:tipLable1];

    
    self.yuELable = [[UILabel alloc] initWithFrame:CGRectMake(tipLable1.left+tipLable1.width, 44.5*BiLiWidth-2*BiLiWidth, 58*BiLiWidth, 17*BiLiWidth)];
    self.yuELable.textColor = RGBFormUIColor(0xf2c517);
    self.yuELable.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.yuELable.adjustsFontSizeToFitWidth = YES;
    [chongZhiButton addSubview:self.yuELable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.huiYuanButton.top+self.huiYuanButton.height+24*BiLiWidth, WIDTH_PingMu, 8*BiLiWidth)];
    lineView.backgroundColor = RGBFormUIColor(0xEDEDED);
    [self.mainScrollView addSubview:lineView];
    
    self.jingJiRenButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, lineView.top+lineView.height+9*BiLiWidth, WIDTH_PingMu, 50*BiLiWidth)];
    [self.jingJiRenButton addTarget:self action:@selector(jingJiRenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.jingJiRenButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (self.jingJiRenButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    self.jingJiRenButton.button_imageView.image = [UIImage imageNamed:@"my_jingJiRen"];
    self.jingJiRenButton.button_lable.frame = CGRectMake(self.jingJiRenButton.button_imageView.left+self.jingJiRenButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, self.jingJiRenButton.height);
    self.jingJiRenButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.jingJiRenButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.jingJiRenButton.button_lable.text = @"经纪人";
    self.jingJiRenButton.button_imageView1.frame = CGRectMake(self.jingJiRenButton.width-9*BiLiWidth-12*BiLiWidth, (self.jingJiRenButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.jingJiRenButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:self.jingJiRenButton];
    self.jingJiRenButton.hidden = YES;

    self.myJieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, lineView.top+lineView.height+9*BiLiWidth, WIDTH_PingMu, 50*BiLiWidth)];
    [self.myJieSuoButton addTarget:self action:@selector(myJieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.myJieSuoButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (self.myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    self.myJieSuoButton.button_imageView.image = [UIImage imageNamed:@"my_jieSuo"];
    self.myJieSuoButton.button_lable.frame = CGRectMake(self.myJieSuoButton.button_imageView.left+self.myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, self.myJieSuoButton.height);
    self.myJieSuoButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.myJieSuoButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.myJieSuoButton.button_lable.text = @"我的解锁";
    self.myJieSuoButton.button_imageView1.frame = CGRectMake(self.myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (self.myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.myJieSuoButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:self.myJieSuoButton];
    
    
    self.myFaBuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.myJieSuoButton.top+self.myJieSuoButton.height, WIDTH_PingMu, 50*BiLiWidth)];
    [self.myFaBuButton addTarget:self action:@selector(myFaBuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.myFaBuButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (self.myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    self.myFaBuButton.button_imageView.image = [UIImage imageNamed:@"my_faBu"];
    self.myFaBuButton.button_lable.frame = CGRectMake(self.myJieSuoButton.button_imageView.left+self.myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, self.myJieSuoButton.height);
    self.myFaBuButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.myFaBuButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.myFaBuButton.button_lable.text = @"我的发布";
    self.myFaBuButton.button_imageView1.frame = CGRectMake(self.myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (self.myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.myFaBuButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:self.myFaBuButton];

    

    
    self.myKeFuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.myFaBuButton.top+self.myFaBuButton.height, WIDTH_PingMu, 50*BiLiWidth)];
    [self.myKeFuButton addTarget:self action:@selector(keFuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.myKeFuButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (self.myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    self.myKeFuButton.button_imageView.image = [UIImage imageNamed:@"my_keFu"];
    self.myKeFuButton.button_lable.frame = CGRectMake(self.myJieSuoButton.button_imageView.left+self.myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, self.myJieSuoButton.height);
    self.myKeFuButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.myKeFuButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.myKeFuButton.button_lable.text = @"联系客服";
    self.myKeFuButton.button_imageView1.frame = CGRectMake(self.myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (self.myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.myKeFuButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:self.myKeFuButton];

    self.chatOnlineButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.myKeFuButton.top+self.myKeFuButton.height, WIDTH_PingMu, 50*BiLiWidth)];
    [self.chatOnlineButton addTarget:self action:@selector(chatOnLineButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.chatOnlineButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (self.myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    self.chatOnlineButton.button_imageView.image = [UIImage imageNamed:@"my_chatOnline"];
    self.chatOnlineButton.button_lable.frame = CGRectMake(self.myJieSuoButton.button_imageView.left+self.myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, self.myJieSuoButton.height);
    self.chatOnlineButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.chatOnlineButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.chatOnlineButton.button_lable.text = @"在线聊天";
    self.chatOnlineButton.button_imageView1.frame = CGRectMake(self.myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (self.myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.chatOnlineButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:self.chatOnlineButton];
    
    self.chaKanMessageButtonRedPointView = [[UIView alloc] initWithFrame:CGRectMake(112*BiLiWidth, 15*BiLiWidth, 8*BiLiWidth, 8*BiLiWidth)];
    self.chaKanMessageButtonRedPointView.backgroundColor = [UIColor redColor];
    self.chaKanMessageButtonRedPointView.layer.cornerRadius = 4*BiLiWidth;
    self.chaKanMessageButtonRedPointView.layer.masksToBounds = YES;
    [self.chatOnlineButton addSubview:self.chaKanMessageButtonRedPointView];
    self.chaKanMessageButtonRedPointView.hidden = YES;


    self.chaKanMessageButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.chatOnlineButton.top+self.chatOnlineButton.height, WIDTH_PingMu, 50*BiLiWidth)];
    [self.chaKanMessageButton addTarget:self action:@selector(xiaoXiButonClick) forControlEvents:UIControlEventTouchUpInside];
    self.chaKanMessageButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (self.myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    self.chaKanMessageButton.button_imageView.image = [UIImage imageNamed:@"my_chaKanXiaoXi"];
    self.chaKanMessageButton.button_lable.frame = CGRectMake(self.myJieSuoButton.button_imageView.left+self.myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, self.myJieSuoButton.height);
    self.chaKanMessageButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.chaKanMessageButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.chaKanMessageButton.button_lable.text = @"查看消息";
    self.chaKanMessageButton.button_imageView1.frame = CGRectMake(self.myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (self.myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.chaKanMessageButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:self.chaKanMessageButton];
    
    self.chaKanMessageButtonRedPointView = [[UIView alloc] initWithFrame:CGRectMake(112*BiLiWidth, 15*BiLiWidth, 8*BiLiWidth, 8*BiLiWidth)];
    self.chaKanMessageButtonRedPointView.backgroundColor = [UIColor redColor];
    self.chaKanMessageButtonRedPointView.layer.cornerRadius = 4*BiLiWidth;
    self.chaKanMessageButtonRedPointView.layer.masksToBounds = YES;
    [self.chaKanMessageButton addSubview:self.chaKanMessageButtonRedPointView];
    self.chaKanMessageButtonRedPointView.hidden = YES;


    
    
    self.tuiGuangButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.chaKanMessageButton.top+self.chaKanMessageButton.height, WIDTH_PingMu, 50*BiLiWidth)];
    [self.tuiGuangButton addTarget:self action:@selector(tuiGuangButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.tuiGuangButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (self.myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    self.tuiGuangButton.button_imageView.image = [UIImage imageNamed:@"my_tuiGuang"];
    self.tuiGuangButton.button_lable.frame = CGRectMake(self.myJieSuoButton.button_imageView.left+self.myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, self.myJieSuoButton.height);
    self.tuiGuangButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.tuiGuangButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.tuiGuangButton.button_lable.text = @"推广赚钱";
    self.tuiGuangButton.button_imageView1.frame = CGRectMake(self.myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (self.myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.tuiGuangButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:self.tuiGuangButton];

    
    self.tianXieYaoQingMaButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.tuiGuangButton.top+self.tuiGuangButton.height, WIDTH_PingMu, 50*BiLiWidth)];
    [self.tianXieYaoQingMaButton addTarget:self action:@selector(tianXieYaoQingMaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.tianXieYaoQingMaButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (self.myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    self.tianXieYaoQingMaButton.button_imageView.image = [UIImage imageNamed:@"my_shouCang"];
    self.tianXieYaoQingMaButton.button_lable.frame = CGRectMake(self.myJieSuoButton.button_imageView.left+self.myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, self.myJieSuoButton.height);
    self.tianXieYaoQingMaButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.tianXieYaoQingMaButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.tianXieYaoQingMaButton.button_lable.text = @"填写邀请码";
    self.tianXieYaoQingMaButton.button_lable1.frame = CGRectMake(self.tianXieYaoQingMaButton.width-100*BiLiWidth-12*BiLiWidth, 0, 100*BiLiWidth, self.tianXieYaoQingMaButton.height);
    self.tianXieYaoQingMaButton.button_lable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.tianXieYaoQingMaButton.button_lable1.textColor = RGBFormUIColor(0x333333);
    self.tianXieYaoQingMaButton.button_lable1.textAlignment = NSTextAlignmentRight;
    self.tianXieYaoQingMaButton.button_imageView1.frame = CGRectMake(self.myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (self.myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.tianXieYaoQingMaButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:self.tianXieYaoQingMaButton];
    
    self.bangDingShouJiButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.tianXieYaoQingMaButton.top+self.tianXieYaoQingMaButton.height, WIDTH_PingMu, 50*BiLiWidth)];
    self.bangDingShouJiButton.backgroundColor = [UIColor whiteColor];
    self.bangDingShouJiButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (self.myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    self.bangDingShouJiButton.button_imageView.image = [UIImage imageNamed:@"my_bangDingTel"];
    self.bangDingShouJiButton.button_lable.frame = CGRectMake(self.myJieSuoButton.button_imageView.left+self.myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, self.myJieSuoButton.height);
    self.bangDingShouJiButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.bangDingShouJiButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.bangDingShouJiButton.button_lable.text = @"绑定手机号";
    [self.mainScrollView addSubview:self.bangDingShouJiButton];
        
    self.mobileButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-163*BiLiWidth, 0, 150*BiLiWidth, self.bangDingShouJiButton.height)];
    [self.mobileButton addTarget:self action:@selector(mobileButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.mobileButton.button_lable.frame = CGRectMake(0, 0, 100*BiLiWidth, self.mobileButton.height);
    self.mobileButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.mobileButton.button_lable.textColor = RGBFormUIColor(0x343434);
    self.mobileButton.button_lable.textAlignment = NSTextAlignmentRight;
    self.mobileButton.button_lable1.frame = CGRectMake(100*BiLiWidth, 0, 50*BiLiWidth, self.mobileButton.height);
    self.mobileButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.mobileButton.button_lable1.textColor = RGBFormUIColor(0x00AEFF);
    self.mobileButton.button_lable1.textAlignment = NSTextAlignmentRight;
    self.mobileButton.button_imageView.frame = CGRectMake(self.mobileButton.width-9*BiLiWidth, (self.mobileButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.mobileButton.button_imageView.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.bangDingShouJiButton addSubview:self.mobileButton];
    
    self.qieHuanZhangHao = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-280*BiLiWidth)/2, self.bangDingShouJiButton.top+self.bangDingShouJiButton.height+20*BiLiWidth, 280*BiLiWidth, 40*BiLiWidth)];
    [self.qieHuanZhangHao addTarget:self action:@selector(qieHuanZhangHaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.qieHuanZhangHao];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6B6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0A76);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = self.qieHuanZhangHao.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [self.qieHuanZhangHao.layer addSublayer:gradientLayer1];
    
    UILabel * qieHuanZhangHaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.qieHuanZhangHao.width, self.qieHuanZhangHao.height)];
    qieHuanZhangHaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    qieHuanZhangHaoLable.textAlignment = NSTextAlignmentCenter;
    qieHuanZhangHaoLable.textColor = [UIColor whiteColor];
    qieHuanZhangHaoLable.text = @"切换账号";
    [self.qieHuanZhangHao addSubview:qieHuanZhangHaoLable];

    
//    self.tiXianButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.tianXieYaoQingMaButton.top+self.tianXieYaoQingMaButton.height, WIDTH_PingMu, 50*BiLiWidth)];
//    [self.tiXianButton addTarget:self action:@selector(tiXianButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    self.tiXianButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (self.myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
//    self.tiXianButton.button_imageView.image = [UIImage imageNamed:@"my_jinBiTiXian"];
//    self.tiXianButton.button_lable.frame = CGRectMake(self.myJieSuoButton.button_imageView.left+self.myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, self.myJieSuoButton.height);
//    self.tiXianButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
//    self.tiXianButton.button_lable.textColor = RGBFormUIColor(0x333333);
//    self.tiXianButton.button_lable.text = @"金币提现";
//    self.tiXianButton.button_lable1.frame = CGRectMake(self.tianXieYaoQingMaButton.width-100*BiLiWidth-12*BiLiWidth, 0, 100*BiLiWidth, self.tianXieYaoQingMaButton.height);
//    self.tiXianButton.button_lable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
//    self.tiXianButton.button_lable1.textColor = RGBFormUIColor(0x333333);
//    self.tiXianButton.button_lable1.textAlignment = NSTextAlignmentRight;
//    self.tiXianButton.button_imageView1.frame = CGRectMake(self.myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (self.myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
//    self.tiXianButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
//    [self.mainScrollView addSubview:self.tiXianButton];
//
//    self.jinBiMingXiButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.tiXianButton.top+self.tiXianButton.height, WIDTH_PingMu, 50*BiLiWidth)];
//    [self.jinBiMingXiButton addTarget:self action:@selector(jinBiMingXiButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    self.jinBiMingXiButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (self.myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
//    self.jinBiMingXiButton.button_imageView.image = [UIImage imageNamed:@"my_jinBiMingXi"];
//    self.jinBiMingXiButton.button_lable.frame = CGRectMake(self.myJieSuoButton.button_imageView.left+self.myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, self.myJieSuoButton.height);
//    self.jinBiMingXiButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
//    self.jinBiMingXiButton.button_lable.textColor = RGBFormUIColor(0x333333);
//    self.jinBiMingXiButton.button_lable.text = @"金币明细";
//    self.jinBiMingXiButton.button_lable1.frame = CGRectMake(self.tianXieYaoQingMaButton.width-100*BiLiWidth-12*BiLiWidth, 0, 100*BiLiWidth, self.tianXieYaoQingMaButton.height);
//    self.jinBiMingXiButton.button_lable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
//    self.jinBiMingXiButton.button_lable1.textColor = RGBFormUIColor(0x333333);
//    self.jinBiMingXiButton.button_lable1.textAlignment = NSTextAlignmentRight;
//    self.jinBiMingXiButton.button_imageView1.frame = CGRectMake(self.myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (self.myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
//    self.jinBiMingXiButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
//    [self.mainScrollView addSubview:self.jinBiMingXiButton];

    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.qieHuanZhangHao.top+self.qieHuanZhangHao.height+20*BiLiWidth)];
    
    self.headerShakeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.headerImageView.left, self.headerImageView.bottom+4*BiLiWidth, 82*BiLiWidth, 44*BiLiWidth)];
    self.headerShakeImageView.image = [UIImage imageNamed:@"headerTipKuang"];
    [self.mainScrollView addSubview:self.headerShakeImageView];
    [NormalUse shakeAnimationForView:self.headerShakeImageView];

    self.settingShakeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-66*BiLiWidth, sheZhiButton.bottom+4*BiLiWidth, 66*BiLiWidth, 44*BiLiWidth)];
    self.settingShakeImageView.image = [UIImage imageNamed:@"shouShiMiMaTipKuang"];
    [self.mainScrollView addSubview:self.settingShakeImageView];
    [NormalUse shakeAnimationForView:self.settingShakeImageView];

    
}
#pragma mark--UIButton
-(void)editUserMessage
{
    [self.headerShakeImageView removeFromSuperview];
    EditUserMessageViewController * vc = [[EditUserMessageViewController alloc] init];
    vc.userInfo = self.userInfo;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)xiaoXiButonClick
{
    XiaoXiViewController * vc = [[XiaoXiViewController alloc] init];
    vc.xiaoXiWeiDuInfo = self.xiaoXiWeiDuInfo;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)sheZhiButtonClick
{
    [self.settingShakeImageView removeFromSuperview];
    
    SheZhiViewController * vc = [[SheZhiViewController alloc] init];
    vc.userInfo = self.userInfo;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)huiYuanButtonClick
{
    HuiYuanViewController * vc = [[HuiYuanViewController alloc] init];
    vc.info = self.userInfo;
    vc.vipListInfo = self.vipListInfo;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)myZhangHuButtonClick
{

    if([NormalUse isValidString:[NormalUse defaultsGetObjectKey:LoginToken]])
    {
        ZhangHuDetailViewController * vc = [[ZhangHuDetailViewController alloc] init];
        NSNumber * coin = [self.userInfo objectForKey:@"coin"];
        vc.yuEStr = [NSString stringWithFormat:@"%d",coin.intValue];
        [self.navigationController pushViewController:vc animated:YES];

    }
}
-(void)shouCangGuanZhuButtonClick
{
    MyShouCangGuanZhuViewController * vc = [[MyShouCangGuanZhuViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)myFaBuButtonClick
{
    MyFaBuViewController * vc = [[MyFaBuViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)jingJiRenButtonClick
{
    JingJiRenDianPuDetailViewController * vc = [[JingJiRenDianPuDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)myJieSuoButtonClick
{
    MyJieSuoListViewController * vc = [[MyJieSuoListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)keFuButtonClick
{
    JinChanWebViewController * vc = [[JinChanWebViewController alloc] init];
    vc.forWhat = @"help";
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)chatOnLineButtonClick
{
    NSArray *displayConversationTypeArray = @[@(ConversationType_PRIVATE)];
    ChatListViewController * chatListVC = [[ChatListViewController alloc] initWithDisplayConversationTypes:displayConversationTypeArray collectionConversationType:nil];
//    ChatListViewController * chatListVC = [[ChatListViewController alloc] init];
    [self.navigationController pushViewController:chatListVC animated:YES];
    [self yinCangTabbar];
}
-(void)tuiGuangButtonClick
{
    TuiGuangZhuanQianViewController * vc = [[TuiGuangZhuanQianViewController alloc] init];
    vc.share_code = [self.userInfo objectForKey:@"share_code"];
    vc.qrcode_url = [self.userInfo objectForKey:@"qrcode_url"];
    vc.kaoBei_content = [self.userInfo objectForKey:@"copy_content"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)mobileButtonClick
{
    if ([NormalUse isValidString:[self.userInfo objectForKey:@"mobile"]]) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"是否确定解除绑定此手机号" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
        }];
        UIAlertAction* sureAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [HTTPModel jieBangMobile:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                
                if (status==1) {
                    
                    [self getUserInfo];
                }
                else
                {
                    [NormalUse showToastView:msg view:self.view];
                }
            }];

        }];

        [alert addAction:cancleAction];
        [alert addAction:sureAction];
        [self presentViewController:alert animated:YES completion:nil];

    }
    else
    {
        InputMobileViewController * vc = [[InputMobileViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
}
-(void)qieHuanZhangHaoButtonClick
{
    InputMobileViewController * vc = [[InputMobileViewController alloc] init];
    vc.bangDingOrQieHuan = @"2";
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)tianXieYaoQingMaButtonClick
{
    self.tianXieYaoQingMaView.hidden = NO;
}
-(void)tiXianButtonClick
{
    TiXianViewController * vc = [[TiXianViewController alloc] init];
    NSNumber * coin = [self.userInfo objectForKey:@"coin"];
    vc.yuEStr = [NSString stringWithFormat:@"%d",coin.intValue];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)jinBiMingXiButtonClick
{
    JinBiMingXiViewController * vc = [[JinBiMingXiViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
