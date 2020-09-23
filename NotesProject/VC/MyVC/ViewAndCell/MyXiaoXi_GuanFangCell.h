//
//  MyXiaoXi_GuanFangCell.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyXiaoXi_GuanFangCell : UITableViewCell

typedef enum {

    GuanFangMessage = 0,

    HuoDongMessage,
    
} XiaoXiCellType;

@property(nonatomic,assign)XiaoXiCellType cellType;

@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * timeLable;
@property(nonatomic,strong)UILabel * titleLable1;
@property(nonatomic,strong)UILabel * messageLable;
@property(nonatomic,strong)UIView * lineView;

-(void)initData:(NSDictionary *)info;

+(float)cellHegiht:(NSDictionary *)info;


@end

NS_ASSUME_NONNULL_END
