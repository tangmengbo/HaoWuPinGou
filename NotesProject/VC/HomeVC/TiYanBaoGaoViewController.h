//
//  TiYanBaoGaoViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiYanBaoGaoViewController : MainBaseViewController
{
    int page;
}
@property(nonatomic,strong)NSMutableArray * sourceArray;

@property(nonatomic,strong)NSDictionary * userInfo;
@property(nonatomic,strong)NSDictionary * vipListInfo;


@end

NS_ASSUME_NONNULL_END
