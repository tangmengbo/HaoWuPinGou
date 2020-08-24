//
//  XiaoXiViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "XiaoXiViewController.h"

@interface XiaoXiViewController ()

@end

@implementation XiaoXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"消息";
    
    [self yinCangTabbar];
    
    Lable_ImageButton * systemMessageButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    systemMessageButton.button_imageView.frame = CGRectMake(18*BiLiWidth, 0, 45*BiLiWidth, 45*BiLiWidth);
    systemMessageButton.button_imageView.image = [UIImage imageNamed:@"xiaoXi_systemMessage"];
    systemMessageButton.button_lable.frame = CGRectMake(systemMessageButton.button_imageView.left+systemMessageButton.button_imageView.width+8.5*BiLiWidth, 4.5*BiLiWidth, 200*BiLiWidth, 15*BiLiWidth);
    systemMessageButton.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    systemMessageButton.button_lable.textColor = RGBFormUIColor(0x333333);
    systemMessageButton.button_lable.text = @"系统通知";
    systemMessageButton.button_lable1.frame = CGRectMake(systemMessageButton.button_lable.left, systemMessageButton.button_lable.top+systemMessageButton.button_lable.height+7.5*BiLiWidth, 200*BiLiWidth, 12*BiLiWidth);
    systemMessageButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    systemMessageButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    systemMessageButton.button_lable1.text = @"还没有系统消息哦～";
    [self.view addSubview:systemMessageButton];
    
    Lable_ImageButton * jieSuoYanZhengButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, systemMessageButton.top+systemMessageButton.height+20*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    jieSuoYanZhengButton.button_imageView.frame = CGRectMake(18*BiLiWidth, 0, 45*BiLiWidth, 45*BiLiWidth);
    jieSuoYanZhengButton.button_imageView.image = [UIImage imageNamed:@"xiaoXi_jieSuoYanZheng"];
    jieSuoYanZhengButton.button_lable.frame = CGRectMake(systemMessageButton.button_imageView.left+systemMessageButton.button_imageView.width+8.5*BiLiWidth, 4.5*BiLiWidth, 200*BiLiWidth, 15*BiLiWidth);
    jieSuoYanZhengButton.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    jieSuoYanZhengButton.button_lable.textColor = RGBFormUIColor(0x333333);
    jieSuoYanZhengButton.button_lable.text = @"解锁和验证";
    jieSuoYanZhengButton.button_lable1.frame = CGRectMake(systemMessageButton.button_lable.left, systemMessageButton.button_lable.top+systemMessageButton.button_lable.height+7.5*BiLiWidth, 200*BiLiWidth, 12*BiLiWidth);
    jieSuoYanZhengButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    jieSuoYanZhengButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    jieSuoYanZhengButton.button_lable1.text = @"还没有通知哦～";
    [self.view addSubview:jieSuoYanZhengButton];

    
    Lable_ImageButton * keFuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, jieSuoYanZhengButton.top+jieSuoYanZhengButton.height+20*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    keFuButton.button_imageView.frame = CGRectMake(18*BiLiWidth, 0, 45*BiLiWidth, 45*BiLiWidth);
    keFuButton.button_imageView.image = [UIImage imageNamed:@"xiaoXi_keFu"];
    keFuButton.button_lable.frame = CGRectMake(systemMessageButton.button_imageView.left+systemMessageButton.button_imageView.width+8.5*BiLiWidth, 4.5*BiLiWidth, 200*BiLiWidth, 15*BiLiWidth);
    keFuButton.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    keFuButton.button_lable.textColor = RGBFormUIColor(0x333333);
    keFuButton.button_lable.text = @"在线客服";
    keFuButton.button_lable1.frame = CGRectMake(systemMessageButton.button_lable.left, systemMessageButton.button_lable.top+systemMessageButton.button_lable.height+7.5*BiLiWidth, 200*BiLiWidth, 12*BiLiWidth);
    keFuButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    keFuButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    keFuButton.button_lable1.text = @"您好～";
    [self.view addSubview:keFuButton];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
