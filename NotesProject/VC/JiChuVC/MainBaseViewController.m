//
//  BaseViewController.m
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/9/14.
//  Copyright (c) 2015年 唐蒙波. All rights reserved.
//

#import "MainBaseViewController.h"
#import "UIImage+GIF.h"

@interface MainBaseViewController ()

@property (nonatomic,strong)MainTabbarController * rootBar;
@property (nonatomic,strong)UILabel * tipLable;
@property (nonatomic,strong)UIView * loadingView;
@property (nonatomic,strong)UIView * loadingBottomView;


@end

@implementation MainBaseViewController

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.rootBar = delegate.tabbar;
    
    self.statusBarView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 20)];
    self.statusBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.statusBarView];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.topNavView = [[UIView alloc] initWithFrame:CGRectMake(0, TopHeight_PingMu, WIDTH_PingMu, 44)];
    self.topNavView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topNavView];
    
    
    self.topTitleLale = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 44)];
    self.topTitleLale.textColor = RGBFormUIColor(0x333333);
    self.topTitleLale.textAlignment = NSTextAlignmentCenter;
    self.topTitleLale.font = [UIFont systemFontOfSize:17*BiLiWidth];//[UIFont fontWithName:@"Helvetica-Bold" size:18*BiLiWidth];
    [self.topNavView addSubview:self.topTitleLale];
    
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,  0, 60, 40)];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.topNavView addSubview:self.leftButton];
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth, (44-18)/2, 18, 18)];
    self.backImageView.image = [UIImage imageNamed:@"btn_back_n"];
    [self.leftButton addSubview:self.backImageView];
    
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-40-10, 0, 50, 40)];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topNavView addSubview:self.rightButton];
    
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, WIDTH_PingMu, 0.5)];
    self.lineView.backgroundColor = [UIColor blackColor];
    self.lineView.alpha = 0.2;
    [self.topNavView addSubview:self.lineView];
    self.lineView.hidden = YES;
    
    self.loadingBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, TopHeight_PingMu+self.topNavView.frame.size.height, WIDTH_PingMu, HEIGHT_PingMu-60)];
    self.loadingBottomView.backgroundColor = [UIColor blackColor];
    self.loadingBottomView.alpha = 0.5;
    
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-200)/2, (HEIGHT_PingMu-60-80)/2, 200, 70)];
    self.loadingView.backgroundColor = [UIColor blackColor];
    self.loadingView.layer.cornerRadius = 10;
    self.loadingView.alpha = 0.8;
    
    if (@available(iOS 13.0, *))
    {
        UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activityView startAnimating];
        activityView.frame = CGRectMake(20, 25, 20, 20);
        [self.loadingView addSubview:activityView];
        
    } else {
        
        UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activityView startAnimating];
        activityView.frame = CGRectMake(20, 25, 20, 20);
        [self.loadingView addSubview:activityView];
    }
    
    self.tipLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 300, 70)];
    self.tipLable.text = @"Loading...";
    self.tipLable.textColor = [UIColor whiteColor];
    self.tipLable.font = [UIFont systemFontOfSize:15];
    [self.loadingView addSubview: self.tipLable];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (@available(iOS 13.0, *)) {
        
        UIColor * rightColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
                     if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) { //浅色模式
                         return [UIColor whiteColor];
                     } else { //深色模式
                         return [UIColor blackColor];
                     }
                 }];
        
        if (rightColor==[UIColor whiteColor]) {
            
            return UIStatusBarStyleDefault;
        }
        else
        {
            return UIStatusBarStyleDarkContent;

        }
    }
    else
    {
        return UIStatusBarStyleDefault;

    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightClick
{
    
}
-(void)xianShiLoadingView:(NSString *)message view:(UIView *)view
{
    if ([message isKindOfClass:[NSString class]]) {
        
        self.tipLable.text = message;
    }
    else
    {
        self.tipLable.text = @"Loading...";
    }
    self.tipLable.width = [NormalUse setSize:[NormalUse getobjectForKey: self.tipLable.text] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15].width;
    self.loadingBottomView.frame = CGRectMake(0, self.loadingBottomView.frame.origin.y, WIDTH_PingMu, HEIGHT_PingMu-self.loadingBottomView.frame.origin.y);
    
    if ([@"yes" isEqualToString:self.loadingFullScreen]) {
        
        self.loadingBottomView.frame = CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu);
    }
    [self.view addSubview:self.loadingBottomView];
    [self.view addSubview:self.loadingView];
}

-(void)yinCangLoadingView
{
    [self.loadingView removeFromSuperview];
    [self.loadingBottomView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)yinCangTabbar
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate yinCangTabbar];
}
-(void)xianShiTabBar
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate xianShiTabBar];
}



@end
