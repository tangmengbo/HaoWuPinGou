//
//  MyCenterViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"
#import "MyScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyCenterViewController : MainBaseViewController

@property(nonatomic,strong)MyScrollView * mainScrollView;

@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UILabel * nickLable;
@property(nonatomic,strong)UILabel * messageLable;

@property(nonatomic,strong)Lable_ImageButton * mianFeiJieSuoButton;
@property(nonatomic,strong)Lable_ImageButton * mianFeiFaBuButton;
@property(nonatomic,strong)Lable_ImageButton * shouCangGuanZhuButton;

@property(nonatomic,strong)UIButton * huiYuanButton;
@property(nonatomic,strong)UILabel * huiYuanTitleLable;
@property(nonatomic,strong)UILabel * huiYuanDaoQiLable;
@property(nonatomic,strong)UILabel * yuELable;

@end

NS_ASSUME_NONNULL_END
