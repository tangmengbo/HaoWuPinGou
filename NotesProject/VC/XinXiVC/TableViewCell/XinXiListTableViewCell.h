//
//  NoticeMessageTableViewCell.h
//  NotesProject
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XinXiListTableViewCell : UITableViewCell


@property(nonatomic,strong)UIImageView * touXiangImageView;

@property(nonatomic,strong)UILabel * xingMingLable;

@property(nonatomic,strong)NSString * messageNewCountStr;

@property(nonatomic,strong)UILabel * messageLable;

@property(nonatomic,strong)UILabel * timeLbale;

@property(nonatomic,strong)UILabel * messageCountLable;


@property(nonatomic,strong)UIView * lineView;


-(void)initData:(NSDictionary *)info;



-(void)initWithFriendInfo:(RCConversation *)conversation;




@end
