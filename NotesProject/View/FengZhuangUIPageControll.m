//
//  FengZhuangUIPageControll.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/24.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "FengZhuangUIPageControll.h"



@implementation FengZhuangUIPageControll

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //计算圆点间距
    CGFloat marginX = 18;
    
    //计算整个pageControll的宽度
   // CGFloat newW = (self.subviews.count - 1 ) * marginX;
    
    //设置新frame
   // self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    //设置居中
//    CGPoint center = self.center;
//    center.x = self.superview.center.x;
//    self.center = center;
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX-5, dot.frame.origin.y, 13, 5)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, 5, 5)];
        }
    }
}



@end
