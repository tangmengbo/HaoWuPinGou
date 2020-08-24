//
//  LLImagePickerCell.h
//  LLImagePickerDemo
//
//  Created by liushaohua on 2019/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLImagePickerCell : UICollectionViewCell


@property (nonatomic, strong) UIImageView *icon;

/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteButton;

/** 视频标志 */
@property (nonatomic, strong) UIImageView *videoImageView;

@property(nonatomic, strong)NSIndexPath *cellIndexPath;

@property (nonatomic, copy) void(^LLClickDeleteButton)(NSIndexPath *cellIndexPath);

@end
