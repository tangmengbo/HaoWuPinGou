//
//  CreateTieZiKouFeiViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateTieZiKouFeiViewController : MainBaseViewController
{
    int uploadImageIndex;
    
    int uploadVideoIndex;
}
@property(nonatomic,strong)NSArray * videoArray;
@property(nonatomic,strong)NSArray * photoArray;


@property(nonatomic,strong)NSMutableArray * videoPathArray;
@property(nonatomic,strong)NSMutableArray * videoShouZhenImagePathArray;
@property(nonatomic,strong)NSMutableArray * photoPathArray;

@property(nonatomic,strong,nullable)NSString * videoPathId;
@property(nonatomic,strong,nullable)NSString * videoShouZhenPathId;
@property(nonatomic,strong,nullable)NSString * imagePathId;




@property(nonatomic,strong)NSString * message_type;
@property(nonatomic,strong)NSString * titleStr;
@property(nonatomic,strong)NSString * city_code;
@property(nonatomic,strong)NSString * address_detail;
@property(nonatomic,strong)NSString * age;
@property(nonatomic,strong)NSString * nums;
//@property(nonatomic,strong)NSString * min_price;
//@property(nonatomic,strong)NSString * max_price;
@property(nonatomic,strong)NSString * nprice_label;
@property(nonatomic,strong)NSString * service_type;
@property(nonatomic,strong)NSString * mobile;
@property(nonatomic,strong)NSString * qq;
@property(nonatomic,strong)NSString * wechat;
@property(nonatomic,strong)NSString * face_value;
@property(nonatomic,strong)NSString * skill_value;
@property(nonatomic,strong)NSString * ambience_value;
@property(nonatomic,strong)NSString * decription;
@property(nonatomic,strong)NSString * from_flg;





@end

NS_ASSUME_NONNULL_END
