//
//  CityListViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/24.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"
#import "CityListCell.h"

@protocol CityListViewControllerDelegate
@optional

- (void)citySelect:(NSDictionary * _Nonnull)info;

@end



NS_ASSUME_NONNULL_BEGIN

@interface CityListViewController : MainBaseViewController

@property(nonatomic,assign)id<CityListViewControllerDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
