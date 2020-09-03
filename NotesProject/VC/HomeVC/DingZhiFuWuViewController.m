//
//  DingZhiFuWuViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "DingZhiFuWuViewController.h"
#import "DingZhiFuWuTableViewCell.h"

@interface DingZhiFuWuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
}

@property(nonatomic,strong)UILabel * locationLable;

@property(nonatomic,strong)NSMutableArray * sourceArray;

@property(nonatomic,strong)UITableView * mainTableView;

@end

@implementation DingZhiFuWuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 180*BiLiWidth)];
    topImageView.image = [UIImage imageNamed:@"banner_dingZhiFuWu"];
    topImageView.userInteractionEnabled = YES;
    [self.view addSubview:topImageView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createDingZhiFuWu)];
    [topImageView addGestureRecognizer:tap];
    
    

    self.backImageView.frame = CGRectMake(self.backImageView.left, (self.topNavView.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.backImageView.image = [UIImage imageNamed:@"white_back"];
    self.topNavView.backgroundColor = [UIColor clearColor];
    [topImageView addSubview:self.topNavView];
    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21*BiLiWidth, topImageView.top+topImageView.height+(45-14.5)*BiLiWidth/2, 14.5*BiLiWidth, 14.5*BiLiWidth)];
    tipImageView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:tipImageView];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(tipImageView.left+tipImageView.width+5*BiLiWidth, topImageView.top+topImageView.height, 200*BiLiWidth, 45*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0xDDDDDD);
    tipLable.text = @"什么是定制服务？";
    [self.view addSubview:tipLable];
    

    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tipLable.height+tipLable.top, WIDTH_PingMu, HEIGHT_PingMu-(tipLable.height+tipLable.top))];
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
    [HTTPModel getDingZhiList:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [self.mainTableView.mj_header endRefreshing];
        self->page = self->page+1;
        if (status==1) {
            
            NSArray * array = [responseObject objectForKey:@"data"];
            self.sourceArray = [[NSMutableArray alloc] initWithArray:array];
            if (array.count>=10) {
                
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
-(void)loadMoreList
{
    [HTTPModel getDingZhiList:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [self.mainTableView.mj_footer endRefreshing];
        
        self->page = self->page+1;
        if (status==1) {
            
            NSArray * array = [responseObject objectForKey:@"data"];
            if (array.count>=10) {
                
                [self.mainTableView.mj_footer endRefreshing];
            }
            else
            {
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            for (NSDictionary * info in array) {
                
                [self.sourceArray addObject:info];
            }
            [self.mainTableView reloadData];
            
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];

}

#pragma mark UItableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return  [DingZhiFuWuTableViewCell cellHegiht:[self.sourceArray objectAtIndex:indexPath.row]];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"DingZhiFuWuTableViewCell"] ;
    DingZhiFuWuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[DingZhiFuWuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    [cell contentViewSetData:[self.sourceArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark --UIButtonClick
-(void)createDingZhiFuWu
{
    CreateDingZhiFuWuViewController * vc = [[CreateDingZhiFuWuViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
