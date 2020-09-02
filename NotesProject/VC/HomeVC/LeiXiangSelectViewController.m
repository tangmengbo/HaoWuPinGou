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
    
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    
    float originx = 12*BiLiWidth;
    float originy = 30*BiLiWidth;
    float xDisTance =  10*BiLiWidth;
    float yDistance = 20*BiLiWidth;
    self.buttonArray = [NSMutableArray array];
    self.selectButtonArray = [NSMutableArray array];
    
    for (int i=0; i<self.sourceArray.count; i++) {
        
        NSString * leiXingStr = [self.sourceArray objectAtIndex:i];
        
        CGSize size = [NormalUse setSize:leiXingStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
        
        if (originx+size.width+8*BiLiWidth>WIDTH_PingMu-12*BiLiWidth) {
            
            originx = 12*BiLiWidth;
            originy = originy+20*BiLiWidth+yDistance;
        }
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originx, self.topNavView.top+self.topNavView.height+originy,size.width+8*BiLiWidth , 20*BiLiWidth)];
        [button setTitle:leiXingStr forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
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
    }
    else
    {
        NSLog(@"%d",(int)selectButton.tag);
        [self.selectButtonArray addObject:selectButton];
        [selectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }
}
-(void)rightClick
{
    if (self.selectButtonArray.count==0) {
        
        [NormalUse showToastView:@"请选择类型" view:self.view];
    }
    UIButton * button = [self.selectButtonArray objectAtIndex:0];
    NSString * str = [self.sourceArray objectAtIndex:button.tag];
    
    for (int i=1; i<self.selectButtonArray.count; i++) {
        
        UIButton * button = [self.selectButtonArray objectAtIndex:i];
        
        str = [[str stringByAppendingString:@","] stringByAppendingString:[self.sourceArray objectAtIndex:button.tag]];
    }
    [self.delegate itemSelected:str type:self.type];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
