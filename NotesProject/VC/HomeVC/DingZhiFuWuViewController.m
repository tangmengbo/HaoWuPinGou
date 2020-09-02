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
    //某个角圆角
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:topImageView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8*BiLiWidth, 8*BiLiWidth)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = topImageView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    topImageView.layer.mask = maskLayer;

//    UIImageView * locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-11*BiLiWidth-55*BiLiWidth, (self.topNavView.height-14*BiLiWidth)/2, 11*BiLiWidth, 14*BiLiWidth)];
//    locationImageView.image = [UIImage imageNamed:@"home_location"];
//    [self.topNavView addSubview:locationImageView];
//
//    self.locationLable = [[UILabel alloc] initWithFrame:CGRectMake(locationImageView.left+locationImageView.width+5*BiLiWidth, locationImageView.top, 50*BiLiWidth, locationImageView.height)];
//    self.locationLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
//    self.locationLable.adjustsFontSizeToFitWidth = YES;
//    self.locationLable.textColor = RGBFormUIColor(0xFFFFFF);
//    self.locationLable.text = @"深圳市";
//    [self.topNavView addSubview:self.locationLable];

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
    
    self.sourceArray = [NSMutableArray array];
    NSDictionary * info = [[NSDictionary alloc] initWithObjectsAndKeys:@"昂克赛拉登记卡SD卡三块多,撒发大水打撒",@"message", nil];
    NSDictionary * info1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"奥施康定哈就是大家都哈大家啊就是订单几哈飒飒大",@"message", nil];
    NSDictionary * info2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"暗杀教室的骄傲的氨基酸的哈上架到经安徽省大家啊黄金道士爱神的箭哈就是大阿萨德很骄傲姜思达爱神的箭哈圣诞节啊",@"message", nil];
    [self.sourceArray addObject:info];
    [self.sourceArray addObject:info1];
    [self.sourceArray addObject:info2];

    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tipLable.height+tipLable.top, WIDTH_PingMu, HEIGHT_PingMu-(tipLable.height+tipLable.top))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];


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
