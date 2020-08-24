//
//  GetCountryInfoViewController.m
//  NotesProject
//
//  Created by 唐蒙波 on 2019/12/19.
//  Copyright © 2019 Meng. All rights reserved.
//

#import "GetCountryInfoViewController.h"

@interface GetCountryInfoViewController ()
@end

@implementation GetCountryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topNavView.hidden = YES;
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    bottomImageView.image = [UIImage imageNamed:@"flash"];
    bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
    bottomImageView.autoresizingMask = UIViewAutoresizingNone;
    bottomImageView.clipsToBounds = YES;
    [self.view addSubview:bottomImageView];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2127141352,1757417748&fm=26&gp=0.jpg"]];
    [self.view addSubview:imageView];
    
    
    [HTTPModel getCityList:nil
                  callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
    }];
    

    [HTTPModel login:[[NSDictionary alloc]initWithObjectsAndKeys:@"15829782534",@"mobile",@"123456",@"password", nil]
            callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
    }];
}

@end
