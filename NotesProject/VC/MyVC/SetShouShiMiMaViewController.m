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

@property(nonatomic,strong)NSMutableArray * buttonArray;


@end

@implementation SetShouShiMiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    self.topTitleLale.text = @"手势密码";

    self.buttonArray = [NSMutableArray array];
    
    UIView * buttonContentView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-36*BiLiWidth)/2, self.topNavView.top+self.topNavView.height+22*BiLiWidth, 36*BiLiWidth, 36*BiLiWidth)];
    [self.view addSubview:buttonContentView];
    for (int i=0; i<9; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(14*BiLiWidth*(i%3), 14*BiLiWidth*(i/3), 8*BiLiWidth, 8*BiLiWidth)];
        button.backgroundColor = RGBFormUIColor(0xE8E9ED);
        button.layer.cornerRadius = 4*BiLiWidth;
        button.tag= i+1;
        [self.buttonArray addObject:button];
        [buttonContentView addSubview:button];
    }
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+88*BiLiWidth, WIDTH_PingMu, 30*BiLiWidth)];
    self.infoLabel.text = @"请绘制手势密码";
    self.infoLabel.textColor = RGBFormUIColor(0x999999);
    self.infoLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.infoLabel];

    


    
    __weak typeof(self) weakSelf = self;
    self.gesturePasswordView = [GesturePasswordView status:self.shouShiType frame:CGRectMake(0, self.infoLabel.top+self.infoLabel.height, WIDTH_PingMu, WIDTH_PingMu-100) verificationPassword:^{
        
        weakSelf.infoLabel.textColor = RGBFormUIColor(0xFF2374);
        weakSelf.infoLabel.text = @"请绘制新的手势密码";
        
    } verificationError:^{
        
        weakSelf.infoLabel.textColor = RGBFormUIColor(0xFF2374);
        weakSelf.infoLabel.text = @"旧密码验证错误";
        
    }  onPasswordSet:^ {
        
        if (self.shouShiType == GesturePasswordStatusSet) {
            
            weakSelf.infoLabel.textColor = RGBFormUIColor(0xFF2374);
            weakSelf.infoLabel.text = @"请重新绘制刚才设置的手势密码";

        }

    } onGetCorrectPswd:^ {
        
        weakSelf.infoLabel.textColor = RGBFormUIColor(0xFF2374);
        weakSelf.infoLabel.text = @"设置成功";
        
    } onGetIncorrectPswd:^ {
        
        if (self.shouShiType == GesturePasswordStatusSet) {
            
            weakSelf.infoLabel.textColor = RGBFormUIColor(0xFF2374);
            weakSelf.infoLabel.text = @"与上一次绘制不一致，请重新设置";

        }
    } errorInput:^{
        
        weakSelf.infoLabel.textColor = RGBFormUIColor(0xFF2374);
        weakSelf.infoLabel.text = @"请至少连接4个点";
    }];
    self.gesturePasswordView.delegate = self;
    [self.view addSubview:self.gesturePasswordView];
    

    
    if (self.shouShiType == GesturePasswordStatusLogin) {
        
        self.backImageView.hidden = YES;
        self.leftButton.hidden = YES;
        self.infoLabel.text = @"请绘制手势密码" ;

    }
    else if (self.shouShiType == GesturePasswordStatusSet)
    {
        self.infoLabel.text = @"请设置手势密码" ;

    }
    else if (self.shouShiType == GesturePasswordStatusReset)
    {
        
    }



}
-(void)setPassWorldFinsih:(NSString *)pwStr
{

    [NormalUse defaultsSetObject:pwStr forKey:@"ShouShiPWDefaults"];
    
//    for (UIButton * button in self.buttonArray) {
//
//        [button setBackgroundColor:RGBFormUIColor(0xE8E9ED)];
//    }
    for (UIButton * button in self.buttonArray) {
        
        NSString * str = [NSString stringWithFormat:@"%d",(int)button.tag];
        if ([pwStr containsString:str]) {
            
            [button setBackgroundColor:RGBFormUIColor(0xFF2374)];
        }
        else
        {
            [button setBackgroundColor:RGBFormUIColor(0xE8E9ED)];

        }
    }
    if (self.shouShiType == GesturePasswordStatusLogin) {
        
        [HTTPModel checkShouShiMiMa:[[NSDictionary alloc] initWithObjectsAndKeys:pwStr,@"gesture_pwd", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            

            if (status==1) {
                
                BOOL  flag =  [[responseObject objectForKey:@"flag"] boolValue];

                if(flag)
                {
                    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [delegate setQiDongTabbar];

                }
                else
                {
                    [self.gesturePasswordView setIncorrectTip];
                    
                    [NormalUse showToastView:@"手势密码错误" view:self.view];

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
