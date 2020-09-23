//
//  GaoDuanShaiXuanView.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GaoDuanShaiXuanView : UIView

@property(nonatomic,strong)NSArray * paiXuSourceArray;
@property(nonatomic,strong)NSMutableArray * paiButtonXuArray;
@property(nonatomic,strong)NSString * field; //'field'默认,'hot_value'热度,'complex_score'评分,'min_price'低价,'max_price'高价
@property(nonatomic,strong)NSString * order; //desc或者 asc(价格从低到高)


@property (nonatomic ,copy) void (^paiXuSelect)(NSString * field,NSString * order);


@end

NS_ASSUME_NONNULL_END
