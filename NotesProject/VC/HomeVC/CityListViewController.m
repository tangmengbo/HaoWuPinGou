//
//  CityListViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/24.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "CityListViewController.h"

@interface CityListViewController ()<UITableViewDelegate,UITableViewDataSource,CityListCellDelegate>

@property(nonatomic,strong)NSArray * hotCityList;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSMutableDictionary * sourceInfo;

@property(nonatomic,strong)NSMutableArray * keyArray;

@end

@implementation CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    self.topTitleLale.text = @"选择城市";
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height+10*BiLiWidth))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    self.mainTableView.sectionIndexColor = RGBFormUIColor(0xFF0877);//修改右边索引字体的颜色
    [self.view addSubview:self.mainTableView];

    self.hotCityList = [NormalUse defaultsGetObjectKey:@"HotCityListDefaults"];
    if ([NormalUse isValidArray:self.hotCityList]) {
        
        [self getCityList];
    }
    else
    {
        [HTTPModel getHotCityList:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                self.hotCityList = responseObject;
                [self getCityList];
            }
        }];

    }
    


}
-(void)getCityList
{
    [HTTPModel getCityList:nil
                  callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"全部",@"cityName",@"-1001",@"cityCode", nil];
            NSMutableArray * hotArray = [[NSMutableArray alloc] initWithArray:self.hotCityList];
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
#pragma mark UItableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.keyArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * keyStr = [self.keyArray objectAtIndex:indexPath.section];
    NSArray *  cityNameArray = [self.sourceInfo objectForKey:keyStr];

    return  [CityListCell cellHegiht:cityNameArray];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"CityListCell"] ;
    CityListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[CityListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    NSString * keyStr = [self.keyArray objectAtIndex:indexPath.section];
    NSArray *  cityNameArray = [self.sourceInfo objectForKey:keyStr];
    [cell initContentView:cityNameArray];
    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString * keyStr = [self.keyArray objectAtIndex:indexPath.section];
//    NSArray *  cityNameArray = [self.sourceInfo objectForKey:keyStr];
//    NSDictionary * info = [cityNameArray objectAtIndex:indexPath.row];
//    [self.delegate citySelect:info];
//    [self.navigationController popViewControllerAnimated:YES];
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        return 135*BiLiWidth;
    }
    else
    {
        return 50*BiLiWidth;

    }
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 135*BiLiWidth)];
        headerView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        
        UILabel * dangQianDingWeiLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BiLiWidth, 34*BiLiWidth, 200*BiLiWidth, 15*BiLiWidth)];
        dangQianDingWeiLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        dangQianDingWeiLable.textColor = RGBFormUIColor(0x333333);
        dangQianDingWeiLable.text = @"当前定位";
        [headerView addSubview:dangQianDingWeiLable];
        
        
        UIButton * dangQianWeiZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-135*BiLiWidth, 23*BiLiWidth, 85*BiLiWidth, 35*BiLiWidth)];
        [headerView addSubview:dangQianWeiZhiButton];
        [dangQianWeiZhiButton addTarget:self action:@selector(dangQianWeiZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = dangQianWeiZhiButton.bounds;
        gradientLayer1.cornerRadius = 35*BiLiWidth/2;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [dangQianWeiZhiButton.layer addSublayer:gradientLayer1];
        
        UILabel * cityLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dangQianWeiZhiButton.width, dangQianWeiZhiButton.height)];
        cityLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        cityLable.textAlignment = NSTextAlignmentCenter;
        cityLable.textColor = [UIColor whiteColor];
        [dangQianWeiZhiButton addSubview:cityLable];
        
        self.cityInfo = [NormalUse defaultsGetObjectKey:@"CityInfoDefaults"];
        
        if ([NormalUse isValidDictionary:self.cityInfo]) {
         
            cityLable.text = [self.cityInfo objectForKey:@"cityName"];
        }
        else
        {
            self.cityInfo = [NormalUse defaultsGetObjectKey:CurrentCity];
            cityLable.text = [self.cityInfo objectForKey:@"cityName"];
        }

        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(19*BiLiWidth, 80*BiLiWidth, WIDTH_PingMu-38*BiLiWidth, 1)];
        lineView.backgroundColor = [RGBFormUIColor(0x999999) colorWithAlphaComponent:0.5];
        [headerView addSubview:lineView];
        
        UILabel * guanFangTuiJianLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BiLiWidth, lineView.top+lineView.height, 200*BiLiWidth, 50*BiLiWidth)];
        guanFangTuiJianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17*BiLiWidth];
        guanFangTuiJianLable.textColor = RGBFormUIColor(0x333333);
        guanFangTuiJianLable.text = [self.keyArray objectAtIndex:section];
        [headerView addSubview:guanFangTuiJianLable];
        
        return headerView;

    }
    else
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
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    return nil;
}
-(void)dangQianWeiZhiButtonClick
{
    [self.delegate citySelect:self.cityInfo];
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)cityButtonSelect:(NSDictionary *)info
{
    [self.delegate citySelect:info];
    [self.navigationController popViewControllerAnimated:YES];

}
-(NSArray *)sectionIndexTitlesForTableView: (UITableView *)tableView {
    
    NSMutableArray *listTitles = [[NSMutableArray alloc] init];
    for (NSString *item in self.keyArray) {
        
          [listTitles addObject: item];
    }

    return listTitles;
}
@end
