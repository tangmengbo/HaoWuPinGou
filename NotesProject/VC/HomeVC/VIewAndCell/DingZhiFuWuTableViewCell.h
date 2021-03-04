//
//  DingZhiFuWuTableViewCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DingZhiFuWuTableViewCell : UITableViewCell

@property(nonatomic,strong)UIView * contentMessageView;

@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UIImageView * vImageView;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * weiZhiLable;
@property(nonatomic,strong)UILabel * faBuTimeLable;
@property(nonatomic,strong)UILabel * priceLable;

@property(nonatomic,strong)UIView * neiRongView;
@property(nonatomic,strong)UILabel * dingZhiNeiRongLable;
@property(nonatomic,strong)UILabel * dingZhiTimeLable;

-(void)contentViewSetData:(NSDictionary *)info;

+(float)cellHegiht:(NSDictionary *)info;




@end

NS_ASSUME_NONNULL_END
