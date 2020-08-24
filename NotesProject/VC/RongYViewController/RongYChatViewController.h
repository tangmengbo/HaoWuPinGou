//
//  ChatViewController.h
//  NotesProject
//
//  Created by pfjhetg on 2017/5/9.
//  Copyright © 2017年 mac. All rights reserved.
//

@interface RongYChatViewController : RCConversationViewController

@property(nonatomic,strong)RCMessageContent * messageContent;


@property(nonatomic,strong)RCMessage * mediaMessage;//发送图片时需要

@end
