//
//  InputMobileViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/27.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InputMobileViewController : MainBaseViewController

@property(nonatomic,strong)NSString * bangDingOrQieHuan;//@"1" 绑定 2 切换

@property(nonatomic,assign)BOOL alsoNotCanPop;//是否不可返回 yes时不可以返回

@end

NS_ASSUME_NONNULL_END
