//
//  KaiJiagJiLuListCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/18.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KaiJiagJiLuListCell : UITableViewCell


-(void)initData:(NSDictionary *)info;

+(float)getCellHeight:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
