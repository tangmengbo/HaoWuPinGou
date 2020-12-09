//
//  ChongZhiOrHuiYuanAlertView.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/12/9.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "ChongZhiOrHuiYuanAlertView.h"
#import "ZhangHuDetailViewController.h"

@implementation ChongZhiOrHuiYuanAlertView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu);
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UIImageView * contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-280*BiLiWidth)/2, (HEIGHT_PingMu-280*BiLiWidth/944*1050)/2, 280*BiLiWidth, 280*BiLiWidth/944*1050)];
        contentImageView.image = [UIImage imageNamed:@"yuEBuZu_TipImage"];
        contentImageView.userInteractionEnabled = YES;
        [self addSubview:contentImageView];
        
        UIButton* closeButton = [[UIButton alloc] initWithFrame:CGRectMake(contentImageView.left+contentImageView.width-20*BiLiWidth, contentImageView.top-20*BiLiWidth, 40*BiLiWidth, 40*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
        NSNumber * auth_vip = [NormalUse defaultsGetObjectKey:@"UserAlsoVip"];
        
        float distance = (contentImageView.width-40*BiLiWidth*330/132*2)/3;
        if (auth_vip.intValue!=0) {
            
            UIButton* chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(distance, contentImageView.height-60*BiLiWidth, 40*BiLiWidth*330/132, 40*BiLiWidth)];
            [chongZhiButton setBackgroundImage:[UIImage imageNamed:@"yuEBuZu_jinBi"] forState:UIControlStateNormal];
            [chongZhiButton addTarget:self action:@selector(chongZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [contentImageView addSubview:chongZhiButton];
            
            UIButton* vipButton = [[UIButton alloc] initWithFrame:CGRectMake(chongZhiButton.left+chongZhiButton.width+distance, chongZhiButton.top, 40*BiLiWidth*330/132, 40*BiLiWidth)];
            [vipButton setBackgroundImage:[UIImage imageNamed:@"yuEBuZu_vip"] forState:UIControlStateNormal];
            [vipButton addTarget:self action:@selector(vipButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [contentImageView addSubview:vipButton];


        }
        else
        {
            UIButton* chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake((contentImageView.width-40*BiLiWidth*330/132)/2, contentImageView.height-60*BiLiWidth, 40*BiLiWidth*330/132, 40*BiLiWidth)];
            [chongZhiButton setBackgroundImage:[UIImage imageNamed:@"yuEBuZu_jinBi"] forState:UIControlStateNormal];
            [chongZhiButton addTarget:self action:@selector(chongZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [contentImageView addSubview:chongZhiButton];

        }
        

    }
    return self;
}
-(void)chongZhiButtonClick
{
    ZhangHuDetailViewController * vc = [[ZhangHuDetailViewController alloc] init];
    [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];
    [self closeButtonClick];
}
-(void)vipButtonClick
{
    HuiYuanViewController * vc = [[HuiYuanViewController alloc] init];
    [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];
    [self closeButtonClick];

}
-(void)closeButtonClick
{
    [self removeFromSuperview];
}
-(void)uploadButtonClick
{
}

@end
