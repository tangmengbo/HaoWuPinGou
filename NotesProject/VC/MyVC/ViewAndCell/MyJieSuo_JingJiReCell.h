//
//  MyJieSuo_JingJiReCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/15.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyJieSuo_JingJiReCell : UITableViewCell

@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * pingFenLable;
@property(nonatomic,strong)UILabel * cityLable;
@property(nonatomic,strong)UILabel * renZhengLable;
@property(nonatomic,strong)UILabel * chengJiaoLable;

-(void)contentViewSetData:(NSDictionary *)info;


@end

NS_ASSUME_NONNULL_END
