//
//  HeiDianBaoGuangViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HeiDianBaoGuangViewController.h"

@interface HeiDianBaoGuangViewController ()

<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView * mainTableView;

@end

@implementation HeiDianBaoGuangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    self.topTitleLale.text = @"黑店曝光";
    self.topTitleLale.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.lineView.hidden = YES;

    [self.rightButton setTitle:@"发布" forState:UIControlStateNormal];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height+10*BiLiWidth))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tag = 1002;
    [self.view addSubview:self.mainTableView];
    
    MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mainTableView.mj_header = mjHeader;
    [self.mainTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreList)];
    self.mainTableView.mj_footer = mjFooter;
    
}
-(void)rightClick
{
    CreateHeiDianBaoGuangViewController * vc = [[CreateHeiDianBaoGuangViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)loadNewLsit
{
    page = 1;
    [HTTPModel getHeiDianList:[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
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
    }];
}
-(void)loadMoreList
{
    [HTTPModel getHeiDianList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
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
    NSString *tableIdentifier = [NSString stringWithFormat:@"HomeListCellCell"] ;
    HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[HomeListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    [cell contentViewSetData:[self.sourceArray objectAtIndex:indexPath.row] cellType:HeiDianBaoGuang];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
    HeiDianDetailViewController * vc = [[HeiDianDetailViewController alloc] init];
    NSString * idStr = [info objectForKey:@"id"];
    vc.idStr = idStr;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
