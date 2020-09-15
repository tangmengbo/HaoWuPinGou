//
//  FaBuYanZhengViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/14.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

@protocol FaBuYanZhengViewControllerDelegate
@optional

- (void)faBuYanZhengSuccess;

@end


NS_ASSUME_NONNULL_BEGIN

@interface FaBuYanZhengViewController : MainBaseViewController
{
    int maxImageSelected;
    int uploadImageIndex;

}
@property(nonatomic,assign)id<FaBuYanZhengViewControllerDelegate>delegate;

@property(nonatomic,strong)NSString * post_id;
@property(nonatomic,strong)NSString * type_id; //type_id 1经纪人，茶小二帖子 2女神、外围、全球帖子
@end

NS_ASSUME_NONNULL_END
