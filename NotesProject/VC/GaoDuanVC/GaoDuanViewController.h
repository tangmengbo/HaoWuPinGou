//
//  GaoDuanViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GaoDuanViewController : MainBaseViewController
{
    int page;
}

@property(nonatomic,strong)NSString * field;//默认最新 hot_value热度


@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)NSArray * bannerArray;

@end

NS_ASSUME_NONNULL_END
