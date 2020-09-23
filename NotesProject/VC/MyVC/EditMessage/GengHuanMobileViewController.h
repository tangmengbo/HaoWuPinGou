//
//  GengHuanMobileViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

@protocol GengHuanMobileViewControllerDelegate
@optional

- (void)gengHuanMobileSuccess:(NSString * _Nonnull)mobileStr;


@end


NS_ASSUME_NONNULL_BEGIN

@interface GengHuanMobileViewController : MainBaseViewController

@property(nonatomic,assign)id<GengHuanMobileViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
