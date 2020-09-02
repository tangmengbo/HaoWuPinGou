//
//  ShouShiMiMaViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/26.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "SetShouShiMiMaViewController.h"
#import "GesturePasswordView.h"

@interface SetShouShiMiMaViewController ()<GesturePasswordViewDelegate>

@property(nonatomic,strong)UILabel * infoLabel;

@property(nonatomic,strong)GesturePasswordView *gesturePasswordView ;

@end

@implementation SetShouShiMiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];

    
    
    
    __weak typeof(self) weakSelf = self;
    self.gesturePasswordView = [GesturePasswordView status:self.shouShiType frame:CGRectMake(0, 140, WIDTH_PingMu, WIDTH_PingMu-100) verificationPassword:^{
        
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
    self.gesturePasswordView.delegate = self;
    [self.view addSubview:self.gesturePasswordView];
    

    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.gesturePasswordView.top+self.gesturePasswordView.height+40*BiLiWidth, WIDTH_PingMu, 30*BiLiWidth)];
    self.infoLabel.textColor = RGBFormUIColor(0x222222);
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.infoLabel];
    
    if (self.shouShiType == GesturePasswordStatusLogin) {
        
        self.topNavView.hidden = YES;
        self.infoLabel.text =@"请输入手势密码" ;

    }
    else if (self.shouShiType == GesturePasswordStatusSet)
    {
        self.infoLabel.text =@"请设置手势密码" ;

    }
    else if (self.shouShiType == GesturePasswordStatusReset)
    {
        
    }



}
-(void)setPassWorldFinsih:(NSString *)pwStr
{

    [NormalUse defaultsSetObject:pwStr forKey:@"ShouShiPWDefaults"];
    
    if (self.shouShiType == GesturePasswordStatusLogin) {
        
        [HTTPModel checkShouShiMiMa:[[NSDictionary alloc] initWithObjectsAndKeys:pwStr,@"gesture_pwd", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            

            if (status==1) {
                
                BOOL   flag =  [[responseObject objectForKey:@"flag"] boolValue];

                if(flag)
                {
                    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [delegate setYiDengLuTabBar];

                }
                else
                {
                    [self.gesturePasswordView setIncorrectTip];
                    
                    [NormalUse showToastView:msg view:self.view];

                }

            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
                
            }
        }];
    }
    else if (self.shouShiType == GesturePasswordStatusSet)
    {
        [HTTPModel setShouShiMiMa:[[NSDictionary alloc] initWithObjectsAndKeys:pwStr,@"gesture_pwd", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
                [NormalUse showToastView:@"手势密码设置成功" view:[NormalUse getCurrentVC].view];
                
            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
                
            }
        }];

    }
}

@end
