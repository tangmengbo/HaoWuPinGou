//
//  DianPuDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "DianPuDetailViewController.h"
#import "DianuDetailListTableViewCell.h"

@interface DianPuDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
    float tableViewHeaderHeight;
    BOOL alsoLock;
}

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSDictionary * dianPuInfo;//店铺信息
@property(nonatomic,strong)NSMutableArray *  artist_list;//店铺下艺人列表

@property(nonatomic,strong)NSString * field;//默认最新 hot_value 最热

@property(nonatomic,strong)UIView * jieSuoTipView;

@end

@implementation DianPuDetailViewController


-(UIView *)jieSuoTipView
{
    if (!_jieSuoTipView) {
        
        _jieSuoTipView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu, WIDTH_PingMu, 155*BiLiWidth)];
        _jieSuoTipView.backgroundColor = RGBFormUIColor(0xFFFFFF);
        [self.view addSubview:_jieSuoTipView];
        _jieSuoTipView.layer.shadowOpacity = 0.2f;
        _jieSuoTipView.layer.shadowColor = [UIColor blackColor].CGColor;
        _jieSuoTipView.layer.shadowOffset = CGSizeMake(0, 3);//CGSizeZero; //设置偏移量为0,四周都有阴影

        //某个角圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_jieSuoTipView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8*BiLiWidth, 8*BiLiWidth)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _jieSuoTipView.bounds;
        maskLayer.path = maskPath.CGPath;
        _jieSuoTipView.layer.mask = maskLayer;

        
        UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, 24*BiLiWidth, 200*BiLiWidth, 17*BiLiWidth)];
        tipLable.text = @"温馨提示";
        tipLable.textColor = RGBFormUIColor(0xFFA218);
        tipLable.font = [UIFont systemFontOfSize:17*BiLiWidth];
        [_jieSuoTipView addSubview:tipLable];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(30*BiLiWidth, tipLable.top+tipLable.height+18*BiLiWidth, WIDTH_PingMu-60*BiLiWidth, 40*BiLiWidth)];
        tipLable1.text = @"解锁经纪人联系方式即可查看经纪人下所有信息的联系方式～";
        tipLable1.numberOfLines = 2;
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [_jieSuoTipView addSubview:tipLable1];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-28*BiLiWidth, 13*BiLiWidth, 14.5*BiLiWidth, 14.5*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"dianPu_tip_close"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeJieSuoTipView) forControlEvents:UIControlEventTouchUpInside];
        [_jieSuoTipView addSubview:closeButton];

    }
    return _jieSuoTipView;
}
-(void)closeJieSuoTipView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.jieSuoTipView.top = HEIGHT_PingMu;
    }];
}
-(Lable_ImageButton *)noMessageTipButotn
{
    if (!_noMessageTipButotn) {
        
        _noMessageTipButotn = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, tableViewHeaderHeight+10*BiLiWidth, WIDTH_PingMu, 90*BiLiWidth)];
        _noMessageTipButotn.button_imageView.frame = CGRectMake((_noMessageTipButotn.width-60*BiLiWidth)/2, 0, 60*BiLiWidth, 60*BiLiWidth);
        _noMessageTipButotn.button_imageView.image = [UIImage imageNamed:@"noMessage_tip"];
        _noMessageTipButotn.button_lable.frame = CGRectMake(0, _noMessageTipButotn.button_imageView.top+_noMessageTipButotn.button_imageView.height+10*BiLiWidth, _noMessageTipButotn.width, 12*BiLiWidth);
        _noMessageTipButotn.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        _noMessageTipButotn.button_lable.textColor = RGBFormUIColor(0x343434);
        _noMessageTipButotn.button_lable.textAlignment = NSTextAlignmentCenter;
        _noMessageTipButotn.button_lable.text = @"暂无数据";
        [self.mainTableView addSubview:_noMessageTipButotn];
    }
    return _noMessageTipButotn;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (alsoLock) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.jieSuoTipView.top = HEIGHT_PingMu-self.jieSuoTipView.height;
        }];


    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    self.field = @"";
    self.artist_list = [NSMutableArray array];

    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    
    MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mainTableView.mj_header = mjHeader;
    
    MJRefreshBackNormalFooter * mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreList)];
    self.mainTableView.mj_footer = mjFooter;


    
    [HTTPModel getDianPuDetail:[[NSDictionary alloc] initWithObjectsAndKeys:self.dianPuId,@"id", nil]
                      callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {

        if (status==1) {

            self.dianPuInfo = responseObject;
            self.topTitleLale.text = [self.dianPuInfo objectForKey:@"name"];
            
            [self.mainTableView reloadData];

            [self loadNewLsit];

        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }

    }];
    
}
-(void)loadNewLsit
{
    page = 1;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    if ([NormalUse isValidString:self.field]) {
        
        [dic setObject:self.field forKey:@"field"];
    }
    [dic setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [dic setObject:self.dianPuId forKey:@"client_id"];
    [HTTPModel getTieZiList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            [self.artist_list removeAllObjects];
            self->page = self->page+1;
            NSArray * array = [responseObject objectForKey:@"data"];
            if (array.count==0) {
                
                self.noMessageTipButotn.hidden = NO;
            }
            else
            {
                self.noMessageTipButotn.hidden = YES;

            }
            for (NSDictionary * info in array) {
                
                [self.artist_list addObject:info];
            }
            
            [self.mainTableView.mj_header endRefreshing];

            if (array.count>=10) {

                [self.mainTableView.mj_footer endRefreshing];
            }
            else
            {
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];

            }

            [self.mainTableView reloadData];
        }
    }];

}
-(void)loadMoreList
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    if ([NormalUse isValidString:self.field]) {
        
        [dic setObject:self.field forKey:@"field"];
    }
    [dic setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [dic setObject:self.dianPuId forKey:@"client_id"];
    [HTTPModel getTieZiList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self->page = self->page+1;
            
            NSArray * array = [responseObject objectForKey:@"data"];
            if (array.count>=10) {
                
                [self.mainTableView.mj_footer endRefreshing];
            }
            else
            {
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];

            }
            self.artist_list = [NSMutableArray array];
            for (NSDictionary * info in array) {
                
                [self.artist_list addObject:info];
            }
            [self.mainTableView reloadData];
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
    NSString *tableIdentifier = [NSString stringWithFormat:@"DianuDetailListTableViewCell"] ;
    DianuDetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[DianuDetailListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.auth_vip = [self.dianPuInfo objectForKey:@"auth_vip"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if ([NormalUse isValidDictionary:self.dianPuInfo])
    {
        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, 99*BiLiWidth, WIDTH_PingMu-25*BiLiWidth, 0)];
        messageLable.numberOfLines = 0;
        messageLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        
        NSString * neiRongStr = [NormalUse getobjectForKey:[self.dianPuInfo objectForKey:@"description"]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
        messageLable.attributedText = attributedString;
        //设置自适应
        [messageLable  sizeToFit];
        
        tableViewHeaderHeight = messageLable.top+messageLable.height+216*BiLiWidth;
        
        NSNumber * is_mark = [self.dianPuInfo objectForKey:@"is_mark"];

        if (is_mark.intValue==1) {

            return messageLable.top+messageLable.height+216*BiLiWidth;

        }
        else
        {
            return messageLable.top+messageLable.height+216*BiLiWidth-32.5*BiLiWidth;

        }
        
    }
    else
    {
        return 0;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 501*BiLiWidth+24*BiLiWidth)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    if ([NormalUse isValidDictionary:self.dianPuInfo]) {
        
        UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 0, 48*BiLiWidth, 48*BiLiWidth)];
        headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        headerImageView.autoresizingMask = UIViewAutoresizingNone;
        headerImageView.clipsToBounds = YES;
        headerImageView.layer.cornerRadius = 24*BiLiWidth;
        [headerView addSubview:headerImageView];
        
        if ([NormalUse isValidArray:[self.dianPuInfo objectForKey:@"image"]]) {
            
            NSArray * images = [self.dianPuInfo objectForKey:@"image"];
            [headerImageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]]];
            
        }
        else if ([NormalUse isValidString:[self.dianPuInfo objectForKey:@"image"]])
        {
            [headerImageView sd_setImageWithURL:[NSURL URLWithString:[self.dianPuInfo objectForKey:@"image"]]];
        }


        CGSize titleSize = [NormalUse setSize:[self.dianPuInfo objectForKey:@"name"] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.width+headerImageView.left+9.5*BiLiWidth, headerImageView.top+7*BiLiWidth, titleSize.width, 17*BiLiWidth)];
        titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        titleLable.textColor = RGBFormUIColor(0x333333);
        titleLable.text  = [self.dianPuInfo objectForKey:@"name"];
        [headerView addSubview:titleLable];
        
        UIImageView * vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(titleLable.left+titleLable.width+10*BiLiWidth, titleLable.top+(titleLable.height-13.5*BiLiWidth)/2, 11.5*BiLiWidth, 13.5*BiLiWidth)];
        [headerView addSubview:vipImageView];
        

        NSNumber * auth_vip = [self.dianPuInfo objectForKey:@"auth_vip"];
        if ([auth_vip isKindOfClass:[NSNumber class]] && auth_vip.intValue==1) {
            
            vipImageView.image = [UIImage imageNamed:@"vip_black"];

        }
        else
        {
            vipImageView.left = titleLable.left+titleLable.width;
            vipImageView.width = 0;
        }
        

        
        Lable_ImageButton * pingFenButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(titleLable.left, titleLable.top+titleLable.height+7*BiLiWidth, 37*BiLiWidth, 13*BiLiWidth)];
        pingFenButton.button_imageView.frame = CGRectMake(0, 0, 13*BiLiWidth, 13*BiLiWidth);
        pingFenButton.button_imageView.image = [UIImage imageNamed:@"star_yellow"];
        pingFenButton.button_lable.frame = CGRectMake(18*BiLiWidth, 0, 20*BiLiWidth, 13*BiLiWidth);
        pingFenButton.button_lable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        pingFenButton.button_lable.textColor = RGBFormUIColor(0xF5BB61);
        NSNumber * complex_score = [self.dianPuInfo objectForKey:@"complex_score"];
        if ([complex_score isKindOfClass:[NSNumber class]]) {
            
            pingFenButton.button_lable.text = [NSString stringWithFormat:@"%.1f",complex_score.floatValue];

        }
        pingFenButton.button_lable1.frame = CGRectMake(pingFenButton.button_lable.left+pingFenButton.button_lable.width+5*BiLiWidth, 0, 200*BiLiWidth, 13*BiLiWidth);
        pingFenButton.button_lable1.font = [UIFont systemFontOfSize:11*BiLiWidth];
        pingFenButton.button_lable1.textColor = RGBFormUIColor(0x999999);
        pingFenButton.button_lable1.text = [NSString stringWithFormat:@"· %@",[NormalUse getobjectForKey:[self.dianPuInfo objectForKey:@"city_name"]]];
        [headerView addSubview:pingFenButton];
        
        UIView * guanZhuBottomView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-84*BiLiWidth, titleLable.top, 72*BiLiWidth, 24*BiLiWidth)];
        [headerView addSubview:guanZhuBottomView];
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = guanZhuBottomView.bounds;
        gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.cornerRadius = 12*BiLiWidth;
        gradientLayer.locations = @[@0,@1];
        [guanZhuBottomView.layer addSublayer:gradientLayer];
        
        self.guanZhuButton = [[UIButton alloc] initWithFrame:guanZhuBottomView.frame];
        [self.guanZhuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.guanZhuButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        [self.guanZhuButton addTarget:self action:@selector(guanZhuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.guanZhuButton];
        NSNumber * is_follow = [self.dianPuInfo objectForKey:@"is_follow"];
        if ([is_follow isKindOfClass:[NSNumber class]]) {
            
            if (is_follow.intValue==0) {
                
                self.guanZhuButton.tag = 0;
                [self.guanZhuButton setBackgroundImage:[UIImage imageNamed:@"guanZhu_n"] forState:UIControlStateNormal];

            }
            else
            {
                self.guanZhuButton.tag = 1;
                [self.guanZhuButton setBackgroundImage:[UIImage imageNamed:@"guanZhu_h"] forState:UIControlStateNormal];

            }
        }

        
        UILabel * renZhengLable = [[UILabel alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, headerImageView.top+headerImageView.height+20.5*BiLiWidth, 63*BiLiWidth, 14*BiLiWidth)];
        renZhengLable.textColor = RGBFormUIColor(0x333333);
        renZhengLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [headerView addSubview:renZhengLable];
        
        NSNumber * post_num = [self.dianPuInfo objectForKey:@"post_num"];
        if ([post_num isKindOfClass:[NSNumber class]]) {
            
            NSString * renZhengStr = [NSString stringWithFormat:@"认证 %d",post_num.intValue];
            NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:renZhengStr];
            [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x999999) range:NSMakeRange(0, 2)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11*BiLiWidth] range:NSMakeRange(0, 2)];
            renZhengLable.attributedText = str;


        }

        
        UILabel * chengJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(renZhengLable.left+renZhengLable.width, headerImageView.top+headerImageView.height+20.5*BiLiWidth, 63*BiLiWidth, 14*BiLiWidth)];
        chengJiaoLable.textColor = RGBFormUIColor(0x333333);
        chengJiaoLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [headerView addSubview:chengJiaoLable];
        
        NSNumber * deal_num = [self.dianPuInfo objectForKey:@"deal_num"];
        if ([post_num isKindOfClass:[NSNumber class]]) {
            
            NSString * chengJiaoStr = [NSString stringWithFormat:@"成交 %d",deal_num.intValue];
            NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:chengJiaoStr];
            [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x999999) range:NSMakeRange(0, 2)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11*BiLiWidth] range:NSMakeRange(0, 2)];
            chengJiaoLable.attributedText = str;


        }


        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, chengJiaoLable.top+chengJiaoLable.height+20.5*BiLiWidth, WIDTH_PingMu-25*BiLiWidth, 0)];
        messageLable.numberOfLines = 0;
        messageLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        messageLable.textColor = RGBFormUIColor(0x333333);
        [headerView addSubview:messageLable];
        
        NSString * neiRongStr = [NormalUse getobjectForKey:[self.dianPuInfo objectForKey:@"description"]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
        messageLable.attributedText = attributedString;
        //设置自适应
        [messageLable  sizeToFit];
        
        
        UIImageView * jiaoYiBaoZhengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth, messageLable.top+messageLable.height+16*BiLiWidth, 16.5*BiLiWidth*323/56, 16.5*BiLiWidth)];
        jiaoYiBaoZhengImageView.image = [UIImage imageNamed:@"baoZhengJin_img"];
        [headerView addSubview:jiaoYiBaoZhengImageView];
        

        UILabel * jiaoYiBaoZhengLable = [[UILabel alloc] initWithFrame:CGRectMake(17*BiLiWidth, 3*BiLiWidth, jiaoYiBaoZhengImageView.width-17*BiLiWidth, 14*BiLiWidth)];
        jiaoYiBaoZhengLable.font = [UIFont systemFontOfSize:9*BiLiWidth];
        jiaoYiBaoZhengLable.textColor = RGBFormUIColor(0x4E8AEE);
        jiaoYiBaoZhengLable.adjustsFontSizeToFitWidth = YES;
        jiaoYiBaoZhengLable.textAlignment = NSTextAlignmentCenter;
        [jiaoYiBaoZhengImageView addSubview:jiaoYiBaoZhengLable];
        
        NSNumber * is_mark = [self.dianPuInfo objectForKey:@"is_mark"];

        if (is_mark.intValue==1) {
            
            jiaoYiBaoZhengLable.text = [NSString stringWithFormat:@"交易保证金:%@",[self.dianPuInfo objectForKey:@"mark_cny"]];
        }
        else
        {
            jiaoYiBaoZhengImageView.hidden = YES;
            jiaoYiBaoZhengImageView.top = messageLable.top+messageLable.height;
            jiaoYiBaoZhengImageView.height = 0;

        }
        
        NSString * unlock_agent_coin = [NormalUse getJinBiStr:@"unlock_agent_coin"];

        self.jieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, jiaoYiBaoZhengImageView.top+jiaoYiBaoZhengImageView.height+16*BiLiWidth, 321*BiLiWidth, 57*BiLiWidth)];
        [self.jieSuoButton setBackgroundImage:[UIImage imageNamed:@"jieSuo_bottomIMageView"] forState:UIControlStateNormal];
        self.jieSuoButton.button_lable.frame = CGRectMake(19.5*BiLiWidth, 0, 150*BiLiWidth, self.jieSuoButton.height);
        self.jieSuoButton.button_lable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.jieSuoButton.button_lable.textColor = RGBFormUIColor(0xFFE1B0);
        self.jieSuoButton.button_lable.text = @"查看所有联系方式";
        self.jieSuoButton.button_lable1.frame = CGRectMake(227*BiLiWidth, 0, 150*BiLiWidth, self.jieSuoButton.height);
        self.jieSuoButton.button_lable1.font = [UIFont systemFontOfSize:13*BiLiWidth];
        self.jieSuoButton.button_lable1.textColor = RGBFormUIColor(0xFFE1B0);
        self.jieSuoButton.button_lable1.text = [NSString stringWithFormat:@"%@金币解锁",[NormalUse getobjectForKey:unlock_agent_coin]];
        [self.jieSuoButton addTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.jieSuoButton];
        
        NSNumber * is_unlock = [self.dianPuInfo objectForKey:@"is_unlock"];
        if([is_unlock isKindOfClass:[NSNumber class]])
        {
            
            if (is_unlock.intValue==1) {
                
                alsoLock = NO;
                
                NSDictionary * contact = [self.dianPuInfo objectForKey:@"contact"];
                [self.jieSuoButton removeTarget:self action:@selector(jieSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
                NSString * wechat = [contact objectForKey:@"wechat"];
                NSString * qq = [contact objectForKey:@"qq"];
                NSNumber * mobile = [contact objectForKey:@"mobile"];
                NSString * lianXieFangShiStr = @"";
                if ([NormalUse isValidString:wechat]) {
                    
                    lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"微信:%@",wechat]];
                }
                if ([NormalUse isValidString:qq]) {
                    
                    lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"  QQ:%@",qq]];
                }
                
                if ([NormalUse isValidString:mobile]) {
                    
                    lianXieFangShiStr = [lianXieFangShiStr stringByAppendingString:[NSString stringWithFormat:@"  电话:%d",mobile.intValue]];
                    
                }
                self.jieSuoButton.button_lable.left = 10*BiLiWidth;
                self.jieSuoButton.button_lable.width = self.jieSuoButton.width-20*BiLiWidth;
                self.jieSuoButton.button_lable.adjustsFontSizeToFitWidth = YES;
                self.jieSuoButton.button_lable.text = lianXieFangShiStr;
                self.jieSuoButton.button_lable1.text = @"";
                
                
            }
            else
            {
                alsoLock = YES;
                
            }
            
        }
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.jieSuoButton.top+self.jieSuoButton.height+28*BiLiWidth, WIDTH_PingMu, 8*BiLiWidth)];
        lineView.backgroundColor = RGBFormUIColor(0xEDEDED);
        [headerView addSubview:lineView];

        self.pingFenButton = [[UIButton alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView.top+lineView.height+28.5*BiLiWidth, 50*BiLiWidth, 12*BiLiWidth)];
        [self.pingFenButton setTitle:@"评分最高" forState:UIControlStateNormal];
        [self.pingFenButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
        self.pingFenButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        [self.pingFenButton addTarget:self action:@selector(pingFenButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.pingFenButton];
        
        self.zuiXinButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+33*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
        [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        [self.zuiXinButton setTitle:@"最新" forState:UIControlStateNormal];
        self.zuiXinButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        [self.zuiXinButton addTarget:self action:@selector(zuiXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.zuiXinButton];
        
        self.zuiReButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+79*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
        [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
        [self.zuiReButton setTitle:@"最热" forState:UIControlStateNormal];
        self.zuiReButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        [self.zuiReButton addTarget:self action:@selector(zuiReButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.zuiReButton];
        
        if ([NormalUse isValidString:self.field]) {
            
            [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
            [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];

        }

    }

    
    
    return headerView;
    
}
-(void)jieSuoButtonClick
{
    [NormalUse showMessageLoadView:@"解锁中..." vc:self];
    
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:@"1" forKey:@"type_id"];
    [info setObject:[self.dianPuInfo objectForKey:@"uid"] forKey:@"related_id"];
    [HTTPModel unlockMobile:info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse removeMessageLoadingView:self];
        if (status==1) {
            
             self.jieSuoButton.button_lable.text = @"已经解锁成功";
                self.jieSuoButton.button_lable1.text = @"";

            [NormalUse showToastView:@"解锁成功" view:self.view];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
        
    }];
    
}
-(void)guanZhuButtonClick:(UIButton *)button
{
    button.enabled = NO;
    
    if (button.tag==0) {
        
        NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:self.dianPuId,@"shop_id", nil];
        [HTTPModel dianPuFollow:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            button.enabled = YES;
            if (status==1) {
                button.tag = 1;
                [button setBackgroundImage:[UIImage imageNamed:@"guanZhu_h"] forState:UIControlStateNormal];
            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
            }
        }];

    }
    else
    {
        NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:self.dianPuId,@"ids", nil];
        [HTTPModel dianPuUnfollow:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            button.enabled = YES;
            if (status==1) {
                button.tag = 0;
                [button setBackgroundImage:[UIImage imageNamed:@"guanZhu_n"] forState:UIControlStateNormal];
            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
            }
        }];

    }
        
    
}
-(void)pingFenButtonClick
{
    
}
-(void)zuiXinButtonClick
{
    self.field = @"";
    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
    [self.mainTableView reloadData];
    
}
-(void)zuiReButtonClick
{
    self.field = @"hot_value";

    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];

    [self.mainTableView reloadData];

}


@end
