//
//  LeiXiangSelectViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/31.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

@protocol LeiXiangSelectViewControllerDelegate
@optional

- (void)itemSelected:(NSString *)str type:(NSString *)type;

@end


NS_ASSUME_NONNULL_BEGIN

@interface LeiXiangSelectViewController : MainBaseViewController

@property(nonatomic,assign)id<LeiXiangSelectViewControllerDelegate>delegate;


@property(nonatomic,strong)NSString * type;//meizi fuwu
@property(nonatomic,strong)NSArray * sourceArray;

@end

NS_ASSUME_NONNULL_END
