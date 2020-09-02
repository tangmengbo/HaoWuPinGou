//
//  NvShenRenZhengStep1VC.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

#define TIMER_INTERVAL 0.1
#define VIDEO_RECORDER_MAX_TIME 10 //视频最大时长 (单位/秒)
#define VIDEO_RECORDER_MIN_TIME 5  //最短视频时长 (单位/秒)


NS_ASSUME_NONNULL_BEGIN

@interface NvShenRenZhengStep1VC : MainBaseViewController

@property(nonatomic,strong) UIButton * tiJiaoButton;

@property(nonatomic,strong)AVPlayer * player;
@property(nonatomic,strong)AVPlayerLayer * layer;
@property(nonatomic,strong)UIView * containerView;



@end

NS_ASSUME_NONNULL_END
