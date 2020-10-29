//
//  HomeWebViewController.h
//  NotesProject
//
//  Created by tangMeng on 2017/5/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebViewController : MainBaseViewController

@property(nonatomic,strong)WKWebView * webView;

@property(nonatomic,strong)NSString * titleStr;

@property(nonatomic,strong)NSString * url;


@end
