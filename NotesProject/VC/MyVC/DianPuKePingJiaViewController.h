//
//  DianPuKePingJiaViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/29.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DianPuKePingJiaViewController : MainBaseViewController

@property(nonatomic,strong)NSString * dianPuId;

@property(nonatomic,strong)UIButton * guanZhuButton;

@property(nonatomic,strong)Lable_ImageButton * jieSuoButton;


@property(nonatomic,strong)UIButton * pingFenButton;
@property(nonatomic,strong)UIButton * zuiXinButton;
@property(nonatomic,strong)UIButton * zuiReButton;

@property(nonatomic,strong)Lable_ImageButton * noMessageTipButotn;

@property(nonatomic,strong)NSString * lianXieFangShiStr;
@end

NS_ASSUME_NONNULL_END
