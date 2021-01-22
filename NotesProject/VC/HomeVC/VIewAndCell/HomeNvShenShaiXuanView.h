//
//  HomeNvShenShaiXuanView.h
//  JianZhi
//
//  Created by tang bo on 2021/1/22.
//  Copyright © 2021 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeNvShenShaiXuanView : UIView

@property(nonatomic,strong)NSArray * paiXuSourceArray;
@property(nonatomic,strong)NSMutableArray * paiButtonXuArray;
@property(nonatomic,strong)NSString * field; //'field'默认,'hot_value'热度


@property (nonatomic ,copy) void (^paiXuSelect)(NSString * field);


@end

NS_ASSUME_NONNULL_END
