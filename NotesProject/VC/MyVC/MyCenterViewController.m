//
//  MyCenterViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyCenterViewController.h"

@interface MyCenterViewController ()

@property(nonatomic,strong)NSDictionary * userInfo;

@end

@implementation MyCenterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self xianShiTabBar];
    
    [HTTPModel getUserInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
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

            //auth_vip 2终身会员 1年会员 0非会员
            NSNumber * auth_vip = [self.userInfo objectForKey:@"auth_vip"];
            if ([auth_vip isKindOfClass:[NSNumber class]]) {
                
                if (auth_vip.intValue==0) {
                    
                    self.huiYuanTitleLable.text = @"开通会员";
                    self.huiYuanDaoQiLable.text = @"暂未开通会员";


                }
                else
                {
                    self.huiYuanTitleLable.text = @"会员到期时间";
                    self.huiYuanDaoQiLable.text = @"";

                }
            }
            
        }
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self.mainScrollView addSubview:self.headerImageView];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NormalUse getCurrentAvatarpath]] placeholderImage:[UIImage imageNamed:@"moRen_header"]];
    
    self.nickLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.left+self.headerImageView.width+14*BiLiWidth, TopHeight_PingMu+19*BiLiWidth, 150*BiLiWidth, 17*BiLiWidth)];
    self.nickLable.textColor = RGBFormUIColor(0x333333);
    self.nickLable.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.nickLable.text = @"去玩而且二";
    [self.mainScrollView addSubview:self.nickLable];
    self.nickLable.text = [NormalUse getCurrentUserName];
    
    self.nickLable =
    
    self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(self.nickLable.left, self.nickLable.top+self.nickLable.height+6.5*BiLiWidth, 150*BiLiWidth, 12*BiLiWidth)];
    self.messageLable.textColor = RGBFormUIColor(0x999999);
    self.messageLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.messageLable.text = @"非VIP暂无免费解锁次数";
    [self.mainScrollView addSubview:self.messageLable];

    
    UIButton * xiaoXiButton = [[UIButton alloc] initWithFrame:CGRectMake(277*BiLiWidth, TopHeight_PingMu+12.5*BiLiWidth, 19*BiLiWidth, 22*BiLiWidth)];
    [xiaoXiButton setImage:[UIImage imageNamed:@"my_xiaoXi"] forState:UIControlStateNormal];
    [xiaoXiButton addTarget:self action:@selector(xiaoXiButonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:xiaoXiButton];
    
    UIButton * sheZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(xiaoXiButton.left+xiaoXiButton.width+27*BiLiWidth, TopHeight_PingMu+12.5*BiLiWidth, 20*BiLiWidth, 22*BiLiWidth)];
    [sheZhiButton setImage:[UIImage imageNamed:@"my_setting"] forState:UIControlStateNormal];
    [sheZhiButton addTarget:self action:@selector(sheZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:sheZhiButton];
    
    
    self.mianFeiJieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(36.5*BiLiWidth, self.headerImageView.top+self.headerImageView.height+24*BiLiWidth, 50*BiLiWidth, 40*BiLiWidth)];
    self.mianFeiJieSuoButton.button_lable.frame = CGRectMake(0, 0, self.mianFeiJieSuoButton.width, 17*BiLiWidth);
    self.mianFeiJieSuoButton.button_lable.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.mianFeiJieSuoButton.button_lable.textColor = RGBFormUIColor(0x343434);
    self.mianFeiJieSuoButton.button_lable.textAlignment = NSTextAlignmentCenter;
    self.mianFeiJieSuoButton.button_lable1.frame = CGRectMake(0, 28*BiLiWidth, self.mianFeiJieSuoButton.width, 12*BiLiWidth);
    self.mianFeiJieSuoButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.mianFeiJieSuoButton.button_lable1.textColor = RGBFormUIColor(0x9A9A9A);
    self.mianFeiJieSuoButton.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.mianFeiJieSuoButton.button_lable1.text = @"免费解锁";
    [self.mainScrollView addSubview:self.mianFeiJieSuoButton];
    
    self.mianFeiFaBuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-50*BiLiWidth)/2, self.headerImageView.top+self.headerImageView.height+24*BiLiWidth, 50*BiLiWidth, 40*BiLiWidth)];
    self.mianFeiFaBuButton.button_lable.frame = CGRectMake(0, 0, self.mianFeiJieSuoButton.width, 17*BiLiWidth);
    self.mianFeiFaBuButton.button_lable.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.mianFeiFaBuButton.button_lable.textColor = RGBFormUIColor(0x343434);
    self.mianFeiFaBuButton.button_lable.textAlignment = NSTextAlignmentCenter;
    self.mianFeiFaBuButton.button_lable1.frame = CGRectMake(0, 28*BiLiWidth, self.mianFeiJieSuoButton.width, 12*BiLiWidth);
    self.mianFeiFaBuButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.mianFeiFaBuButton.button_lable1.textColor = RGBFormUIColor(0x9A9A9A);
    self.mianFeiFaBuButton.button_lable1.textAlignment = NSTextAlignmentCenter;
    self.mianFeiFaBuButton.button_lable1.text = @"免费发布";
    [self.mainScrollView addSubview:self.mianFeiFaBuButton];

    self.shouCangGuanZhuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-50*BiLiWidth-36.5*BiLiWidth, self.headerImageView.top+self.headerImageView.height+24*BiLiWidth, 50*BiLiWidth, 40*BiLiWidth)];
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


    
    
    UIButton * huiYuanButton = [[UIButton alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.shouCangGuanZhuButton.top+self.shouCangGuanZhuButton.height+18.5*BiLiWidth, 160*BiLiWidth, 78*BiLiWidth)];
    [huiYuanButton setBackgroundImage:[UIImage imageNamed:@"my_huiYuanBottom"] forState:UIControlStateNormal];
    [huiYuanButton addTarget:self action:@selector(huiYuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:huiYuanButton];
    
    self.huiYuanTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(8.5*BiLiWidth, 23*BiLiWidth, 90*BiLiWidth, 14*BiLiWidth)];
    self.huiYuanTitleLable.textColor = RGBFormUIColor(0x865A0A);
    self.huiYuanTitleLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [huiYuanButton addSubview:self.huiYuanTitleLable];
    
    self.huiYuanDaoQiLable = [[UILabel alloc] initWithFrame:CGRectMake(8.5*BiLiWidth, self.huiYuanTitleLable.top+self.huiYuanTitleLable.height+8*BiLiWidth, 90*BiLiWidth, 11*BiLiWidth)];
    self.huiYuanDaoQiLable.textColor = RGBFormUIColor(0xC49A47);
    self.huiYuanDaoQiLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [huiYuanButton addSubview:self.huiYuanDaoQiLable];

    
    UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(huiYuanButton.left+huiYuanButton.width+16*BiLiWidth, huiYuanButton.top, huiYuanButton.width, huiYuanButton.height)];
    [chongZhiButton setBackgroundImage:[UIImage imageNamed:@"my_jinBiBottom"] forState:UIControlStateNormal];
    [self.mainScrollView addSubview:chongZhiButton];

    self.yuELable = [[UILabel alloc] initWithFrame:CGRectMake(94.5*BiLiWidth, 39*BiLiWidth, 60*BiLiWidth, 17*BiLiWidth)];
    self.yuELable.textColor = RGBFormUIColor(0xFECF61);
    self.yuELable.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.yuELable.adjustsFontSizeToFitWidth = YES;
    [chongZhiButton addSubview:self.yuELable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, huiYuanButton.top+huiYuanButton.height+24*BiLiWidth, WIDTH_PingMu, 8*BiLiWidth)];
    lineView.backgroundColor = RGBFormUIColor(0xEDEDED);
    [self.mainScrollView addSubview:lineView];

    Lable_ImageButton  * myJieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, lineView.top+lineView.height+9*BiLiWidth, WIDTH_PingMu, 50*BiLiWidth)];
    [myJieSuoButton addTarget:self action:@selector(myJieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    myJieSuoButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    myJieSuoButton.button_imageView.image = [UIImage imageNamed:@"my_jieSuo"];
    myJieSuoButton.button_lable.frame = CGRectMake(myJieSuoButton.button_imageView.left+myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, myJieSuoButton.height);
    myJieSuoButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    myJieSuoButton.button_lable.textColor = RGBFormUIColor(0x333333);
    myJieSuoButton.button_lable.text = @"我的解锁";
    myJieSuoButton.button_imageView1.frame = CGRectMake(myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    myJieSuoButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:myJieSuoButton];
    
    
    Lable_ImageButton  * myFaBuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, myJieSuoButton.top+myJieSuoButton.height, WIDTH_PingMu, 50*BiLiWidth)];
    myFaBuButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    myFaBuButton.button_imageView.image = [UIImage imageNamed:@"my_faBu"];
    myFaBuButton.button_lable.frame = CGRectMake(myJieSuoButton.button_imageView.left+myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, myJieSuoButton.height);
    myFaBuButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    myFaBuButton.button_lable.textColor = RGBFormUIColor(0x333333);
    myFaBuButton.button_lable.text = @"我的发布";
    myFaBuButton.button_imageView1.frame = CGRectMake(myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    myFaBuButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:myFaBuButton];

    
    Lable_ImageButton  * myShouCangButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, myFaBuButton.top+myFaBuButton.height, WIDTH_PingMu, 50*BiLiWidth)];
    myShouCangButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    myShouCangButton.button_imageView.image = [UIImage imageNamed:@"my_shouCang"];
    myShouCangButton.button_lable.frame = CGRectMake(myJieSuoButton.button_imageView.left+myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, myJieSuoButton.height);
    myShouCangButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    myShouCangButton.button_lable.textColor = RGBFormUIColor(0x333333);
    myShouCangButton.button_lable.text = @"我的收藏";
    myShouCangButton.button_imageView1.frame = CGRectMake(myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    myShouCangButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:myShouCangButton];

    
    Lable_ImageButton  * myKeFuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, myShouCangButton.top+myShouCangButton.height, WIDTH_PingMu, 50*BiLiWidth)];
    myKeFuButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    myKeFuButton.button_imageView.image = [UIImage imageNamed:@"my_keFu"];
    myKeFuButton.button_lable.frame = CGRectMake(myJieSuoButton.button_imageView.left+myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, myJieSuoButton.height);
    myKeFuButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    myKeFuButton.button_lable.textColor = RGBFormUIColor(0x333333);
    myKeFuButton.button_lable.text = @"联系客服";
    myKeFuButton.button_imageView1.frame = CGRectMake(myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    myKeFuButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:myKeFuButton];

    
    Lable_ImageButton  * tuiGuangButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, myKeFuButton.top+myKeFuButton.height, WIDTH_PingMu, 50*BiLiWidth)];
    tuiGuangButton.button_imageView.frame = CGRectMake(21*BiLiWidth, (myJieSuoButton.height-20*BiLiWidth)/2, 20*BiLiWidth, 20*BiLiWidth);
    tuiGuangButton.button_imageView.image = [UIImage imageNamed:@"my_tuiGuang"];
    tuiGuangButton.button_lable.frame = CGRectMake(myJieSuoButton.button_imageView.left+myJieSuoButton.button_imageView.width+20.5*BiLiWidth, 0, 200*BiLiWidth, myJieSuoButton.height);
    tuiGuangButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    tuiGuangButton.button_lable.textColor = RGBFormUIColor(0x333333);
    tuiGuangButton.button_lable.text = @"推广赚钱";
    tuiGuangButton.button_imageView1.frame = CGRectMake(myJieSuoButton.width-9*BiLiWidth-12*BiLiWidth, (myJieSuoButton.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    tuiGuangButton.button_imageView1.image = [UIImage imageNamed:@"my_left_jiaoTou"];
    [self.mainScrollView addSubview:tuiGuangButton];

    UIButton * kaiJiangButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-330*BiLiWidth)/2, tuiGuangButton.top+tuiGuangButton.height+8*BiLiWidth, 330*BiLiWidth, 76.5*BiLiWidth)];
    [kaiJiangButton setBackgroundImage:[UIImage imageNamed:@"my_kaiJiang"] forState:UIControlStateNormal];
    [kaiJiangButton addTarget:self action:@selector(kaiJiangButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:kaiJiangButton];
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, kaiJiangButton.top+kaiJiangButton.height+40*BiLiWidth)];
    
}
#pragma mark--UIButton
-(void)xiaoXiButonClick
{
    XiaoXiViewController * vc = [[XiaoXiViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)sheZhiButtonClick
{
    SheZhiViewController * vc = [[SheZhiViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)huiYuanButtonClick
{
    HuiYuanViewController * vc = [[HuiYuanViewController alloc] init];
    vc.info = self.userInfo;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)myJieSuoButtonClick
{
    MyJieSuoListViewController * vc = [[MyJieSuoListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)kaiJiangButtonClick
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.tabbar setItemSelected:3];
}
@end
