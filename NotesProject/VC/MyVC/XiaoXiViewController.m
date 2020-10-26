//
//  XiaoXiViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "XiaoXiViewController.h"
#import "MyXiaoXi_GuanFangCell.h"
#import "MyXiaoXi_ShenHeCell.h"
#import "GuanFangXiaoXiDetailViewController.h"
#import "ChatListViewController.h"

@interface XiaoXiViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    ChatListViewController * chatListVC;
}

@property(nonatomic,strong)UILabel * unReadMesLable;

@property(nonatomic,strong)UIButton * button1;
@property(nonatomic,strong)UIButton * button2;
@property(nonatomic,strong)UIButton * button3;
@property(nonatomic,strong)UIButton * button4;
@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)UIView * shenHeXiaoXiPoint;
@property(nonatomic,strong)UIView * huoDongXiaoXiPoint;
@property(nonatomic,strong)UIView * huiHuaXiaoXiPoint;

@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)UITableView * tableView1;
@property(nonatomic,strong)UITableView * tableView2;
@property(nonatomic,strong)UITableView * tableView3;

@property(nonatomic,strong)NSMutableArray * sourceArray1;
@property(nonatomic,strong)NSMutableArray * sourceArray2;
@property(nonatomic,strong)NSMutableArray * sourceArray3;

@property(nonatomic,strong)UIImageView *noMessageTipImageView1;
@property(nonatomic,strong)UIImageView *noMessageTipImageView2;
@property(nonatomic,strong)UIImageView *noMessageTipImageView3;




@end

@implementation XiaoXiViewController

-(UIImageView *)noMessageTipImageView1
{
    if (!_noMessageTipImageView1) {
        
        _noMessageTipImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, WIDTH_PingMu*1280/720)];
        _noMessageTipImageView1.image = [UIImage imageNamed:@"NoMessageTip"];
        
    }
    return _noMessageTipImageView1;
}
-(UIImageView *)noMessageTipImageView2
{
    if (!_noMessageTipImageView2) {
        
        _noMessageTipImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, WIDTH_PingMu*1280/720)];
        _noMessageTipImageView2.image = [UIImage imageNamed:@"NoMessageTip"];
        
    }
    return _noMessageTipImageView2;
}
-(UIImageView *)noMessageTipImageView3
{
    if (!_noMessageTipImageView3) {
        
        _noMessageTipImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, WIDTH_PingMu*1280/720)];
        _noMessageTipImageView3.image = [UIImage imageNamed:@"NoMessageTip"];
        
    }
    return _noMessageTipImageView3;
}

-(void)rightClick
{
    
    NSArray *displayConversationTypeArray = @[@(ConversationType_PRIVATE)];
    ChatListViewController * vc = [[ChatListViewController alloc] initWithDisplayConversationTypes:displayConversationTypeArray collectionConversationType:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;

    [chatListVC reloadMessageList];//刷新消息列表
    
    int unReadMesNumber = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]];

    if (unReadMesNumber<=0) {
        
        self.huiHuaXiaoXiPoint.hidden = YES;
    }
    else
    {
        self.huiHuaXiaoXiPoint.hidden = NO;
    }
//    if (unReadMesNumber<=0) {
//        self.unReadMesLable.hidden = YES;
//    }
//    else
//    {
//        self.unReadMesLable.hidden = NO;
//        self.unReadMesLable.text = [NSString stringWithFormat:@"%d",unReadMesNumber];
//        if (unReadMesNumber<10) {
//
//            self.unReadMesLable.frame = CGRectMake(self.unReadMesLable.frame.origin.x, self.unReadMesLable.frame.origin.y, 15, 15);
//        }
//        else
//        {
//            self.unReadMesLable.frame = CGRectMake(self.unReadMesLable.frame.origin.x, self.unReadMesLable.frame.origin.y, 20, 15);
//        }
//    }

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.topTitleLale.text = @"消息";
    
    [self yinCangTabbar];
    
//    [self.rightButton setTitle:@"消息" forState:UIControlStateNormal];



    CGSize size =  [NormalUse setSize:@"官方消息" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];

    self.button1 = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu/4-size.width)/2, self.topNavView.height+self.topNavView.top+10*BiLiWidth, size.width, 17*BiLiWidth)];
    [self.button1 setTitle:@"官方消息" forState:UIControlStateNormal];
    [self.button1 setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.button1.tag = 0;
    self.button1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.button1 addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.button1.titleLabel sizeToFit];
    [self.view addSubview:self.button1];
    [self.button1 sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.button2 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/4+(WIDTH_PingMu/4-size.width)/2, self.topNavView.height+self.topNavView.top+10*BiLiWidth, size.width, 17*BiLiWidth)];
    [self.button2 setTitle:@"审核消息" forState:UIControlStateNormal];
    [self.button2 setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.button2.tag = 1;
    self.button2.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.button2 addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2.titleLabel sizeToFit];
    [self.view addSubview:self.button2];
    
    self.shenHeXiaoXiPoint = [[UIView alloc] initWithFrame:CGRectMake(self.button2.left+self.button2.width-7*BiLiWidth, self.button2.top, 8*BiLiWidth, 8*BiLiWidth)];
    self.shenHeXiaoXiPoint.backgroundColor = [UIColor redColor];
    self.shenHeXiaoXiPoint.layer.cornerRadius = 4*BiLiWidth;
    self.shenHeXiaoXiPoint.layer.masksToBounds = YES;
    [self.view addSubview:self.shenHeXiaoXiPoint];
    NSNumber * review_msgcnt = [self.xiaoXiWeiDuInfo objectForKey:@"review_msgcnt"];
    if (review_msgcnt.intValue==0) {
        
        self.shenHeXiaoXiPoint.hidden = YES;

    }
    else
    {
        self.shenHeXiaoXiPoint.hidden = NO;

    }


    self.button3 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/4*2+(WIDTH_PingMu/4-size.width)/2, self.topNavView.height+self.topNavView.top+10*BiLiWidth, size.width, 17*BiLiWidth)];
    [self.button3 setTitle:@"活动消息" forState:UIControlStateNormal];
    [self.button3 setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.button3.tag = 2;
    self.button3.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.button3 addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.button3.titleLabel sizeToFit];
    [self.view addSubview:self.button3];
    
    
    self.huoDongXiaoXiPoint = [[UIView alloc] initWithFrame:CGRectMake(self.button3.left+self.button3.width-7*BiLiWidth, self.button2.top, 8*BiLiWidth, 8*BiLiWidth)];
    self.huoDongXiaoXiPoint.backgroundColor = [UIColor redColor];
    self.huoDongXiaoXiPoint.layer.cornerRadius = 4*BiLiWidth;
    self.huoDongXiaoXiPoint.layer.masksToBounds = YES;
    [self.view addSubview:self.huoDongXiaoXiPoint];
    NSNumber * active_msgcnt = [self.xiaoXiWeiDuInfo objectForKey:@"active_msgcnt"];

    if (active_msgcnt.intValue==0) {
        
        self.huoDongXiaoXiPoint.hidden = YES;

    }
    else
    {
        self.huoDongXiaoXiPoint.hidden = NO;

    }
    
    self.button4 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu/4*3+(WIDTH_PingMu/4-size.width)/2, self.topNavView.height+self.topNavView.top+10*BiLiWidth, size.width, 17*BiLiWidth)];
    [self.button4 setTitle:@"会话消息" forState:UIControlStateNormal];
    [self.button4 setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.button4.tag = 3;
    self.button4.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.button4 addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.button4.titleLabel sizeToFit];
    [self.view addSubview:self.button4];
    
    self.huiHuaXiaoXiPoint = [[UIView alloc] initWithFrame:CGRectMake(self.button4.left+self.button4.width-7*BiLiWidth, self.button2.top, 8*BiLiWidth, 8*BiLiWidth)];
    self.huiHuaXiaoXiPoint.backgroundColor = [UIColor redColor];
    self.huiHuaXiaoXiPoint.layer.cornerRadius = 4*BiLiWidth;
    self.huiHuaXiaoXiPoint.layer.masksToBounds = YES;
    [self.view addSubview:self.huiHuaXiaoXiPoint];
    self.huiHuaXiaoXiPoint.hidden = NO;


    
//    self.unReadMesLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-20*BiLiWidth, self.button4.top-7.5, 20, 15)];
//    self.unReadMesLable.textColor = [UIColor whiteColor];
//    self.unReadMesLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
//    self.unReadMesLable.textAlignment = NSTextAlignmentCenter;
//    self.unReadMesLable.layer.cornerRadius = 15/2;
//    self.unReadMesLable.layer.masksToBounds = YES;
//    self.unReadMesLable.hidden = YES;
//    self.unReadMesLable.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.unReadMesLable];


    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake((self.button1.width-53*BiLiWidth)/2+self.button1.left,self.button1.top+15*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
    self.sliderView.layer.cornerRadius = 7*BiLiWidth/2;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.alpha = 0.8;
    [self.view addSubview:self.sliderView];
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

    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.button1.top+self.button1.height+10*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(self.button1.top+self.button1.height+10*BiLiWidth))];
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu*4, self.mainScrollView.height)];
    self.mainScrollView.delegate = self;
    self.mainScrollView.tag = 1002;
    self.mainScrollView.pagingEnabled = YES;
    [self.view addSubview:self.mainScrollView];
    
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.tag = 0;
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView1.showsHorizontalScrollIndicator = NO;
    self.tableView1.showsVerticalScrollIndicator = NO;
    [self.mainScrollView addSubview:self.tableView1];
    
    MJRefreshNormalHeader * header1 = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [HTTPModel getXiaoXiMessageList:[[NSDictionary alloc]initWithObjectsAndKeys:@"0",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self.sourceArray1 = [responseObject objectForKey:@"data"];

                if (![NormalUse isValidArray:self.sourceArray1]) {
                    
                    [self.tableView1 addSubview:self.noMessageTipImageView1];
                }
                else
                {
                    [self.noMessageTipImageView1 removeFromSuperview];
                }
                [self.tableView1 reloadData];
                [self.tableView1.mj_header endRefreshing];

            }
        }];

    }];
    header1.lastUpdatedTimeLabel.hidden = YES;
    self.tableView1.mj_header = header1;
    [self.tableView1.mj_header beginRefreshing];
    
    

    
    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.tag = 1;
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView2.showsHorizontalScrollIndicator = NO;
    self.tableView2.showsVerticalScrollIndicator = NO;
    [self.mainScrollView addSubview:self.tableView2];
    
    MJRefreshNormalHeader * header2 = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [HTTPModel getXiaoXiMessageList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self.sourceArray2 = [responseObject objectForKey:@"data"];
                if (![NormalUse isValidArray:self.sourceArray2]) {
                    
                    [self.tableView2 addSubview:self.noMessageTipImageView2];
                }
                else
                {
                    [self.noMessageTipImageView2 removeFromSuperview];
                }

                [self.tableView2 reloadData];
                [self.tableView2.mj_header endRefreshing];

            }
        }];
    }];
    header2.lastUpdatedTimeLabel.hidden = YES;
    self.tableView2.mj_header = header2;
    [self.tableView2.mj_header beginRefreshing];


    
    self.tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*2, 0, WIDTH_PingMu, self.mainScrollView.height)];
    self.tableView3.delegate = self;
    self.tableView3.dataSource = self;
    self.tableView3.tag = 2;
    self.tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView3.showsHorizontalScrollIndicator = NO;
    self.tableView3.showsVerticalScrollIndicator = NO;
    [self.mainScrollView addSubview:self.tableView3];
    
    MJRefreshNormalHeader * header3 = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [HTTPModel getXiaoXiMessageList:[[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                self.sourceArray3 = [responseObject objectForKey:@"data"];
                
                if (![NormalUse isValidArray:self.sourceArray3]) {
                    
                    [self.tableView3 addSubview:self.noMessageTipImageView3];
                }
                else
                {
                    [self.noMessageTipImageView3 removeFromSuperview];
                }

                [self.tableView3 reloadData];
                [self.tableView3.mj_header endRefreshing];

            }
        }];

    }];
    header3.lastUpdatedTimeLabel.hidden = YES;
    self.tableView3.mj_header = header3;
    [self.tableView3.mj_header beginRefreshing];


    NSArray *displayConversationTypeArray = @[@(ConversationType_PRIVATE)];
    chatListVC = [[ChatListViewController alloc] initWithDisplayConversationTypes:displayConversationTypeArray collectionConversationType:nil];
    chatListVC.view.frame = CGRectMake(WIDTH_PingMu*3, 0, WIDTH_PingMu, self.mainScrollView.height);
    [self.mainScrollView addSubview:chatListVC.view];
}
-(void)listTopButtonClick:(UIButton *)button
{
    [self.mainScrollView setContentOffset:CGPointMake(button.tag*WIDTH_PingMu, 0) animated:YES];
    
    if (button.tag==0) {
        
        self.button2.transform = CGAffineTransformIdentity;
        self.button3.transform = CGAffineTransformIdentity;
        self.button4.transform = CGAffineTransformIdentity;
    }
    else if (button.tag==1)
    {
        self.button1.transform = CGAffineTransformIdentity;
        self.button3.transform = CGAffineTransformIdentity;
        self.button4.transform = CGAffineTransformIdentity;

        self.shenHeXiaoXiPoint.hidden = YES;
    }
    else if(button.tag==2)
    {
        self.button1.transform = CGAffineTransformIdentity;
        self.button2.transform = CGAffineTransformIdentity;
        self.button4.transform = CGAffineTransformIdentity;

        self.huoDongXiaoXiPoint.hidden = YES;

    }
    else
    {
        self.button1.transform = CGAffineTransformIdentity;
        self.button2.transform = CGAffineTransformIdentity;
        self.button3.transform = CGAffineTransformIdentity;

    }
    
        
    [UIView animateWithDuration:0.5 animations:^{
        
        button.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.sliderView.left = button.left+(button.width-self.sliderView.width)/2;
        
    }];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (scrollView.tag==1002) {
        
        int  specialIndex = scrollView.contentOffset.x/WIDTH_PingMu;
        
        if (specialIndex==0) {
            
            [self.button1 sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        else if (specialIndex==1)
        {
            [self.button2 sendActionsForControlEvents:UIControlEventTouchUpInside];

        }
        else if(specialIndex==2)
        {
            [self.button3 sendActionsForControlEvents:UIControlEventTouchUpInside];

        }
        else
        {
            [self.button4 sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
    }

}

#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0) {
        
        return self.sourceArray1.count;
    }
    else if (tableView.tag==1)
    {
        return self.sourceArray2.count;

    }
    else
    {
        return self.sourceArray3.count;

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==0) {
        
        NSDictionary * info = [self.sourceArray1 objectAtIndex:indexPath.row];
        
        return [MyXiaoXi_GuanFangCell cellHegiht:info];
    }
    else if (tableView.tag==1)
    {
        NSDictionary * info = [self.sourceArray2 objectAtIndex:indexPath.row];
        
        return [MyXiaoXi_ShenHeCell cellHegiht:info];

    }
    else
    {
        NSDictionary * info = [self.sourceArray3 objectAtIndex:indexPath.row];
        
        return [MyXiaoXi_GuanFangCell cellHegiht:info];

    }

    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==0) {
        
        NSDictionary * info = [self.sourceArray1 objectAtIndex:indexPath.row];
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyXiaoXi_GuanFangCell"] ;
        MyXiaoXi_GuanFangCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyXiaoXi_GuanFangCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.cellType = GuanFangMessage;
        [cell initData:info];
        
        return cell;
    }
    else if (tableView.tag==1)
    {
        NSDictionary * info = [self.sourceArray2 objectAtIndex:indexPath.row];
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyXiaoXi_ShenHeCell"] ;
        MyXiaoXi_ShenHeCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyXiaoXi_ShenHeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        [cell initData:info];
        
        return cell;

    }
    else
    {
        NSDictionary * info = [self.sourceArray3 objectAtIndex:indexPath.row];
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"MyXiaoXi_GuanFangCell"] ;
        MyXiaoXi_GuanFangCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[MyXiaoXi_GuanFangCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.cellType = HuoDongMessage;

        [cell initData:info];
        
        return cell;

    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0) {
        
        NSDictionary * info = [self.sourceArray1 objectAtIndex:indexPath.row];
        NSNumber * idNumber = [info objectForKey:@"id"];
        GuanFangXiaoXiDetailViewController * vc = [[GuanFangXiaoXiDetailViewController alloc] init];
        vc.idStr = [NSString stringWithFormat:@"%d",idNumber.intValue];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
}
/*
-(void)initUI
{
    Lable_ImageButton * systemMessageButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    systemMessageButton.button_imageView.frame = CGRectMake(18*BiLiWidth, 0, 45*BiLiWidth, 45*BiLiWidth);
    systemMessageButton.button_imageView.image = [UIImage imageNamed:@"xiaoXi_systemMessage"];
    systemMessageButton.button_lable.frame = CGRectMake(systemMessageButton.button_imageView.left+systemMessageButton.button_imageView.width+8.5*BiLiWidth, 4.5*BiLiWidth, 200*BiLiWidth, 15*BiLiWidth);
    systemMessageButton.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    systemMessageButton.button_lable.textColor = RGBFormUIColor(0x333333);
    systemMessageButton.button_lable.text = @"系统通知";
    systemMessageButton.button_lable1.frame = CGRectMake(systemMessageButton.button_lable.left, systemMessageButton.button_lable.top+systemMessageButton.button_lable.height+7.5*BiLiWidth, 200*BiLiWidth, 12*BiLiWidth);
    systemMessageButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    systemMessageButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    systemMessageButton.button_lable1.text = @"还没有系统消息哦～";
    [self.view addSubview:systemMessageButton];
    
    Lable_ImageButton * jieSuoYanZhengButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, systemMessageButton.top+systemMessageButton.height+20*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    jieSuoYanZhengButton.button_imageView.frame = CGRectMake(18*BiLiWidth, 0, 45*BiLiWidth, 45*BiLiWidth);
    jieSuoYanZhengButton.button_imageView.image = [UIImage imageNamed:@"xiaoXi_jieSuoYanZheng"];
    jieSuoYanZhengButton.button_lable.frame = CGRectMake(systemMessageButton.button_imageView.left+systemMessageButton.button_imageView.width+8.5*BiLiWidth, 4.5*BiLiWidth, 200*BiLiWidth, 15*BiLiWidth);
    jieSuoYanZhengButton.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    jieSuoYanZhengButton.button_lable.textColor = RGBFormUIColor(0x333333);
    jieSuoYanZhengButton.button_lable.text = @"解锁和验证";
    jieSuoYanZhengButton.button_lable1.frame = CGRectMake(systemMessageButton.button_lable.left, systemMessageButton.button_lable.top+systemMessageButton.button_lable.height+7.5*BiLiWidth, 200*BiLiWidth, 12*BiLiWidth);
    jieSuoYanZhengButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    jieSuoYanZhengButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    jieSuoYanZhengButton.button_lable1.text = @"还没有通知哦～";
    [self.view addSubview:jieSuoYanZhengButton];

    
    Lable_ImageButton * keFuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, jieSuoYanZhengButton.top+jieSuoYanZhengButton.height+20*BiLiWidth, WIDTH_PingMu, 45*BiLiWidth)];
    keFuButton.button_imageView.frame = CGRectMake(18*BiLiWidth, 0, 45*BiLiWidth, 45*BiLiWidth);
    keFuButton.button_imageView.image = [UIImage imageNamed:@"xiaoXi_keFu"];
    keFuButton.button_lable.frame = CGRectMake(systemMessageButton.button_imageView.left+systemMessageButton.button_imageView.width+8.5*BiLiWidth, 4.5*BiLiWidth, 200*BiLiWidth, 15*BiLiWidth);
    keFuButton.button_lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    keFuButton.button_lable.textColor = RGBFormUIColor(0x333333);
    keFuButton.button_lable.text = @"在线客服";
    keFuButton.button_lable1.frame = CGRectMake(systemMessageButton.button_lable.left, systemMessageButton.button_lable.top+systemMessageButton.button_lable.height+7.5*BiLiWidth, 200*BiLiWidth, 12*BiLiWidth);
    keFuButton.button_lable1.font = [UIFont systemFontOfSize:12*BiLiWidth];
    keFuButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    keFuButton.button_lable1.text = @"您好～";
    [self.view addSubview:keFuButton];

}
 */

@end
