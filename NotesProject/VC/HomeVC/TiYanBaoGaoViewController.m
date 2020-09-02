//
//  TiYanBaoGaoViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "TiYanBaoGaoViewController.h"

@interface TiYanBaoGaoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel * locationLable;

@property(nonatomic,strong)UITableView * mainTableView;



@end

@implementation TiYanBaoGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    self.topTitleLale.text = @"体验报告";
    self.topTitleLale.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.lineView.hidden = YES;
    
    page = 0;
    
    UIImageView * locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-11*BiLiWidth-55*BiLiWidth, (self.topNavView.height-14*BiLiWidth)/2, 11*BiLiWidth, 14*BiLiWidth)];
    locationImageView.image = [UIImage imageNamed:@"home_location"];
    [self.topNavView addSubview:locationImageView];
    
    self.locationLable = [[UILabel alloc] initWithFrame:CGRectMake(locationImageView.left+locationImageView.width+5*BiLiWidth, locationImageView.top, 50*BiLiWidth, locationImageView.height)];
    self.locationLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.locationLable.adjustsFontSizeToFitWidth = YES;
    self.locationLable.textColor = RGBFormUIColor(0x333333);
    self.locationLable.text = @"深圳市";
    [self.topNavView addSubview:self.locationLable];

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
-(void)loadNewLsit
{
    page = 0;
    [HTTPModel getTiYanBaoGaoList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
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
    [HTTPModel getTiYanBaoGaoList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
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
    NSString *tableIdentifier = [NSString stringWithFormat:@"TiYanBaoGaoCell"] ;
    TiYanBaoGaoCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[TiYanBaoGaoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    [cell contentViewSetData:[self.sourceArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TiYanBaoGaoDetailViewController * vc = [[TiYanBaoGaoDetailViewController alloc] init];
    vc.info = [self.sourceArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
