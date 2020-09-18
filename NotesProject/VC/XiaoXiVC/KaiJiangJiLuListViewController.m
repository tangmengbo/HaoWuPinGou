//
//  GouMaiJiLuViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/26.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "KaiJiangJiLuListViewController.h"
#import "KaiJiagJiLuListCell.h"

@interface KaiJiangJiLuListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * mainTableView;
@property(nonatomic,strong)NSArray * sourceArray;

@end

@implementation KaiJiangJiLuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"开奖记录";
    
    [self yinCangTabbar];
    
    UIButton * qiShuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu/3, 60*BiLiWidth)];
    [qiShuButton setTitle:@"开奖期数" forState:UIControlStateNormal];
    [qiShuButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    qiShuButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.view addSubview:qiShuButton];
    
    UIButton * timeButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/3, self.topNavView.top+self.topNavView.height, WIDTH_PingMu/3, 60*BiLiWidth)];
    [timeButton setTitle:@"开奖时间" forState:UIControlStateNormal];
    [timeButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    timeButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.view addSubview:timeButton];

    UIButton * jiangChiButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/3*2, self.topNavView.top+self.topNavView.height, WIDTH_PingMu/3, 60*BiLiWidth)];
    [jiangChiButton setTitle:@"奖池" forState:UIControlStateNormal];
    [jiangChiButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    jiangChiButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.view addSubview:jiangChiButton];

    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, jiangChiButton.top+jiangChiButton.height, WIDTH_PingMu, HEIGHT_PingMu-(jiangChiButton.top+jiangChiButton.height))style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];

    
    self.showOrHiddenCellArray = [NSMutableArray array];
    [HTTPModel getKaiJingList:nil
                     callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        self.sourceArray = responseObject;
        
        for (int i=0; i<self.sourceArray.count; i++) {
            
            [self.showOrHiddenCellArray addObject:@"1"]; //@"1" 隐藏 0 展示
        }
        [self.mainTableView reloadData];
    }];
}

#pragma mark UItableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sourceArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([@"1" isEqualToString:[self.showOrHiddenCellArray objectAtIndex:(int)section]])
    {
        return 0;
    }
    else
    {
        return 1;

    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([@"1" isEqualToString:[self.showOrHiddenCellArray objectAtIndex:(int)indexPath.section]])
    {
        return 0;
    }
    else
    {
        return  [KaiJiagJiLuListCell getCellHeight:[self.sourceArray objectAtIndex:(int)indexPath.section]];

    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"KaiJiagJiLuListCell%d",indexPath.section] ;
    KaiJiagJiLuListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[KaiJiagJiLuListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.selectedBackgroundView.backgroundColor = RGBFormUIColor(0xF4F4F4);
    
    NSDictionary * info = [self.sourceArray objectAtIndex:(int)indexPath.section];

    [cell initData:info];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        
    return 34.5*BiLiWidth;
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 34.5*BiLiWidth)];
    headerView.tag = section;
    
    UILabel * qiShuLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu/3, 34.5*BiLiWidth)];
    qiShuLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    qiShuLable.textColor = RGBFormUIColor(0x666666);
    qiShuLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:qiShuLable];
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu/3, 0, WIDTH_PingMu/3, 34.5*BiLiWidth)];
    timeLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    timeLable.textColor = RGBFormUIColor(0x666666);
    timeLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:timeLable];

    Lable_ImageButton * jiangChiButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/3*2, 0, WIDTH_PingMu/3, 34.5*BiLiWidth)];
    jiangChiButton.button_lable.frame = CGRectMake(30*BiLiWidth, 0, 60*BiLiWidth,jiangChiButton.height);
    jiangChiButton.button_lable.textAlignment = NSTextAlignmentCenter;
    jiangChiButton.button_lable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    jiangChiButton.button_lable.textColor = RGBFormUIColor(0x666666);
    jiangChiButton.button_imageView.frame = CGRectMake(jiangChiButton.button_lable.left+jiangChiButton.button_lable.width+6*BiLiWidth, (jiangChiButton.height-5.5*BiLiWidth)/2, 10*BiLiWidth, 5.5*BiLiWidth);
    [headerView addSubview:jiangChiButton];
    
    if([@"1" isEqualToString:[self.showOrHiddenCellArray objectAtIndex:section]])
    {
        jiangChiButton.button_imageView.image  = [UIImage imageNamed:@"kaiJiang_Xia"];
    }
    else
    {
        jiangChiButton.button_imageView.image  = [UIImage imageNamed:@"kaiJiang_Shang"];

    }


    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 34.5*BiLiWidth-1, WIDTH_PingMu, 1)];
    lineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [headerView addSubview:lineView];

    
    UIButton  * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
    button.tag = section;
    [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    
    NSDictionary * info = [self.sourceArray objectAtIndex:(int)section];
    qiShuLable.text = [info objectForKey:@"periods"];
    timeLable.text = [info objectForKey:@"draw_time"];
    NSNumber * base_coin = [info objectForKey:@"base_coin"];
    jiangChiButton.button_lable.text = [NSString stringWithFormat:@"%d",base_coin.intValue];



    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
    KaiJiangDetailViewController * vc = [[KaiJiangDetailViewController alloc] init];
    vc.idNumber = [info objectForKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tapAction:(UIButton *)button{
    
    
    if ([[self.showOrHiddenCellArray objectAtIndex:(int)button.tag] isEqualToString:@"0"]) {
        
        [self.showOrHiddenCellArray replaceObjectAtIndex:(int)button.tag withObject:@"1"];
    }else{
        [self.showOrHiddenCellArray replaceObjectAtIndex:(int)button.tag withObject:@"0"];
        
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:button.tag];
    [self.mainTableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}
@end
