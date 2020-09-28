//
//  SettingViewController.m
//  SheQu
//
//  Created by 周璟琳 on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SheZhiViewController.h"
#import "InputMobileViewController.h"

@interface SheZhiViewController ()
{
    float huanCun;
}

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)Lable_ImageButton * mobileButton;

@property(nonatomic,strong)UILabel * cleanLable;


@end

@implementation SheZhiViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"设置";
    self.topTitleLale.alpha = 0.9;

    huanCun = [self readCacheSize];


    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.frame.origin.y+self.topNavView.frame.size.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.frame.origin.y+self.topNavView.frame.size.height))];
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, HEIGHT_PingMu+20)];
    [self.view addSubview:self.mainScrollView];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshUserInfo];
    [self yinCangTabbar];

}
-(void)refreshUserInfo
{
    
    [HTTPModel getUserInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            self.userInfo = responseObject;
            [NormalUse defaultsSetObject:[NormalUse removeNullFromDictionary:self.userInfo] forKey:UserInformation];
            [self initView];
        }
    }];

}
-(void)initView
{
    [self.mainScrollView removeAllSubviews];
    
    UIButton * mobileButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 15*BiLiWidth, WIDTH_PingMu, 53*BiLiWidth)];
    mobileButton.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:mobileButton];
    
    UILabel * mobileLable = [[UILabel alloc] initWithFrame:CGRectMake(16*BiLiWidth,0, 100*BiLiWidth, 53*BiLiWidth)];
    mobileLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    mobileLable.textColor = RGBFormUIColor(0x343434);
    mobileLable.text = @"手机号";
    [mobileButton addSubview:mobileLable];

    
    self.mobileButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-170*BiLiWidth, 0, 150*BiLiWidth, mobileButton.height)];
    [self.mobileButton addTarget:self action:@selector(mobileButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.mobileButton.button_lable.frame = CGRectMake(0, 0, 100*BiLiWidth, self.mobileButton.height);
    self.mobileButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.mobileButton.button_lable.textColor = RGBFormUIColor(0x343434);
    self.mobileButton.button_lable.textAlignment = NSTextAlignmentRight;
    self.mobileButton.button_lable1.frame = CGRectMake(100*BiLiWidth, 0, 50*BiLiWidth, self.mobileButton.height);
    self.mobileButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.mobileButton.button_lable1.textColor = RGBFormUIColor(0x00AEFF);
    self.mobileButton.button_lable1.textAlignment = NSTextAlignmentRight;
    self.mobileButton.button_imageView.frame = CGRectMake(self.mobileButton.width-18*BiLiWidth, (self.mobileButton.height-18*BiLiWidth)/2, 18*BiLiWidth, 18*BiLiWidth);
    self.mobileButton.button_imageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [mobileButton addSubview:self.mobileButton];
    
    if ([NormalUse isValidString:[self.userInfo objectForKey:@"mobile"]]) {

        self.mobileButton.button_lable.text = [self.userInfo objectForKey:@"mobile"];
        self.mobileButton.button_lable1.text = @"解绑";
        self.mobileButton.button_imageView.hidden = YES;
    }
    else
    {
        self.mobileButton.button_lable1.left = self.mobileButton.button_lable1.left-50*BiLiWidth-18*BiLiWidth;
        self.mobileButton.button_lable1.width = self.mobileButton.button_lable1.width+50*BiLiWidth;
        self.mobileButton.button_lable1.text = @"绑定手机号码";
        self.mobileButton.button_lable1.textColor = RGBFormUIColor(0x343434);

    }


    
    UIView * zhaoHuiMiMaLineView = [[UIView alloc] initWithFrame:CGRectMake(0, mobileButton.height-1, WIDTH_PingMu, 1)];
    zhaoHuiMiMaLineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [mobileButton addSubview:zhaoHuiMiMaLineView];

    
    UIButton * shouShiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, mobileButton.top+mobileButton.height, WIDTH_PingMu, 53*BiLiWidth)];
    [shouShiButton addTarget:self action:@selector(shouShiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    shouShiButton.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:shouShiButton];
    
    UILabel * shouShiLable = [[UILabel alloc] initWithFrame:CGRectMake(16*BiLiWidth,0, 100*BiLiWidth, 53*BiLiWidth)];
    shouShiLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    shouShiLable.textColor = RGBFormUIColor(0x343434);
    shouShiLable.text = @"手势密码";
    [shouShiButton addSubview:shouShiLable];
    
    UIImageView * shouShiLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-(17+18)*BiLiWidth, (53*BiLiWidth-18*BiLiWidth)/2, 18*BiLiWidth, 18*BiLiWidth)];
    shouShiLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [shouShiButton addSubview:shouShiLeftImageView];
    
    UIView * shouShiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, shouShiButton.height-1, WIDTH_PingMu, 1)];
    shouShiLineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [shouShiButton addSubview:shouShiLineView];
    
    
    UIButton * cleanButton = [[UIButton alloc] initWithFrame:CGRectMake(0, shouShiButton.top+shouShiButton.height, WIDTH_PingMu, 53*BiLiWidth)];
    [cleanButton addTarget:self action:@selector(cleanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    cleanButton.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:cleanButton];
    
    UILabel * cleanLable = [[UILabel alloc] initWithFrame:CGRectMake(16*BiLiWidth,0, 100*BiLiWidth, 53*BiLiWidth)];
    cleanLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    cleanLable.textColor = RGBFormUIColor(0x343434);
    cleanLable.text = @"清除缓存";
    [cleanButton addSubview:cleanLable];
    
    self.cleanLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-120*BiLiWidth, 0, 100*BiLiWidth, 53*BiLiWidth)];
    self.cleanLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.cleanLable.textColor = RGBFormUIColor(0x9A9A9A);
    self.cleanLable.textAlignment = NSTextAlignmentRight;
    [cleanButton addSubview:self.cleanLable];
    self.cleanLable.text =  [NSString stringWithFormat:@"%.2fM",huanCun];
    
    UIView * cleanLineView = [[UIView alloc] initWithFrame:CGRectMake(0, shouShiButton.height-1, WIDTH_PingMu, 1)];
    cleanLineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [cleanButton addSubview:cleanLineView];

    

    UIButton * versionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, cleanButton.top+cleanButton.height, WIDTH_PingMu, 53*BiLiWidth)];
    versionButton.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:versionButton];
    
    UILabel * versionLable = [[UILabel alloc] initWithFrame:CGRectMake(16*BiLiWidth,0, 100*BiLiWidth, 53*BiLiWidth)];
    versionLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    versionLable.textColor = RGBFormUIColor(0x343434);
    versionLable.text = @"版本号";
    [versionButton addSubview:versionLable];
    
    UILabel * versionNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-120*BiLiWidth, 0, 100*BiLiWidth, 53*BiLiWidth)];
    versionNumberLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    versionNumberLable.textColor = RGBFormUIColor(0x9A9A9A);
    versionNumberLable.textAlignment = NSTextAlignmentRight;
    [versionButton addSubview:versionNumberLable];
    
    NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    versionNumberLable.text = [NSString stringWithFormat:@"V%@",versionAgent];
    
    UIView * versionLineView = [[UIView alloc] initWithFrame:CGRectMake(0, shouShiButton.height-1, WIDTH_PingMu, 1)];
    versionLineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [versionButton addSubview:versionLineView];
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, versionButton.frame.origin.y+versionButton.frame.size.height+50*BiLiWidth)];



    UIButton *  tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, versionButton.top+versionButton.height+35*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [tiJiaoButton addTarget:self action:@selector(qieHuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:tiJiaoButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = tiJiaoButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [tiJiaoButton.layer addSublayer:gradientLayer1];
    
    UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tiJiaoButton.width, tiJiaoButton.height)];
    tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiJiaoLable.text = @"切换账号";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [tiJiaoButton addSubview:tiJiaoLable];
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, tiJiaoButton.frame.origin.y+tiJiaoButton.frame.size.height+50*BiLiWidth)];
    
    
    
    

}
-(void)qieHuanButtonClick
{
    InputMobileViewController * vc = [[InputMobileViewController alloc] init];
    vc.bangDingOrQieHuan = @"2";
    [self.navigationController pushViewController:vc animated:YES];
    
//    [HTTPModel loginOut:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
//
//        if (status==1) {
//
//            [NormalUse showToastView:@"已退出登录" view:self.view];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                [self.navigationController popViewControllerAnimated:YES];
//
//            });
//
//
//        }
//        else
//        {
//            [NormalUse showToastView:msg view:self.view];
//        }
//    }];

}
-(void)mobileButtonClick
{
    if ([NormalUse isValidString:[self.userInfo objectForKey:@"mobile"]]) {
        
        [HTTPModel jieBangMobile:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                [self refreshUserInfo];
            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
            }
        }];
    }
    else
    {
        InputMobileViewController * vc = [[InputMobileViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
}
-(void)shouShiButtonClick
{
    SetShouShiMiMaViewController * vc = [[SetShouShiMiMaViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)cleanButtonClick
{
    [self clearFile];

    huanCun = [self readCacheSize];

    self.cleanLable.text = [NSString stringWithFormat:@"%.2fM",huanCun];

}
-(void)guiFanButtonClick
{
    
}
//1. 获取缓存文件的大小
-( float )readCacheSize
{
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];

    
    return [ self folderSizeAtPath :cachePath];
}


//由于缓存文件存在沙箱中，我们可以通过NSFileManager API来实现对缓存文件大小的计算。
// 遍历文件夹获得文件夹大小，返回多少 M
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0);
    
}

// 计算 单个文件的大小
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];


    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}
//2. 清除缓存
- (void)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];

    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];


        }
    }
    
       
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
