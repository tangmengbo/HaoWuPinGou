//
//  TouSuViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JvBaoViewController : MainBaseViewController<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
{
    int maxImageSelected;
    
    int uploadImageIndex;
}

@property(nonatomic,strong)NSString * post_id;

@property(nonatomic,strong)UITextView * textView;

@property(nonatomic,strong)UIView * photoContentView;

@property(nonatomic,strong)NSString * pathId;

@property(nonatomic,strong)NSString * role; //1帖子 2三角色 3夫妻交友

@end

NS_ASSUME_NONNULL_END
