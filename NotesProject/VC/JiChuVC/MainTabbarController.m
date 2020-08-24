//
//  SJTabBarController.m
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/10/10.
//  Copyright © 2015年 唐蒙波. All rights reserved.
//

#import "MainTabbarController.h"


@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    for(UIView *view in self.view.subviews){

        if([view isKindOfClass:[UITabBar class]]){

            view.hidden = YES;

            break;

        }
    }
    [self initTabBar];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unreadMessCount:) name:UnReaderMesCount object:nil];

}
//获取到礼物通知执行动画
-(void)unreadMessCount:(NSNotification *)notification
{
    
    NSString * unReadCount = [notification object];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (unReadCount.intValue<=0) {
            self.unReadMesLable.hidden = YES;
            
        }
        else
        {
            self.unReadMesLable.hidden = NO;
            self.unReadMesLable.text = unReadCount;
            if (unReadCount.length<2) {
                self.unReadMesLable.frame = CGRectMake(self.unReadMesLable.frame.origin.x, self.unReadMesLable.frame.origin.y, 15, 15);
            }
            else
            {
                self.unReadMesLable.frame = CGRectMake(self.unReadMesLable.frame.origin.x, self.unReadMesLable.frame.origin.y, 20, 15);
            }
        }
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].applicationIconBadgeNumber = unReadCount.intValue;
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initTabBar
{
    self.tabBar.backgroundColor = [UIColor clearColor];
    //设置为半透明
    self.tabBarController.tabBar.alpha = 0;
    
    self.bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu-(BottomHeight_PingMu),WIDTH_PingMu ,BottomHeight_PingMu)];
    self.bottomView.userInteractionEnabled = YES;
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 0.5)];
    lineView.backgroundColor = RGBFormUIColor(0x333333);
    lineView.alpha = 0.2;
    [self.bottomView addSubview:lineView];
    
    self.tab1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu/5, 49)];
    self.tab1.tag = 0;
    [self.tab1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    self.tab1.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:self.tab1];
    
    self.img1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.tab1.frame.size.width-22)/2, 5, 22, 22)];
    self.img1.image = [UIImage imageNamed:@"tab_home_h"];
    [self.tab1 addSubview:self.img1];
    
    self.lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.img1.top+self.img1.height+5, self.tab1.width, 11)];
    self.lab1.font = [UIFont systemFontOfSize:11*BiLiWidth];
    self.lab1.textColor = RGBFormUIColor(0x333333);
    self.lab1.text = @"首页";
    self.lab1.textAlignment = NSTextAlignmentCenter;
    [self.tab1 addSubview:self.lab1];
    
    self.tab2 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/5, 0, WIDTH_PingMu/5, self.tab1.height)];
    self.tab2.tag = 1;
    [self.tab2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    self.tab2.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:self.tab2];
    
    self.img2 = [[UIImageView alloc] initWithFrame:CGRectMake((self.tab2.frame.size.width-22)/2, self.img1.top, 22, 22)];
    self.img2.image = [UIImage imageNamed:@"tab_gaoDuan_n"];
    [self.tab2 addSubview:self.img2];
    
    self.lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.lab1.top, self.tab1.width, 11)];
    self.lab2.font = [UIFont systemFontOfSize:11];
    self.lab2.textColor = RGBFormUIColor(0xDDDDDD);
    self.lab2.text = @"高端";
    self.lab2.textAlignment = NSTextAlignmentCenter;
    [self.tab2 addSubview:self.lab2];

    

    self.tab3 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/5*2, 0, WIDTH_PingMu/5, self.tab1.height)];
    self.tab3.tag = 2;
    [self.tab3 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    self.tab3.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:self.tab3];
    
    self.img3 = [[UIImageView alloc] initWithFrame:CGRectMake((self.tab3.frame.size.width-25)/2, 6, 25, 20)];
    self.img3.image = [UIImage imageNamed:@"tab_fuQiJiao_n"];
    [self.tab3 addSubview:self.img3];
    
    self.lab3 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.lab1.top, self.tab1.width, 11)];
    self.lab3.font = [UIFont systemFontOfSize:11];
    self.lab3.textColor = RGBFormUIColor(0xDDDDDD);
    self.lab3.text = @"夫妻交";
    self.lab3.textAlignment = NSTextAlignmentCenter;
    [self.tab3 addSubview:self.lab3];

    
    
    self.tab4 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/5*3, 0, WIDTH_PingMu/5, self.tab1.height)];
    self.tab4.tag = 3;
    [self.tab4 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    self.tab4.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:self.tab4];
    
    
    self.img4 = [[UIImageView alloc] initWithFrame:CGRectMake((self.tab3.frame.size.width-22)/2, self.img1.top, 22, 22)];
    self.img4.image = [UIImage imageNamed:@"tab_xiaoXi_n"];//[UIImage imageNamed:@"woDe_tab_n"];
    [self.tab4 addSubview:self.img4];
    
    self.lab4 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.lab1.top, self.tab1.width, 11)];
    self.lab4.font = [UIFont systemFontOfSize:11];
    self.lab4.textColor = RGBFormUIColor(0xDDDDDD);
    self.lab4.text = @"消息";
    self.lab4.textAlignment = NSTextAlignmentCenter;
    [self.tab4 addSubview:self.lab4];

    
    self.unReadMesLable = [[UILabel alloc] initWithFrame:CGRectMake(self.tab1.frame.size.width/2+7, 5, 20, 15)];
    self.unReadMesLable.textColor = [UIColor whiteColor];
    self.unReadMesLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
    self.unReadMesLable.textAlignment = NSTextAlignmentCenter;
    self.unReadMesLable.layer.cornerRadius = 15/2;
    self.unReadMesLable.layer.masksToBounds = YES;
    self.unReadMesLable.hidden = YES;
    self.unReadMesLable.backgroundColor = [UIColor redColor];
    [self.tab4 addSubview:self.unReadMesLable];
    
    self.tab5 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/5*4, 0, WIDTH_PingMu/5, self.tab1.height)];
    self.tab5.tag = 4;
    [self.tab5 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    self.tab5.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:self.tab5];
    
    self.img5 = [[UIImageView alloc] initWithFrame:CGRectMake((self.tab3.frame.size.width-22)/2, self.img1.top, 22, 22)];
    self.img5.image = [UIImage imageNamed:@"tab_my_n"];
    [self.tab5 addSubview:self.img5];
    
    self.lab5 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.lab1.top, self.tab1.width, 11)];
    self.lab5.font = [UIFont systemFontOfSize:11];
    self.lab5.textColor = RGBFormUIColor(0xDDDDDD);
    self.lab5.text = @"我的";
    self.lab5.textAlignment = NSTextAlignmentCenter;
    [self.tab5 addSubview:self.lab5];

}

-(void)selectButton:(id)sender
{
    UIButton * button = (UIButton *)sender;
    [self resetTabbarContent:(int)button.tag];
}
-(void)setItemSelected:(int)index
{
    [self resetTabbarContent:index];
}
-(void)resetTabbarContent:(int)index
{
    if (index ==0)
    {
        self.selectedIndex = 0;
        self.img1.image = [UIImage imageNamed:@"tab_home_h"];
        self.img2.image = [UIImage imageNamed:@"tab_gaoDuan_n"];
        self.img3.image = [UIImage imageNamed:@"tab_fuQiJiao_n"];
        self.img4.image = [UIImage imageNamed:@"tab_xiaoXi_n"];
        self.img5.image = [UIImage imageNamed:@"tab_my_n"];
        
        self.lab1.textColor = RGBFormUIColor(0x333333);
        self.lab2.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab3.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab4.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab5.textColor = RGBFormUIColor(0xDDDDDD);

        
        
    }
    else if (index ==1)
    {
        self.selectedIndex = 1;
        
        self.img1.image = [UIImage imageNamed:@"tab_home_n"];
        self.img2.image = [UIImage imageNamed:@"tab_gaoDuan_h"];
        self.img3.image = [UIImage imageNamed:@"tab_fuQiJiao_n"];
        self.img4.image = [UIImage imageNamed:@"tab_xiaoXi_n"];
        self.img5.image = [UIImage imageNamed:@"tab_my_n"];
        
        self.lab1.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab2.textColor = RGBFormUIColor(0x333333);
        self.lab3.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab4.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab5.textColor = RGBFormUIColor(0xDDDDDD);


    }
    else if (index ==2)
    {
        self.selectedIndex = 2;
        
        self.img1.image = [UIImage imageNamed:@"tab_home_n"];
        self.img2.image = [UIImage imageNamed:@"tab_gaoDuan_n"];
        self.img3.image = [UIImage imageNamed:@"tab_fuQiJiao_h"];
        self.img4.image = [UIImage imageNamed:@"tab_xiaoXi_n"];
        self.img5.image = [UIImage imageNamed:@"tab_my_n"];
        
        self.lab1.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab2.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab3.textColor = RGBFormUIColor(0x333333);
        self.lab4.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab5.textColor = RGBFormUIColor(0xDDDDDD);


    }
    else if (index ==3)
    {
        self.selectedIndex = 3;
        self.img1.image = [UIImage imageNamed:@"tab_home_n"];
        self.img2.image = [UIImage imageNamed:@"tab_gaoDuan_n"];
        self.img3.image = [UIImage imageNamed:@"tab_fuQiJiao_n"];
        self.img4.image = [UIImage imageNamed:@"tab_xiaoXi_h"];
        self.img5.image = [UIImage imageNamed:@"tab_my_n"];
        
        self.lab1.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab2.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab3.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab4.textColor = RGBFormUIColor(0x333333);
        self.lab5.textColor = RGBFormUIColor(0xDDDDDD);


    }
    else if (index==4)
    {
        self.selectedIndex = 4;
        self.img1.image = [UIImage imageNamed:@"tab_home_n"];
        self.img2.image = [UIImage imageNamed:@"tab_gaoDuan_n"];
        self.img3.image = [UIImage imageNamed:@"tab_fuQiJiao_n"];
        self.img4.image = [UIImage imageNamed:@"tab_xiaoXi_n"];
        self.img5.image = [UIImage imageNamed:@"tab_my_h"];
        
        self.lab1.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab2.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab3.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab4.textColor = RGBFormUIColor(0xDDDDDD);
        self.lab5.textColor = RGBFormUIColor(0x333333);

    }
 
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
