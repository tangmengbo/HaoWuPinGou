//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

#import "PGIndexBannerSubiew.h"

@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.mainImageView];
        [self.mainImageView addSubview:self.tipLable];
        [self.tipLable addSubview:self.lineView];
        [self.mainImageView addSubview:self.tipLable1];
        [self.tipLable1 addSubview:self.lineView1];
        [self addSubview:self.coverView];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleCellTapAction:)];
        [self addGestureRecognizer:singleTap];
    }
    
    return self;
}

- (void)singleCellTapAction:(UIGestureRecognizer *)gesture {
    if (self.didSelectCellBlock) {
        self.didSelectCellBlock(self.tag, self);
    }
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {
    
    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }
    
    self.mainImageView.frame = superViewBounds;
    self.tipLable.frame = CGRectMake(20, self.mainImageView.height-30, 200, 30);
    self.lineView.frame = CGRectMake(50, (self.tipLable.height-1)/2, 60, 1);
    self.tipLable1.frame = CGRectMake(20, 0, 200, 30);
    self.lineView1.frame = CGRectMake(40, (self.tipLable1.height-1)/2, 60, 1);
    self.coverView.frame = superViewBounds;
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.userInteractionEnabled = YES;
        _mainImageView.layer.cornerRadius = 8*BiLiWidth;
        _mainImageView.layer.masksToBounds = YES;
        _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
        _mainImageView.autoresizingMask = UIViewAutoresizingNone;
        _mainImageView.clipsToBounds = YES;
    }
    return _mainImageView;
}
- (UILabel *)tipLable {
    
    if (_tipLable == nil) {
        _tipLable = [[UILabel alloc] init];
    }
    return _tipLable;
}
- (UIView *)lineView {
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor clearColor];
    }
    return _lineView;
}
- (UILabel *)tipLable1 {
    
    if (_tipLable1 == nil) {
        _tipLable1 = [[UILabel alloc] init];
    }
    return _tipLable1;
}
- (UIView *)lineView1 {
    
    if (_lineView1 == nil) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = [UIColor clearColor];
    }
    return _lineView1;
}
- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.layer.cornerRadius = 8*BiLiWidth;
        _coverView.layer.masksToBounds = YES;
        _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}

@end
