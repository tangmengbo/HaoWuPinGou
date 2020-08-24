//
//  Lable_ImageButton.m
//  XiTang
//
//  Created by 唐蒙波 on 2019/12/2.
//  Copyright © 2019 Meng. All rights reserved.
//

#import "Lable_ImageButton.h"

@implementation Lable_ImageButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
    }
    return self;
}
-(UIView *)button_View
{
    if (!_button_View) {
        
        _button_View = [[UIView alloc] init];
        _button_View.layer.masksToBounds = YES;
        _button_View.userInteractionEnabled = NO;
        [self addSubview:_button_View];
    }
    return _button_View;
}
-(UILabel *)button_lable
{
    if (!_button_lable) {
        
        _button_lable = [[UILabel alloc] init];
        [self addSubview:_button_lable];
    }
    return _button_lable;
}
-(UILabel *)button_lable1
{
    if (!_button_lable1) {
        
        _button_lable1 = [[UILabel alloc] init];
        [self addSubview:_button_lable1];
    }
    return _button_lable1;
}
-(UIImageView *)button_imageView
{
    if (!_button_imageView) {
        
        _button_imageView = [[UIImageView alloc] init];
        _button_imageView.layer.masksToBounds = YES;
        [self addSubview:_button_imageView];
    }
    return _button_imageView;

}
-(UIImageView *)button_imageView1
{
    if (!_button_imageView1) {
        
        _button_imageView1 = [[UIImageView alloc] init];
        _button_imageView1.layer.masksToBounds = YES;
        [self addSubview:_button_imageView1];
    }
    return _button_imageView1;

}
@end
