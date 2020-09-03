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

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSDictionary * dianPuInfo;//店铺信息
@property(nonatomic,strong)NSArray *  artist_list;//店铺下艺人列表

@end

@implementation DianPuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
   // self.topTitleLale.text = self.dianName;
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.mainTableView.tag = 1002;
    [self.view addSubview:self.mainTableView];

    
    [HTTPModel getDianPuDetail:[[NSDictionary alloc] initWithObjectsAndKeys:self.dianPuId,@"id", nil]
                      callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            self.dianPuInfo = responseObject;
            self.artist_list = [self.dianPuInfo objectForKey:@"artist_list"];
            self.topTitleLale.text = [self.dianPuInfo objectForKey:@"name"];
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
    
    return  197*BiLiWidth+48*BiLiWidth+21*BiLiWidth+8*BiLiWidth;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"DianuDetailListTableViewCell"] ;
    DianuDetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[DianuDetailListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
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
        
        return messageLable.top+messageLable.height+216*BiLiWidth;
        
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
        
        if ([NormalUse isValidArray:[self.dianPuInfo objectForKey:@"images"]]) {
            
            NSArray * images = [self.dianPuInfo objectForKey:@"images"];
            [headerImageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:0]]];
            
        }
        else if ([NormalUse isValidString:[self.dianPuInfo objectForKey:@"images"]])
        {
            [headerImageView sd_setImageWithURL:[NSURL URLWithString:[self.dianPuInfo objectForKey:@"images"]]];
        }


        CGSize titleSize = [NormalUse setSize:[self.dianPuInfo objectForKey:@"name"] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.width+headerImageView.left+9.5*BiLiWidth, headerImageView.top+7*BiLiWidth, titleSize.width, 17*BiLiWidth)];
        titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        titleLable.textColor = RGBFormUIColor(0x333333);
        titleLable.text  = [self.dianPuInfo objectForKey:@"name"];
        [headerView addSubview:titleLable];
        
        UIImageView * vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(titleLable.left+titleLable.width+10*BiLiWidth, titleLable.top+(titleLable.height-13.5*BiLiWidth)/2, 11.5*BiLiWidth, 13.5*BiLiWidth)];
        vipImageView.backgroundColor = [UIColor greenColor];
        [headerView addSubview:vipImageView];
        
        Lable_ImageButton * pingFenButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(titleLable.left, titleLable.top+titleLable.height+7*BiLiWidth, 37*BiLiWidth, 13*BiLiWidth)];
        pingFenButton.button_imageView.frame = CGRectMake(0, 0, 13*BiLiWidth, 13*BiLiWidth);
        pingFenButton.button_imageView.backgroundColor = [UIColor greenColor];
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
        [self.guanZhuButton addTarget:self action:@selector(guanZhuButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.guanZhuButton];
        NSNumber * is_follow = [self.dianPuInfo objectForKey:@"is_follow"];
        if ([is_follow isKindOfClass:[NSNumber class]]) {
            
            if (is_follow.intValue==0) {
                
                self.guanZhuButton.tag = 0;
                [self.guanZhuButton setTitle:@"关注" forState:UIControlStateNormal];

            }
            else
            {
                self.guanZhuButton.tag = 1;
                [self.guanZhuButton setTitle:@"已关注" forState:UIControlStateNormal];

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

        UIImageView * jiaoYiBaoZhengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, messageLable.top+messageLable.height+16*BiLiWidth, 109*BiLiWidth, 18*BiLiWidth)];
        jiaoYiBaoZhengImageView.backgroundColor = [UIColor greenColor];
        [headerView addSubview:jiaoYiBaoZhengImageView];
        
        Lable_ImageButton * jieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, jiaoYiBaoZhengImageView.top+jiaoYiBaoZhengImageView.height+16*BiLiWidth, 321*BiLiWidth, 57*BiLiWidth)];
        [jieSuoButton setBackgroundColor:[UIColor purpleColor]];
        jieSuoButton.button_lable.frame = CGRectMake(19.5*BiLiWidth, 0, 150*BiLiWidth, jieSuoButton.height);
        jieSuoButton.button_lable.font = [UIFont systemFontOfSize:13*BiLiWidth];
        jieSuoButton.button_lable.textColor = RGBFormUIColor(0xFFE1B0);
        jieSuoButton.button_lable.text = @"查看所有联系方式";
        jieSuoButton.button_lable1.frame = CGRectMake(227*BiLiWidth, 0, 150*BiLiWidth, jieSuoButton.height);
        jieSuoButton.button_lable1.font = [UIFont systemFontOfSize:13*BiLiWidth];
        jieSuoButton.button_lable1.textColor = RGBFormUIColor(0xFFE1B0);
        jieSuoButton.button_lable1.text = @"100金币解锁";
        [headerView addSubview:jieSuoButton];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, jieSuoButton.top+jieSuoButton.height+28*BiLiWidth, WIDTH_PingMu, 8*BiLiWidth)];
        lineView.backgroundColor = RGBFormUIColor(0xEDEDED);
        [headerView addSubview:lineView];

        self.pingFenButton = [[UIButton alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView.top+lineView.height+28.5*BiLiWidth, 50*BiLiWidth, 12*BiLiWidth)];
        [self.pingFenButton setTitle:@"评分最高" forState:UIControlStateNormal];
        [self.pingFenButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
        self.pingFenButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        [self.pingFenButton addTarget:self action:@selector(pingFenButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.pingFenButton];
        
        self.zuiXinButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+33*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
        [self.zuiXinButton setTitle:@"最新" forState:UIControlStateNormal];
        self.zuiXinButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        [self.zuiXinButton addTarget:self action:@selector(zuiXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.zuiXinButton];
        
        self.zuiReButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+79*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
        [self.zuiReButton setTitle:@"最热" forState:UIControlStateNormal];
        self.zuiReButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        [self.zuiReButton addTarget:self action:@selector(zuiReButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.zuiReButton];
        
        [self.zuiReButton sendActionsForControlEvents:UIControlEventTouchUpInside];

    }

    
    
    return headerView;
    
}
-(void)pingFenButtonClick
{
}
-(void)zuiXinButtonClick
{
    self.zuiXinOrZuiRe = @"1";
    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
}
-(void)zuiReButtonClick
{
    self.zuiXinOrZuiRe = @"2";

    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];

}


@end
