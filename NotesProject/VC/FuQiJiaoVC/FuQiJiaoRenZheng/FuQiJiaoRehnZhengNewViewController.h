//
//  FuQiJiaoRehnZhengNewViewController.h
//  JianZhi
//
//  Created by tang bo on 2021/3/12.
//  Copyright © 2021 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FuQiJiaoRehnZhengNewViewController : MainBaseViewController

@property(nonatomic,strong)NSString * renZhengType;////认证类型 1茶小二 2经纪人 3 会员认证


@property(nonatomic,strong)NSDictionary * cityInfo;

@property(nonatomic,strong)UIButton * fuWuDiQuTF;
@property(nonatomic,strong)UITextField * chanPinShuLiangTF;
@property(nonatomic,strong)UITextField * beginPriceTF;
@property(nonatomic,strong)UITextField * endPriceTF;
@property(nonatomic,strong)UITextField * lianXiFangShiTF;

@end

NS_ASSUME_NONNULL_END
