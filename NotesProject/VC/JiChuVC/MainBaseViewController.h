//
//  BaseViewController.h
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/9/14.
//  Copyright (c) 2015年 唐蒙波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabbarController.h"
#import <AVFoundation/AVFoundation.h>

@interface MainBaseViewController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic,strong)UIView * topNavView;
@property (nonatomic,strong)UIView  * statusBarView;
@property (nonatomic,strong)UIButton * leftButton;
@property (nonatomic,strong)UIImageView * backImageView;
@property (nonatomic,strong)UIButton * rightButton;
@property (nonatomic,strong)UILabel * topTitleLale;
@property (nonatomic,strong)UIView * lineView;

@property(nonatomic,strong)NSString * loadingFullScreen;

-(void)xianShiLoadingView:(NSString *)message view:(UIView *)view;
-(void)yinCangLoadingView;

-(void)yinCangTabbar;
-(void)xianShiTabBar;




@end
