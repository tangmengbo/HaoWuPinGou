//
//  ForeignCityListViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/11/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"
#import "ForeignCityListCell.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ForeignCityListViewControllerDelegate
@optional

- (void)foreignCitySelect:(NSDictionary * _Nonnull)info;

@end

@interface ForeignCityListViewController : MainBaseViewController<ForeignCityListCellDelegate>

@property(nonatomic,assign)id<ForeignCityListViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
