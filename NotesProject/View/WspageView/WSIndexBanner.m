//
//  WSIndexBanner.m
//  WSCycleScrollView
//
//  Created by iMac on 16/8/10.
//  Copyright © 2016年 sinfotek. All rights reserved.
//

#import "WSIndexBanner.h"

@implementation WSIndexBanner

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.mainImageView];
    }
    
    return self;
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-80*BiLiWidth)/2, 0, 80*BiLiWidth, 85*BiLiWidth)];
        _mainImageView.layer.masksToBounds = YES;
        _mainImageView.userInteractionEnabled = YES;
        _mainImageView.layer.cornerRadius = 8*BiLiWidth;
        _mainImageView.layer.masksToBounds = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-80*BiLiWidth)/2, 0, 80*BiLiWidth, 85*BiLiWidth)];
        _coverView.backgroundColor = [UIColor whiteColor];
        _coverView.alpha = 0;
    }
    return _coverView;
}


@end
