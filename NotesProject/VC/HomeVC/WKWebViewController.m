//
//  HomeWebViewController.m
//  NotesProject
//
//  Created by tangMeng on 2017/5/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "WKWebViewController.h"

@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation WKWebViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.topNavView.frame.origin.y+self.topNavView.frame.size.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.frame.origin.y+self.topNavView.frame.size.height))];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]]];
    [self.view addSubview: self.webView];
    
    self.webView.UIDelegate = self;
    // 导航代理
    self.webView.navigationDelegate = self;
    if ([NormalUse isValidString:self.titleStr]) {
        
        self.topTitleLale.text = self.titleStr;
    }
    
    
    self.webView.backgroundColor = [UIColor whiteColor];
    
    
    [self.webView loadRequest:request];
    
    
    
    
    [NormalUse xianShiGifLoadingView:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)leftClick
{
//    if (self.webView.canGoBack) {
//
//        [self.webView goBack];
//
//    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
 //   }
}
#pragma mark -- WKNavigationDelegate
/*
 WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
 */

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [NormalUse quXiaoGifLoadingView:self];
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}
// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self yinCangTabbar];
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
