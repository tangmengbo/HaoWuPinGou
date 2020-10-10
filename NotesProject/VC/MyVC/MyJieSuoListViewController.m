//
//  MyJieSuoListViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/11.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyJieSuoListViewController.h"
#import "MyJieSuo_TieZiListCell.h"
#import "MyJieSuo_sanDaJiaoSeCell.h"
#import "MyJieSuo_JingJiReCell.h"
#import "DingZhiFuWuTableViewCell.h"
#import "DianPuKePingJiaViewController.h"

@interface MyJieSuoListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int tieZiPage;
    int jingJiRenPage;
    int nvShenPage;
    int WaiWeiPage;
    int peiWanPage;
    int dingZhiPage;
    int fuQiJiaoPage;
}

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIScrollView * topButtonScrollView;
@property(nonatomic,strong)NSMutableArray * topButtonArray;

@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)NSMutableArray * tieZiArray;
@property(nonatomic,strong)UITableView * tieZiTableView;


@property(nonatomic,strong)NSMutableArray * jingJiRenArray;
@property(nonatomic,strong)UITableView * jingJiRenTableView;

@property(nonatomic,strong)NSMutableArray * nvShenArray;
@property(nonatomic,strong)UITableView * nvShenTableView;


@property(nonatomic,strong)NSMutableArray * waiWeiArray;
@property(nonatomic,strong)UITableView * waiWeiTableView;

@property(nonatomic,strong)NSMutableArray * peiWanArray;
@property(nonatomic,strong)UITableView * peiWanTableView;

@property(nonatomic,strong)NSMutableArray * dingZhiArray;
@property(nonatomic,strong)UITableView * dingZhiTableView;

@property(nonatomic,strong)NSMutableArray * fuQiJiaoArray;
@property(nonatomic,strong)UITableView * fuQiJiaoTableView;


@end

@implementation MyJieSuoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"全部解锁";
    
    self.tieZiArray = [NSMutableArray array];
    self.jingJiRenArray = [NSMutableArray array];
    self.nvShenArray = [NSMutableArray array];
    self.waiWeiArray = [NSMutableArray array];
    self.peiWanArray = [NSMutableArray array];
    self.dingZhiArray = [NSMutableArray array];
    self.fuQiJiaoArray = [NSMutableArray array];
    
    [self yinCangTabbar];

    self.topButtonArray = [NSMutableArray array];
    NSArray * array = [[NSArray alloc] initWithObjects:@"经纪人",@"滴滴约信息",@"女神",@"外围",@"陪玩",@"定制服务",@"夫妻交", nil];
    
    self.topButtonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,self.topNavView.top+self.topNavView.height, WIDTH_PingMu, 50*BiLiWidth)];
    self.topButtonScrollView.showsVerticalScrollIndicator = NO;
    self.topButtonScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.topButtonScrollView];
    
    float originX = 30*BiLiWidth;
    for (int i=0; i<array.count; i++) {
        
        CGSize size = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:18*BiLiWidth];
        
        UIButton * tieZiButton = [[UIButton alloc] initWithFrame:CGRectMake(originX, 0, size.width, 50*BiLiWidth)];
        [tieZiButton setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [tieZiButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        tieZiButton.tag = i;
        tieZiButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        [self.topButtonScrollView addSubview:tieZiButton];
        
        if (i==0) {
            
            [tieZiButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
            
            self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(30*BiLiWidth,30*BiLiWidth,size.width,7*BiLiWidth)];
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
        originX = originX+size.width+13*BiLiWidth;
        
        [self.topButtonScrollView setContentSize:CGSizeMake(tieZiButton.left+tieZiButton.width+30*BiLiWidth, self.topButtonScrollView.height)];
    }
    

    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topButtonScrollView.top+self.topButtonScrollView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topButtonScrollView.top+self.topButtonScrollView.height))];
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu*array.count, self.mainScrollView.height)];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.tag = 1001;
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    //1经纪人 2茶小二 3女神 4外围 5全球陪玩 6定制服务
    [self addJingJiRenTableView];
    [self addTieZiTableView];
    [self addNvShenTableView];
    [self addWaiWeiTableView];
    [self addPeiWanTableView];
    [self addDiangZhiFuWuTableView];
    [self addFuQiJiaoTableView];
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
    if (selectButton.origin.x+selectButton.width>WIDTH_PingMu) {
        
        [self.topButtonScrollView setContentOffset:CGPointMake(selectButton.origin.x+selectButton.width-WIDTH_PingMu, 0)];
    }
    if (selectButton.tag==0) {
        
        [self.topButtonScrollView setContentOffset:CGPointMake(0, 0)];

    }
    [self.mainScrollView setContentOffset:CGPointMake(WIDTH_PingMu*selectButton.tag, 0)];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.sliderView.left = selectButton.left;
        self.sliderView.width = selectButton.width;

        
    } completion:^(BOOL finished) {
        [self sliderViewSetJianBian];

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

-(void)addJingJiRenTableView
{
    //经纪人
    self.jingJiRenTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.jingJiRenTableView.delegate = self;
    self.jingJiRenTableView.dataSource = self;
    self.jingJiRenTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jingJiRenTableView.tag = 0;
    [self.mainScrollView addSubview:self.jingJiRenTableView];
    
    __weak typeof(self)wself = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self->jingJiRenPage = 1;
        [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->jingJiRenPage],@"page",@"1",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            [wself.jingJiRenTableView.mj_header endRefreshing];

            if (status==1) {
                
                [wself.jingJiRenArray removeAllObjects];
                self->jingJiRenPage++;
                NSArray * array = [responseObject objectForKey:@"data"];
                
                if (![NormalUse isValidArray:array] || array.count==0) {
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.waiWeiTableView.width, self.waiWeiTableView.width*1280/720)];
                    imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                    [self.jingJiRenTableView addSubview:imageView];
                }

                
                if (array.count>=10) {
                    
                    [wself.jingJiRenTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.jingJiRenTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.jingJiRenArray addObject:info];
                }
                [wself.jingJiRenTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
            }
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.jingJiRenTableView.mj_header = header;
    [self.jingJiRenTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->jingJiRenPage],@"page",@"1",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self->jingJiRenPage++;
                
                NSArray * array = [responseObject objectForKey:@"data"];
                if (array.count>=10) {
                    
                    [wself.jingJiRenTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.jingJiRenTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.jingJiRenArray addObject:info];
                }
                [wself.jingJiRenTableView reloadData];
            }
            else
            {
                [wself.jingJiRenTableView.mj_footer endRefreshing];

                [NormalUse showToastView:msg view:wself.view];
            }
        }];

    }];
    self.jingJiRenTableView.mj_footer = footer;

}

-(void)addTieZiTableView
{
    //帖子
    self.tieZiTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.tieZiTableView.delegate = self;
    self.tieZiTableView.dataSource = self;
    self.tieZiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tieZiTableView.tag = 1;
    [self.mainScrollView addSubview:self.tieZiTableView];
    
    __weak typeof(self)wself = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self->tieZiPage = 1;
        [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->tieZiPage],@"page",@"2",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            [wself.tieZiTableView.mj_header endRefreshing];

            if (status==1) {
                
                [wself.tieZiArray removeAllObjects];
                self->tieZiPage++;
                NSArray * array = [responseObject objectForKey:@"data"];
                
                if (![NormalUse isValidArray:array] || array.count==0) {
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.waiWeiTableView.width, self.waiWeiTableView.width*1280/720)];
                    imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                    [self.tieZiTableView addSubview:imageView];
                }

                if (array.count>=10) {
                    
                    [wself.tieZiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.tieZiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.tieZiArray addObject:info];
                }
                [wself.tieZiTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
            }
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tieZiTableView.mj_header = header;
    [self.tieZiTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->tieZiPage],@"page",@"2",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self->tieZiPage++;
                NSArray * array = [responseObject objectForKey:@"data"];
                if (array.count>=10) {
                    
                    [wself.tieZiTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.tieZiTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.tieZiArray addObject:info];
                }
                [wself.tieZiTableView reloadData];
            }
            else
            {
                [wself.tieZiTableView.mj_footer endRefreshing];

                [NormalUse showToastView:msg view:wself.view];
            }
        }];

    }];
    self.tieZiTableView.mj_footer = footer;

}
-(void)addNvShenTableView
{
    //女神
    self.nvShenTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*2, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.nvShenTableView.delegate = self;
    self.nvShenTableView.dataSource = self;
    self.nvShenTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.nvShenTableView.tag = 2;
    [self.mainScrollView addSubview:self.nvShenTableView];
    
    __weak typeof(self)wself = self;
       
       MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
           self->nvShenPage = 1;
           [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->nvShenPage],@"page",@"3",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               [wself.nvShenTableView.mj_header endRefreshing];

               if (status==1) {
                   
                   [wself.nvShenArray removeAllObjects];
                   self->nvShenPage++;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   
                   if (![NormalUse isValidArray:array] || array.count==0) {
                       
                       UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.waiWeiTableView.width, self.waiWeiTableView.width*1280/720)];
                       imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                       [self.nvShenTableView addSubview:imageView];
                   }

                   if (array.count>=10) {
                       
                       [wself.nvShenTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.nvShenTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.nvShenArray addObject:info];
                   }
                   [wself.nvShenTableView reloadData];
               }
               else
               {
                   [NormalUse showToastView:msg view:wself.view];
               }
           }];
       }];
       header.lastUpdatedTimeLabel.hidden = YES;
       self.nvShenTableView.mj_header = header;
       [self.nvShenTableView.mj_header beginRefreshing];
       
       MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           
           [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->nvShenPage],@"page",@"3",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               if (status==1) {
                   
                   self->nvShenPage++;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   if (array.count>=10) {
                       
                       [wself.nvShenTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.nvShenTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.nvShenArray addObject:info];
                   }
                   [wself.nvShenTableView reloadData];
               }
               else
               {
                   [wself.nvShenTableView.mj_footer endRefreshing];

                   [NormalUse showToastView:msg view:wself.view];
               }
           }];

       }];
       self.nvShenTableView.mj_footer = footer;

}

-(void)addWaiWeiTableView
{
    //外围
    self.waiWeiTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*3, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.waiWeiTableView.delegate = self;
    self.waiWeiTableView.dataSource = self;
    self.waiWeiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.waiWeiTableView.tag = 3;
    [self.mainScrollView addSubview:self.waiWeiTableView];
    
    __weak typeof(self)wself = self;
       
       MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
           self->WaiWeiPage = 1;
           [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->WaiWeiPage],@"page",@"4",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               [wself.waiWeiTableView.mj_header endRefreshing];

               if (status==1) {
                   
                   [wself.waiWeiArray removeAllObjects];
                   self->WaiWeiPage++;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   
                   if (![NormalUse isValidArray:array] || array.count==0) {
                       
                       UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.waiWeiTableView.width, self.waiWeiTableView.width*1280/720)];
                       imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                       [self.waiWeiTableView addSubview:imageView];
                   }
                   if (array.count>=10) {
                       
                       [wself.waiWeiTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.waiWeiTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.waiWeiArray addObject:info];
                   }
                   [wself.waiWeiTableView reloadData];
               }
               else
               {
                   [NormalUse showToastView:msg view:wself.view];
               }
           }];
       }];
       header.lastUpdatedTimeLabel.hidden = YES;
       self.waiWeiTableView.mj_header = header;
       [self.waiWeiTableView.mj_header beginRefreshing];
       
       MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           
           [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->WaiWeiPage],@"page",@"4",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               if (status==1) {
                   self->WaiWeiPage = 1;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   if (array.count>=10) {
                       
                       [wself.waiWeiTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.waiWeiTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.waiWeiArray addObject:info];
                   }
                   [wself.waiWeiTableView reloadData];
               }
               else
               {
                   [wself.waiWeiTableView.mj_footer endRefreshing];

                   [NormalUse showToastView:msg view:wself.view];
               }
           }];

       }];
       self.waiWeiTableView.mj_footer = footer;

}
-(void)addPeiWanTableView
{
    //陪玩
    self.peiWanTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*4, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.peiWanTableView.delegate = self;
    self.peiWanTableView.dataSource = self;
    self.peiWanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.peiWanTableView.tag = 4;
    [self.mainScrollView addSubview:self.peiWanTableView];
    
    __weak typeof(self)wself = self;
       
       MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
           self->peiWanPage = 1;
           [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->peiWanPage],@"page",@"5",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               [wself.peiWanTableView.mj_header endRefreshing];

               if (status==1) {
                   
                   [wself.peiWanArray removeAllObjects];
                   self->peiWanPage++;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   
                   if (![NormalUse isValidArray:array] || array.count==0) {
                       
                       UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.waiWeiTableView.width, self.waiWeiTableView.width*1280/720)];
                       imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                       [self.peiWanTableView addSubview:imageView];
                   }

                   if (array.count>=10) {
                       
                       [wself.peiWanTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.peiWanTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.peiWanArray addObject:info];
                   }
                   [wself.peiWanTableView reloadData];
               }
               else
               {
                   [NormalUse showToastView:msg view:wself.view];
               }
           }];
       }];
       header.lastUpdatedTimeLabel.hidden = YES;
       self.peiWanTableView.mj_header = header;
       [self.peiWanTableView.mj_header beginRefreshing];
       
       MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           
           [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->peiWanPage],@"page",@"5",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               if (status==1) {
                   
                   self->peiWanPage++;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   if (array.count>=10) {
                       
                       [wself.peiWanTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.peiWanTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.peiWanArray addObject:info];
                   }
                   [wself.peiWanTableView reloadData];
               }
               else
               {
                   [wself.peiWanTableView.mj_footer endRefreshing];

                   [NormalUse showToastView:msg view:wself.view];
               }
           }];

       }];
       self.peiWanTableView.mj_footer = footer;

}
-(void)addDiangZhiFuWuTableView
{
    //定制服务
    self.dingZhiTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*5, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.dingZhiTableView.delegate = self;
    self.dingZhiTableView.dataSource = self;
    self.dingZhiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dingZhiTableView.tag = 5;
    [self.mainScrollView addSubview:self.dingZhiTableView];
    
    __weak typeof(self)wself = self;
       
       MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
           self->dingZhiPage = 1;
           [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->dingZhiPage],@"page",@"6",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               [wself.dingZhiTableView.mj_header endRefreshing];

               if (status==1) {
                   
                   [wself.dingZhiArray removeAllObjects];
                   self->dingZhiPage++;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   
                   if (![NormalUse isValidArray:array] || array.count==0) {
                       
                       UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.waiWeiTableView.width, self.waiWeiTableView.width*1280/720)];
                       imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                       [self.dingZhiTableView addSubview:imageView];
                   }

                   if (array.count>=10) {
                       
                       [wself.dingZhiTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.dingZhiTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.dingZhiArray addObject:info];
                   }
                   [wself.dingZhiTableView reloadData];
               }
               else
               {
                   [NormalUse showToastView:msg view:wself.view];
               }
           }];
       }];
       header.lastUpdatedTimeLabel.hidden = YES;
       self.dingZhiTableView.mj_header = header;
       [self.dingZhiTableView.mj_header beginRefreshing];
       
       MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           
           [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->dingZhiPage],@"page",@"6",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               if (status==1) {
                   
                   self->dingZhiPage++;

                   NSArray * array = [responseObject objectForKey:@"data"];
                   if (array.count>=10) {
                       
                       [wself.dingZhiTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.dingZhiTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.dingZhiArray addObject:info];
                   }
                   [wself.dingZhiTableView reloadData];
               }
               else
               {
                   [wself.dingZhiTableView.mj_footer endRefreshing];

                   [NormalUse showToastView:msg view:wself.view];
               }
           }];

       }];
       self.dingZhiTableView.mj_footer = footer;

}
-(void)addFuQiJiaoTableView
{
    //夫妻交
    self.fuQiJiaoTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*6, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.fuQiJiaoTableView.delegate = self;
    self.fuQiJiaoTableView.dataSource = self;
    self.fuQiJiaoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.fuQiJiaoTableView.tag = 6;
    [self.mainScrollView addSubview:self.fuQiJiaoTableView];
    
    __weak typeof(self)wself = self;
       
       MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
           self->fuQiJiaoPage = 1;
           [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->fuQiJiaoPage],@"page",@"7",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               [wself.fuQiJiaoTableView.mj_header endRefreshing];

               if (status==1) {
                   
                   [wself.fuQiJiaoArray removeAllObjects];
                   self->fuQiJiaoPage++;
                   NSArray * array = [responseObject objectForKey:@"data"];
                   
                   if (![NormalUse isValidArray:array] || array.count==0) {
                       
                       UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.waiWeiTableView.width, self.waiWeiTableView.width*1280/720)];
                       imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                       [self.fuQiJiaoTableView addSubview:imageView];
                   }

                   if (array.count>=10) {
                       
                       [wself.fuQiJiaoTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.fuQiJiaoTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.fuQiJiaoArray addObject:info];
                   }
                   [wself.fuQiJiaoTableView reloadData];
               }
               else
               {
                   [NormalUse showToastView:msg view:wself.view];
               }
           }];
       }];
       header.lastUpdatedTimeLabel.hidden = YES;
       self.fuQiJiaoTableView.mj_header = header;
       [self.fuQiJiaoTableView.mj_header beginRefreshing];
       
       MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           
           [HTTPModel getJieUnlockList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->fuQiJiaoPage],@"page",@"7",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
               if (status==1) {
                   
                   self->fuQiJiaoPage++;

                   NSArray * array = [responseObject objectForKey:@"data"];
                   if (array.count>=10) {
                       
                       [wself.fuQiJiaoTableView.mj_footer endRefreshing];
                   }
                   else
                   {
                       [wself.fuQiJiaoTableView.mj_footer endRefreshingWithNoMoreData];
                   }
                   for (NSDictionary * info in array) {
                       
                       [wself.fuQiJiaoArray addObject:info];
                   }
                   [wself.fuQiJiaoTableView reloadData];
               }
               else
               {
                   [wself.fuQiJiaoTableView.mj_footer endRefreshing];

                   [NormalUse showToastView:msg view:wself.view];
               }
           }];

       }];
       self.fuQiJiaoTableView.mj_footer = footer;

}
#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView.tag==0) {
        
        return self.jingJiRenArray.count;

    }
    else if (tableView.tag==1)
    {
         return self.tieZiArray.count;
    }
    else if (tableView.tag==2)
    {
        return self.nvShenArray.count;

    }
    else if (tableView.tag==3)
    {
        return self.waiWeiArray.count;

    }
    else if (tableView.tag==4)
    {
        return self.peiWanArray.count;

    }
    else if (tableView.tag==5)
    {
        return self.dingZhiArray.count;

    }
    else if (tableView.tag==6)
    {
        return self.fuQiJiaoArray.count;
        
    }

    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==0) {
        
        return  109*BiLiWidth;

    }
    else if (tableView.tag==1)
    {
        return  144*BiLiWidth+17*BiLiWidth;
    }
    else if (tableView.tag==2)
    {
        return  144*BiLiWidth+17*BiLiWidth;

    }
    else if (tableView.tag==3)
    {
        return  144*BiLiWidth+17*BiLiWidth;

    }
    else if (tableView.tag==4)
    {
        return  144*BiLiWidth+17*BiLiWidth;

    }
    else if(tableView.tag==5)
    {
        return  [DingZhiFuWuTableViewCell cellHegiht:[self.dingZhiArray objectAtIndex:indexPath.row]];

    }
    else
    {
        return 144*BiLiWidth+17*BiLiWidth;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0) {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyJieSuo_JingJiReCell"] ;
        MyJieSuo_JingJiReCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyJieSuo_JingJiReCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.jingJiRenArray objectAtIndex:indexPath.row]];
        return cell;

    }
    else if (tableView.tag==1)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyJieSuoListCell"] ;
        MyJieSuo_TieZiListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyJieSuo_TieZiListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.tieZiArray objectAtIndex:indexPath.row] type_id:@"1"];
        return cell;

    }
    else if (tableView.tag==2)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyJieSuo_sanDaJiaoSeCell"] ;
        MyJieSuo_sanDaJiaoSeCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyJieSuo_sanDaJiaoSeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.nvShenArray objectAtIndex:indexPath.row] type_id:@"2"];
        return cell;

    }
    else if (tableView.tag==3)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyJieSuo_sanDaJiaoSeCell"] ;
        MyJieSuo_sanDaJiaoSeCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyJieSuo_sanDaJiaoSeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.waiWeiArray objectAtIndex:indexPath.row] type_id:@"2"];
        return cell;

    }
    else if (tableView.tag==4)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyJieSuo_sanDaJiaoSeCell"] ;
        MyJieSuo_sanDaJiaoSeCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyJieSuo_sanDaJiaoSeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.peiWanArray objectAtIndex:indexPath.row] type_id:@"2"];
        return cell;

    }
    else if (tableView.tag==5)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"DingZhiFuWuTableViewCell"] ;
        DingZhiFuWuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[DingZhiFuWuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.dingZhiArray objectAtIndex:indexPath.row]];
        return cell;

    }
    else
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyJieSuo_sanDaJiaoSeCell"] ;
        MyJieSuo_sanDaJiaoSeCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyJieSuo_sanDaJiaoSeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.fuQiJiaoArray objectAtIndex:indexPath.row] type_id:@"3"];
        return cell;

    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0) {
        
        NSDictionary * info = [self.jingJiRenArray objectAtIndex:indexPath.row];
        DianPuKePingJiaViewController * vc = [[DianPuKePingJiaViewController alloc] init];
        NSNumber * idNumber = [info objectForKey:@"id"];
        vc.dianPuId = [NSString stringWithFormat:@"%d",idNumber.intValue];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (tableView.tag==1)
    {
        NSDictionary * info = [self.tieZiArray objectAtIndex:indexPath.row];
        TieZiDetailViewController * vc = [[TieZiDetailViewController alloc] init];
        NSNumber * idNumber = [info objectForKey:@"id"];
        vc.post_id = [NSString stringWithFormat:@"%d",idNumber.intValue];
        vc.avatarUrl = [info objectForKey:@"images"];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (tableView.tag==2)
    {
        NSDictionary * info = [self.nvShenArray objectAtIndex:indexPath.row];
        NSNumber * girlId = [info objectForKey:@"id"];
        SanDaJiaoSeDetailViewController * vc = [[SanDaJiaoSeDetailViewController alloc] init];
        vc.girl_id = [NSString stringWithFormat:@"%d",girlId.intValue];
        vc.type = @"3";
        [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];

    }
    else if (tableView.tag==3)
    {
        NSDictionary * info = [self.waiWeiArray objectAtIndex:indexPath.row];
        NSNumber * girlId = [info objectForKey:@"id"];
        SanDaJiaoSeDetailViewController * vc = [[SanDaJiaoSeDetailViewController alloc] init];
        vc.girl_id = [NSString stringWithFormat:@"%d",girlId.intValue];
        vc.type = @"4";
        [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];


    }
    else if (tableView.tag==4)
    {
        NSDictionary * info = [self.peiWanArray objectAtIndex:indexPath.row];
        NSNumber * girlId = [info objectForKey:@"id"];
        SanDaJiaoSeDetailViewController * vc = [[SanDaJiaoSeDetailViewController alloc] init];
        vc.girl_id = [NSString stringWithFormat:@"%d",girlId.intValue];
        vc.type = @"5";
        [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];

    }
    else if (tableView.tag==5)
    {
        NSDictionary * info = [self.dingZhiArray objectAtIndex:indexPath.row];
        
        DingZhiFuWuDetailViewController * vc = [[DingZhiFuWuDetailViewController alloc] init];
        NSNumber * idNumber = [info objectForKey:@"id"];
        vc.idStr = [NSString stringWithFormat:@"%d",idNumber.intValue];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else
    {
        NSDictionary * info = [self.fuQiJiaoArray objectAtIndex:indexPath.row];
        FuQiJiaoDetailViewController * vc = [[FuQiJiaoDetailViewController alloc] init];
        NSNumber * couple_id = [info objectForKey:@"id"];
        vc.couple_id = [NSString stringWithFormat:@"%d",couple_id.intValue];
        [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];

    }
}
#pragma mark--MyJieSuo_TieZiListCellDelegate

-(void)faBuYanZheng:(NSDictionary *)info
{
    FaBuYanZhengViewController * vc = [[FaBuYanZhengViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
