//
//  HuiYuanViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/11.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuiYuanViewController : MainBaseViewController

@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic,strong)NSDictionary * vipListInfo;

@property(nonatomic,strong)NSArray * bannerArray;

@property(nonatomic,strong)UIPageControl * pageControl;

@end

NS_ASSUME_NONNULL_END
