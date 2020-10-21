//
//  FuQiJiaoWeiRenZhengFaTieKouFeiVC.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/10/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FuQiJiaoWeiRenZhengFaTieKouFeiVC : MainBaseViewController

@property(nonatomic,strong)NSNumber * auth_couple;////0 未认证 1 已认证 2 审核中

@property(nonatomic,strong)NSDictionary * info;

@end

NS_ASSUME_NONNULL_END
