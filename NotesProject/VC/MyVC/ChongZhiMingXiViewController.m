//
//  ChongZhiMingXiViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "ChongZhiMingXiViewController.h"
#import "ChongZhiMingXiCell.h"

@interface ChongZhiMingXiViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * mainTableView;
@property(nonatomic,strong)NSMutableArray * sourceArray;
@property(nonatomic,strong)UIImageView * noMessageTipImageView;

@end

@implementation ChongZhiMingXiViewController

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

    self.topTitleLale.text = @"充值明细";
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tag = 0;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.showsHorizontalScrollIndicator = NO;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainTableView];
    
    MJRefreshNormalHeader * header1 = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [HTTPModel getXiaoXiMessageList:[[NSDictionary alloc]initWithObjectsAndKeys:@"0",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
//                self.sourceArray = [responseObject objectForKey:@"data"];
//
//                if (![NormalUse isValidArray:self.sourceArray]) {
                    
                    [self.mainTableView addSubview:self.noMessageTipImageView];
//                }
//                else
//                {
//                    [self.noMessageTipImageView removeFromSuperview];
//                }
                [self.mainTableView reloadData];
                [self.mainTableView.mj_header endRefreshing];

            }
        }];

    }];
    header1.lastUpdatedTimeLabel.hidden = YES;
    self.mainTableView.mj_header = header1;
    [self.mainTableView.mj_header beginRefreshing];

}

#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
    return self.sourceArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 94.5*BiLiWidth;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"ChongZhiMingXiCell"] ;
    ChongZhiMingXiCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[ChongZhiMingXiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    [cell initData:info];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
@end
