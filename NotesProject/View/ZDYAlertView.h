//
//  ZDYAlertView.h
//  JianZhi
//
//  Created by tang bo on 2021/2/26.
//  Copyright © 2021 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDYAlertView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message1:(NSString *)message1 message2:(NSString *)message2 button1Title:(NSString *)button1Title button2Title:(NSString *)button2Title;

@property (nonatomic ,copy) void (^button1Click)(void);
@property (nonatomic ,copy) void (^button2Click)(void);

@end

NS_ASSUME_NONNULL_END
