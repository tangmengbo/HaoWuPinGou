//
//  NvShenRenZhengStep3VC.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NvShenRenZhengStep3VC : MainBaseViewController
{
    int needJinBiValue;
}
@property(nonatomic,strong)NSString * renZhengType;//1女神 2外围女 3全球空降  当前选择的认证选项

@property(nonatomic,strong)NSString * renZhengType1;//补充的认证选项1
@property(nonatomic,strong)NSString * renZhengType2;//补充的认证选项2

@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic,strong)UILabel * jinBiLable;
@property(nonatomic,strong)UILabel * yuELable;

@property(nonatomic,strong)Lable_ImageButton * lableButton1;
@property(nonatomic,strong)Lable_ImageButton * lableButton2;



@end

NS_ASSUME_NONNULL_END
