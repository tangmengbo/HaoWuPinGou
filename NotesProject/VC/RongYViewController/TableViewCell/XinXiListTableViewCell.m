//
//  NoticeMessageTableViewCell.m
//  NotesProject
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XinXiListTableViewCell.h"

@implementation XinXiListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];


    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.touXiangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth, 10*BiLiWidth, 40*BiLiWidth, 40*BiLiWidth)];
        self.touXiangImageView.layer.cornerRadius = 40*BiLiWidth/2;
        self.touXiangImageView.layer.masksToBounds = YES;
        self.touXiangImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.touXiangImageView.autoresizingMask = UIViewAutoresizingNone;
        self.touXiangImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.touXiangImageView];
        self.touXiangImageView.hidden = YES;

        self.xingMingLable = [[UILabel alloc] initWithFrame:CGRectMake(self.touXiangImageView.frame.origin.x+self.touXiangImageView.frame.size.width+14*BiLiWidth,14*BiLiWidth,  WIDTH_PingMu-(self.touXiangImageView.frame.origin.x+self.touXiangImageView.frame.size.width+40*BiLiWidth), 15*BiLiWidth)];
        self.xingMingLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.xingMingLable.textColor = [UIColor blackColor];
        self.xingMingLable.alpha = 0.9;
        [self.contentView addSubview:self.xingMingLable];


 
        self.messageCountLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-35*BiLiWidth, 12*BiLiWidth, 20*BiLiWidth, 15*BiLiWidth)];
        self.messageCountLable.textColor = [UIColor whiteColor];
        self.messageCountLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
        self.messageCountLable.textAlignment = NSTextAlignmentCenter;
        self.messageCountLable.layer.cornerRadius = 15*BiLiWidth/2;
        self.messageCountLable.layer.masksToBounds = YES;
        self.messageCountLable.hidden = YES;
        self.messageCountLable.backgroundColor =  [UIColor redColor];
        [self.contentView addSubview:self.messageCountLable];

 
        self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(self.xingMingLable.frame.origin.x, self.xingMingLable.frame.origin.y+self.xingMingLable.frame.size.height+15*BiLiWidth/2, WIDTH_PingMu-(self.touXiangImageView.frame.origin.x+self.touXiangImageView.frame.size.width+90*BiLiWidth), 13*BiLiWidth)];
        self.messageLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        self.messageLable.textColor = [UIColor blackColor];
        self.messageLable.alpha = 0.5;
        [self.contentView addSubview:self.messageLable];


        
        self.timeLbale = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-210*BiLiWidth, self.messageLable.frame.origin.y, 200*BiLiWidth, 15*BiLiWidth)];
        self.timeLbale.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.timeLbale.textColor = [UIColor blackColor];
        self.timeLbale.alpha = 0.5;
        self.timeLbale.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.timeLbale];

        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 65*BiLiWidth-1, WIDTH_PingMu, 1)];
        self.lineView .backgroundColor =RGBFormUIColor(0xf9f9f9);
        [self.contentView addSubview:self.lineView];

    }
    return self;
}

-(void)initWithFriendInfo:(RCConversation *)conversation
{
    self.timeLbale.hidden = NO;
    self.touXiangImageView.hidden = NO;

    self.messageLable.textColor = [UIColor blackColor];
    
    RCUserInfo * userInfo = conversation.lastestMessage.senderUserInfo;
    NSString * extraStr = userInfo.extra;
    NSDictionary * info = [NormalUse dictionaryWithJsonString:extraStr];
    
    if ([[NormalUse getNowUserID] isEqualToString:userInfo.userId]) {
        
        if ([NormalUse isValidDictionary:info]) {
            
            [self.touXiangImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"avatarUrl"]] placeholderImage:[UIImage imageNamed:@"user_placeholder_woman"]];
            self.xingMingLable.text =  [info objectForKey:@"name"];
            
        }
        else
        {
            self.touXiangImageView.image = [UIImage imageNamed:@"user_placeholder_woman"];
            self.xingMingLable.text = @"no nick";
        }
    }
    else
    {
        [self.touXiangImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"user_placeholder_woman"]];
        self.xingMingLable.text =  userInfo.name;
    }
    

    NSString * targateId = conversation.targetId;

    int unReadMessNumber =  [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_PRIVATE targetId:targateId];
    if (unReadMessNumber !=0) {

        self.messageCountLable.hidden = NO;
        self.messageCountLable.text = [NSString stringWithFormat:@"%d",unReadMessNumber];


        if (unReadMessNumber<10) {
            self.messageCountLable.frame = CGRectMake(self.messageCountLable.frame.origin.x, self.messageCountLable.frame.origin.y, 15*BiLiWidth, 15*BiLiWidth);
        }
        else
        {
        self.messageCountLable.frame = CGRectMake(self.messageCountLable.frame.origin.x, self.messageCountLable.frame.origin.y, 20*BiLiWidth, 15*BiLiWidth);
        }
    }
    else
    {
        self.messageCountLable.hidden = YES;
    }

    if ([conversation.objectName isEqualToString:RCTextMessageTypeIdentifier]) {
        RCTextMessage *textMsg = (RCTextMessage *)conversation.lastestMessage;
        self.messageLable.text = textMsg.content;
    } else if ([conversation.objectName isEqualToString:RCImageMessageTypeIdentifier])
    {
        self.messageLable.text = @"[Photos]";

    } else if ([conversation.objectName isEqualToString:RCVoiceMessageTypeIdentifier])
    {
        self.messageLable.text = @"[Voices]";
    }
    else
    {
        self.messageLable.text = @"";
    }
    self.timeLbale.text = [NormalUse getMessageReadableDateFromTimestamp:[NormalUse getTimestamp:[[NSDate alloc] initWithTimeIntervalSince1970:conversation.sentTime/1000]]];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
