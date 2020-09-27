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

@property(nonatomic,strong)UIView * tipKuangView;

@end

@implementation DingZhiFuWuViewController

-(UIView *)tipKuangView
{
    if (!_tipKuangView) {
        
        _tipKuangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _tipKuangView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self.view addSubview:_tipKuangView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-253*BiLiWidth)/2, 287*BiLiWidth, 253*BiLiWidth)];
        kuangImageView.backgroundColor = RGBFormUIColor(0xFFFFFF);
        kuangImageView.layer.cornerRadius = 8*BiLiWidth;
        kuangImageView.layer.masksToBounds = YES;
        kuangImageView.userInteractionEnabled = YES;
        [_tipKuangView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [_tipKuangView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"提示";
        [kuangImageView addSubview:tipLable1];
        
        UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 40*BiLiWidth)];
        tipLable2.font = [UIFont systemFontOfSize:12*BiLiWidth];
        tipLable2.textColor = RGBFormUIColor(0x343434);
        tipLable2.numberOfLines = 0;
        [kuangImageView addSubview:tipLable2];
        
        NSString * neiRongStr  = @"什么是定制服务：\n定制服务为用户提供个性化需求，用户可根据自己的喜好以及时间来发布自己的需求，发布完成后可展示在需求大厅，经纪人、女神、外围等来解锁信息。\n定制服务的发布规则：\n 1、定制服务为用户发布需求，有经纪人、女神、外围等解锁信息，解锁后可联系发帖的用户提供服务。\n 2、定制服务的发布需要支付相应的费用，发布之后不可修改和删除\n 3、定制服务特殊需求尽量描述详细，如是否需要提供上门服务等。";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
        tipLable2.attributedText = attributedString;
        [tipLable2  sizeToFit];

        UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable2.top+tipLable2.height+20*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 40*BiLiWidth)];
        [sureButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:sureButton];
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = sureButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [sureButton.layer addSublayer:gradientLayer1];
        
        UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sureButton.width, sureButton.height)];
        sureLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        sureLable.text = @"确定";
        sureLable.textAlignment = NSTextAlignmentCenter;
        sureLable.textColor = [UIColor whiteColor];
        [sureButton addSubview:sureLable];
        
        kuangImageView.height = sureButton.top+sureButton.height+20*BiLiWidth;
        kuangImageView.top = (HEIGHT_PingMu-kuangImageView.height)/2;
        closeButton.top = kuangImageView.top-33*BiLiWidth/3;
    }
    return _tipKuangView;
}

-(void)closeTipKuangView
{
    self.tipKuangView.hidden = YES;
}
-(void)showTiShiKuang
{
    self.tipKuangView.hidden = NO;
}
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
    tipImageView.image = [UIImage imageNamed:@"dingZhiFuWu_tip"];
    [self.view addSubview:tipImageView];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(tipImageView.left+tipImageView.width+5*BiLiWidth, topImageView.top+topImageView.height, 200*BiLiWidth, 45*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0x999999);
    tipLable.text = @"什么是定制服务？";
    [self.view addSubview:tipLable];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(tipImageView.left, tipImageView.top-10*BiLiWidth, 200*BiLiWidth, 34*BiLiWidth)];
    [button addTarget:self action:@selector(showTiShiKuang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    

    
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
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
    
    DingZhiFuWuDetailViewController * vc = [[DingZhiFuWuDetailViewController alloc] init];
    NSNumber * idNumber = [info objectForKey:@"id"];
    vc.idStr = [NSString stringWithFormat:@"%d",idNumber.intValue];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --UIButtonClick
-(void)createDingZhiFuWu
{
    CreateDingZhiFuWuViewController * vc = [[CreateDingZhiFuWuViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
