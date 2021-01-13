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

-(void)xiancheng
{
//    NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:@"6",@"3",@"2",@"4",nil];
//    for (int i=0; i<array.count; i++) {
//
//        for (int j=0; j<array.count-1-i; j++) {
//
//            if ([array objectAtIndex:j]>[array objectAtIndex:j+1]) {
//
//                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
//            }
//        }
//
//    }
//    NSLog(@"%@",array);
//    NSMutableArray * array1 = [[NSMutableArray alloc] initWithObjects:@"6",@"3",@"2",@"4",nil];
//
//    for (int i=0; i<array1.count-1; i++) {
//
//        for (int j = i+1; j<array1.count; j++) {
//
//            if ([array1 objectAtIndex:i]>[array1 objectAtIndex:j]) {
//
//                [array1 exchangeObjectAtIndex:i withObjectAtIndex:j];
//            }
//
//        }
//    }
//    NSLog(@"%@",array1);

//    // 创建队列
//    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
//    // 创建队列组
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//
//    dispatch_group_async(group, queue, ^{
//
//        NSLog(@"线程一一执行完成%@",[NSThread currentThread]);
//
//        [HTTPModel getXiTongGongGao:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
//
//            if (status==1) {
//                NSLog(@"线程一执行完成%@",[NSThread currentThread]);
//                dispatch_group_leave(group);
//            }
//        }];
//
//    });
//
//
//    dispatch_group_enter(group);
//    dispatch_group_async(group, queue, ^{
//
//        NSLog(@"线程二二执行完成%@",[NSThread currentThread]);
//
//        [HTTPModel getXiTongGongGao:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
//            if (status==1) {
//                NSLog(@"线程二执行完成%@",[NSThread currentThread]);
//                dispatch_group_leave(group);
//            }
//        }];
//
//    });
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//
//        NSLog(@"end");
//    });
//
//    NSLog(@"****************************123");
//
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//        //进行异步操作
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//            NSLog(@"异步操作1111：%@", [NSThread currentThread]);
//            dispatch_semaphore_signal(semaphore);
//        });
//
//        //异步操作2
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            sleep(2);
//            NSLog(@"异步操作2222：%@", [NSThread currentThread]);
//            dispatch_semaphore_signal(semaphore);
//        });
//        //异步操作3
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            sleep(3);
//            NSLog(@"异步操作3333：%@", [NSThread currentThread]);
//            dispatch_semaphore_signal(semaphore);
//        });
    NSOperationQueue * operationQueue = [[NSOperationQueue alloc] init];
    NSBlockOperation * operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i=0; i<10; i++) {
            
            NSLog(@"线程一%d",i);
        }
    }];
    NSBlockOperation * operation2 = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i=0; i<10; i++) {
            
            NSLog(@"线程二%d,%@",i,[NSThread currentThread]);
        }
    }];
//    [operation2 addDependency:operation1];
    [operationQueue addOperation:operation1];
    [operationQueue addOperation:operation2];
    
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self registerAPNs];
    
    [self xiancheng];
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
