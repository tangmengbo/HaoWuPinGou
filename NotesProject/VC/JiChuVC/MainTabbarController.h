//
//  SJTabBarController.h
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/10/10.
//  Copyright © 2015年 唐蒙波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabbarController : UITabBarController


@property (nonatomic,strong)UIImageView * bottomView;

@property (nonatomic,strong)UIButton * tab1;
@property (nonatomic,strong)UIButton * tab2;
@property (nonatomic,strong)UIButton * tab3;
@property (nonatomic,strong)UIButton * tab4;
@property (nonatomic,strong)UIButton * tab5;

@property (nonatomic,strong)UILabel * unReadMesLable;

@property (nonatomic,strong)UIImageView * img1;
@property (nonatomic,strong)UILabel * lab1;

@property (nonatomic,strong)UIImageView * img2;
@property (nonatomic,strong)UILabel * lab2;

@property (nonatomic,strong)UIImageView * img3;
@property (nonatomic,strong)UILabel * lab3;

@property (nonatomic,strong)UIImageView * img4;
@property (nonatomic,strong)UILabel * lab4;

@property (nonatomic,strong)UIImageView * img5;
@property (nonatomic,strong)UILabel * lab5;

-(void)setItemSelected:(int)index;

@end
