//
//  HomeViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"
#import "HomeShaiXuanView.h"
#import "HomeNvShenCell.h"
#import "HomeNvShenShaiXuanView.h"
#import "VipRenZhengTieZeDetailVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : MainBaseViewController

@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)UIView * chaXiaoErFaTieRenZhengView1;
@property(nonatomic,strong)UIView * chaXiaoErFaTieRenZhengView;//茶小二发帖,认证
@property(nonatomic,strong)UIView * chaXiaoErRenZhengTipView;//茶小儿认证前提示view

@property(nonatomic,strong)HomeShaiXuanView * shaiXuanView;//筛选条件view
@property(nonatomic,strong)HomeNvShenShaiXuanView * nvShenShaiXuanView;//筛选女神列表

@property(nonatomic,strong)Lable_ImageButton * nvShenRenZhengButton ;
@property(nonatomic,strong)Lable_ImageButton * renZhengButton;
@property(nonatomic,strong)UILabel * chaXiaErYiRenZhengLable;//茶小二已认证提示lable
@property(nonatomic,strong)UILabel * nvShenRenZhengLable;//女神已认证提示lable


@property(nonatomic,strong)UIView * sanDaJiaSeFaTieRenZhengView;

@property(nonatomic,strong)NSString * nvShenFaTieOrChaXiaoErFaTie;//0 茶小二发帖 1 女神发帖

@property(nonatomic,strong)NSNumber * auth_vip_cetf;
@property(nonatomic,strong)NSNumber * auth_vip;
@property(nonatomic,strong)NSDictionary * vipListInfo;
@property(nonatomic,strong)NSDictionary * userInfo;

@property(nonatomic,strong)UIImageView * shakeImageView;

@end

NS_ASSUME_NONNULL_END
