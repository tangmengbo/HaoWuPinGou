//
//  ChatViewController.m
//  NotesProject
//
//  Created by pfjhetg on 2017/5/9.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "RongYChatViewController.h"

#import "MWPhotoBrowser.h"

//#import "UIView+Toast.h"

@interface RongYChatViewController () {
    RCUploadMediaStatusListener *currentuploadListener;
}

@property (nonatomic, weak) RCMessageModel *currentMsgModel;

@end

@implementation RongYChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NormalUse getNowUserID] name:[NormalUse getCurrentUserName] portrait:[NormalUse getCurrentAvatarpath]];
    
    
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-40-10, 20, 50, 40)];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitle:@"Report" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = menuButton;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedGeiFuTNotification:) name:ReceivedGeiFuTNotification object:nil];
    
    
    self.chatSessionInputBarControl.inputTextView.delegate = self;
    
    //扩展底部输入框里+里面的内容,位置,图片...
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    
    if([@"Uploading" isEqualToString:[NormalUse getUpdateStatusStr]])
    {
        if([languageName hasPrefix:@"zh"])
        {
            [self.chatSessionInputBarControl.pluginBoardView updateItemAtIndex:2 image:[UIImage imageNamed:@"chatVC_Video"] title:@"视频通话"];
            
        }
        else
        {
            [self.chatSessionInputBarControl.pluginBoardView updateItemAtIndex:2 image:[UIImage imageNamed:@"chatVC_Video"] title:@"Video"];
            
        }
        [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlDefaultType style:6];
    }
    else
    {
        [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlDefaultType style:5];
    }
    
    
}
// 扩展功能板的点击回调
- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag
{
    if([@"Uploading" isEqualToString:[NormalUse getUpdateStatusStr]])
    {
        if (tag==1003)
        {
            
        }
        else
        {
            [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
        }
    }
    else
    {
        [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBarHidden = NO;
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate yinCangTabbar];
    self.enableUnreadMessageIcon = YES;
    self.enableNewComingMessageIcon = YES;
    self.defaultInputType = RCChatSessionInputBarInputText;
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"threeTuiJianPushToAnchorDetail" object:nil];
    [super viewWillDisappear:animated];
}

//重新添加定义cell的一些属性
- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell
                   atIndexPath:(NSIndexPath *)indexPath
{
    
    RCMessageCell * cell2 = (RCMessageCell *)cell;
    //设置用户头像是圆的
    cell2.portraitStyle = RC_USER_AVATAR_CYCLE;
    RCMessage *message = self.conversationDataRepository[indexPath.row];
    if ([message.objectName isEqualToString:RCTextMessageTypeIdentifier]) {
        RCTextMessage *rctext = (RCTextMessage*)message.content;
        NSData *jsonData = [rctext.content dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&err];
        if (dic) {
            if (dic[@"type"]) {
                //删除消息
                NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
                [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];
                [self deleteMessage:cell.model];
            }
        }
    }
}

- (RCMessage *)willAppendAndDisplayMessage:(RCMessage *)message
{
    if ([message.objectName isEqualToString:RCTextMessageTypeIdentifier]) {
        RCTextMessage *rctext = (RCTextMessage*)message.content;
        NSData *jsonData = [rctext.content dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&err];
        if (dic) {
            if (dic[@"type"]) {
                //删除消息
                NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
                [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];
                return nil;
            }
        }
    }
    return message;
}
- (void)chatInputBar:(RCChatSessionInputBarControl *)chatInputBar shouldChangeFrame:(CGRect)frame
{
    [super chatInputBar:chatInputBar shouldChangeFrame:frame];
    
}

-(void)didLongTouchMessageCell:(RCMessageModel *)model inView:(UIView *)view
{
   // [super didLongTouchMessageCell:model inView:view];
}

-(void)didTapMessageCell:(RCMessageModel *)model
{
    [super didTapMessageCell:model];
}
- (RCMessageContent *)willSendMessage:(RCMessageContent *)messageContent
{
//    NSDictionary * userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[self.targetInfo objectForKey:@"avatarUrl"],@"avatarUrl",[self.targetInfo objectForKey:@"nickname"],@"name",[self.targetInfo objectForKey:@"userId"],@"userId" ,nil];
//    NSString * extraStr = [NormalUse convertToJsonData:userInfo];
//    messageContent.senderUserInfo = [[RCUserInfo alloc] initWithUserId:[NormalUse getNowUserID] name:[NormalUse getCurrentUserName] portrait:[NormalUse getCurrentAvatarpath]];
//    messageContent.senderUserInfo.extra = extraStr;

    if ([messageContent isKindOfClass:[RCImageMessage class]]) {
        messageContent.senderUserInfo = [[RCUserInfo alloc] initWithUserId:[NormalUse getNowUserID] name:[NormalUse getCurrentUserName] portrait:[NormalUse getCurrentAvatarpath]];
        //[self sendMediaMessage:messageContent pushContent:nil appUpload:YES];
        return messageContent;
    } else if ([messageContent isKindOfClass:[RCTextMessage class]]) {
        RCTextMessage *rctextMessage = (RCTextMessage *)messageContent;
        return rctextMessage;
    } else {
        return messageContent;
    }
    
    
    
}
- (void)didSendMessage:(NSInteger)status content:(RCMessageContent *)messageContent
{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshNotice" object:nil];
}
- (void)uploadMedia:(RCMessage *)message
     uploadListener:(RCUploadMediaStatusListener *)uploadListener
{
    if ([message.content isKindOfClass:[RCImageMessage class]]) {
        self.mediaMessage = message;
        currentuploadListener = uploadListener;
        RCImageMessage *rcImage = (RCImageMessage *)message.content;
        UIImage * currentImage = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg", rcImage.localPath]];
        //开始上传图片
        UIImage * uploadImage = [NormalUse scaleToSize:currentImage size:CGSizeMake(400, 400*(currentImage.size.height/currentImage.size.width))];
        NSData *data = UIImagePNGRepresentation(uploadImage);
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
        NSString *imageType = @"jpg";
        
//        [self.interfaceTool uploadImage:@"8024"
//                      picBody_base64Str:encodedImageStr
//                              picFormat:imageType
//                                   type:@"1"
//                               delegate:self
//                               selector:@selector(uploadSuccess:)
//                          errorSelector:@selector(uploadError:)];
    }
    
    
}
-(void)uploadSuccess:(NSDictionary *)info
{
    //上传成功获得返回路径
    RCImageMessage *content = (RCImageMessage *)self.mediaMessage.content;
    content.imageUrl = [info objectForKey:@"url"];
    currentuploadListener.successBlock(content);
}

-(void)uploadError:(NSDictionary *)info
{
    [NormalUse showToastView:[info objectForKey:@"message"] view:self.view];
    currentuploadListener.errorBlock(RC_MSG_RESPONSE_TIMEOUT);
}

- (void)cancelUploadMedia:(RCMessageModel *)model
{
    
}
//点击头像
- (void)didTapCellPortrait:(NSString *)userId
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)rightClick
{
}



@end
