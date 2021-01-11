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


@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)NSArray * bannerArray;

@property(nonatomic,strong)UIView * headerView;

@property(nonatomic,strong)UIView * jingJiRenRenZhengTipView;//经纪人认证前提示view


@end

NS_ASSUME_NONNULL_END
