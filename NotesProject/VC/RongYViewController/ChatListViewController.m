//
//  ChatListViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/10/9.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "ChatListViewController.h"

@interface ChatListViewController ()

@end

@implementation ChatListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView * statusBarView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 20)];
//    statusBarView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:statusBarView];
//
//    [self.navigationController setNavigationBarHidden:YES];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    UIView * topNavView = [[UIView alloc] initWithFrame:CGRectMake(0, TopHeight_PingMu, WIDTH_PingMu, 44)];
//    topNavView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:topNavView];
//
//
//    UILabel * topTitleLale = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 44)];
//    topTitleLale.textColor = RGBFormUIColor(0x333333);
//    topTitleLale.textAlignment = NSTextAlignmentCenter;
//    topTitleLale.text = @"消息";
//    topTitleLale.font = [UIFont systemFontOfSize:17*BiLiWidth];//[UIFont fontWithName:@"Helvetica-Bold" size:18*BiLiWidth];
//    [topNavView addSubview:topTitleLale];
//
//
//    UIButton * leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,  0, 60, 40)];
//    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
//    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [topNavView addSubview:leftButton];
//
//    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth, (44-18)/2, 18, 18)];
//    backImageView.image = [UIImage imageNamed:@"btn_back_n"];
//    [leftButton addSubview:backImageView];
    
   self.conversationListTableView.frame = CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu-(20+44));
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self refreshConversationTableViewIfNeeded];
    self.isEnteredToCollectionViewController = YES;

}
-(void)reloadMessageList
{
    [self refreshConversationTableViewIfNeeded];

}
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath
{
    RongYChatViewController *chatVC = [[RongYChatViewController alloc] initWithConversationType:
                                       ConversationType_PRIVATE targetId:model.targetId];
    [[NormalUse getCurrentVC].navigationController pushViewController:chatVC animated:YES];

}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
