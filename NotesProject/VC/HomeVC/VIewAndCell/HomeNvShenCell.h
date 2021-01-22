//
//  HomeNvShenCell.h
//  JianZhi
//
//  Created by tang bo on 2021/1/21.
//  Copyright © 2021 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeNvShenCell : UITableViewCell

@property(nonatomic,strong)UIView * contentMessageView;


@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * faBuTimeLable;
@property(nonatomic,strong)UILabel * leiXingLable;
@property(nonatomic,strong)UILabel * diQuLable;
@property(nonatomic,strong)UILabel * fuWuLable;
@property(nonatomic,strong)UILabel * pingFenLable;
@property(nonatomic,strong)UIView * pingFenStarView;
@property(nonatomic,strong)UILabel * xiaoFeiLable;

@property(nonatomic,assign)CellType cellType;

-(void)contentViewSetData:(NSDictionary *)info;


@end

NS_ASSUME_NONNULL_END
