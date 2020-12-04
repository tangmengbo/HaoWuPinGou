//
//  AppDelegate.m
//  NotesProject
//
//  Created by BoBo on 2019/10/15.
//  Copyright © 2019 BoBo. All rights reserved.
//

#import "AppDelegate.h"
#import "GetCountryInfoViewController.h"
#import "SheZhiViewController.h"
#import "MyNavigationViewController.h"
#import "QiDongViewController.h"
#import "GetIPAlsoCanUseViewController.h"


NSString *NTESNotificationLogout = @"NTESNotificationLogout";



@interface AppDelegate ()



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self registerAPNs];
    

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置状态栏文字颜色
    
    [NormalUse defaultsSetObject:nil forKey:@"CityInfoDefaults"];
    [NormalUse defaultsSetObject:nil forKey:@"ForeignCityInfoDefaults"];

    [self setIPAlsoCanUseTabbar];
    
    [HTTPModel getJSSiteUrls:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {

        if (status==1) {

            NSArray * array = responseObject;
            [NormalUse defaultsSetObject:array forKey:AppSiteUrls];
        }
    }];

    return YES;
}
#pragma mark - misc
//推送处理1
- (void)registerAPNs
{
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    
}
//推送处理2
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
//推送处理3
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [[RCIMClient sharedRCIMClient] setDeviceTokenData:deviceToken];
}
-(void)setIPAlsoCanUseTabbar
{
    GetIPAlsoCanUseViewController   * loginVC = [[GetIPAlsoCanUseViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;

}
-(void)setYinDaoTabbar
{
    GetCountryInfoViewController   * loginVC = [[GetCountryInfoViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;

}
-(void)setShouShiYanZhengTabbar
{
    SetShouShiMiMaViewController * vc = [[SetShouShiMiMaViewController alloc] init];
    vc.shouShiType = GesturePasswordStatusLogin;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;

}
-(void)setQiDongTabbar
{
    QiDongViewController * vc = [[QiDongViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;

}
-(void)setWeiDengLuTabBar
{
    //退出融云
    [[RCIM sharedRCIM] logout];
    
    [[RCIM sharedRCIM] disconnect];
        
}
-(void)setYiDengLuTabBar
{
    HomeViewController * VC1 = [[HomeViewController alloc] init];
    MyNavigationViewController * nav1 = [[MyNavigationViewController alloc] initWithRootViewController:VC1];
    
    GaoDuanViewController * VC2 = [[GaoDuanViewController alloc] init];
    MyNavigationViewController * nav2 = [[MyNavigationViewController alloc] initWithRootViewController:VC2];
    
    
    FuQiJiaoViewController * VC3 = [[FuQiJiaoViewController alloc] init];
    MyNavigationViewController * nav3 = [[MyNavigationViewController alloc] initWithRootViewController:VC3];
    
    
    JingCaiFuLiViewController   * VC4 = [[JingCaiFuLiViewController alloc] init];
    MyNavigationViewController * nav4 = [[MyNavigationViewController alloc] initWithRootViewController:VC4];
    
    
    MyCenterViewController * VC5 = [[MyCenterViewController alloc] init];
    MyNavigationViewController * nav5 = [[MyNavigationViewController alloc] initWithRootViewController:VC5];
    
    NSArray * vcArray = [[NSArray alloc] initWithObjects:nav1,nav2,nav3,nav4 ,nav5,nil];
    
    self.tabbar = [[MainTabbarController alloc] init];
    self.tabbar.viewControllers = vcArray;
    self.window.rootViewController = self.tabbar;
    
}
-(void)yinCangTabbar
{
    self.tabbar.bottomView.hidden = YES;
}
-(void)xianShiTabBar
{
    self.tabbar.bottomView.hidden = NO;
}
-(void)applicationWillEnterForeground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YanZhengDingDanNotification" object:nil];


}

@end
