//
//  MyShouCangGuanZhu_ShouCangCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/15.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyShouCangGuanZhu_ShouCangCellDelegate
@optional

- (void)shouCangTianJiaToDelet:(NSString *)idStr;
- (void)shouCangQuXiaoToDelet:(NSString *)idStr;

@end


NS_ASSUME_NONNULL_BEGIN

@interface MyShouCangGuanZhu_ShouCangCell : UITableViewCell

@property(nonatomic,assign)id<MyShouCangGuanZhu_ShouCangCellDelegate>delegate;


@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UIImageView * guanFangImageView;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * faBuTimeLable;
@property(nonatomic,strong)UILabel * leiXingLable;
@property(nonatomic,strong)UILabel * diQuLable;
@property(nonatomic,strong)UILabel * fuWuLable;
@property(nonatomic,strong)UILabel * pingFenLable;
@property(nonatomic,strong)UIView * pingFenStarView;
@property(nonatomic,strong)UILabel * xiaoFeiLable;

@property(nonatomic,strong)Lable_ImageButton * alsoDeleteButton;


-(void)contentViewSetData:(NSDictionary *)info alsoDelete:(BOOL)alsoDelete;

@end

NS_ASSUME_NONNULL_END
