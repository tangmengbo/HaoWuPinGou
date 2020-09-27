//
//  EditDianPuShangPinListViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/27.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "EditDianPuShangPinListViewController.h"
#import "JingJiRenBianJiListCell.h"

@interface EditDianPuShangPinListViewController ()<UITableViewDelegate,UITableViewDataSource,JingJiRenBianJiListCellDelegate>

@property(nonatomic,strong)NSMutableArray * selectArray;

@property(nonatomic,strong)UITableView * mainTableView;

@end

@implementation EditDianPuShangPinListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    
    self.topTitleLale.text = @"编辑信息";
    [self.rightButton setTitle:@"删除" forState:UIControlStateNormal];
    
    self.selectArray = [NSMutableArray array];

    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    
    
}
-(void)leftClick
{
    NSArray *temArray = self.navigationController.viewControllers;

    for(UIViewController *temVC in temArray)
    {
        if ([temVC isKindOfClass:[JingJiRenDianPuDetailViewController class]])
        {
            [self.navigationController popToViewController:temVC animated:YES];
        }
    }


}
-(void)rightClick
{
    if (![NormalUse isValidArray:self.selectArray]) {
        
        [NormalUse showToastView:@"请选择要删除的信息" view:self.view];
        return;
        
    }
    NSString * idStr = [self.selectArray objectAtIndex:0];
    for (int i=1; i<self.selectArray.count; i++) {
        
        idStr = [[idStr stringByAppendingString:@"|"] stringByAppendingString:[self.selectArray objectAtIndex:i]];
    }
    [NormalUse showMessageLoadView:@"删除中..." vc:self];
    [HTTPModel jingJiRenShanChuTieZi:[[NSDictionary alloc]initWithObjectsAndKeys:idStr,@"post_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse removeMessageLoadingView:self];

        if (status==1) {
            
            [NormalUse showToastView:@"删除成功" view:self.view];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self leftClick];
            });
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
    int cellNumber;
    if (self.artist_list.count%2==0) {
        
        cellNumber = (int)self.artist_list.count/2;
    }
    else
    {
        cellNumber = (int)self.artist_list.count/2+1;
    }
    return cellNumber;


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  202*BiLiWidth;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"JingJiRenBianJiListCell"] ;
    JingJiRenBianJiListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[JingJiRenBianJiListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if ((indexPath.row+1)*2<=self.artist_list.count) {
        
        [cell initData:[self.artist_list objectAtIndex:indexPath.row*2] info2:[self.artist_list objectAtIndex:indexPath.row*2+1]];
    }
    else
    {
        [cell initData:[self.artist_list objectAtIndex:indexPath.row*2] info2:nil];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma matk--JingJiRenBianJiListCellDelegate
-(void)itemSelect:(NSString *)selectIdStr
{
    BOOL alsoHave = NO;
    for (NSString * idStr  in self.selectArray) {
        
        if ([selectIdStr isEqualToString:idStr]) {
            alsoHave = YES;
            break;
        }
    }
    if (alsoHave) {
        
        [self.selectArray removeObject:selectIdStr];
    }
    else
    {
        [self.selectArray addObject:selectIdStr];
    }
    NSLog(@"%@",self.selectArray);
}
@end
