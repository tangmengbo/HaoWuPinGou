//
//  HeiDianDetailPingJiaCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/25.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeiDianDetailPingJiaCell : UITableViewCell


@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UILabel * nickLable;
@property(nonatomic,strong)UILabel * tiYanTimeLable;
@property(nonatomic,strong)UILabel * pingFenTipLable;
@property(nonatomic,strong)UILabel * pingFenLable;

@property(nonatomic,strong)UIScrollView * contentScrollView;

@property(nonatomic,strong)UILabel * messageLable;


@property(nonatomic,strong)UIButton * toolButton;


-(void)initContentView:(NSDictionary *)info;

+(float)cellHegiht:(NSDictionary *)info;


@end

NS_ASSUME_NONNULL_END
