//
//  CreateDingZhiFuWuViewController.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/31.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MainBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateDingZhiFuWuViewController : MainBaseViewController<LeiXiangSelectViewControllerDelegate>
{
    int beiginOrEndTimeSelect; //0 begin 1 end
}


@property(nonatomic,strong) UIView * whiteContentView;

@property(nonatomic,strong)UILabel * cityLable;
@property(nonatomic,strong)NSDictionary * cityInfo;

@property(nonatomic,strong)UIButton * beginTimeButton;
@property(nonatomic,strong)UILabel * beginWeekLable;
@property(nonatomic,strong)UIButton * endTimeButton;
@property(nonatomic,strong)UILabel * endWeekLable;


@property(nonatomic,strong)UITextField * beginPriceTF;
@property(nonatomic,strong)UITextField * endPriceTF;

@property(nonatomic,strong)UIButton * leiXingButton;

@property(nonatomic,strong)UIButton * xiangMuButton;

@property(nonatomic,strong)UITextField * weiXinTF;
@property(nonatomic,strong)UITextField * qqTF;
@property(nonatomic,strong)UITextField * telTF;

@property(nonatomic,strong)UITextView * describleTextView;

@property(nonatomic,strong)UIView * pickRootView;
@property(nonatomic,strong)UIDatePicker * datePickView ;

@property(nonatomic,strong,nullable)NSDate * beginDate;
@property(nonatomic,strong,nullable)NSDate * endDate;
@property(nonatomic,strong)NSString * leiXingStr;
@property(nonatomic,strong)NSString * xiangMuStr;



@end

NS_ASSUME_NONNULL_END
