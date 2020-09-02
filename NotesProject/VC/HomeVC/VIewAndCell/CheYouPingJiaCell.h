//
//  CheYouPingJiaCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/31.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheYouPingJiaCell : UITableViewCell

@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UILabel * nickLable;
@property(nonatomic,strong)UILabel * tiYanTimeLable;
@property(nonatomic,strong)UILabel * pingFenTipLable;
@property(nonatomic,strong)UILabel * pingFenLable;

@property(nonatomic,strong)UIImageView * imageView1;
@property(nonatomic,strong)UIImageView * imageView2;
@property(nonatomic,strong)UIImageView * imageView3;
@property(nonatomic,strong)UIImageView * imageView4;

@property(nonatomic,strong)UILabel * messageLable;

@property(nonatomic,strong)NSString * type;// yanCheBaoGao

@property(nonatomic,strong)UIButton * toolButton;


-(void)initContentView:(NSDictionary *)info;

+(float)cellHegiht:(NSDictionary *)info;


@end

NS_ASSUME_NONNULL_END
