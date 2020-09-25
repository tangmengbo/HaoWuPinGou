//
//  JinBiMingXiViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "JinBiMingXiViewController.h"
#import "JinBiMingXiCell.h"

@interface JinBiMingXiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int page;
}



@property(nonatomic,strong)UITableView * mainTableView;
@property(nonatomic,strong)NSMutableArray * sourceArray;
@property(nonatomic,strong)UIImageView * noMessageTipImageView;

@property(nonatomic,strong)UIView * leiXingSelectView;
@property(nonatomic,strong)Lable_ImageButton * selectButton;

@property(nonatomic,strong)UIButton * allButton;
@property(nonatomic,strong)UIButton * incomeButton;
@property(nonatomic,strong)UIButton * outcomeButton;
@property(nonatomic,strong)UIImageView * duiGouImageView;


@property(nonatomic,strong)NSString * type_id;// 1收入 2支出 不填则所有



@end

@implementation JinBiMingXiViewController



-(UIImageView *)noMessageTipImageView
{
    if (!_noMessageTipImageView) {
        
        _noMessageTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, WIDTH_PingMu*1280/720)];
        _noMessageTipImageView.image = [UIImage imageNamed:@"NoMessageTip"];
        
    }
    return _noMessageTipImageView;
}
-(UIView *)leiXingSelectView
{
    if (!_leiXingSelectView) {
        
        _leiXingSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topNavView.height+self.topNavView.height+25*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu)];
        _leiXingSelectView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self.view addSubview:_leiXingSelectView];
        
        UIView * whiteContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 120*BiLiWidth)];
        whiteContentView.backgroundColor = [UIColor whiteColor];
        [_leiXingSelectView addSubview:whiteContentView];
        
        self.allButton = [[UIButton alloc] initWithFrame:CGRectMake(15*BiLiWidth, 0, WIDTH_PingMu-15*BiLiWidth, 40*BiLiWidth)];
        [self.allButton setTitle:@"全部" forState:UIControlStateNormal];
        [self.allButton setTitleColor:RGBFormUIColor(0xFF2474) forState:UIControlStateNormal];
        self.allButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.allButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.allButton addTarget:self action:@selector(allButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [whiteContentView addSubview:self.allButton];
        

        self.incomeButton = [[UIButton alloc] initWithFrame:CGRectMake(15*BiLiWidth, 40*BiLiWidth, WIDTH_PingMu-15*BiLiWidth, 40*BiLiWidth)];
        [self.incomeButton setTitle:@"收入" forState:UIControlStateNormal];
        [self.incomeButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        self.incomeButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.incomeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.incomeButton addTarget:self action:@selector(incomeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [whiteContentView addSubview:self.incomeButton];

        self.outcomeButton = [[UIButton alloc] initWithFrame:CGRectMake(15*BiLiWidth, 80*BiLiWidth, WIDTH_PingMu-15*BiLiWidth, 40*BiLiWidth)];
        [self.outcomeButton setTitle:@"支出" forState:UIControlStateNormal];
        [self.outcomeButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        self.outcomeButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.outcomeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.outcomeButton addTarget:self action:@selector(outcomeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [whiteContentView addSubview:self.outcomeButton];

        self.duiGouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(whiteContentView.width-33*BiLiWidth, self.allButton.top+(self.allButton.height-9*BiLiWidth)/2, 11*BiLiWidth, 9*BiLiWidth)];
        self.duiGouImageView.image = [UIImage imageNamed:@"zhangHu_duiGou"];
        [whiteContentView addSubview:self.duiGouImageView];

        
    }
    return _leiXingSelectView;
}
-(void)allButtonClick
{
    [self.allButton setTitleColor:RGBFormUIColor(0xFF2474) forState:UIControlStateNormal];
    [self.incomeButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    [self.outcomeButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    
    self.duiGouImageView.top = self.allButton.top+(self.allButton.height-9*BiLiWidth)/2;
    self.leiXingSelectView.hidden = YES;
    
    self.type_id = @"";
    self.selectButton.tag = 0;
    self.selectButton.button_lable.text = @"全部";
    self.selectButton.button_lable.textColor  = RGBFormUIColor(0x9A9A9A);
    self.selectButton.button_imageView.image = [UIImage imageNamed:@"zhangHu_downSanJiao"];
    [self.mainTableView.mj_header beginRefreshing];

}
-(void)incomeButtonClick
{
    [self.allButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    [self.incomeButton setTitleColor:RGBFormUIColor(0xFF2474) forState:UIControlStateNormal];
    [self.outcomeButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    
    self.duiGouImageView.top = self.incomeButton.top+(self.incomeButton.height-9*BiLiWidth)/2;
    self.leiXingSelectView.hidden = YES;

    self.type_id = @"1";
    self.selectButton.tag = 0;
    self.selectButton.button_lable.text = @"收入";
    self.selectButton.button_lable.textColor  = RGBFormUIColor(0x9A9A9A);
    self.selectButton.button_imageView.image = [UIImage imageNamed:@"zhangHu_downSanJiao"];
    [self.mainTableView.mj_header beginRefreshing];

}
-(void)outcomeButtonClick
{
    [self.allButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    [self.incomeButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
    [self.outcomeButton setTitleColor:RGBFormUIColor(0xFF2474) forState:UIControlStateNormal];
    
    self.duiGouImageView.top = self.outcomeButton.top+(self.outcomeButton.height-9*BiLiWidth)/2;
    self.leiXingSelectView.hidden = YES;

    self.type_id = @"2";
    self.selectButton.tag = 0;
    self.selectButton.button_lable.text = @"支出";
    self.selectButton.button_lable.textColor  = RGBFormUIColor(0x9A9A9A);
    self.selectButton.button_imageView.image = [UIImage imageNamed:@"zhangHu_downSanJiao"];

    [self.mainTableView.mj_header beginRefreshing];
}
-(void)showSelectView
{
    if (self.selectButton.tag==0) {
        
        self.selectButton.tag = 1;
        self.leiXingSelectView.hidden = NO;
        self.selectButton.button_lable.textColor = RGBFormUIColor(0xFF2474);
        self.selectButton.button_imageView.image = [UIImage imageNamed:@"zhangHu_upSanJiao"];

    }
    else
    {
        self.selectButton.tag = 0;
        self.leiXingSelectView.hidden = YES;
        self.selectButton.button_lable.textColor = RGBFormUIColor(0x9A9A9A);
        self.selectButton.button_imageView.image = [UIImage imageNamed:@"zhangHu_downSanJiao"];

    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"金币明细";
    self.type_id = @"";
    
    UIButton * titleKuangButton = [[UIButton alloc] initWithFrame:CGRectMake(15*BiLiWidth, self.topNavView.height+self.topNavView.height, WIDTH_PingMu-30*BiLiWidth, 25*BiLiWidth)];
    titleKuangButton.layer.borderWidth = 1;
    titleKuangButton.layer.borderColor = [RGBFormUIColor(0xEEEEEE) CGColor];
    [self.view addSubview:titleKuangButton];
    
    
    
    UILabel * leiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 52*BiLiWidth,titleKuangButton.height)];
    leiXingLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    leiXingLable.textColor = RGBFormUIColor(0x9A9A9A);
    leiXingLable.layer.borderWidth = 1;
    leiXingLable.layer.borderColor = [RGBFormUIColor(0xEEEEEE) CGColor];
    leiXingLable.text = @"类型";
    leiXingLable.textAlignment = NSTextAlignmentCenter;
    [titleKuangButton addSubview:leiXingLable];
    
    self.selectButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(titleKuangButton.width-47*BiLiWidth, 0, 47*BiLiWidth, titleKuangButton.height)];
    self.selectButton.tag = 0;
    [self.selectButton addTarget:self action:@selector(showSelectView) forControlEvents:UIControlEventTouchUpInside];
    self.selectButton.button_lable.frame = CGRectMake(0, 0, 30*BiLiWidth, titleKuangButton.height);
    self.selectButton.button_lable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.selectButton.button_lable.textColor  = RGBFormUIColor(0x9A9A9A);
    self.selectButton.button_lable.text = @"全部";
    self.selectButton.button_imageView.frame = CGRectMake(30*BiLiWidth, (self.selectButton.height-6.5*BiLiWidth)/2, 10.5*BiLiWidth, 6.5*BiLiWidth);
    self.selectButton.button_imageView.image = [UIImage imageNamed:@"zhangHu_downSanJiao"];
    [titleKuangButton addSubview:self.selectButton];

    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleKuangButton.top+titleKuangButton.height, WIDTH_PingMu, HEIGHT_PingMu-(titleKuangButton.top+titleKuangButton.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tag = 0;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.showsHorizontalScrollIndicator = NO;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainTableView];

        MJRefreshNormalHeader * header1 = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self->page = 1;
            
            [HTTPModel getJinBiMingXiList:[[NSDictionary alloc]initWithObjectsAndKeys:self.type_id,@"type_id",[NSString stringWithFormat:@"%d",self->page],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                
                if (status==1) {
                    
                    self->page = self->page+1;
                    [self.mainTableView.mj_header endRefreshing];

                    NSArray * data = [responseObject objectForKey:@"data"];
                    self.sourceArray = [[NSMutableArray alloc] initWithArray:data];
                    if (data.count>=10) {
                        
                        [self.mainTableView.mj_footer endRefreshing];
                    }
                    else
                    {
                        [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
                    }
                    if ([NormalUse isValidArray:data]) {
                        
                        [self.noMessageTipImageView removeFromSuperview];

                    }
                    else
                    {
                        [self.mainTableView addSubview:self.noMessageTipImageView];

                    }
                    [self.mainTableView reloadData];
                    [self.mainTableView.mj_header endRefreshing];

                }
                else
                {
                    [NormalUse showToastView:msg view:self.view];
                }
            }];
        }];
            
    header1.lastUpdatedTimeLabel.hidden = YES;
    self.mainTableView.mj_header = header1;
    [self.mainTableView.mj_header beginRefreshing];

    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [HTTPModel getJinBiMingXiList:[[NSDictionary alloc]initWithObjectsAndKeys:self.type_id,@"type_id",[NSString stringWithFormat:@"%d",self->page],@"page", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                page = page+1;
                
                [self.mainTableView.mj_header endRefreshing];

                NSArray * data = [responseObject objectForKey:@"data"];
                if (data.count>=10) {
                    
                    [self.mainTableView.mj_footer endRefreshing];
                }
                else
                {
                    [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (NSDictionary * info in data) {
                    
                    [self.sourceArray addObject:info];
                }
                [self.mainTableView reloadData];

            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
            }
        }];

    }];
    self.mainTableView.mj_footer = footer;


}

#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
    return self.sourceArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 52*BiLiWidth;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"JinBiMingXiCell"] ;
    JinBiMingXiCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[JinBiMingXiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    [cell initData:info];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
