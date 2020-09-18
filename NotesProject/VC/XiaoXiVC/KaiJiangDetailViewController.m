//
//  KaiJiangDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/26.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "KaiJiangDetailViewController.h"

@interface KaiJiangDetailViewController ()

@end

@implementation KaiJiangDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"开奖详情";
    
    [HTTPModel getKaiJingDetail:[[NSDictionary alloc]initWithObjectsAndKeys:self.idNumber,@"id", nil]
                       callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
    }];
    
    
}



@end
