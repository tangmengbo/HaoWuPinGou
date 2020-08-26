//
//  ShouShiMiMaViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/26.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "ShouShiMiMaViewController.h"
#import "GesturePasswordView.h"

@interface ShouShiMiMaViewController ()<GesturePasswordViewDelegate>

@property(nonatomic,strong)UILabel * infoLabel;

@end

@implementation ShouShiMiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu-50*BiLiWidth, WIDTH_PingMu, 30*BiLiWidth)];
    self.infoLabel.textColor = RGBFormUIColor(0x222222);
    [self.view addSubview:self.infoLabel];
    
    __weak typeof(self) weakSelf = self;
    GesturePasswordView *gesturePasswordView = [GesturePasswordView status:GesturePasswordStatusLogin frame:CGRectMake(0, 140, WIDTH_PingMu, WIDTH_PingMu-100) verificationPassword:^{
        weakSelf.infoLabel.text = @"请输入新的手势密码";
    } verificationError:^{
        weakSelf.infoLabel.text = @"旧密码验证错误";
    }  onPasswordSet:^ {
        weakSelf.infoLabel.text = @"请重新输入刚才设置的手势密码";
    } onGetCorrectPswd:^ {
        weakSelf.infoLabel.text = @"设置成功";
    } onGetIncorrectPswd:^ {
        weakSelf.infoLabel.text = @"与上一次输入不一致，请重新设置";
    } errorInput:^{
        weakSelf.infoLabel.text = @"请至少连接4个点";
    }];
    gesturePasswordView.delegate = self;
    [self.view addSubview:gesturePasswordView];

}
-(void)setPassWorldFinsih:(NSString *)pwStr
{
    [NormalUse defaultsSetObject:pwStr forKey:@"ShouShiPWDefaults"];
}

@end
