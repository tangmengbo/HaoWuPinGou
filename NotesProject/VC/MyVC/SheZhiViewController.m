//
//  SettingViewController.m
//  SheQu
//
//  Created by 周璟琳 on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SheZhiViewController.h"

@interface SheZhiViewController ()

@property(nonatomic,strong)UIScrollView * mainScrollView;


@end

@implementation SheZhiViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"Settings";
    self.topTitleLale.alpha = 0.9;

    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topNavView.frame.origin.y+self.topNavView.frame.size.height, WIDTH_PingMu, HEIGHT_PingMu)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];


    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, bottomView.frame.origin.y+ 5*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(bottomView.frame.origin.y+5*BiLiWidth))];
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, HEIGHT_PingMu+20)];
    [self.view addSubview:self.mainScrollView];

 
    
    UIButton * shouShiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 15*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    [shouShiButton addTarget:self action:@selector(shouShiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    shouShiButton.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:shouShiButton];
    
    UILabel * restoringLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, (45*BiLiWidth-17*BiLiWidth)/2, 15*BiLiWidth*10, 17*BiLiWidth)];
    restoringLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    restoringLable.textColor = [UIColor blackColor];
    restoringLable.alpha = 0.9;
    restoringLable.text = @"设置手势密码";
    [shouShiButton addSubview:restoringLable];
    
    UIImageView * shouShiLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-(12+18)*BiLiWidth, (45*BiLiWidth-18*BiLiWidth)/2, 18*BiLiWidth, 18*BiLiWidth)];
    shouShiLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [shouShiButton addSubview:shouShiLeftImageView];

    
    UIButton * tuiChuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, shouShiButton.frame.origin.y+shouShiButton.frame.size.height+15*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    tuiChuButton.backgroundColor = [UIColor whiteColor];
    [tuiChuButton addTarget:self action:@selector(tuiChuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:tuiChuButton];
    
    UILabel * exitLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, (45*BiLiWidth-17*BiLiWidth)/2, 15*BiLiWidth*4.5, 17*BiLiWidth)];
    exitLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    exitLable.textColor = [UIColor blackColor];
    exitLable.alpha = 0.9;
    exitLable.text = @"Log out";
    [tuiChuButton addSubview:exitLable];
    
    
    UIImageView * exitLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-(12+18)*BiLiWidth, (45*BiLiWidth-18*BiLiWidth)/2, 18*BiLiWidth, 18*BiLiWidth)];
    exitLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [tuiChuButton addSubview:exitLeftImageView];
    
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, tuiChuButton.frame.origin.y+tuiChuButton.frame.size.height+50*BiLiWidth)];
}

-(void)shouShiButtonClick
{
    SetShouShiMiMaViewController * vc = [[SetShouShiMiMaViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)tuiChuButtonClick
{
    
    __weak typeof(self) wself = self;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Log out" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * exit = [UIAlertAction actionWithTitle:@"Log out" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [wself LoginOut];
             
    }];
    [alert addAction:cancle];
    [alert addAction:exit];
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)LoginOut
{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate setWeiDengLuTabBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self yinCangTabbar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
