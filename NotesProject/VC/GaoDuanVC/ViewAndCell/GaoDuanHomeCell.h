//
//  GaoDuanHomeCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/20.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GaoDuanHomeCell : UITableViewCell

@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UIImageView * starImageView;
@property(nonatomic,strong)UILabel * starLable;
@property(nonatomic,strong)UILabel * cityLable;
@property(nonatomic,strong)UIButton * jinRuButton;
@property(nonatomic,strong)UIScrollView * contentScrollView;
@property(nonatomic,strong)UIImageView * jiaoYiBaoZhengImageView;
@property(nonatomic,strong)UILabel * renZhengLable;
@property(nonatomic,strong)UILabel * chengJiaoLable;




@property(nonatomic,strong)UIView * lineView;

-(void)contentViewSetData:(NSDictionary *)info;


@end

NS_ASSUME_NONNULL_END
