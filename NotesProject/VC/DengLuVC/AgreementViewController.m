//
//  AgreementViewController.m
//  SheQu
//
//  Created by BoBo on 2019/5/24.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.topTitleLale.text = @"YoYo user agreement";
    self.topTitleLale.alpha = 0.9;
    
    [self yinCangTabbar];
    
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.topNavView.frame.origin.y+self.topNavView.frame.size.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.frame.origin.y+self.topNavView.frame.size.height+40*BiLiWidth))];
    textView.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"KKXieYi"];
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:13*BiLiWidth];
    [self.view addSubview:textView];

    textView.frame = CGRectMake(0,self.topNavView.frame.origin.y+self.topNavView.frame.size.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.frame.origin.y+self.topNavView.frame.size.height));
}
-(void)agreeButtonClick
{
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
