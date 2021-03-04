//
//  SanDaJiaoSeDetailViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/9.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SanDaJiaoSeDetailViewController : MainBaseViewController
{
    BOOL alsoUnlockSuccess;
}


@property(nonatomic,strong)NSString * type;//3女神 4外围 5全球陪玩

@property(nonatomic,strong)NSString * girl_id;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)FengZhuangUIPageControll * pageControll;


@property(nonatomic,strong)UIView * messageContentView;


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

@property(nonatomic,strong)Lable_ImageButton * jieSuoButton;
@property(nonatomic,strong)Lable_ImageButton * yuYueButton;

@property(nonatomic,strong)NSString * lianXieFangShiStr;

@property(nonatomic,strong)UIImageView * shakeImageView;



@end

NS_ASSUME_NONNULL_END
