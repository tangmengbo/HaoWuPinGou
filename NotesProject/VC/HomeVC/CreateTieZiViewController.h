//
//  CreateTieZiViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/8.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateTieZiViewController : MainBaseViewController<LeiXiangSelectViewControllerDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,CityListViewControllerDelegate>
{
    int maxImageSelected;
    int uploadImageIndex;
    
    int maxVideoSelected;
    int uploadVideoIndex;
}
//1：经纪人发布到店铺的帖子 0默认普通帖子
@property(nonatomic,strong)NSString * from_flg;

@property(nonatomic,strong)UITextField * xinXiLeiXingTF;
@property(nonatomic,strong)UITextField * biaoTiTF;
@property(nonatomic,strong)UIButton * diQuButton;
@property(nonatomic,strong)UITextField * ageTF;
@property(nonatomic,strong)UITextField * chanPinShuLiangTF;
@property(nonatomic,strong)UITextField * beginPriceTF;
@property(nonatomic,strong)UITextField * endPriceTF;
@property(nonatomic,strong)UIButton * fuWuXiangMuButton;

@property(nonatomic,strong)UITextField * weiXinTF;
@property(nonatomic,strong)UITextField * qqTF;
@property(nonatomic,strong)UITextField * telTF;

@property(nonatomic,strong)NSMutableArray * yanZhiStarButtonArray;
@property(nonatomic,strong)NSString * yanZhiStarValue;

@property(nonatomic,strong)NSMutableArray * jiShuStarButtonArray;
@property(nonatomic,strong)NSString * jiShuStarValue;

@property(nonatomic,strong)NSMutableArray * huanJingStarButtonArray;
@property(nonatomic,strong)NSString * huanJingStarValue;

@property(nonatomic,strong)UIView * videoContentView;
@property(nonatomic,strong)NSMutableArray * videoArray;
@property(nonatomic,strong)NSMutableArray * videoPathArray;

@property(nonatomic,strong)UILabel * zhaoPianSelectLable;
@property(nonatomic,strong)UIView * photoContentView;
@property(nonatomic,strong)NSMutableArray * photoArray;
@property(nonatomic,strong)UIImagePickerController * imagePickerController;
@property(nonatomic,strong)NSMutableArray * photoPathArray;


@property(nonatomic,strong)UILabel * xiangQingLable;
@property(nonatomic,strong)UITextView * xiangQingTextView;

@property(nonatomic,strong)UIButton * tiJiaoButton;

@property(nonatomic,strong)NSDictionary * cityInfo;//城市信息
@property(nonatomic,strong,nullable)NSString * videoPathId;
@property(nonatomic,strong,nullable)NSString * imagePathId;


@end

NS_ASSUME_NONNULL_END
