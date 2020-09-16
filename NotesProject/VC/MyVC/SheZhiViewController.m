//
//  SettingViewController.m
//  SheQu
//
//  Created by 周璟琳 on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SheZhiViewController.h"

@interface SheZhiViewController ()
{
    float huanCun;
}

@property(nonatomic,strong)UIScrollView * mainScrollView;

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

 
    UIButton * zhaoHuiMiMaButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 15*BiLiWidth, WIDTH_PingMu, 53*BiLiWidth)];
    [zhaoHuiMiMaButton addTarget:self action:@selector(zhaoHuiMiMaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    zhaoHuiMiMaButton.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:zhaoHuiMiMaButton];
    
    UILabel * zhaoHuiMiMaLable = [[UILabel alloc] initWithFrame:CGRectMake(16*BiLiWidth,0, 100*BiLiWidth, 53*BiLiWidth)];
    zhaoHuiMiMaLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    zhaoHuiMiMaLable.textColor = RGBFormUIColor(0x343434);
    zhaoHuiMiMaLable.text = @"找回密码";
    [zhaoHuiMiMaButton addSubview:zhaoHuiMiMaLable];
    
    UIImageView * zhaoHuiMiMaLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-(17+18)*BiLiWidth, (53*BiLiWidth-18*BiLiWidth)/2, 18*BiLiWidth, 18*BiLiWidth)];
    zhaoHuiMiMaLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [zhaoHuiMiMaButton addSubview:zhaoHuiMiMaLeftImageView];
    
    UIView * zhaoHuiMiMaLineView = [[UIView alloc] initWithFrame:CGRectMake(0, zhaoHuiMiMaButton.height-1, WIDTH_PingMu, 1)];
    zhaoHuiMiMaLineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [zhaoHuiMiMaButton addSubview:zhaoHuiMiMaLineView];

    
    UIButton * shouShiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, zhaoHuiMiMaButton.top+zhaoHuiMiMaButton.height, WIDTH_PingMu, 53*BiLiWidth)];
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

    
    UIButton * guiFanButton = [[UIButton alloc] initWithFrame:CGRectMake(0, cleanButton.top+cleanButton.height, WIDTH_PingMu, 53*BiLiWidth)];
    [guiFanButton addTarget:self action:@selector(guiFanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    guiFanButton.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:guiFanButton];
    
    UILabel * guiFanLable = [[UILabel alloc] initWithFrame:CGRectMake(16*BiLiWidth,0, 100*BiLiWidth, 53*BiLiWidth)];
    guiFanLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    guiFanLable.textColor = RGBFormUIColor(0x343434);
    guiFanLable.text = @"用户试用规范";
    [guiFanButton addSubview:guiFanLable];
    
    UIImageView * guiFanLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-(17+18)*BiLiWidth, (53*BiLiWidth-18*BiLiWidth)/2, 18*BiLiWidth, 18*BiLiWidth)];
    guiFanLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [guiFanButton addSubview:guiFanLeftImageView];

    UIView * guiFanLineView = [[UIView alloc] initWithFrame:CGRectMake(0, shouShiButton.height-1, WIDTH_PingMu, 1)];
    guiFanLineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [guiFanButton addSubview:guiFanLineView];

    UIButton * versionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, guiFanButton.top+guiFanButton.height, WIDTH_PingMu, 53*BiLiWidth)];
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
}
-(void)zhaoHuiMiMaButtonClick
{
    
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
/*
-(void)tuiChuButtonClick
{
    
    __weak typeof(self) wself = self;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"退出登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * exit = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [wself LoginOut];
             
    }];
    [alert addAction:cancle];
    [alert addAction:exit];
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)LoginOut
{
    [HTTPModel loginOut:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            [NormalUse defaultsSetObject:nil forKey:UserInformation];
            [NormalUse defaultsSetObject:nil forKey:LoginToken];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate setYiDengLuTabBar];
}
*/
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self yinCangTabbar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
