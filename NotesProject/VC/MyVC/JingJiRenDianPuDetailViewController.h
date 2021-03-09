//
//  JingJiRenDianPuDetailViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/18.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JingJiRenDianPuDetailViewController : MainBaseViewController<CityListViewControllerDelegate>

@property(nonatomic,strong)NSString * dianPuId;

@property(nonatomic,strong)UIButton * guanZhuButton;

@property(nonatomic,strong)Lable_ImageButton * jieSuoButton;


@property(nonatomic,strong)UIButton * pingFenButton;
@property(nonatomic,strong)UIButton * zuiXinButton;
@property(nonatomic,strong)UIButton * zuiReButton;
@property(nonatomic,strong)UIImageView * locationImageView;
@property(nonatomic,strong)UIButton * cityButton;
@property(nonatomic,strong)NSDictionary * cityInfo;



@property(nonatomic,strong)Lable_ImageButton * noMessageTipButotn;


@end

NS_ASSUME_NONNULL_END
