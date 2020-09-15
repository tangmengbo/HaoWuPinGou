//
//  MyFaBu_DingZhiFuWuCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/15.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyFaBu_DingZhiFuWuCell : UITableViewCell

@property(nonatomic,strong)UIView * contentMessageView;

@property(nonatomic,strong)UILabel * priceLable;
@property(nonatomic,strong)UILabel * weiZhiLable;

@property(nonatomic,strong)UIView * neiRongView;

@property(nonatomic,strong)UILabel * dingZhiNeiRongLable;
@property(nonatomic,strong)UILabel * dingZhiTimeLable;
@property(nonatomic,strong)UILabel * leiXingLable;
@property(nonatomic,strong)UILabel * fuWuXiangMuLable;
@property(nonatomic,strong)UIImageView * statusImageView;

-(void)contentViewSetData:(NSDictionary *)info;

+(float)cellHegiht:(NSDictionary *)info;


@end

NS_ASSUME_NONNULL_END
