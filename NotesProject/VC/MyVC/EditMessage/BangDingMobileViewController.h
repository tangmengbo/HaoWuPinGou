//
//  BangDingMobileViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BangDingMobileViewControllerDelegate
@optional

- (void)bangDingMobileSuccess:(NSString * _Nonnull)mobileStr;


@end


@interface BangDingMobileViewController : MainBaseViewController

@property(nonatomic,assign)id<BangDingMobileViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
