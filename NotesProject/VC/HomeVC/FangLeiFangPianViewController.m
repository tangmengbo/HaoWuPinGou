//
//  FangLeiFangPianViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "FangLeiFangPianViewController.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "FangLeiFangPianDetailViewController.h"

@interface FangLeiFangPianViewController ()

@property(nonatomic,strong)NSArray * sourceArray;



@end

@implementation FangLeiFangPianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self yinCangTabbar];
    self.topTitleLale.text = @"防雷防骗";
    self.topTitleLale.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.lineView.hidden = YES;
    
    [NormalUse xianShiGifLoadingView:self];
    [HTTPModel getArticleList:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse quXiaoGifLoadingView:self];
        if (status==1) {
            
            self.sourceArray = responseObject;
            
            for (int i=0; i<self.sourceArray.count; i++) {
                
                NSDictionary * info = [self.sourceArray objectAtIndex:i];
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, self.topNavView.top+self.topNavView.height+10*BiLiWidth+129*BiLiWidth*i, WIDTH_PingMu-25*BiLiWidth, 110*BiLiWidth)];
                button.tag =  i;
                [button sd_setBackgroundImageWithURL:[NSURL URLWithString:[HTTP_REQUESTURL stringByAppendingString:[NormalUse getobjectForKey:[info objectForKey:@"show_cover_pic"]]]] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
                
            }
            
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
        
    }];
    
}
-(void)buttonClick:(UIButton *)button
{
    NSDictionary * info = [self.sourceArray objectAtIndex:button.tag];
    FangLeiFangPianDetailViewController * vc = [[FangLeiFangPianDetailViewController alloc] init];
    vc.info = info;
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
