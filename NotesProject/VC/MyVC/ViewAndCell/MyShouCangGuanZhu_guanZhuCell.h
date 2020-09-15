//
//  MyShouCangGuanZhu_guanZhuCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/15.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyShouCangGuanZhu_guanZhuCellDelegate
@optional

- (void)guanZhuTianJiaToDelet:(NSString *)idStr;
- (void)guanZhuQuXiaoToDelet:(NSString *)idStr;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MyShouCangGuanZhu_guanZhuCell : UITableViewCell
{
    BOOL alsoDelete;
}
@property(nonatomic,assign)id<MyShouCangGuanZhu_guanZhuCellDelegate>delegate;

@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * pingFenLable;
@property(nonatomic,strong)UILabel * cityLable;
@property(nonatomic,strong)UILabel * renZhengLable;
@property(nonatomic,strong)UILabel * chengJiaoLable;

@property(nonatomic,strong)Lable_ImageButton * alsoDeleteButton;

-(void)contentViewSetData:(NSDictionary *)info alsoDelete:(BOOL)alsoDelete;


@end

NS_ASSUME_NONNULL_END
