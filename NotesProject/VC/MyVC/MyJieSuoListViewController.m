//
//  MyJieSuoListViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/11.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyJieSuoListViewController.h"
#import "MyJieSuoListCell.h"

@interface MyJieSuoListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
}
@property(nonatomic,strong)UIButton * tieZiButton;
@property(nonatomic,strong)UIButton * jingJiRenButton;
@property(nonatomic,strong)UIButton * nvShenButton;
@property(nonatomic,strong)UIButton * waiWeiRenButton;
@property(nonatomic,strong)UIButton * peiWanRenButton;
@property(nonatomic,strong)UIButton * dingZhiFuWuButton;


@property(nonatomic,strong)NSMutableArray * sourceArray;
@property(nonatomic,strong)UITableView * tableView;


@end

@implementation MyJieSuoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"全部解锁";
    
    self.sourceArray = [NSMutableArray array];
    [self yinCangTabbar];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    //1经纪人 2茶小二 3女神 4外围 5全球陪玩 6定制服务
    
    MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = mjHeader;
    [self.tableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreList)];
    self.tableView.mj_footer = mjFooter;

}
-(void)loadNewLsit
{
    
    page = 1;
    [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"page",@"2",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            [self.sourceArray removeAllObjects];
            self->page++;
            NSArray * array = [responseObject objectForKey:@"data"];
            if (array.count>=10) {
                
                [self.tableView.mj_footer endRefreshing];
            }
            else
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            for (NSDictionary * info in array) {
                
                [self.sourceArray addObject:info];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
}

-(void)loadMoreList
{
    [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"page",@"1",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSArray * array = [responseObject objectForKey:@"data"];
            if (array.count>=10) {
                
                [self.tableView.mj_footer endRefreshing];
            }
            else
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            for (NSDictionary * info in array) {
                
                [self.sourceArray addObject:info];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
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
    NSString *tableIdentifier = [NSString stringWithFormat:@"MyJieSuoListCell"] ;
    MyJieSuoListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[MyJieSuoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell contentViewSetData:[self.sourceArray objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
