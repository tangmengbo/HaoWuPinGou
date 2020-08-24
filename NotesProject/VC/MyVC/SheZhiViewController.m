//
//  SettingViewController.m
//  SheQu
//
//  Created by 周璟琳 on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SheZhiViewController.h"

@interface SheZhiViewController ()

@property(nonatomic,strong)UIScrollView * mainScrollView;



@property(nonatomic,strong)Lable_ImageButton * vipTimeButton;


@end

@implementation SheZhiViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"Settings";
    self.topTitleLale.alpha = 0.9;

    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topNavView.frame.origin.y+self.topNavView.frame.size.height, WIDTH_PingMu, HEIGHT_PingMu)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];


    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, bottomView.frame.origin.y+ 5*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(bottomView.frame.origin.y+5*BiLiWidth))];
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, HEIGHT_PingMu+20)];
    [self.view addSubview:self.mainScrollView];

 

    
    UIButton * noticeButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, WIDTH_PingMu, 45*BiLiWidth)];
    noticeButton.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:noticeButton];
    
//    UILabel * noticeLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, (45*BiLiWidth-15*BiLiWidth)/2, 15*BiLiWidth*4.5, 15*BiLiWidth)];
//    noticeLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
//    noticeLable.textColor = [UIColor blackColor];
//    noticeLable.alpha = 0.9;
//    noticeLable.text = TEXT_LanguageInternationalization(@"Notifications");
//    [noticeButton addSubview:noticeLable];
//
//
//    UILabel * noticeLable1 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-12*BiLiWidth-40, (45*BiLiWidth-15*BiLiWidth)/2, 200, 15*BiLiWidth)];
//    noticeLable1.font = [UIFont systemFontOfSize:15*BiLiWidth];
//    noticeLable1.textColor = [UIColor blackColor];
//    noticeLable1.textAlignment = NSTextAlignmentRight;
//    noticeLable1.alpha = 0.3;
//    noticeLable1.text = @"Turned on";
//    [noticeButton addSubview:noticeLable1];
    
    UILabel * acountLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, (45*BiLiWidth-15*BiLiWidth)/2, 15*BiLiWidth*10, 15*BiLiWidth)];
    acountLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    acountLable.textColor = [UIColor blackColor];
    acountLable.alpha = 0.9;
    acountLable.text = @"Notifications";
    [noticeButton addSubview:acountLable];
    
    acountLable.width = [NormalUse setSize:@"Notifications" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth].width;


    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(9*BiLiWidth, noticeButton.frame.origin.y+noticeButton.frame.size.height+15*BiLiWidth, WIDTH_PingMu-18*BiLiWidth, 40*BiLiWidth)];
    tipLable.text = @"In the iPhone's Settings - notification center - function,  find the app Tick to change the Settings for new message alerts";
    tipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    tipLable.alpha = 0.5;
    tipLable.numberOfLines = 2;
    [self.mainScrollView addSubview:tipLable];
    
    

    
    UIButton * aboutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, tipLable.frame.origin.y+tipLable.frame.size.height+15*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    aboutButton.backgroundColor = [UIColor whiteColor];
    [aboutButton addTarget:self action:@selector(aboutButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:aboutButton];
    
    UILabel * aboutLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, (45*BiLiWidth-14*BiLiWidth)/2, 15*BiLiWidth*10, 15*BiLiWidth)];
    aboutLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    aboutLable.textColor = [UIColor blackColor];
    aboutLable.alpha = 0.9;
    aboutLable.text = @"Version Number";
    [aboutButton addSubview:aboutLable];
    aboutLable.width = [NormalUse setSize:@"Version Number" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth].width;


    UIImageView * aboutLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-(12+18)*BiLiWidth, (45*BiLiWidth-18*BiLiWidth)/2, 18*BiLiWidth, 18*BiLiWidth)];
    aboutLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [aboutButton addSubview:aboutLeftImageView];
    
    UIButton * restoringButton;
    restoringButton = [[UIButton alloc] init];
    [self.mainScrollView addSubview:restoringButton];

        
    restoringButton.frame = CGRectMake(0, aboutButton.frame.origin.y+aboutButton.frame.size.height+15*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth);
    restoringButton.backgroundColor = [UIColor whiteColor];
    
    UILabel * restoringLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, (45*BiLiWidth-17*BiLiWidth)/2, 15*BiLiWidth*4.5, 17*BiLiWidth)];
    restoringLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    restoringLable.textColor = [UIColor blackColor];
    restoringLable.alpha = 0.9;
    restoringLable.text = @"Vip Restoring";
    [restoringButton addSubview:restoringLable];
    
    restoringLable.width = [NormalUse setSize:@"Vip Restoring" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth].width;
    
    self.vipTimeButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-162*BiLiWidth, 0, 150*BiLiWidth, restoringButton.height)];
    [self.vipTimeButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.vipTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.vipTimeButton.alpha = 0.9;
    self.vipTimeButton.button_lable.frame = CGRectMake(0, 0, self.vipTimeButton.width-25*BiLiWidth*282/180, self.vipTimeButton.height);
    self.vipTimeButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.vipTimeButton.titleLabel.textColor = [UIColor blackColor];
    self.vipTimeButton.button_imageView.frame = CGRectMake(self.vipTimeButton.width-25*BiLiWidth*282/180, 10*BiLiWidth, 25*BiLiWidth*282/180, 25*BiLiWidth);
    self.vipTimeButton.button_imageView.image = [UIImage imageNamed:@"vip_Restoring"];
    [self.vipTimeButton addTarget:self action:@selector(restoringButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [restoringButton addSubview:self.vipTimeButton];
    
    
    
    UIButton * heiMingDanButton = [[UIButton alloc] initWithFrame:CGRectMake(0, restoringButton.frame.origin.y+restoringButton.frame.size.height+15*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    heiMingDanButton.backgroundColor = [UIColor whiteColor];
    [heiMingDanButton addTarget:self action:@selector(heiMingDanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:heiMingDanButton];
    
    UILabel * heiMingDanLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, (45*BiLiWidth-14*BiLiWidth)/2, 15*BiLiWidth*4.5, 15*BiLiWidth)];
    heiMingDanLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    heiMingDanLable.textColor = [UIColor blackColor];
    heiMingDanLable.alpha = 0.9;
    heiMingDanLable.text = @"Blacklist";
    [heiMingDanButton addSubview:heiMingDanLable];
    
    heiMingDanLable.width = [NormalUse setSize:@"Blacklist" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth].width;

    
    UIImageView * heiMingDanLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-(12+18)*BiLiWidth, (45*BiLiWidth-18*BiLiWidth)/2, 18*BiLiWidth, 18*BiLiWidth)];
    heiMingDanLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [heiMingDanButton addSubview:heiMingDanLeftImageView];
    
    UIButton * zhuXiaoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, heiMingDanButton.frame.origin.y+heiMingDanButton.frame.size.height+15*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    zhuXiaoButton.backgroundColor = [UIColor whiteColor];
    [zhuXiaoButton addTarget:self action:@selector(zhuXiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:zhuXiaoButton];
    
    UILabel * zhuXiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, (45*BiLiWidth-14*BiLiWidth)/2, 15*BiLiWidth*10, 15*BiLiWidth)];
    zhuXiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    zhuXiaoLable.textColor = [UIColor blackColor];
    zhuXiaoLable.alpha = 0.9;
    zhuXiaoLable.text = @"Account cancellation";
    [zhuXiaoButton addSubview:zhuXiaoLable];
    
    zhuXiaoLable.width = [NormalUse setSize:@"Account cancellation" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth].width;

    
    
    
    UIImageView * zhuXiaoLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-(12+18)*BiLiWidth, (45*BiLiWidth-18*BiLiWidth)/2, 18*BiLiWidth, 18*BiLiWidth)];
    zhuXiaoLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [zhuXiaoButton addSubview:zhuXiaoLeftImageView];

    
    
    UIButton * tuiChuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, zhuXiaoButton.frame.origin.y+zhuXiaoButton.frame.size.height+15*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    tuiChuButton.backgroundColor = [UIColor whiteColor];
    [tuiChuButton addTarget:self action:@selector(tuiChuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:tuiChuButton];
    
    UILabel * exitLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, (45*BiLiWidth-17*BiLiWidth)/2, 15*BiLiWidth*4.5, 17*BiLiWidth)];
    exitLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    exitLable.textColor = [UIColor blackColor];
    exitLable.alpha = 0.9;
    exitLable.text = @"Log out";
    [tuiChuButton addSubview:exitLable];
    
    exitLable.width = [NormalUse setSize:@"Log out" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth].width;

    
    
    
    UIImageView * exitLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-(12+18)*BiLiWidth, (45*BiLiWidth-18*BiLiWidth)/2, 18*BiLiWidth, 18*BiLiWidth)];
    exitLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [tuiChuButton addSubview:exitLeftImageView];
    
    
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, tuiChuButton.frame.origin.y+tuiChuButton.frame.size.height+50*BiLiWidth)];
}

-(void)restoringButtonClick
{
   

    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([@"true" isEqualToString:[defaults objectForKey:@"userAlsoVip"]]) {

        [NormalUse showToastView:@"Restor Success" view:self.view];

    }
    else
    {
        [NormalUse showToastView:@"You don't need to restor" view:self.view];

    }
}
-(void)getVipInfoError:(NSDictionary *)info
{
    [NormalUse quXiaoGifLoadingView:self];
}
-(void)aboutButtonClick
{
}
-(void)heiMingDanButtonClick
{
}
-(void)zhuXiaoButtonClick
{
}
-(void)tuiChuButtonClick
{
    
    __weak typeof(self) wself = self;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Log out" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * exit = [UIAlertAction actionWithTitle:@"Log out" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [wself LoginOut];
             
    }];
    [alert addAction:cancle];
    [alert addAction:exit];
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)LoginOut
{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate setWeiDengLuTabBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self yinCangTabbar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
