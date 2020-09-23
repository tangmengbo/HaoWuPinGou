//
//  AutoScrollLabel.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/22.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define NUM_LABELS 2

enum AutoScrollDirection {
    AUTOSCROLL_SCROLL_RIGHT,
    AUTOSCROLL_SCROLL_LEFT,
};
 
@interface AutoScrollLabel : UIScrollView <UIScrollViewDelegate>{
    UILabel *label[NUM_LABELS];
    enum AutoScrollDirection scrollDirection;
    float scrollSpeed;
    NSTimeInterval pauseInterval;
    int bufferSpaceBetweenLabels;
    bool isScrolling;
}
@property(nonatomic) enum AutoScrollDirection scrollDirection;
@property(nonatomic) float scrollSpeed;
@property(nonatomic) NSTimeInterval pauseInterval;
@property(nonatomic) int bufferSpaceBetweenLabels;
// normal UILabel properties
@property(nonatomic,retain) UIColor *textColor;
@property(nonatomic, retain) UIFont *font;
 
- (void) readjustLabels;
- (void) setText: (NSString *) text;
- (NSString *) text;
- (void) scroll;


@end

NS_ASSUME_NONNULL_END
