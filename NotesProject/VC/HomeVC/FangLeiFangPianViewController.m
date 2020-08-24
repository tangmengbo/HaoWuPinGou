//
//  FangLeiFangPianViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "FangLeiFangPianViewController.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface FangLeiFangPianViewController ()



@end

@implementation FangLeiFangPianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topTitleLale.text = @"防雷防骗";
    self.topTitleLale.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.lineView.hidden = YES;
    
    NSArray * array = [[NSArray alloc] initWithObjects:@"1",@"1", nil];
    
    for (int i=0; i<array.count; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, self.topNavView.top+self.topNavView.height+10*BiLiWidth+129*BiLiWidth*i, WIDTH_PingMu-25*BiLiWidth, 110*BiLiWidth)];
        button.tag =  i;
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597827992453&di=89f2d23d41e7e650adec139e15eb8688&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];

    }
    
    
    
}
-(void)buttonClick:(UIButton *)button
{
    
}


@end
