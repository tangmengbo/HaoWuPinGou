//
//  HeiDianDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/28.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HeiDianDetailViewController.h"

@interface HeiDianDetailViewController ()

@end

@implementation HeiDianDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HTTPModel getHeiDianDetail:[[NSDictionary alloc]initWithObjectsAndKeys:self.idStr,@"id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            
            NSLog(@"%@",responseObject);
            
        }
    }];
    
}


@end
