//
//  HeiDianPingJiaViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/16.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeiDianPingJiaViewController : MainBaseViewController<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
{
    int maxImageSelected;
    
    int uploadImageIndex;
}

@property(nonatomic,strong)NSString * black_id;

@property(nonatomic,strong)UITextView * textView;

@property(nonatomic,strong)UIView * photoContentView;

@property(nonatomic,strong)NSString * pathId;

@end

NS_ASSUME_NONNULL_END
