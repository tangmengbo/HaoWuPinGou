//
//  MyShouCangGuanZhuViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/15.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "MyShouCangGuanZhuViewController.h"
#import "MyShouCangGuanZhu_ShouCangCell.h"
#import "MyShouCangGuanZhu_guanZhuCell.h"

@interface MyShouCangGuanZhuViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,MyShouCangGuanZhu_ShouCangCellDelegate,MyShouCangGuanZhu_guanZhuCellDelegate>
{
    int shouCangPage;
    int guanZhuPage;
    
    BOOL alsoDelete;
}

@property(nonatomic,strong)UIButton * shouCangButton;
@property(nonatomic,strong)NSMutableArray * shouCangArray;
@property(nonatomic,strong)UITableView * shouCangTableView;

@property(nonatomic,strong)UIButton * guanZhuButton;
@property(nonatomic,strong)NSMutableArray * guanZhuAray;
@property(nonatomic,strong)UITableView * guanZhuTableView;

@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSMutableArray * deleteShouCangArray;
@property(nonatomic,strong)NSMutableArray * deleteGuanZhuArray;


@end

@implementation MyShouCangGuanZhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    alsoDelete = NO;
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    self.rightButton.tag = 0;
    
    self.shouCangArray = [NSMutableArray array];
    self.guanZhuAray = [NSMutableArray array];
    
    self.shouCangButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-53*BiLiWidth*3)/2, 0, 53*BiLiWidth, self.topNavView.height)];
    [self.shouCangButton setTitle:@"收藏" forState:UIControlStateNormal];
    [self.shouCangButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.shouCangButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.shouCangButton.tag = 0;
    [self.topNavView addSubview:self.shouCangButton];
    
    self.guanZhuButton = [[UIButton alloc] initWithFrame:CGRectMake(self.shouCangButton.left+self.shouCangButton.width+53*BiLiWidth, 0, 53*BiLiWidth, self.topNavView.height)];
    [self.guanZhuButton setTitle:@"关注" forState:UIControlStateNormal];
    [self.guanZhuButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
    [self.guanZhuButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.guanZhuButton.tag = 1;
    [self.topNavView addSubview:self.guanZhuButton];


    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(self.shouCangButton.left,30*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
    self.sliderView.layer.cornerRadius = 7*BiLiWidth/2;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.alpha = 0.8;
    [self.topNavView addSubview:self.sliderView];
    
    [self sliderViewSetJianBian];

    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu*2, self.mainScrollView.height)];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.tag = 1001;
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    [self addShouCangTableView];
    [self addGuanZhuTableView];
    
    self.deleteShouCangArray = [NSMutableArray array];
    self.deleteGuanZhuArray = [NSMutableArray array];
    
}
-(void)rightClick
{
    if (self.rightButton.tag==0) {
        
        [self.rightButton setTitle:@"删除" forState:UIControlStateNormal];
        self.rightButton.tag = 1;
        alsoDelete = YES;
        [self.shouCangTableView reloadData];
        [self.guanZhuTableView reloadData];

    }
    else
    {
        if (![NormalUse isValidArray:self.deleteShouCangArray] && ![NormalUse  isValidArray:self.deleteGuanZhuArray]) {
                
                [NormalUse showToastView:@"删除项不能为空" view:self.view];
                return;
            }
            
        
            if ([NormalUse isValidArray:self.deleteShouCangArray]&&self.deleteShouCangArray.count>0) {
                
                NSString * ids = [self.deleteShouCangArray objectAtIndex:0];
                for (int i=1; i<self.deleteShouCangArray.count; i++) {
                    
                    ids = [[ids stringByAppendingString:@"|"] stringByAppendingString:[self.deleteShouCangArray objectAtIndex:i]];
                }
                NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:ids,@"ids", nil];
                [HTTPModel tieZiUnFollow:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                   
                    if (status==1) {
                        
                        [self.shouCangTableView.mj_header beginRefreshing];
                        [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
                        self.rightButton.tag = 0;

                    }
                    else
                    {
                        [NormalUse showToastView:msg view:self.view];
                    }
                    
                }];
            }
            if ([NormalUse isValidArray:self.deleteGuanZhuArray]&&self.deleteGuanZhuArray.count>0) {
                
                NSString * ids = [self.deleteGuanZhuArray objectAtIndex:0];
                for (int i=1; i<self.deleteGuanZhuArray.count; i++) {
                    
                    ids = [[ids stringByAppendingString:@"|"] stringByAppendingString:[self.deleteGuanZhuArray objectAtIndex:i]];
                }
                NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:ids,@"ids", nil];

                [HTTPModel dianPuUnfollow:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                    
                    if (status==1) {
                        
                        [self.guanZhuTableView.mj_header beginRefreshing];
                        [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
                        self.rightButton.tag = 0;

                        
                    }
                    else
                    {
                        [NormalUse showToastView:msg view:self.view];
                    }
                }];
            }

    }
    

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
    if (selectButton.tag==0) {
        
        [self.shouCangButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [self.guanZhuButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];

    }
    else
    {
        [self.shouCangButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
        [self.guanZhuButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];

    }
    [self.mainScrollView setContentOffset:CGPointMake(WIDTH_PingMu*selectButton.tag, 0)];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.sliderView.left = selectButton.left;

        
    } completion:^(BOOL finished) {

        
    }];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (scrollView.tag==1001) {
        
        int  specialIndex = scrollView.contentOffset.x/WIDTH_PingMu;
        
        if (specialIndex==0) {
            
            [self.shouCangButton sendActionsForControlEvents:UIControlEventTouchUpInside];

        }
        else
        {
            [self.guanZhuButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }

}
-(void)addShouCangTableView
{
    //收藏
    self.shouCangTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10*BiLiWidth, WIDTH_PingMu, self.mainScrollView.height-10*BiLiWidth)];
    self.shouCangTableView.delegate = self;
    self.shouCangTableView.dataSource = self;
    self.shouCangTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shouCangTableView.tag = 0;
    [self.mainScrollView addSubview:self.shouCangTableView];
    
    __weak typeof(self)wself = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self->shouCangPage = 1;
        [HTTPModel getMyShouCangList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->shouCangPage],@"page",nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            [wself.shouCangTableView.mj_header endRefreshing];

            if (status==1) {
                
                [wself.shouCangArray removeAllObjects];
                self->shouCangPage++;
                NSArray * array = [responseObject objectForKey:@"data"];
                
                if (![NormalUse isValidArray:array] || array.count==0) {
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.shouCangTableView.width, self.shouCangTableView.width*1280/720)];
                    imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                    [self.shouCangTableView addSubview:imageView];
                }

                
                if (array.count>=10) {
                    
                    [wself.shouCangTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.shouCangTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.shouCangArray addObject:info];
                }
                [wself.shouCangTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
            }
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.shouCangTableView.mj_header = header;
    [self.shouCangTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [HTTPModel getMyShouCangList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->shouCangPage],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self->shouCangPage++;
                
                NSArray * array = [responseObject objectForKey:@"data"];
                if (array.count>=10) {
                    
                    [wself.shouCangTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.shouCangTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.shouCangArray addObject:info];
                }
                [wself.shouCangTableView reloadData];
            }
            else
            {
                [wself.shouCangTableView.mj_footer endRefreshing];

                [NormalUse showToastView:msg view:wself.view];
            }
        }];

    }];
    self.shouCangTableView.mj_footer = footer;

}

-(void)addGuanZhuTableView
{
    //关注
    self.guanZhuTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.guanZhuTableView.delegate = self;
    self.guanZhuTableView.dataSource = self;
    self.guanZhuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.guanZhuTableView.tag = 1;
    [self.mainScrollView addSubview:self.guanZhuTableView];
    
    __weak typeof(self)wself = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self->guanZhuPage = 1;
        [HTTPModel getMyGuanZhuList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->guanZhuPage],@"page",nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            [wself.guanZhuTableView.mj_header endRefreshing];

            if (status==1) {
                
                [wself.guanZhuAray removeAllObjects];
                self->guanZhuPage++;
                NSArray * array = responseObject;
                
                if (![NormalUse isValidArray:array] || array.count==0) {
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.guanZhuTableView.width, self.guanZhuTableView.width*1280/720)];
                    imageView.image = [UIImage imageNamed:@"NoMessageTip"];
                    [self.guanZhuTableView addSubview:imageView];
                }

                if (array.count>=10) {
                    
                    [wself.guanZhuTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.guanZhuTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.guanZhuAray addObject:info];
                }
                [wself.guanZhuTableView reloadData];
            }
            else
            {
                [NormalUse showToastView:msg view:wself.view];
            }
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.guanZhuTableView.mj_header = header;
    [self.guanZhuTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [HTTPModel getMyGuanZhuList:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self->guanZhuPage],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self->guanZhuPage++;
                NSArray * array = responseObject;
                if (array.count>=10) {
                    
                    [wself.guanZhuTableView.mj_footer endRefreshing];
                }
                else
                {
                    [wself.guanZhuTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in array) {
                    
                    [wself.guanZhuAray addObject:info];
                }
                [wself.guanZhuTableView reloadData];
            }
            else
            {
                [wself.guanZhuTableView.mj_footer endRefreshing];

                [NormalUse showToastView:msg view:wself.view];
            }
        }];

    }];
    self.guanZhuTableView.mj_footer = footer;

}
#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView.tag==0) {
        
        return self.shouCangArray.count;

    }
    else if (tableView.tag==1)
    {
         return self.guanZhuAray.count;
    }


    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==0) {
        
        return  144*BiLiWidth+17*BiLiWidth;

    }
    else
    {
        return  109*BiLiWidth;

    }
   
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0) {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyShouCangGuanZhu_ShouCangCell"] ;
        MyShouCangGuanZhu_ShouCangCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyShouCangGuanZhu_ShouCangCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.delegate = self;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.shouCangArray objectAtIndex:indexPath.row] alsoDelete:alsoDelete];
        return cell;

    }
    else
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyShouCangGuanZhu_guanZhuCell"] ;
        MyShouCangGuanZhu_guanZhuCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyShouCangGuanZhu_guanZhuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.delegate = self;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell contentViewSetData:[self.guanZhuAray objectAtIndex:indexPath.row] alsoDelete:alsoDelete];
        return cell;

    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0) {
        
        //1 普通贴子 2女神 3外围 4全球 5夫妻交友
        NSDictionary * info = [self.shouCangArray objectAtIndex:indexPath.row];
        NSNumber * type_id = [info objectForKey:@"type_id"];
        if (type_id.intValue==1) {
            
            TieZiDetailViewController * vc = [[TieZiDetailViewController alloc] init];
            NSNumber * idNumber = [info objectForKey:@"post_id"];
            vc.post_id = [NSString stringWithFormat:@"%d",idNumber.intValue];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
        else if(type_id.intValue==2)
        {
            NSNumber * girlId = [info objectForKey:@"post_id"];
            SanDaJiaoSeDetailViewController * vc = [[SanDaJiaoSeDetailViewController alloc] init];
            vc.girl_id = [NSString stringWithFormat:@"%d",girlId.intValue];
            vc.type = @"3";
            [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];
            
        }
        else if(type_id.intValue==3)
        {
            NSNumber * girlId = [info objectForKey:@"post_id"];
            SanDaJiaoSeDetailViewController * vc = [[SanDaJiaoSeDetailViewController alloc] init];
            vc.girl_id = [NSString stringWithFormat:@"%d",girlId.intValue];
            vc.type = @"4";
            [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];
            
        }
        else if(type_id.intValue==4)
        {
            NSNumber * girlId = [info objectForKey:@"post_id"];
            SanDaJiaoSeDetailViewController * vc = [[SanDaJiaoSeDetailViewController alloc] init];
            vc.girl_id = [NSString stringWithFormat:@"%d",girlId.intValue];
            vc.type = @"5";
            [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];
            
        }
        else if (type_id.intValue==5)
        {
            FuQiJiaoDetailViewController * vc = [[FuQiJiaoDetailViewController alloc] init];
            NSNumber * couple_id = [info objectForKey:@"post_id"];
            vc.couple_id = [NSString stringWithFormat:@"%d",couple_id.intValue];
            [[NormalUse getCurrentVC].navigationController pushViewController:vc animated:YES];
            
        }
        
        
        
        
    }
    else if (tableView.tag==1)
    {
        NSDictionary * info = [self.guanZhuAray objectAtIndex:indexPath.row];
        DianPuDetailViewController * vc = [[DianPuDetailViewController alloc] init];
        NSNumber * idNumber = [info objectForKey:@"id"];
        vc.dianPuId = [NSString stringWithFormat:@"%d",idNumber.intValue];
        [self.navigationController pushViewController:vc animated:YES];

    }
    
}
#pragma mark--UITableViewCellDelgate
-(void)shouCangTianJiaToDelet:(NSString *)idStr
{
    [self.deleteShouCangArray addObject:idStr];
}
-(void)shouCangQuXiaoToDelet:(NSString *)idStr
{
    [self.deleteShouCangArray removeObject:idStr];
}
-(void)guanZhuTianJiaToDelet:(NSString *)idStr
{
    [self.deleteGuanZhuArray addObject:idStr];

}
-(void)guanZhuQuXiaoToDelet:(NSString *)idStr
{
    [self.deleteGuanZhuArray removeObject:idStr];

}

@end
