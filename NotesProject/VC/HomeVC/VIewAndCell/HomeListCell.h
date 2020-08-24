//
//  HomeListCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/20.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeListCell : UITableViewCell

@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * leiXingLable;
@property(nonatomic,strong)UILabel * diQuLable;
@property(nonatomic,strong)UILabel * fuWuLable;
@property(nonatomic,strong)UILabel * pingFenLable;
@property(nonatomic,strong)UIView * pingFenStarView;
@property(nonatomic,strong)UILabel * xiaoFeiLable;

-(void)contentViewSetData:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
