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
@property(nonatomic,strong)UIImageView * vipImageView;

@property(nonatomic,strong)UIView * redPointView;

@property(nonatomic,strong)Lable_ImageButton * mianFeiJieSuoButton;
@property(nonatomic,strong)Lable_ImageButton * mianFeiFaBuButton;
@property(nonatomic,strong)Lable_ImageButton * shouCangGuanZhuButton;

@property(nonatomic,strong)Lable_ImageButton  * jingJiRenButton;
@property(nonatomic,strong)Lable_ImageButton  * myJieSuoButton;
@property(nonatomic,strong)Lable_ImageButton  * myFaBuButton;
@property(nonatomic,strong)Lable_ImageButton  * myKeFuButton;
@property(nonatomic,strong)Lable_ImageButton  * tuiGuangButton;
@property(nonatomic,strong)Lable_ImageButton  * tianXieYaoQingMaButton;
@property(nonatomic,strong)Lable_ImageButton  * tiXianButton;
@property(nonatomic,strong)Lable_ImageButton  * jinBiMingXiButton;

@property(nonatomic,strong)UIButton * kaiJiangButton;

@property(nonatomic,strong)UIButton * huiYuanButton;
@property(nonatomic,strong)UILabel * huiYuanTitleLable;
@property(nonatomic,strong)UILabel * huiYuanDaoQiLable;
@property(nonatomic,strong)UILabel * yuELable;

@property(nonatomic,strong)NSDictionary * vipListInfo;

@end

NS_ASSUME_NONNULL_END
