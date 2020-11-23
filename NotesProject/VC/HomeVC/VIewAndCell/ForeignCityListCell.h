//
//  ForeignCityListCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/11/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ForeignCityListCellDelegate
@optional

- (void)cityButtonSelect:(NSDictionary *)info;

@end

@interface ForeignCityListCell : UITableViewCell

@property(nonatomic,assign)id<ForeignCityListCellDelegate>delegate;

@property(nonatomic,strong)NSArray * array;


@property(nonatomic,strong)UIView * buttonContentView;


-(void)initContentView:(NSArray *)array;

+(float)cellHegiht:(NSArray *)array;


@end

NS_ASSUME_NONNULL_END
