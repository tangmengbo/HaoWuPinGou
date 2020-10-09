//
//  NoticeViewController.m
//  NotesProject
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XinXiListViewController.h"
#import "XinXiListTableViewCell.h"
@interface XinXiListViewController ()
{
    int messagePageIndex;
    int messageTableViewSection;
}



@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UITableView * messageTableView;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation XinXiListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.topTitleLale.text = @"消息";
    
    self.messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topNavView.frame.origin.y+self.topNavView.frame.size.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.frame.origin.y+self.topNavView.frame.size.height))];
    self.messageTableView.delegate  = self;
    self.messageTableView.dataSource = self;
    self.messageTableView.tag = 1;
    self.messageTableView.backgroundColor = [UIColor whiteColor];
    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *))
    {
        self.messageTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.messageTableView];
    
    [self reloadMessageList];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMessageList) name:@"refreshNotice" object:nil];

}

- (void)reloadMessageList {

   if (self.messageTableView.editing) {
        
        return;
    }
    __weak typeof(self)wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
              
        wself.dataSourceArray = [NSMutableArray array];
        
        wself.dataSourceArray = [[NSMutableArray alloc] initWithArray:[[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE)]]];
        
        for (int i=0; i<wself.dataSourceArray.count;i++)
        {
            RCConversation *conversation = [wself.dataSourceArray objectAtIndex:i];
            if (!conversation.lastestMessage)
            {
                i--;
                [wself.dataSourceArray removeObject:conversation];
                
                [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:conversation.targetId];
                
                [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_PRIVATE targetId:conversation.targetId];
            }
            else
            {
                RCUserInfo * userInfo = conversation.lastestMessage.senderUserInfo;
                NSString * extraStr = userInfo.extra;
                NSDictionary * info = [NormalUse dictionaryWithJsonString:extraStr];
                if ([[NormalUse getNowUserID] isEqualToString:userInfo.userId]) {
                    
                    if (![NormalUse isValidDictionary:info]) {
                        
                        i--;
                        [wself.dataSourceArray removeObject:conversation];
                        
                        [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:conversation.targetId];
                        
                        [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_PRIVATE targetId:conversation.targetId];

                    }
                }
            }

        }
        
        [wself.messageTableView reloadData];

          });
    
    int unReadMesNumber = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]];
    [[NSNotificationCenter defaultCenter] postNotificationName:UnReaderMesCount object:[NSString stringWithFormat:@"%d",unReadMesNumber]];
    [UIApplication sharedApplication].applicationIconBadgeNumber = unReadMesNumber;

  
}
#pragma mark---UITableViewDelegate

//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.dataSourceArray.count;
    
     
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  60*BiLiWidth;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"NoticeMessageTableViewCell"] ;
    XinXiListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[XinXiListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    [cell initWithFriendInfo:[self.dataSourceArray objectAtIndex:indexPath.row]];
    // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!tableView.editing)
    {
        RCConversation *conversation = self.dataSourceArray[indexPath.row];
        RongYChatViewController *chatVC = [[RongYChatViewController alloc] initWithConversationType:
                                           ConversationType_PRIVATE targetId:conversation.targetId];
        chatVC.conversationType = ConversationType_PRIVATE;
        chatVC.targetId = conversation.targetId;
        [self.navigationController pushViewController:chatVC animated:YES];
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.editing) {

          return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;

      }
      else
      {
          return UITableViewCellEditingStyleDelete;

      }

}
//实现这个方法不仅可以实现左滑功能,还可以自定义左滑的按钮,并且实现按钮点击处理的事件
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [tableView beginUpdates];
        // 从数据源中删除
        RCConversation *conversation = self.dataSourceArray[indexPath.row];
        [self.dataSourceArray removeObjectAtIndex:indexPath.row];
        // 从列表中删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:conversation.targetId];
        [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_PRIVATE targetId:conversation.targetId];
        [tableView endUpdates];
        
        //设置消息上的未读消息
        int unReadMesNumber = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]];
        [[NSNotificationCenter defaultCenter] postNotificationName:UnReaderMesCount object:[NSString stringWithFormat:@"%d",unReadMesNumber]];
        [UIApplication sharedApplication].applicationIconBadgeNumber = unReadMesNumber;
        
    }];
    return @[action1];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self yinCangTabbar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
