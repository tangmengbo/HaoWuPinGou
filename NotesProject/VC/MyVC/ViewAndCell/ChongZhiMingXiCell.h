//
//  ChongZhiMingXiCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChongZhiMingXiCell : UITableViewCell

@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic,strong)UILabel * dingDanBianHaoLable;
@property(nonatomic,strong)UILabel * typeLable;
@property(nonatomic,strong)UILabel * jinELable;
@property(nonatomic,strong)UILabel * statusLable;
@property(nonatomic,strong)UILabel * timeLbale;
@property(nonatomic,strong)UIButton * lianXikeFuButton;

-(void)initData:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
