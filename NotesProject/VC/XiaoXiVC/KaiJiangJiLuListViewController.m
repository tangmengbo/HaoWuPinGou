//
//  GouMaiJiLuViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/26.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "KaiJiangJiLuListViewController.h"

@interface KaiJiangJiLuListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * mainTableView;
@property(nonatomic,strong)NSArray * sourceArray;

@end

@implementation KaiJiangJiLuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"开奖记录";
    
    [self yinCangTabbar];
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height+10*BiLiWidth))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];

    
    [HTTPModel getKaiJingList:nil
                     callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        self.sourceArray = responseObject;
        [self.mainTableView reloadData];
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
    NSString *tableIdentifier = [NSString stringWithFormat:@"UITableViewCell"] ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.selectedBackgroundView.backgroundColor = RGBFormUIColor(0xF4F4F4);
    
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];

    cell.textLabel.text = [info objectForKey:@"periods"];
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
