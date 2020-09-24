//
//  CityListCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/24.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CityListCellDelegate
@optional

- (void)cityButtonSelect:(NSDictionary *)info;

@end


@interface CityListCell : UITableViewCell

@property(nonatomic,assign)id<CityListCellDelegate>delegate;

@property(nonatomic,strong)NSArray * array;


@property(nonatomic,strong)UIView * buttonContentView;

-(void)initContentView:(NSArray *)array;

+(float)cellHegiht:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
