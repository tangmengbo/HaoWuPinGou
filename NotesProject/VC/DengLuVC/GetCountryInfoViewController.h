//
//  GetCountryInfoViewController.h
//  NotesProject
//
//  Created by 唐蒙波 on 2019/12/19.
//  Copyright © 2019 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetCountryInfoViewController : MainBaseViewController<CLLocationManagerDelegate>

@property(nonatomic, strong) NSDictionary * info;
@property(nonatomic, strong) CLLocationManager *myLocation;


@end

NS_ASSUME_NONNULL_END
