//
//  RongCloudManager.h
//  NotesProject
//
//  Created by pfjhetg on 2017/5/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ReceivedMessageNotification @"ReceivedMessageNotification"
#define ReceivedGeiFuTNotification  @"ReceivedGeiFuTNotification"
#define VideoGetMessageNotification  @"VideoGetMessageNotification"
#define ZhuBoHuJiaoNotification @"ZhuBoHuJiaoNotification"
#define UnReaderMesCount  @"UnReaderMesCount"
#define HasAuthenticationSuccess  @"HasAuthenticationSuccess"




@interface RongYManager : NSObject<RCIMReceiveMessageDelegate, RCIMUserInfoDataSource,RCIMConnectionStatusDelegate>

+ (RongYManager *)getInstance;

-(void)initRongYun;
- (void)connectRongCloud;
- (void)disconnectRongCloud;





@end
