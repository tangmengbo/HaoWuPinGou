//
//  GouMaiJiLuListViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/26.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GouMaiJiLuListViewController.h"
#import "GouMaiJiLuCell.h"

@interface GouMaiJiLuListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * mainTableView;
@property(nonatomic,strong)NSArray * sourceArray;

@end

@implementation GouMaiJiLuListViewController

-(UIImageView *)noMessageTipImageView
{
    if (!_noMessageTipImageView) {
        
        _noMessageTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, WIDTH_PingMu*1280/720)];
        _noMessageTipImageView.image = [UIImage imageNamed:@"NoMessageTip"];
        
    }
    return _noMessageTipImageView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"购买记录";
    
    [self yinCangTabbar];
    
    UIButton * qiShuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu/4, 50*BiLiWidth)];
    [qiShuButton setTitle:@"开奖期数" forState:UIControlStateNormal];
    [qiShuButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    qiShuButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.view addSubview:qiShuButton];
    
    UIButton * timeButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/4, self.topNavView.top+self.topNavView.height, WIDTH_PingMu/4, 50*BiLiWidth)];
    [timeButton setTitle:@"开奖时间" forState:UIControlStateNormal];
    [timeButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    timeButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.view addSubview:timeButton];

    UIButton * duiHuanMaButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/4*2, self.topNavView.top+self.topNavView.height, WIDTH_PingMu/4, 50*BiLiWidth)];
    [duiHuanMaButton setTitle:@"兑换号码" forState:UIControlStateNormal];
    [duiHuanMaButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    duiHuanMaButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.view addSubview:duiHuanMaButton];
    
    UIButton * resultButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/4*3, self.topNavView.top+self.topNavView.height, WIDTH_PingMu/4, 50*BiLiWidth)];
    [resultButton setTitle:@"开奖结果" forState:UIControlStateNormal];
    [resultButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    resultButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.view addSubview:resultButton];


    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, resultButton.top+resultButton.height, WIDTH_PingMu, HEIGHT_PingMu-(resultButton.top+resultButton.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    
    [HTTPModel getBuyList:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        self.sourceArray = responseObject;
        [self.mainTableView reloadData];
        
        if (![NormalUse isValidArray:self.sourceArray]) {
            
            [self.mainTableView addSubview:self.noMessageTipImageView];
        }
        
    }];
}

#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  40*BiLiWidth;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"GouMaiJiLuCell"] ;
    GouMaiJiLuCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[GouMaiJiLuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
    [cell initData:info];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
    KaiJiangDetailViewController * vc = [[KaiJiangDetailViewController alloc] init];
    vc.idNumber = [info objectForKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
