//
//  CreateDianPuViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/16.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateDianPuViewController : MainBaseViewController<LeiXiangSelectViewControllerDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,CityListViewControllerDelegate>
{
    int maxImageSelected;
    int uploadImageIndex;

}

@property(nonatomic,strong)UIView * photoContentView;
@property(nonatomic,strong)NSMutableArray * photoArray;
@property(nonatomic,strong)UIImagePickerController * imagePickerController;
@property(nonatomic,strong)NSMutableArray * photoPathArray;

@property(nonatomic,strong)NSString * imagePathId;

@property(nonatomic,strong)UITextField * dianPuNameTF;
@property(nonatomic,strong)UIButton * diQuButton;
@property(nonatomic,strong)UITextField *lianXiFangShiTF;
//@property(nonatomic,strong)UITextField * weiXinTF;
//@property(nonatomic,strong)UITextField * qqTF;
//@property(nonatomic,strong)UITextField * telTF;
@property(nonatomic,strong)UITextView * jianJieTextView;

@property(nonatomic,strong)NSDictionary * cityInfo;

@property(nonatomic,strong)Lable_ImageButton * markButton;
@property(nonatomic,strong)UITextField * peiFuMoneyTF;


@end

NS_ASSUME_NONNULL_END
