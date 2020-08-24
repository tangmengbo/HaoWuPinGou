//
//  AppDelegate.h
//  NotesProject
//
//  Created by BoBo on 2019/10/15.
//  Copyright © 2019 BoBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabbarController.h"

#import "GetCountryInfoViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL alsoShowHuiBo;
}

@property(nonatomic,strong)UIWindow * window;//必须命名为 window
@property(nonatomic,strong)MainTabbarController * tabbar;


-(void)setYinDaoTabbar;
-(void)setWeiDengLuTabBar;
-(void)setYiDengLuTabBar;

- (void)yinCangTabbar;
-(void)xianShiTabBar;


@end

