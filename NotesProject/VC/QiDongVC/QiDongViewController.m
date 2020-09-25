//
//  QiDongViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/22.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "QiDongViewController.h"
#import "ZYNetworkAccessibility.h"

@interface QiDongViewController ()
{
    int timeNumber;
    BOOL alsoShowAlert;
}
@property(nonatomic,strong)UIButton * daojiShiButton;
@property(nonatomic,strong,nullable)NSTimer * timer;

@end

@implementation QiDongViewController


-(void)getNetWorkStatus
{
    [ZYNetworkAccessibility setStateDidUpdateNotifier:^(ZYNetworkAccessibleState state) {
        NSLog(@"setStateDidUpdateNotifier > %zd", state);
        
        if (ZYNetworkRestricted == state) {//没有网络权限
            
            if(!self->alsoShowAlert)
            {
                self->alsoShowAlert = YES;
                
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"网络连接失败" message:@"检测到网络权限可能未开启，您可以在“设置”中检查蜂窝移动网络" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        self->alsoShowAlert = NO;
                    }]];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        self->alsoShowAlert = NO;

                        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
                            [[UIApplication sharedApplication] openURL:settingsURL];
                            
                        }
                    }]];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil] ;

            }
            
        }
        if (state == ZYNetworkAccessible) {//网络可用
            
            [ZYNetworkAccessibility stop];

            [HTTPModel getAppJinBiList:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
                if (status==1) {
                    
                    NSDictionary * info = [NormalUse removeNullFromDictionary:responseObject];
                    [NormalUse defaultsSetObject:info forKey:JinBiShuoMing];
                }
            }];

            //未登录用户先 获取初始化账号
            [HTTPModel registerInit:[[NSDictionary alloc]initWithObjectsAndKeys:[NormalUse getSheBeiBianMa],@"phone_ucode", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                
                if (status==1) {
                    
                    if ([NormalUse isValidDictionary:[responseObject objectForKey:@"info"]]) {
                        
                        //用户基本信息存储到本地
                        [NormalUse defaultsSetObject:[NormalUse removeNullFromDictionary:[responseObject objectForKey:@"info"]] forKey:UserInformation];

                    }
                    //获取初始化账号 成功后调用登录 获取到logintoken
                    [HTTPModel login:[[NSDictionary alloc]initWithObjectsAndKeys:[NormalUse getSheBeiBianMa],@"phone_ucode", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                        
                        if (status==1) {
                            
                            [self timeFinish];

                            NSString *  logintoken = [responseObject objectForKey:@"logintoken"];
                            [NormalUse defaultsSetObject:logintoken forKey:LoginToken];

                        }
                    }];
                }
            }];
            
        }
    }];
    
    [ZYNetworkAccessibility start];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topNavView.hidden = YES;
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    bottomImageView.image = [UIImage imageNamed:@"flash"];
    bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
    bottomImageView.autoresizingMask = UIViewAutoresizingNone;
    bottomImageView.clipsToBounds = YES;
    [self.view addSubview:bottomImageView];
    
    [HTTPModel getBannerList:[[NSDictionary alloc]initWithObjectsAndKeys:@"0",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSArray * array = responseObject;
            if ([NormalUse isValidArray:array]) {
                
                
                NSDictionary * info = [array objectAtIndex:0];
                NSString * imagePath = [NSString stringWithFormat:@"%@%@",HTTP_REQUESTURL,[info objectForKey:@"picture"]];
                
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                imageView.autoresizingMask = UIViewAutoresizingNone;
                imageView.clipsToBounds = YES;
                imageView.alpha = 0;
                [self.view addSubview:imageView];
                
                [UIView animateWithDuration:0.5 animations:^{
                    bottomImageView.alpha = 0;
                    imageView.alpha = 1;
                }];
                
                
                NSNumber * limit_sec = [info objectForKey:@"limit_sec"];
                self->timeNumber = limit_sec.intValue;
                
                
                self.daojiShiButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-90, TopHeight_PingMu+10, 80, 30)];
                self.daojiShiButton.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
                self.daojiShiButton.layer.cornerRadius = 15;
                self.daojiShiButton.titleLabel.font = [UIFont systemFontOfSize:12];
                [self.daojiShiButton setTitle:[NSString stringWithFormat:@"跳过(%d)",self->timeNumber] forState:UIControlStateNormal];
                [self.daojiShiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.daojiShiButton addTarget:self action:@selector(tiaoGuo) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:self.daojiShiButton];
                
                
                
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRecord) userInfo:nil repeats:YES];
                
                
            }
            else
            {
                
                [self timeFinish];
                
            }
            
        }
        else
        {
            //用户首次安装没有网络权限
            if ([msg isEqualToString:NET_ERROR_MSG] && ![NormalUse isValidString:[NormalUse defaultsGetObjectKey:LoginToken]]) {
                
                [self getNetWorkStatus];
                    
            }
            else
            {
                
                [self timeFinish];
                
            }
        }
    }];

    
}
-(void)timerRecord
{
    timeNumber = timeNumber-1;
    if (timeNumber==0) {
        
        [self.timer invalidate];
        self.timer = nil;
        [self timeFinish];
    }
    [self.daojiShiButton setTitle:[NSString stringWithFormat:@"跳过(%d)",timeNumber] forState:UIControlStateNormal];

}
-(void)tiaoGuo
{
    [self.timer invalidate];
    self.timer = nil;
    [self timeFinish];
}
-(void)timeFinish
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate setYiDengLuTabBar];

}

@end
