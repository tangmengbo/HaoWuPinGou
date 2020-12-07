//
//  JinChanWebViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/10/13.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "JinChanWebViewController.h"

@interface JinChanWebViewController ()<WKUIDelegate,WKScriptMessageHandler>

@property(nonatomic,strong)WKWebView * webView;

@end

@implementation JinChanWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self yinCangTabbar];
    [self addTheWebview];
}
// 配置webview
-(void)addTheWebview {
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    WKWebViewConfiguration *wvConfig = [[WKWebViewConfiguration alloc] init];
    wvConfig.userContentController = userContentController;
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:wvConfig];
    _webView.UIDelegate = self;
    if (@available(iOS 11.0, *)) {
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    _webView.frame = CGRectMake(0, TopHeight_PingMu, WIDTH_PingMu, HEIGHT_PingMu-TopHeight_PingMu);

    [self.view addSubview:_webView];

    NSDictionary * userInfo = [NormalUse defaultsGetObjectKey:UserRongYunInfo];
    NSLog(@"%@,%@",userInfo,[NormalUse getCurrentUserName]);
    NSDictionary * jsInfo = [NormalUse defaultsGetObjectKey:AppSiteUrls];
    NSError *err = nil;
    NSDictionary *dict = @{
        @"httpHost": [jsInfo objectForKey:@"http_addr"],
        @"imHost": [jsInfo objectForKey:@"socket_addr"],
        @"appFlag": @"lt01223",
        @"apiKey": @"asdad902382jdada89HJAa",
        @"secretKey": @"dHas89dashdjatydGkjsad7aadhga",
        @"thirdUserName": [NormalUse getCurrentUserName],
        @"thirdUserId": [userInfo objectForKey:@"userid"],
        @"forWhat": self.forWhat,
        @"canOpenWechat": @"true",
        @"canOpenAlipay": @"true",
        @"canSaveQrcode": @"true",
        @"loginJcInApp":@"true",
    };
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    NSString *thirdConfig = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSData *base64 = [thirdConfig dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [base64 base64EncodedStringWithOptions:0];


    NSString *urlString = [NSString stringWithFormat:@"%@%@", [jsInfo objectForKey:@"change_h5_url"], base64String];

    NSURL *mallUrl = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:mallUrl
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:30];
    [_webView loadRequest:request];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [self customStatusBar];
    // 注册退出商城的方法，供js调用(在viewWillAppear中添加，在viewWillDisappear中释放)
    [_webView.configuration.userContentController addScriptMessageHandler:self name:@"jcLogoutMall"];
    [_webView.configuration.userContentController addScriptMessageHandler:self name:@"jcOpenPay"];
    [_webView.configuration.userContentController addScriptMessageHandler:self name:@"jcSaveQrcode"];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"jcLogoutMall"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"jcOpenPay"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"jcSaveQrcode"];
//    [self systemStatusBar];
}
// 实现js中的alert
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    completionHandler();
}

// 实现H5中的<a target="_blank" />
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    NSURL *url = navigationAction.request.URL;
    [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
    return nil;
}

// js调用oc的统一入口
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    NSLog(@"方法名:%@", message.name);
    NSLog(@"参数:%@", message.body);

    NSString *methods = [NSString stringWithFormat:@"%@:", message.name];
    SEL selector = NSSelectorFromString(methods);
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:message.body];
    } else {
        NSLog(@"未实现方法：%@", message.name);
    }
}

// 实现供js调用的方法
-(void)jcLogoutMall:(id _Nonnull)body {
    [self.navigationController popViewControllerAnimated:YES];
}

// js通知oc打开第三方支付
-(void)jcOpenPay:(id _Nonnull)body {
    
    
    if([@"wechat" isEqualToString:body[@"payWay"]])
    {
        NSURL * url = [NSURL URLWithString:@"weixin://"];
        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
        if (canOpen) {
            
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
        else
        {
            [NormalUse showToastView:@"您的设备未安装微信" view:self.view];
        }
    }
    else
    {
        NSURL * url = [NSURL URLWithString:@"alipay://"];
        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
        if (canOpen) {

            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];

        }
        else
        {
            [NormalUse showToastView:@"您的设备未安装支付宝" view:self.view];
        }
    }
}

// js通知oc保存图片
-(void)jcSaveQrcode:(id _Nonnull)body {
    NSString *string = body[@"qrcode"];
    NSLog(@"imag:%@",string);
    NSData *decodeData = [[NSData alloc]initWithBase64EncodedString:string options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    // 将NSData转为UIImage
    UIImage *qrcodeImage = [UIImage imageWithData: decodeData];
    UIImageWriteToSavedPhotosAlbum(qrcodeImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
// 保存图片结果
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo
{
    if (error == nil) {
        NSLog(@"保存成功");
        
        [NormalUse showToastView:@"已保存到相册" view:self.view];
    }
    else{
        [NormalUse showToastView:@"保存失败，请检查应用是否设置了保存图片限制" view:self.view];
    }
}
@end
