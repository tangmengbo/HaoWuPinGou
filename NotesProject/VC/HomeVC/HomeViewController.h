//
//  HomeViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"
#import "HomeShaiXuanView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : MainBaseViewController

@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)UIView * chaXiaoErFaTieRenZhengView1;
@property(nonatomic,strong)UIView * chaXiaoErFaTieRenZhengView;//茶小二发帖,认证

@property(nonatomic,strong)HomeShaiXuanView * shaiXuanView;//筛选条件view




@end

NS_ASSUME_NONNULL_END
