//
//  MyFaBuViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/15.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyFaBuViewController.h"
#import "MyFaBu_XinXiCell.h"
#import "MyFaBu_DingZhiFuWuCell.h"
#import "MyFaBu_JiaoSeAndFuQiJiaoTieZiCell.h"
#import "SanDaJiaoSeDetailViewController.h"

@interface MyFaBuViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,CityListViewControllerDelegate>
{
    int xinXiPage;
    int nvShenTieZiPage;
    int waiWeiTieZiPage;
    int peiWanTieZiPage;
    int fuQiJiaoTieZiPage;
    int heiDianBaoGuangPage;
    int dingZhiFuWuPage;
    int yanZhengPage;
}

@property(nonatomic,strong)UIScrollView * topButtonScrollView;
@property(nonatomic,strong)NSMutableArray * topButtonArray;
@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSMutableArray * xinXiArray;
@property(nonatomic,strong)UITableView * xinXiTableView;

@property(nonatomic,strong)NSMutableArray * nvShenTieZiArray;
@property(nonatomic,strong)UITableView * nvShenTieZiTableView;

@property(nonatomic,strong)NSMutableArray * waiWeiTieZiArray;
@property(nonatomic,strong)UITableView * waiWeiTieZiTableView;

@property(nonatomic,strong)NSMutableArray * peiWanTieZiArray;
@property(nonatomic,strong)UITableView * peiWanTieZiTableView;

@property(nonatomic,strong)NSMutableArray * fuQiJiaoTieZiArray;
@property(nonatomic,strong)UITableView * fuQiJiaoTieZiTableView;


@property(nonatomic,strong)NSMutableArray * heiDianBaoGuangArray;
@property(nonatomic,strong)UITableView * heiDianBaoGuangTableView;

@property(nonatomic,strong)NSMutableArray * dingZhiFuWuArray;
@property(nonatomic,strong)UITableView * dingZhiFuWuTableView;


@property(nonatomic,strong)NSMutableArray * yanZhengArray;
@property(nonatomic,strong)UITableView * yanZhengTableView;

@property(nonatomic,strong)UIImageView * locationImageView;
@property(nonatomic,strong)UIButton * cityButton;
@property(nonatomic,strong)NSDictionary * cityInfo;



@end

@implementation MyFaBuViewController

-(void)cityButtonClick
{
    CityListViewController * vc = [[CityListViewController alloc] init];
    vc.delegate = self;
    vc.alsoFromHome = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)citySelect:(NSDictionary *)info
{
    self.cityInfo = info;
    [self.cityButton setTitle:[info objectForKey:@"cityName"] forState:UIControlStateNormal];
    CGSize  citySize = [NormalUse setSize:self.cityButton.titleLabel.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
    
    self.cityButton.width = citySize.width;
    self.cityButton.left = self.topNavView.width-citySize.width-10*BiLiWidth;
    self.locationImageView.left = self.cityButton.left-18*BiLiWidth;
    
    [self.xinXiTableView.mj_header beginRefreshing];
    [self.nvShenTieZiTableView.mj_header beginRefreshing];
    [self.waiWeiTieZiTableView.mj_header beginRefreshing];
    [self.peiWanTieZiTableView.mj_header beginRefreshing];
    [self.fuQiJiaoTieZiTableView.mj_header beginRefreshing];
    [self.heiDianBaoGuangTableView.mj_header beginRefreshing];
    [self.dingZhiFuWuTableView.mj_header beginRefreshing];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    self.xinXiArray = [NSMutableArray array];
    self.nvShenTieZiArray = [NSMutableArray array];
    self.waiWeiTieZiArray = [NSMutableArray array];
    self.peiWanTieZiArray = [NSMutableArray array];
    self.fuQiJiaoTieZiArray = [NSMutableArray array];
    self.heiDianBaoGuangArray = [NSMutableArray array];
    self.dingZhiFuWuArray = [NSMutableArray array];
    self.yanZhengArray = [NSMutableArray array];

    
    self.topTitleLale.text = @"我的发布";
    
    self.cityButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-100*BiLiWidth, (self.topNavView.height-12*BiLiWidth)/2, 90*BiLiWidth, 12*BiLiWidth)];
    [self.cityButton setTitle:@"全部" forState:UIControlStateNormal];
    [self.cityButton setTitleColor:RGBFormUIColor(0xFF0876) forState:UIControlStateNormal];
    self.cityButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.cityButton addTarget:self action:@selector(cityButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topNavView addSubview:self.cityButton];
    if ([NormalUse isValidDictionary:self.cityInfo]) {
        
        [self.cityButton setTitle:[self.cityInfo objectForKey:@"cityName"] forState:UIControlStateNormal];

    }
    CGSize  citySize = [NormalUse setSize:self.cityButton.titleLabel.text withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
    
    self.cityButton.width = citySize.width;
    self.cityButton.left = self.topNavView.width-citySize.width-10*BiLiWidth;
    
    self.locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.cityButton.left-18*BiLiWidth, self.cityButton.top-1*BiLiWidth, 11*BiLiWidth, 14*BiLiWidth)];
    self.locationImageView.image = [UIImage imageNamed:@"home_location"];
    [self.topNavView addSubview:self.locationImageView];

    
    self.topButtonArray = [NSMutableArray array];
    NSArray * array = [[NSArray alloc] initWithObjects:@"信息",@"女神",@"外围空降",@"全球陪玩",@"夫妻交友",@"黑店曝光",@"定制服务",@"验证", nil];
    
    self.topButtonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,self.topNavView.top+self.topNavView.height, WIDTH_PingMu, 50*BiLiWidth)];
    self.topButtonScrollView.showsVerticalScrollIndicator = NO;
    self.topButtonScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.topButtonScrollView];
    
    for (int i=0; i<array.count; i++) {
        
        
        UIButton * tieZiButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/4*i, 0, WIDTH_PingMu/4, 50*BiLiWidth)];
        [tieZiButton setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [tieZiButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        tieZiButton.tag = i;
        tieZiButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        [self.topButtonScrollView addSubview:tieZiButton];
        
        if (i==0) {
            
            [tieZiButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
            
            self.sliderView = [[UIView alloc] initWithFrame:CGRectMake((tieZiButton.width-53*BiLiWidth)/2,30*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
            self.sliderView.layer.cornerRadius = 7*BiLiWidth/2;
            self.sliderView.layer.masksToBounds = YES;
            self.sliderView.alpha = 0.8;
            [self.topButtonScrollView addSubview:self.sliderView];
            
            [self sliderViewSetJianBian];
            
        }
        else
        {
            [tieZiButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
            
        }
        [self.topButtonArray addObject:tieZiButton];
        
        [self.topButtonScrollView setContentSize:CGSizeMake(tieZiButton.left+tieZiButton.width+30*BiLiWidth, self.topButtonScrollView.height)];
    }
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topButtonScrollView.top+self.topButtonScrollView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topButtonScrollView.top+self.topButtonScrollView.height))];
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu*array.count, self.mainScrollView.height)];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.tag = 1001;
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    [self addXinXiTableView];
    [self addNvShenTieZiTableView];
    [self addWaiWeiTieZiTableView];
    [self addPeiWanTieZiTableView];
    [self addFuQiJiaoTieZiTableView];
    [self addHeiDianBaoGuangTableView];
    [self addDingZhiFuWuTableView];
    [self addYanZhengTableView];
    
    
}
-(void)sliderViewSetJianBian
{
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.sliderView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    [self.sliderView.layer addSublayer:gradientLayer];

}
-(void)topButtonClick:(UIButton *)selectButton
{
    for (UIButton * button in self.topButtonArray) {
        
        if (button.tag==selectButton.tag) {
            
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        }
        else
        {
            [button setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];

        }
    }
    [self.mainScrollView setContentOffset:CGPointMake(WIDTH_PingMu*selectButton.tag, 0)];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.sliderView.left = selectButton.left+(selectButton.width-self.sliderView.width)/2;

        
    } completion:^(BOOL finished) {

        
    }];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (scrollView.tag==1001) {
        
        int  specialIndex = scrollView.contentOffset.x/WIDTH_PingMu;
        
        UIButton * button = [self.topButtonArray objectAtIndex:specialIndex];
        [button sendActionsForControlEvents:UIControlEventTouchUpInside];
    }

}
-(void)addXinXiTableView
{
    //信息
    self.xinXiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.xinXiTableView.delegate = self;
    self.xinXiTableView.dataSource = self;
    self.xinXiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.xinXiTableView.tag = 0;
    [self.mainScrollView addSubview:self.xinXiTableView];
    
    __weak typeof(self)wself = self;
    

    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self->xinXiPage = 1;
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];

            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->xinXiPage] forKey:@"page"];
        [HTTPModel getMyXinXiList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            [wself.xinXiTableView.mj_header endRefreshing];

            if (status==1) {
                
                [wself.xinXiArray removeAllObjects];
                self->xinXiPage++;
                NSArray * array = [responseObject objectForKey:@"data"];
                
                if (![NormalUse isValidArray:array] || array.count==0) {
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.xinXiTableView.width, self.xinXiTableView.width*1280/720)];
                    imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                    [self.xinXiTableView addSubview:imageView];
                }

                
                if (array.count>=10) {
                    
                    [wself.xinXiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.xinXiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.xinXiArray addObject:info];
                }
                [wself.xinXiTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
            }
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.xinXiTableView.mj_header = header;
    [self.xinXiTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->xinXiPage] forKey:@"page"];

        [HTTPModel getMyXinXiList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self->xinXiPage++;
                
                NSArray * array = [responseObject objectForKey:@"data"];
                if (array.count>=10) {
                    
                    [wself.xinXiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.xinXiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.xinXiArray addObject:info];
                }
                [wself.xinXiTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
                [wself.xinXiTableView.mj_footer endRefreshing];

            }
        }];

    }];
    self.xinXiTableView.mj_footer = footer;

}
-(void)addNvShenTieZiTableView
{
    //信息
    self.nvShenTieZiTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.nvShenTieZiTableView.delegate = self;
    self.nvShenTieZiTableView.dataSource = self;
    self.nvShenTieZiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.nvShenTieZiTableView.tag = 1;
    [self.mainScrollView addSubview:self.nvShenTieZiTableView];
    
    __weak typeof(self)wself = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self->nvShenTieZiPage = 1;
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->nvShenTieZiPage] forKey:@"page"];
        [dic setObject:@"1" forKey:@"type_id"];

        [HTTPModel getJiaoSeFaTieList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            [wself.nvShenTieZiTableView.mj_header endRefreshing];

            if (status==1) {
                
                [wself.nvShenTieZiArray removeAllObjects];
                self->nvShenTieZiPage++;
                NSArray * array = [responseObject objectForKey:@"data"];
                
                if (![NormalUse isValidArray:array] || array.count==0) {
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.nvShenTieZiTableView.width, self.nvShenTieZiTableView.width*1280/720)];
                    imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                    [self.nvShenTieZiTableView addSubview:imageView];
                }

                
                if (array.count>=10) {
                    
                    [wself.nvShenTieZiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.nvShenTieZiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.nvShenTieZiArray addObject:info];
                }
                [wself.nvShenTieZiTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
            }
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.nvShenTieZiTableView.mj_header = header;
    [self.nvShenTieZiTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->nvShenTieZiPage] forKey:@"page"];
        [dic setObject:@"1" forKey:@"type_id"];

        [HTTPModel getJiaoSeFaTieList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self->nvShenTieZiPage++;
                
                NSArray * array = [responseObject objectForKey:@"data"];
                if (array.count>=10) {
                    
                    [wself.nvShenTieZiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.nvShenTieZiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.nvShenTieZiArray addObject:info];
                }
                [wself.nvShenTieZiTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
                [wself.nvShenTieZiTableView.mj_footer endRefreshing];

            }
        }];

    }];
    self.nvShenTieZiTableView.mj_footer = footer;

}

-(void)addWaiWeiTieZiTableView
{
    //信息
    self.waiWeiTieZiTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*2, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.waiWeiTieZiTableView.delegate = self;
    self.waiWeiTieZiTableView.dataSource = self;
    self.waiWeiTieZiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.waiWeiTieZiTableView.tag = 2;
    [self.mainScrollView addSubview:self.waiWeiTieZiTableView];
    
    __weak typeof(self)wself = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self->waiWeiTieZiPage = 1;
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->waiWeiTieZiPage] forKey:@"page"];
        [dic setObject:@"2" forKey:@"type_id"];

        [HTTPModel getJiaoSeFaTieList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            [wself.waiWeiTieZiTableView.mj_header endRefreshing];

            if (status==1) {
                
                [wself.waiWeiTieZiArray removeAllObjects];
                self->waiWeiTieZiPage++;
                NSArray * array = [responseObject objectForKey:@"data"];
                
                if (![NormalUse isValidArray:array] || array.count==0) {
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.waiWeiTieZiTableView.width, self.waiWeiTieZiTableView.width*1280/720)];
                    imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                    [self.waiWeiTieZiTableView addSubview:imageView];
                }

                
                if (array.count>=10) {
                    
                    [wself.waiWeiTieZiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.waiWeiTieZiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.waiWeiTieZiArray addObject:info];
                }
                [wself.waiWeiTieZiTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
            }
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.waiWeiTieZiTableView.mj_header = header;
    [self.waiWeiTieZiTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->waiWeiTieZiPage] forKey:@"page"];
        [dic setObject:@"2" forKey:@"type_id"];

        [HTTPModel getJiaoSeFaTieList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self->waiWeiTieZiPage++;
                
                NSArray * array = [responseObject objectForKey:@"data"];
                if (array.count>=10) {
                    
                    [wself.waiWeiTieZiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.waiWeiTieZiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.waiWeiTieZiArray addObject:info];
                }
                [wself.waiWeiTieZiTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
                [wself.waiWeiTieZiTableView.mj_footer endRefreshing];

            }
        }];

    }];
    self.waiWeiTieZiTableView.mj_footer = footer;

}
-(void)addPeiWanTieZiTableView{
    //信息
    self.peiWanTieZiTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*3, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.peiWanTieZiTableView.delegate = self;
    self.peiWanTieZiTableView.dataSource = self;
    self.peiWanTieZiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.peiWanTieZiTableView.tag = 3;
    [self.mainScrollView addSubview:self.peiWanTieZiTableView];
    
    __weak typeof(self)wself = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self->peiWanTieZiPage = 1;
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->peiWanTieZiPage] forKey:@"page"];
        [dic setObject:@"3" forKey:@"type_id"];

        [HTTPModel getJiaoSeFaTieList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            [wself.peiWanTieZiTableView.mj_header endRefreshing];

            if (status==1) {
                
                [wself.peiWanTieZiArray removeAllObjects];
                self->peiWanTieZiPage++;
                NSArray * array = [responseObject objectForKey:@"data"];
                
                if (![NormalUse isValidArray:array] || array.count==0) {
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.peiWanTieZiTableView.width, self.peiWanTieZiTableView.width*1280/720)];
                    imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                    [self.peiWanTieZiTableView addSubview:imageView];
                }

                
                if (array.count>=10) {
                    
                    [wself.peiWanTieZiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.peiWanTieZiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.peiWanTieZiArray addObject:info];
                }
                [wself.peiWanTieZiTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
            }
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.peiWanTieZiTableView.mj_header = header;
    [self.peiWanTieZiTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->peiWanTieZiPage] forKey:@"page"];
        [dic setObject:@"3" forKey:@"type_id"];

        [HTTPModel getJiaoSeFaTieList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self->peiWanTieZiPage++;
                
                NSArray * array = [responseObject objectForKey:@"data"];
                if (array.count>=10) {
                    
                    [wself.peiWanTieZiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.peiWanTieZiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.peiWanTieZiArray addObject:info];
                }
                [wself.peiWanTieZiTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
                [wself.peiWanTieZiTableView.mj_footer endRefreshing];

            }
        }];

    }];
    self.peiWanTieZiTableView.mj_footer = footer;

}
-(void)addFuQiJiaoTieZiTableView
{
    //信息
    self.fuQiJiaoTieZiTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*4, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.fuQiJiaoTieZiTableView.delegate = self;
    self.fuQiJiaoTieZiTableView.dataSource = self;
    self.fuQiJiaoTieZiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.fuQiJiaoTieZiTableView.tag = 4;
    [self.mainScrollView addSubview:self.fuQiJiaoTieZiTableView];
    
    __weak typeof(self)wself = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self->fuQiJiaoTieZiPage = 1;
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->fuQiJiaoTieZiPage] forKey:@"page"];

        [HTTPModel getFuQiJiaoFaTieList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            [wself.fuQiJiaoTieZiTableView.mj_header endRefreshing];

            if (status==1) {
                
                [wself.fuQiJiaoTieZiArray removeAllObjects];
                self->fuQiJiaoTieZiPage++;
                NSArray * array = [responseObject objectForKey:@"data"];
                
                if (![NormalUse isValidArray:array] || array.count==0) {
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.fuQiJiaoTieZiTableView.width, self.fuQiJiaoTieZiTableView.width*1280/720)];
                    imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                    [self.fuQiJiaoTieZiTableView addSubview:imageView];
                }

                
                if (array.count>=10) {
                    
                    [wself.fuQiJiaoTieZiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.fuQiJiaoTieZiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.fuQiJiaoTieZiArray addObject:info];
                }
                [wself.fuQiJiaoTieZiTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
            }
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.fuQiJiaoTieZiTableView.mj_header = header;
    [self.fuQiJiaoTieZiTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->fuQiJiaoTieZiPage] forKey:@"page"];

        
        [HTTPModel getFuQiJiaoFaTieList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self->fuQiJiaoTieZiPage++;
                
                NSArray * array = [responseObject objectForKey:@"data"];
                if (array.count>=10) {
                    
                    [wself.fuQiJiaoTieZiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.fuQiJiaoTieZiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.fuQiJiaoTieZiArray addObject:info];
                }
                [wself.fuQiJiaoTieZiTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
                [wself.fuQiJiaoTieZiTableView.mj_footer endRefreshing];

            }
        }];

    }];
    self.fuQiJiaoTieZiTableView.mj_footer = footer;

}

-(void)addHeiDianBaoGuangTableView
{
    //黑店曝光
    self.heiDianBaoGuangTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*5, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.heiDianBaoGuangTableView.delegate = self;
    self.heiDianBaoGuangTableView.dataSource = self;
    self.heiDianBaoGuangTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.heiDianBaoGuangTableView.tag = 5;
    [self.mainScrollView addSubview:self.heiDianBaoGuangTableView];
    
    __weak typeof(self)wself = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self->heiDianBaoGuangPage = 1;
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->heiDianBaoGuangPage] forKey:@"page"];

        
        [HTTPModel getMyHeiDianBaoGuangList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            [wself.heiDianBaoGuangTableView.mj_header endRefreshing];

            if (status==1) {
                
                [wself.heiDianBaoGuangArray removeAllObjects];
                self->heiDianBaoGuangPage++;
                NSArray * array = [responseObject objectForKey:@"data"];
                
                if (![NormalUse isValidArray:array] || array.count==0) {
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.heiDianBaoGuangTableView.width, self.heiDianBaoGuangTableView.width*1280/720)];
                    imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                    [self.heiDianBaoGuangTableView addSubview:imageView];
                }

                if (array.count>=10) {
                    
                    [wself.heiDianBaoGuangTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.heiDianBaoGuangTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.heiDianBaoGuangArray addObject:info];
                }
                [wself.heiDianBaoGuangTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
            }
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.heiDianBaoGuangTableView.mj_header = header;
    [self.heiDianBaoGuangTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidDictionary:self.cityInfo]) {
            NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
            if (cityCode.intValue!=-1001) {
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
            }
        }
        [dic setObject:[NSString stringWithFormat:@"%d",self->heiDianBaoGuangPage] forKey:@"page"];

        
        [HTTPModel getMyHeiDianBaoGuangList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->heiDianBaoGuangPage],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self->heiDianBaoGuangPage++;
                NSArray * array = [responseObject objectForKey:@"data"];
                if (array.count>=10) {
                    
                    [wself.heiDianBaoGuangTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.heiDianBaoGuangTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.heiDianBaoGuangArray addObject:info];
                }
                [wself.heiDianBaoGuangTableView reloadData];
            }
            else
            {
                [wself.heiDianBaoGuangTableView.mj_footer endRefreshing];

                [NormalUse showToastView:msg view:wself.view];
            }
        }];

    }];
    self.heiDianBaoGuangTableView.mj_footer = footer;

}
-(void)addDingZhiFuWuTableView
{
    //定制服务
    self.dingZhiFuWuTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*6, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.dingZhiFuWuTableView.delegate = self;
    self.dingZhiFuWuTableView.dataSource = self;
    self.dingZhiFuWuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dingZhiFuWuTableView.tag = 6;
    [self.mainScrollView addSubview:self.dingZhiFuWuTableView];
    
    __weak typeof(self)wself = self;
       
       MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
           self->dingZhiFuWuPage = 1;
           
           NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
           if ([NormalUse isValidDictionary:self.cityInfo]) {
               NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
               if (cityCode.intValue!=-1001) {
                   NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                   [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
               }
           }
           [dic setObject:[NSString stringWithFormat:@"%d",self->dingZhiFuWuPage] forKey:@"page"];

           [HTTPModel getMyDingZhiFuWuList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               [wself.dingZhiFuWuTableView.mj_header endRefreshing];

               if (status==1) {
                   
                   [wself.dingZhiFuWuArray removeAllObjects];
                   self->dingZhiFuWuPage++;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   
                   if (![NormalUse isValidArray:array] || array.count==0) {
                       
                       UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.dingZhiFuWuTableView.width, self.dingZhiFuWuTableView.width*1280/720)];
                       imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                       [self.dingZhiFuWuTableView addSubview:imageView];
                   }

                   if (array.count>=10) {
                       
                       [wself.dingZhiFuWuTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.dingZhiFuWuTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.dingZhiFuWuArray addObject:info];
                   }
                   [wself.dingZhiFuWuTableView reloadData];
               }
               else
               {
                   [NormalUse showToastView:msg view:wself.view];
               }
           }];
       }];
       header.lastUpdatedTimeLabel.hidden = YES;
       self.dingZhiFuWuTableView.mj_header = header;
       [self.dingZhiFuWuTableView.mj_header beginRefreshing];
       
       MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           
           NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
           if ([NormalUse isValidDictionary:self.cityInfo]) {
               NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
               if (cityCode.intValue!=-1001) {
                   NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                   [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
               }
           }
           [dic setObject:[NSString stringWithFormat:@"%d",self->dingZhiFuWuPage] forKey:@"page"];

           [HTTPModel getMyDingZhiFuWuList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               if (status==1) {
                   
                   self->dingZhiFuWuPage++;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   if (array.count>=10) {
                       
                       [wself.dingZhiFuWuTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.dingZhiFuWuTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.dingZhiFuWuArray addObject:info];
                   }
                   [wself.dingZhiFuWuTableView reloadData];
               }
               else
               {
                   [wself.dingZhiFuWuTableView.mj_footer endRefreshing];

                   [NormalUse showToastView:msg view:wself.view];
               }
           }];

       }];
       self.dingZhiFuWuTableView.mj_footer = footer;

}

-(void)addYanZhengTableView
{
    //验证
    self.yanZhengTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*7, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.yanZhengTableView.delegate = self;
    self.yanZhengTableView.dataSource = self;
    self.yanZhengTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.yanZhengTableView.tag = 7;
    [self.mainScrollView addSubview:self.yanZhengTableView];
    
    __weak typeof(self)wself = self;
       
       MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
           self->yanZhengPage = 1;
           
           NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
           if ([NormalUse isValidDictionary:self.cityInfo]) {
               NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
               if (cityCode.intValue!=-1001) {
                   NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                   [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
               }
           }
           [dic setObject:[NSString stringWithFormat:@"%d",self->yanZhengPage] forKey:@"page"];

           [HTTPModel getMyYanZhengList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               [wself.yanZhengTableView.mj_header endRefreshing];

               if (status==1) {
                   
                   [wself.yanZhengArray removeAllObjects];
                   self->yanZhengPage++;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   
                   if (![NormalUse isValidArray:array] || array.count==0) {
                       
                       UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.yanZhengTableView.width, self.yanZhengTableView.width*1280/720)];
                       imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                       [self.yanZhengTableView addSubview:imageView];
                   }
                   if (array.count>=10) {
                       
                       [wself.yanZhengTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.yanZhengTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.yanZhengArray addObject:info];
                   }
                   [wself.yanZhengTableView reloadData];
               }
               else
               {
                   [NormalUse showToastView:msg view:wself.view];
               }
           }];
       }];
       header.lastUpdatedTimeLabel.hidden = YES;
       self.yanZhengTableView.mj_header = header;
       [self.yanZhengTableView.mj_header beginRefreshing];
       
       MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           
           NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
           if ([NormalUse isValidDictionary:self.cityInfo]) {
               NSString * cityCode = [self.cityInfo objectForKey:@"cityCode"];
               if (cityCode.intValue!=-1001) {
                   NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                   [dic setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"cityCode"];
               }
           }
           [dic setObject:[NSString stringWithFormat:@"%d",self->yanZhengPage] forKey:@"page"];

           [HTTPModel getMyYanZhengList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               if (status==1) {
                   self->yanZhengPage = 1;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   if (array.count>=10) {
                       
                       [wself.yanZhengTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.yanZhengTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.yanZhengArray addObject:info];
                   }
                   [wself.yanZhengTableView reloadData];
               }
               else
               {
                   [wself.yanZhengTableView.mj_footer endRefreshing];

                   [NormalUse showToastView:msg view:wself.view];
               }
           }];

       }];
       self.yanZhengTableView.mj_footer = footer;

}
#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView.tag==0) {
        
        return self.xinXiArray.count;

    }
    else if (tableView.tag==1)
    {
         return self.nvShenTieZiArray.count;
    }
    else if (tableView.tag==2)
    {
        return self.waiWeiTieZiArray.count;

    }
    else if (tableView.tag==3)
    {
        return self.peiWanTieZiArray.count;

    }
    else if (tableView.tag==4)
    {
        return self.fuQiJiaoTieZiArray.count;

    }
    else if (tableView.tag==5)
    {
         return self.heiDianBaoGuangArray.count;
    }
    else if (tableView.tag==6)
    {
        return self.dingZhiFuWuArray.count;

    }
    else if (tableView.tag==7)
    {
        return self.yanZhengArray.count;

    }

    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==0) {
        
        return  144*BiLiWidth+17*BiLiWidth;

    }
    else if (tableView.tag==1)
    {
         return 144*BiLiWidth+7*BiLiWidth;
    }
    else if (tableView.tag==2)
    {
        return 144*BiLiWidth+7*BiLiWidth;

    }
    else if (tableView.tag==3)
    {
        return 144*BiLiWidth+7*BiLiWidth;

    }
    else if (tableView.tag==4)
    {
        return 144*BiLiWidth+7*BiLiWidth;

    }
    else if (tableView.tag==5)
    {
        return  144*BiLiWidth+17*BiLiWidth;
    }
    else if (tableView.tag==6)
    {
        return  [MyFaBu_DingZhiFuWuCell cellHegiht:[self.dingZhiFuWuArray objectAtIndex:indexPath.row]];

    }
    else
    {
        return  144*BiLiWidth+17*BiLiWidth;

    }
   
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0) {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyFaBu_XinXiCell"] ;
        MyFaBu_XinXiCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyFaBu_XinXiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.xinXiArray objectAtIndex:indexPath.row]];
        return cell;

    }
    else if (tableView.tag==1)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyFaBu_JiaoSeAndFuQiJiaoTieZiCell"] ;
        MyFaBu_JiaoSeAndFuQiJiaoTieZiCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyFaBu_JiaoSeAndFuQiJiaoTieZiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.nvShenTieZiArray objectAtIndex:indexPath.row]];
        return cell;
    }
    else if (tableView.tag==2)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyFaBu_JiaoSeAndFuQiJiaoTieZiCell"] ;
        MyFaBu_JiaoSeAndFuQiJiaoTieZiCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyFaBu_JiaoSeAndFuQiJiaoTieZiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.waiWeiTieZiArray objectAtIndex:indexPath.row]];
        return cell;

    }
    else if (tableView.tag==3)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyFaBu_JiaoSeAndFuQiJiaoTieZiCell"] ;
        MyFaBu_JiaoSeAndFuQiJiaoTieZiCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyFaBu_JiaoSeAndFuQiJiaoTieZiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.peiWanTieZiArray objectAtIndex:indexPath.row]];
        return cell;

    }
    else if (tableView.tag==4)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyFaBu_JiaoSeAndFuQiJiaoTieZiCell"] ;
        MyFaBu_JiaoSeAndFuQiJiaoTieZiCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyFaBu_JiaoSeAndFuQiJiaoTieZiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.fuQiJiaoTieZiArray objectAtIndex:indexPath.row]];
        return cell;

    }
    else if (tableView.tag==5)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyFaBu_XinXiCell"] ;
        MyFaBu_XinXiCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyFaBu_XinXiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.heiDianBaoGuangArray objectAtIndex:indexPath.row]];
        return cell;

    }
    else if (tableView.tag==6)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyFaBu_DingZhiFuWuCell"] ;
        MyFaBu_DingZhiFuWuCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyFaBu_DingZhiFuWuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.dingZhiFuWuArray objectAtIndex:indexPath.row]];
        return cell;

    }
    else
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyFaBu_XinXiCell"] ;
        MyFaBu_XinXiCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyFaBu_XinXiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.alsoYanZheng = YES;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.yanZhengArray objectAtIndex:indexPath.row]];
        return cell;

    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0) {
        
        NSDictionary * info = [self.xinXiArray objectAtIndex:indexPath.row];

        NSNumber * post_type = [info objectForKey:@"post_type"];//2会员贴 1 普通贴
        if (post_type.intValue==2) {

            VipRenZhengTieZeDetailVC * vc = [[VipRenZhengTieZeDetailVC alloc] init];
            NSNumber * idNumber = [info objectForKey:@"id"];
            if ([idNumber isKindOfClass:[NSNumber class]]) {
                vc.post_id = [NSString stringWithFormat:@"%d",idNumber.intValue];
            }
            [self.navigationController pushViewController:vc animated:YES];

        }
        else
        {
            TieZiDetailViewController * vc = [[TieZiDetailViewController alloc] init];
            NSNumber * idNumber = [info objectForKey:@"id"];
            vc.post_id = [NSString stringWithFormat:@"%d",idNumber.intValue];
            [self.navigationController pushViewController:vc animated:YES];

        }
        
    }
    else if (tableView.tag==1)
    {
        NSDictionary * info = [self.nvShenTieZiArray objectAtIndex:indexPath.row];
        
        NSNumber * girlId = [info objectForKey:@"id"];
        SanDaJiaoSeDetailViewController * vc = [[SanDaJiaoSeDetailViewController alloc] init];
        vc.girl_id = [NSString stringWithFormat:@"%d",girlId.intValue];
        vc.type = @"3" ;
        [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];

    }
    else if (tableView.tag==2)
    {
        NSDictionary * info = [self.waiWeiTieZiArray objectAtIndex:indexPath.row];
        NSNumber * girlId = [info objectForKey:@"id"];
        SanDaJiaoSeDetailViewController * vc = [[SanDaJiaoSeDetailViewController alloc] init];
        vc.girl_id = [NSString stringWithFormat:@"%d",girlId.intValue];
        vc.type = @"4" ;
        [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];

    }
    else if (tableView.tag==3)
    {
        NSDictionary * info = [self.peiWanTieZiArray objectAtIndex:indexPath.row];
        NSNumber * girlId = [info objectForKey:@"id"];
        SanDaJiaoSeDetailViewController * vc = [[SanDaJiaoSeDetailViewController alloc] init];
        vc.girl_id = [NSString stringWithFormat:@"%d",girlId.intValue];
        vc.type = @"5" ;
        [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];

    }
    else if (tableView.tag==4)
    {
        NSDictionary * info = [self.fuQiJiaoTieZiArray objectAtIndex:indexPath.row];
        FuQiJiaoDetailViewController * vc = [[FuQiJiaoDetailViewController alloc] init];
        NSNumber * couple_id = [info objectForKey:@"id"];
        vc.couple_id = [NSString stringWithFormat:@"%d",couple_id.intValue];
        [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];

    }
    else if (tableView.tag==5)
    {
        NSDictionary * info = [self.heiDianBaoGuangArray objectAtIndex:indexPath.row];
        HeiDianDetailViewController * vc = [[HeiDianDetailViewController alloc] init];
        NSString * idStr = [info objectForKey:@"id"];
        vc.idStr = idStr;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (tableView.tag==6)
    {
        NSDictionary * info = [self.dingZhiFuWuArray objectAtIndex:indexPath.row];
        
        DingZhiFuWuDetailViewController * vc = [[DingZhiFuWuDetailViewController alloc] init];
        NSNumber * idNumber = [info objectForKey:@"id"];
        vc.idStr = [NSString stringWithFormat:@"%d",idNumber.intValue];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (tableView.tag==7)
    {
        NSDictionary * info = [self.yanZhengArray objectAtIndex:indexPath.row];
        TieZiDetailViewController * vc = [[TieZiDetailViewController alloc] init];
        NSNumber * idNumber = [info objectForKey:@"id"];
        vc.post_id = [NSString stringWithFormat:@"%d",idNumber.intValue];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

@end
