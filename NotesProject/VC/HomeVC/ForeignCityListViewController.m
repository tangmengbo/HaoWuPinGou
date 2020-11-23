//
//  ForeignCityListViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/11/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "ForeignCityListViewController.h"

@interface ForeignCityListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray * hotCityList;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSMutableDictionary * sourceInfo;

@property(nonatomic,strong)NSMutableArray * keyArray;


@end

@implementation ForeignCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"选择城市";
    [self yinCangTabbar];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height+10*BiLiWidth))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
//    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    self.mainTableView.sectionIndexColor = RGBFormUIColor(0xFF0877);//修改右边索引字体的颜色
    [self.view addSubview:self.mainTableView];

    
    [HTTPModel getHotCityList:[[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"fromWhere", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1)
        {
            self.hotCityList = responseObject;

            
            [HTTPModel getCityList:[[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"fromWhere", nil]
                          callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                
                if (status==1) {
                    
                    NSMutableArray * hotArray = [[NSMutableArray alloc] initWithArray:self.hotCityList];
                    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"全部",@"cityName",@"-1001",@"cityCode", nil];
                    [hotArray insertObject:dic atIndex:0];


                    self.sourceInfo = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
                    NSArray * keyArray = [responseObject allKeys];
                    self.keyArray = [[NSMutableArray alloc] initWithArray:[keyArray sortedArrayUsingSelector:@selector(compare:)]];
                    [self.keyArray insertObject:@"热门" atIndex:0];
                    [self.sourceInfo setValue:hotArray forKey:@"热门"];
                    [self.mainTableView reloadData];
                    
                }
            }];

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
    if (section==0) {
       
        return 1;
    }
    else
    {
        NSString * keyStr = [self.keyArray objectAtIndex:section];
        NSArray *  cityNameArray = [self.sourceInfo objectForKey:keyStr];
        return cityNameArray.count;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        
        NSString * keyStr = [self.keyArray objectAtIndex:indexPath.section];
        NSArray *  cityNameArray = [self.sourceInfo objectForKey:keyStr];
        return  [ForeignCityListCell cellHegiht:cityNameArray];

    }
    else
    {
        return 40*BiLiWidth;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"ForeignCityListCell"] ;
        ForeignCityListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[ForeignCityListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
        NSString * keyStr = [self.keyArray objectAtIndex:indexPath.section];
        NSArray *  cityNameArray = [self.sourceInfo objectForKey:keyStr];
        [cell initContentView:cityNameArray];
        return cell;

    }
    else
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"UITableViewCell"] ;
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
        cell.textLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        return cell;

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section!=0) {
        
        NSString * keyStr = [self.keyArray objectAtIndex:indexPath.section];
        NSArray *  cityNameArray = [self.sourceInfo objectForKey:keyStr];
        NSDictionary * info = [cityNameArray objectAtIndex:indexPath.row];
        [self.delegate foreignCitySelect:info];
        [self.navigationController popViewControllerAnimated:YES];

    }
}
#pragma mark--
-(void)cityButtonSelect:(NSDictionary *)info
{
    [self.delegate foreignCitySelect:info];
    [self.navigationController popViewControllerAnimated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 50*BiLiWidth;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 50*BiLiWidth)];
        headerView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        
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
