//
//  GetIPAlsoCanUseViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/10/24.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GetIPAlsoCanUseViewController.h"
#import "ZYNetworkAccessibility.h"
#import "InputMobileViewController.h"


@interface GetIPAlsoCanUseViewController ()
{
    BOOL alsoShowAlert;
    
    int urlSourceIndex1;
    
    int ipIndex1;
    
    int urlSourceIndex2;

    int ipIndex2;

}
@property(nonatomic,strong)NSArray * urlSourceArray1;


@property(nonatomic,strong)NSArray * ipArray1;

@property(nonatomic,strong)NSArray * urlSourceArray2;

@property(nonatomic,strong)NSArray * ipArray2;

@end

@implementation GetIPAlsoCanUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topNavView.hidden = YES;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    imageView.image = [UIImage imageNamed:@"flash"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingNone;
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
    
    UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityView startAnimating];
    activityView.frame = CGRectMake(90*BiLiWidth, HEIGHT_PingMu-90*BiLiWidth, 20, 20);
    [self.view addSubview:activityView];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(activityView.left+activityView.width+25, activityView.top, 200, activityView.height)];
    tipLable.textColor = [UIColor whiteColor];
    tipLable.font = [UIFont systemFontOfSize:13];
    tipLable.text = @"正在为您匹配最佳线路...";
    [self.view addSubview:tipLable];

    
    self.urlSourceArray1 = [[NSArray alloc] initWithObjects:@"api.dis123s1.xyz",@"api.dis123s2.xyz",@"api.dis123s3.xyz",@"api.dis123s4.xyz", nil];
        

    [self getNetWorkStatus];
}
-(void)getNetWorkStatus
{
    [ZYNetworkAccessibility setStateDidUpdateNotifier:^(ZYNetworkAccessibleState state) {
        NSLog(@"setStateDidUpdateNotifier > %zd", state);
        
        if (ZYNetworkRestricted == state) {//没有网络权限
            
            if(!self->alsoShowAlert)
            {
                self->alsoShowAlert = YES;
                
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"网络连接失败" message:@"检测到网络权限可能未开启，您可以在“设置”中检查蜂窝移动网络" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        self->alsoShowAlert = NO;
                    }]];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        self->alsoShowAlert = NO;

                        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
                            [[UIApplication sharedApplication] openURL:settingsURL];
                            
                        }
                    }]];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil] ;

            }
            
        }
        if (state == ZYNetworkAccessible) {//网络可用
            
            
            if ([@"网络不可用" isEqualToString:[NormalUse netWorkState]]) {
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"网络连接失败" message:@"当前网络不可用,请稍后重试" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil] ;

            }
            else
            {
                [ZYNetworkAccessibility stop];

                [self beginYanZhengIP];

            }

            
        }
    }];
    
    [ZYNetworkAccessibility start];

}
-(void)beginYanZhengIP
{
    urlSourceIndex1 = 0;

    NSString * urlStr = [NSString stringWithFormat:@"http://119.29.29.29/d?dn=%@.&ip=1.1.1.1",[self.urlSourceArray1 objectAtIndex:urlSourceIndex1]];
    
    [self getIpByUrl1:urlStr];
    
}
//通过url获取ip数组
-(void)getIpByUrl1:(NSString *)urlStr
{
    urlSourceIndex1 = urlSourceIndex1+1;

    ipIndex1 = 0;

    [HTTPModel getIPByUrl:[[NSDictionary alloc] initWithObjectsAndKeys:urlStr,@"testUrl", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {

        if (status==1) {
            
            self.ipArray1 = responseObject;
            
            //如果self.urlSourceArray1获取到对的self.ipArray1数组是对的,则根据ip获取Url
            if ([NormalUse isValidArray:self.ipArray1]) {
                
                [self getUrlByIp:[self.ipArray1 objectAtIndex:self->ipIndex1]];

            }
            else
            {
                [self getIpByUrl1Error];
            }

            
        }
        else
        {
            [self getIpByUrl1Error];
        }
    }];

}
-(void)getIpByUrl1Error
{
    //如果获取到的ip数组不对,则再次通过self.urlSourceArray1中的下一个url获取ip数组
    if (self->urlSourceIndex1<self.urlSourceArray1.count-1) {
        
        NSString * urlStr = [NSString stringWithFormat:@"http://119.29.29.29/d?dn=%@.&ip=1.1.1.1",[self.urlSourceArray1 objectAtIndex:self->urlSourceIndex1]];

        [self getIpByUrl1:urlStr];

    }
    else
    {
        //如果获取到的ip数组不对,且self.urlSourceArray1中只剩余一个url,则直接用self.urlSourceArray1中的最后一个url

        [self beginGoInApp];
    }


}
-(void)getUrlByIp:(NSString *)ipStr
{
    ipIndex1 = ipIndex1+1;
    
    urlSourceIndex2 = 0;
    
    [HTTPModel getUrlListByIp:[[NSDictionary alloc]initWithObjectsAndKeys:ipStr,@"uri", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            [NormalUse defaultsSetObject:[responseObject objectForKey:@"ios_pkg"] forKey:@"ios_pkg"];
            self.urlSourceArray2 = [responseObject objectForKey:@"main_site"];
            [NormalUse defaultsSetObject:[responseObject objectForKey:@"res_site"] forKey:@"UploadYuMingDefaults"];
            //如果根据self.ipArray1中的ip获取到了对的url数组self.urlSourceArray2,则根据self.urlSourceArray2中的url获取ip数组self.ipArray2
            if ([NormalUse isValidArray:self.urlSourceArray2]) {
                
                NSString * urlStr = [NSString stringWithFormat:@"http://119.29.29.29/d?dn=%@.&ip=1.1.1.1",[self.urlSourceArray2 objectAtIndex:self->urlSourceIndex2]];

                [self getIpByUrl2:urlStr];
            }
            else
            {
                [self getUrlByIpError];
            }
        }
        else
        {
            [self getUrlByIpError];
        }
        
    }];
}
-(void)getUrlByIpError
{
    //如果根据self.ipArray1中的ip获取到的url数组self.urlSourceArray2不对,则再次根据self.ipArray1中的下一个ip获取self.urlSourceArray2

    if (ipIndex1<self.ipArray1.count) {
        
        [self getUrlByIp:[self.ipArray1 objectAtIndex:ipIndex1]];

    }
    else
    {
        //如果根据self.ipArray1中的ip获取到的url数组self.urlSourceArray2不对,且self.ipArray1中已经没有ip,则根据self.urlSourceArray1中的url去获取self.ipArray1

        //如果self.urlSourceArray1中的下一个url不是最后一个
        if (urlSourceIndex1<self.urlSourceArray1.count-1) {
            
            NSString * urlStr = [NSString stringWithFormat:@"http://119.29.29.29/d?dn=%@.&ip=1.1.1.1",[self.urlSourceArray1 objectAtIndex:urlSourceIndex1]];

            [self getIpByUrl1:urlStr];

        }
        else
        {
            //如果self.urlSourceArray1中只剩余一个url,则直接用self.urlSourceArray1中的最后一个url
            [self beginGoInApp];
        }

    }


}
-(void)getIpByUrl2:(NSString *)urlStr
{
    urlSourceIndex2 = urlSourceIndex2+1;
    
    ipIndex2 = 0;
    
    [HTTPModel getIPByUrl:[[NSDictionary alloc] initWithObjectsAndKeys:urlStr,@"testUrl", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {

        if (status==1) {
            
            self.ipArray2 = responseObject;
            
            //如果根据self.urlSourceArray2中的url获取到的self.ipArray2是对的则去验证self.ipArray2中的ip是否可用
            if ([NormalUse isValidArray:self.ipArray2]) {
                
                [self yanZhengIp:[self.ipArray2 objectAtIndex:self->ipIndex2]];

            }
            else
            {
                [self getIpByUrl2Error];
            }
        }
        else
        {
            [self getIpByUrl2Error];

        }
    }];

}
-(void)getIpByUrl2Error
{
    //如果根据self.urlSourceArray2中的url获取到的self.ipArray2不对,则根据self.urlSourceArray2中的下一个url去获取self.ipArray2数组
    
    if(urlSourceIndex2<self.urlSourceArray2.count)
    {
        NSString * urlStr = [NSString stringWithFormat:@"http://119.29.29.29/d?dn=%@.&ip=1.1.1.1",[self.urlSourceArray2 objectAtIndex:urlSourceIndex2]];

        [self getIpByUrl2:urlStr];

    }
    else
    {
        //如果self.urlSourceArray2中已经没有url,则根据self.ipArray1中的ip去获取self.urlSourceArray2数组
        if (self->ipIndex1<self.ipArray1.count) {
            
            [self getUrlByIp:[self.ipArray1 objectAtIndex:self->ipIndex1]];

        }
        else
        {
            //如果self.ipArray1中已经没有ip,怎根据self.urlSourceArray1中的url去获取如果self.ipArray1
            if (self->urlSourceIndex1<self.urlSourceArray1.count-1) {
                
                [self getIpByUrl1:[self.urlSourceArray1 objectAtIndex:self->urlSourceIndex1]];

            }
            else
            {
                //如果self.urlSourceArray1中只剩余最后一个url 则直接使用
                
                [self beginGoInApp];
                
            }
            
        }

    }
    
}
-(void)yanZhengIp:(NSString *)ipStr
{

    ipIndex2 = ipIndex2+1;
    NSString * testUrl = [NSString stringWithFormat:@"http://%@:8089/appi/common/curCity",ipStr];
    [HTTPModel IpTestCheck:[[NSDictionary alloc]initWithObjectsAndKeys:testUrl,@"testIp", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {

            [NormalUse defaultsSetObject:[NSString stringWithFormat:@"http://%@:8089",ipStr] forKey:APPUrlRequestDefults];
            
            [self goInApp];
        }
        else
        {
            if (self->ipIndex2<self.ipArray2.count) {
                
                [self yanZhengIp:[self.ipArray2 objectAtIndex:self->ipIndex2]];

            }
            else if (self->urlSourceIndex2<self.urlSourceArray2.count)
            {
                NSString * urlStr = [NSString stringWithFormat:@"http://119.29.29.29/d?dn=%@.&ip=1.1.1.1",[self.urlSourceArray2 objectAtIndex:self->urlSourceIndex2]];

                [self getIpByUrl2:urlStr];

            }
            else if (self->ipIndex1<self.ipArray1.count)
            {
                
                [self getUrlByIp:[self.ipArray1 objectAtIndex:self->ipIndex1]];

            }
            else if (self->urlSourceIndex1<self.urlSourceArray1.count-1)
            {
                [self getIpByUrl1:[self.urlSourceArray1 objectAtIndex:self->urlSourceIndex1]];
            }
            else
            {
                [self beginGoInApp];
            }
            
        }
        
    }];

}
-(void)beginGoInApp
{
    
    [NormalUse defaultsSetObject:[NSString stringWithFormat:@"http://%@:8089",[self.urlSourceArray1 objectAtIndex:self.urlSourceArray1.count-1]] forKey:APPUrlRequestDefults];

    [self goInApp];

}
-(void)goInApp
{
    

    [HTTPModel getJSSiteUrls:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {

        if (status==1) {

            NSDictionary * info = responseObject;
            [NormalUse defaultsSetObject:[NormalUse removeNullFromDictionary:info] forKey:AppSiteUrls];
        }
    }];
    
    [HTTPModel getAppJinBiList:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            NSDictionary * info = [NormalUse removeNullFromDictionary:responseObject];
            [NormalUse defaultsSetObject:info forKey:JinBiShuoMing];
        }
    }];
    
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [HTTPModel acountAlsoCanUse:[[NSDictionary alloc]initWithObjectsAndKeys:[NormalUse getSheBeiBianMa],@"phone_ucode",@"2",@"platform", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        NSNumber * statusCode = [responseObject objectForKey:@"status"];
        if (statusCode.intValue==1) {
            
            [self accountZhengChang];
        }
        else if (statusCode.intValue==-1)//账号被删除 重新生成账号
        {
            [self noAccountRegistInit];

        }
        else if (statusCode.intValue==0)//禁用：提示并跳到切换账号界面
        {
            [delegate setYiDengLuTabBar];
            [delegate.tabbar setItemSelected:4];
            InputMobileViewController * vc = [[InputMobileViewController alloc] init];
            vc.bangDingOrQieHuan = @"2";
            vc.alsoNotCanPop = YES;
            UINavigationController * nav =[delegate.tabbar.viewControllers objectAtIndex:4];
            [nav pushViewController:vc animated:YES];

        }
    }];
    
   
}
//账号无异常 进入正常的登录注册流程
-(void)accountZhengChang
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    //用户已经登录
    if ([NormalUse isValidString:[NormalUse defaultsGetObjectKey:LoginToken]]) {
        
        if ([NormalUse isValidDictionary:[NormalUse defaultsGetObjectKey:UserRongYunInfo]]) {
            
            [[RongYManager getInstance] connectRongCloud];

        }
        //是否需要手势密码
        [HTTPModel alsoNeesShouShiMiMa:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                //是否需要手势密码
                BOOL  isSign =  [[responseObject objectForKey:@"flag"] boolValue];
                
                if (isSign)
                {
                    //输入手势密码
                    [delegate setShouShiYanZhengTabbar];
                }
                else
                {
                    //直接进入
                    [delegate setQiDongTabbar];
                }

            }
            else
            {
                //直接进入
                [delegate setQiDongTabbar];
            }
        }];
    }
    else
    {
//
        [self noAccountRegistInit];
    }

}
//没有登陆 或 账号被删除 重新init生成账号
-(void)noAccountRegistInit
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    //未登录用户先 获取初始化账号
    [HTTPModel registerInit:[[NSDictionary alloc]initWithObjectsAndKeys:[NormalUse getSheBeiBianMa],@"phone_ucode",@"2",@"platform", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            if ([NormalUse isValidDictionary:[responseObject objectForKey:@"info"]]) {
                
                NSDictionary * userInfo = [responseObject objectForKey:@"info"];
                [NormalUse defaultsSetObject:[userInfo objectForKey:@"ryuser"] forKey:UserRongYunInfo];
                [[RongYManager getInstance] connectRongCloud];


            }
            //获取初始化账号 成功后调用登录 获取到logintoken
            [HTTPModel login:[[NSDictionary alloc]initWithObjectsAndKeys:[NormalUse getSheBeiBianMa],@"phone_ucode", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                
                if (status==1) {
                    
                    NSString *  logintoken = [responseObject objectForKey:@"logintoken"];
                    [NormalUse defaultsSetObject:logintoken forKey:LoginToken];

                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"YYYY-MM-dd"];
                    NSDate *datenow = [NSDate date];
                    NSString *currentTimeString = [formatter stringFromDate:datenow];
                    [NormalUse defaultsSetObject:@"1" forKey:currentTimeString];

                    [delegate setQiDongTabbar];

                }
            }];
            
            //只有首次安装时执行到这里的时候进入
            if (![@"true" isEqualToString:[NormalUse defaultsGetObjectKey:@"share_codeDefaults"]]) {
                
                [NormalUse defaultsSetObject:@"true" forKey:@"share_codeDefaults"];
                
                //获取剪切板是否有信息，share_code
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                if ([NormalUse isValidString:pasteboard.string]) {

                    [self uploadShareCode:pasteboard.string];
                }
                else
                {
                    [HTTPModel getShareCode:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                        
                        if (status==1) {
                            
                            [self uploadShareCode:[NormalUse getobjectForKey:[responseObject objectForKey:@"share_code"]]];
                            
                        }

                    }];


                }
            }
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
}
-(void)uploadShareCode:(NSString *)share_code
{
    [HTTPModel tianXieYaoQingMa:[[NSDictionary alloc] initWithObjectsAndKeys:share_code,@"share_code", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
        }
        else
        {
            
        }
    }];

}

@end
