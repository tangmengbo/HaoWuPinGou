//
//  GongGaoAlertView.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/10.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GongGaoAlertView : UIView

- (instancetype)initWithFrame:(CGRect)frame messageInfo:(NSDictionary *)mesageInfo;

@property (nonatomic ,copy) void (^closeView)(void);
@property (nonatomic ,copy) void (^toUpload)(void);

@end

NS_ASSUME_NONNULL_END
