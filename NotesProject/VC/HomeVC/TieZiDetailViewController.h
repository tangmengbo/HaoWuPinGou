//
//  TieZiDetailViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/31.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TieZiDetailViewController : MainBaseViewController<JYCarouselDelegate>
{
    BOOL alsoUnlockSuccess;
}

@property(nonatomic,strong)NSString * post_id;

@property(nonatomic,assign)BOOL alsoFromYanCheBaoGao;

@property(nonatomic,strong)NSString * avatarUrl;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)FengZhuangUIPageControll * pageControll;


@property(nonatomic,strong)UIView * messageContentView;

@property(nonatomic,strong)Lable_ImageButton * jieSuoButton;
@property(nonatomic,strong)Lable_ImageButton * yuYueButton;

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

@property(nonatomic,strong)NSString * lianXieFangShiStr;//联系方式

@property(nonatomic,strong)NSNumber * is_active;//是否官方发帖

@property(nonatomic,strong)UIImageView * shakeImageView;


@end

NS_ASSUME_NONNULL_END
