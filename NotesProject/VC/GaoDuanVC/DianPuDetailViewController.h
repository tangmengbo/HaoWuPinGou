//
//  DianPuDetailViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DianPuDetailViewController : MainBaseViewController

@property(nonatomic,strong)NSString * dianPuId;

@property(nonatomic,strong)UIButton * guanZhuButton;

@property(nonatomic,strong)UIButton * pingFenButton;
@property(nonatomic,strong)UIButton * zuiXinButton;
@property(nonatomic,strong)UIButton * zuiReButton;

@property(nonatomic,strong)UIView * itemButtonContentView;
@property(nonatomic,strong)UIButton * pingFenButton1;
@property(nonatomic,strong)UIButton * zuiXinButton1;
@property(nonatomic,strong)UIButton * zuiReButton1;

@property(nonatomic,strong)NSString * zuiXinOrZuiRe;//1 最新 2 最热



@end

NS_ASSUME_NONNULL_END
