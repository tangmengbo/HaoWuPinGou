//
//  JinBiMingXiCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JinBiMingXiCell : UITableViewCell

@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * timeLable;
@property(nonatomic,strong)UILabel * jinBiLable;

-(void)initData:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
