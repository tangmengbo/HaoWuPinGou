//
//  MyScrollView.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL)touchesShouldCancelInContentView:(UIView *)view {

    if ([view isKindOfClass:[UIButton class]]) {

        return YES;

    }
    return [super touchesShouldCancelInContentView:view];

}


@end
