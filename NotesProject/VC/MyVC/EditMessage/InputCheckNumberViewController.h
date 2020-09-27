//
//  InputCheckNumberViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/27.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InputCheckNumberViewController : MainBaseViewController

@property(nonatomic,strong)NSString * mobileStr;

@property(nonatomic,strong)NSString * editPWOrBangDing; //@"1" 重置密码 2 绑定手机号

@end

NS_ASSUME_NONNULL_END
