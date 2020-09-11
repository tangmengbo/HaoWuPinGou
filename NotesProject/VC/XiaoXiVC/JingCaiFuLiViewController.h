//
//  JingCaiFuLiViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JingCaiFuLiViewController : MainBaseViewController

{
    int number;//购买次数
    
    int shengYuTime;//距离开奖的时间
}

@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,strong)UITextView * contentTextView;

@property(nonatomic,strong)NSString * ticket_buy_coin;


@end

NS_ASSUME_NONNULL_END
