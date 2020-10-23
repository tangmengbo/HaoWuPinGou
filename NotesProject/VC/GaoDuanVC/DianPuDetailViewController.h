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

@property(nonatomic,strong)Lable_ImageButton * jieSuoButton;


@property(nonatomic,strong)Lable_ImageButton * pingFenButton;
@property(nonatomic,strong)UIButton * zuiXinButton;
@property(nonatomic,strong)UIButton * zuiReButton;

@property(nonatomic,strong)NSString * shaiXuanLeiXingStr;
@property(nonatomic,strong)NSArray * paiXuSourceArray;
@property(nonatomic,strong)NSMutableArray * paiButtonXuArray;
@property(nonatomic,strong)UIView * shaiXuanView;

@property(nonatomic,strong)Lable_ImageButton * noMessageTipButotn;





@end

NS_ASSUME_NONNULL_END
