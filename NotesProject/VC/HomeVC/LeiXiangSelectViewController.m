//
//  LeiXiangSelectViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/31.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "LeiXiangSelectViewController.h"

@interface LeiXiangSelectViewController ()

@property(nonatomic,strong)NSMutableArray * buttonArray;
@property(nonatomic,strong)NSMutableArray * selectButtonArray;

@end

@implementation LeiXiangSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([@"meizi" isEqualToString:self.type]) {
        
        self.topTitleLale.text = @"妹子类型";
    }
    else if([@"fuwu" isEqualToString:self.type])
    {
        self.topTitleLale.text = @"服务类型";

    }
    else if ([@"xinxi" isEqualToString:self.type])
    {
        self.topTitleLale.text = @"信息类型";

    }
    
    
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    self.buttonArray = [NSMutableArray array];
    self.selectButtonArray = [NSMutableArray array];
    
    if ([@"meizi" isEqualToString:self.type]) {
        
        [HTTPModel getXiaoJieLeiXing:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self.sourceArray = responseObject;
                
                [self initView];
            }
            
        }];
        

    }
    else if ([@"fuwu" isEqualToString:self.type])
    {
        [HTTPModel getFuWuLeiXing:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self.sourceArray = responseObject;
                [self initView];
            }

        }];

    }
    else if ([@"xinxi" isEqualToString:self.type])
    {
        [HTTPModel getXinXiLeiXing:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self.sourceArray = responseObject;
                [self initView];
            }

        }];

    }

}
-(void)initView
{
 
    float originx = 12*BiLiWidth;
    float originy = 30*BiLiWidth;
    float xDisTance =  10*BiLiWidth;
    float yDistance = 20*BiLiWidth;

    for (int i=0; i<self.sourceArray.count; i++) {
        
        NSString * leiXingStr = [self.sourceArray objectAtIndex:i];
        
        CGSize size = [NormalUse setSize:leiXingStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
        
        if (originx+size.width+20*BiLiWidth>WIDTH_PingMu-12*BiLiWidth) {
            
            originx = 12*BiLiWidth;
            originy = originy+40*BiLiWidth+yDistance;
        }
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originx, self.topNavView.top+self.topNavView.height+originy,size.width+20*BiLiWidth , 40*BiLiWidth)];
        [button setTitle:leiXingStr forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [button setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
        button.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        button.tag=i;
        button.layer.cornerRadius = 20*BiLiWidth;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        originx = originx+button.width+xDisTance;
        
    }

}
-(void)buttonClick:(UIButton *)selectButton
{
    BOOL alsoHave = NO;
    
    for (UIButton * button in self.selectButtonArray) {
        
        if (button.tag==selectButton.tag) {
            alsoHave = YES;
            break;
        }
    }
    if (alsoHave) {
        
        [self.selectButtonArray removeObject:selectButton];
        [selectButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [selectButton setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
    }
    else
    {
        NSLog(@"%d",(int)selectButton.tag);
        [self.selectButtonArray addObject:selectButton];
        [selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [selectButton setBackgroundColor:RGBFormUIColor(0x333333)];

        
    }
}
-(void)rightClick
{
    if (self.selectButtonArray.count==0) {
        
        [NormalUse showToastView:@"请选择类型" view:self.view];
        return;
    }
    UIButton * button = [self.selectButtonArray objectAtIndex:0];
    NSString * str = [self.sourceArray objectAtIndex:button.tag];
    
    for (int i=1; i<self.selectButtonArray.count; i++) {
        
        UIButton * button = [self.selectButtonArray objectAtIndex:i];
        
        str = [[str stringByAppendingString:@"|"] stringByAppendingString:[self.sourceArray objectAtIndex:button.tag]];
    }
    [self.delegate itemSelected:str type:self.type];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
