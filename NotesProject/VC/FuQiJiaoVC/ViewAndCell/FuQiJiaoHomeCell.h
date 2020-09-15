//
//  FuQiJiaoHomeCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/20.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FuQiJiaoHomeCell : UITableViewCell

@property(nonatomic,strong)NSDictionary * info1;
@property(nonatomic,strong)NSDictionary * info2;

@property(nonatomic,strong)UIView * contentView1;
@property(nonatomic,strong)UIImageView * headerImageView1;
@property(nonatomic,strong)UILabel * cityLable1;
@property(nonatomic,strong)UIImageView * zuanShiImageView1;
@property(nonatomic,strong)UILabel * messageLable1;
@property(nonatomic,strong)UIButton * button1;

@property(nonatomic,strong)UIView * contentView2;
@property(nonatomic,strong)UIImageView * headerImageView2;
@property(nonatomic,strong)UILabel * cityLable2;
@property(nonatomic,strong)UIImageView * zuanShiImageView2;
@property(nonatomic,strong)UILabel * messageLable2;
@property(nonatomic,strong)UIButton * button2;



-(void)initData:(NSDictionary *)info1 info2:(NSDictionary * _Nullable)info2;

@end

NS_ASSUME_NONNULL_END
