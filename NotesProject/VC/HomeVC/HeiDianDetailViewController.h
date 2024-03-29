//
//  HeiDianDetailViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/28.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeiDianDetailViewController : MainBaseViewController<JYCarouselDelegate>


@property(nonatomic,strong)NSString * idStr;


@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)FengZhuangUIPageControll * pageControll;


@property(nonatomic,strong)UIView * messageContentView;

@property(nonatomic,strong)Lable_ImageButton * jieSuoButton;
@property(nonatomic,strong)UILabel * tipLable;

@property(nonatomic,strong)UIButton * jiBenXinXiButton;
@property(nonatomic,strong)UIView * jiBenXinXiContentView;

@property(nonatomic,strong)UIButton * xiangQingJieShaoButton;
@property(nonatomic,strong)UIView * xiangQingJieShaoContentView;

@property(nonatomic,strong)NSArray * pingLunArray;
@property(nonatomic,strong)UIButton * cheYouPingJiaButton;

@property(nonatomic,strong)UIImageView * noMessageTipButotn;
@property(nonatomic,strong)UITableView * cheYouPingJiaTableView;

@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)UIScrollView * bottomContentScollView;

@property(nonatomic,strong)NSString * lianXieFangShiStr;
@end

NS_ASSUME_NONNULL_END
