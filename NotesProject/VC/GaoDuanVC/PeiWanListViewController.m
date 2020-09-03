//
//  PeiWanListViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/3.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "PeiWanListViewController.h"

@interface PeiWanListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
}

@property(nonatomic,strong)NSMutableArray * sourceArray;
@property(nonatomic,strong)UITableView * mainTableView;

@end

@implementation PeiWanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sourceArray = [NSMutableArray array];
    
    page = 1;
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu-(TopHeight_PingMu+58*BiLiWidth+BottomHeight_PingMu))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    
    MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mainTableView.mj_header = mjHeader;
    [self.mainTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreList)];
    self.mainTableView.mj_footer = mjFooter;
}
-(void)loadNewLsit
{
    page = 0;
    [HTTPModel getSanDaGirlList:[[NSDictionary alloc]initWithObjectsAndKeys:@"3",@"type_id",[NSString stringWithFormat:@"%d",page],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self->page++;
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            [self.mainTableView.mj_header endRefreshing];
            if (dataArray.count>=10) {
                
                [self.mainTableView.mj_footer endRefreshing];
            }
            else
            {
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }
            self.sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.mainTableView reloadData];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
    
}
-(void)loadMoreList
{
    [HTTPModel getSanDaGirlList:[[NSDictionary alloc]initWithObjectsAndKeys:@"3",@"type_id",[NSString stringWithFormat:@"%d",page],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self->page++;
            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary * info in dataArray) {
                
                [self.sourceArray addObject:info];
            }
            if (dataArray.count>=10) {
                
                [self.mainTableView.mj_footer endRefreshing];
            }
            else
            {
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.mainTableView reloadData];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
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
    
    return  144*BiLiWidth+17*BiLiWidth;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"NvShenListTableViewCell"] ;
    NvShenListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[NvShenListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    [cell contentViewSetData:[self.sourceArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TieZiDetailViewController * vc = [[TieZiDetailViewController alloc] init];
//    vc. = [self.sourceArray objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
