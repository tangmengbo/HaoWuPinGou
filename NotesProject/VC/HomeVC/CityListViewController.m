//
//  CityListViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/24.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "CityListViewController.h"

@interface CityListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSDictionary * sourceInfo;
@property(nonatomic,strong)NSArray * keyArray;

@end

@implementation CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height+10*BiLiWidth))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];

    
    [HTTPModel getCityList:nil
                  callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.sourceInfo = responseObject;
            NSArray * keyArray = [responseObject allKeys];
            self.keyArray = [keyArray sortedArrayUsingSelector:@selector(compare:)];
            [self.mainTableView reloadData];
        }
    }];


}
#pragma mark UItableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.keyArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * keyStr = [self.keyArray objectAtIndex:section];
    NSArray *  cityNameArray = [self.sourceInfo objectForKey:keyStr];

    return cityNameArray.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return  40*BiLiWidth;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"HomeListCellCell"] ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    NSString * keyStr = [self.keyArray objectAtIndex:indexPath.section];
    NSArray *  cityNameArray = [self.sourceInfo objectForKey:keyStr];
    NSDictionary * info = [cityNameArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [info objectForKey:@"cityName"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        
    return 50*BiLiWidth;
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 501*BiLiWidth+24*BiLiWidth)];
    headerView.backgroundColor = [UIColor whiteColor];
    //顶部轮播图
    //官方推荐
    UILabel * guanFangTuiJianLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, 0, 200*BiLiWidth, 50*BiLiWidth)];
    guanFangTuiJianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17*BiLiWidth];
    guanFangTuiJianLable.textColor = RGBFormUIColor(0x333333);
    guanFangTuiJianLable.text = [self.keyArray objectAtIndex:section];
    [headerView addSubview:guanFangTuiJianLable];
    
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

-(NSArray *)sectionIndexTitlesForTableView: (UITableView *)tableView {
    
    NSMutableArray *listTitles = [[NSMutableArray alloc] init];
    for (NSString *item in self.keyArray) {
        
          [listTitles addObject: item];
    }

    return listTitles;
}
@end
