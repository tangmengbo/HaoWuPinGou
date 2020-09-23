
//
//  RongCloudManager.m
//  NotesProject
//
//  Created by pfjhetg on 2017/5/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RongYManager.h"

//NSString *const rongCloudAppKey = RYKey;

@implementation RongYManager

+ (RongYManager *)getInstance {
    static dispatch_once_t pred;
    static RongYManager *singletonInstance = nil;
    [RCIM sharedRCIM].disableMessageAlertSound = YES;
    
    dispatch_once(&pred, ^{
        singletonInstance = [[self alloc] init];
    });
    return singletonInstance;
}
-(void)initRongYun
{
    [[RCIM sharedRCIM] initWithAppKey:RYKey];
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    [RCIM sharedRCIM].enableMessageRecall = YES;
    
}
- (id)init {
    if ((self = [super init])) {
        [[RCIM sharedRCIM] initWithAppKey:RYKey];
        [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
        [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
        [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
        [RCIM sharedRCIM].enableMessageRecall = YES;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeground)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)connectRongCloud {
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:UserInformation];
    NSString *loginToken = [userInfo objectForKey:@"face_token"];
    if([[RCIMClient sharedRCIMClient] getConnectionStatus] != ConnectionStatus_Connected) {
        [[RCIM sharedRCIM] connectWithToken:loginToken success:^(NSString *userId) {
            NSLog(@"融云 登陆成功。当前登录的用户ID：%@", userId);
            [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NormalUse getNowUserID] name:[NormalUse getCurrentUserName] portrait:[NormalUse getCurrentAvatarpath]];
        } error:^(RCConnectErrorCode status) {
            NSLog(@"融云 登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"融云 token错误");
        }];
    }
}
//断开与融云的链接但是接收推送
-(void)disconnectRongCloud
{
    [[RCIM sharedRCIM] disconnect:YES];
    NSLog(@"融云 断开连接");
}
/*!
 获取用户信息
 @param userId                  用户ID
 @param completion              获取用户信息完成之后需要执行的Block
 @param userInfo(in completion) 该用户ID对应的用户信息
 @discussion SDK通过此方法获取用户信息并显示，请在completion中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    RCUserInfo *userInfo;
    if ([userId isEqualToString:[NormalUse getNowUserID]]) {
        userInfo = [[RCUserInfo alloc] initWithUserId:[NormalUse getNowUserID] name:[NormalUse getCurrentUserName] portrait:[NormalUse getCurrentAvatarpath]];
        completion(userInfo);
    } else {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *info = [defaults objectForKey:userId];
        userInfo = [[RCUserInfo alloc] initWithUserId:info[@"userId"] name:info[@"nick"] portrait:info[@"avatarUrl"]];
        completion(userInfo);
    }
}
/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param left        还剩余的未接收的消息数，left>=0
 
 @discussion 如果您设置了IMKit消息监听之后，SDK在接收到消息时候会执行此方法（无论App处于前台或者后台）。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 */
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshNotice" object:nil];
}

//融云连接状态变化监听
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status
{
    if (status==ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT)//用户被挤掉下线
    {
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [appDelegate setWeiDengLuTabBar];
        
        [NormalUse showToastView:@"您的账号已在其他设备登录,请重新登录" view:[NormalUse getCurrentVC].view];
    }
}

- (void)applicationWillEnterForeground {
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:UserInformation];
    NSString *loginToken = [userInfo objectForKey:@"face_token"];


    if([[RCIMClient sharedRCIMClient] getConnectionStatus] != ConnectionStatus_Connected) {
        [[RCIM sharedRCIM] connectWithToken:loginToken success:^(NSString *userId) {
            NSLog(@"融云 登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"融云 登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"融云 token错误");
        }];
    }
}

- (void)dealloc {
    
}

@end
