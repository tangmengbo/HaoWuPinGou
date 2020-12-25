//
//  JingCaiFuLiViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "JingCaiFuLiViewController.h"

@interface JingCaiFuLiViewController ()

@property(nonatomic,strong)NSDictionary * messageInfo;

@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)UILabel * jinBiLable;
@property(nonatomic,strong)UILabel * danWeiLable;
@property(nonatomic,strong)UILabel * daoJiShiLable;

@property(nonatomic,strong)UILabel * numberLable;
@property(nonatomic,strong)UIButton * jinBiGouMaiButton;

@property(nonatomic,strong)Lable_ImageButton * vipButton;

@property(nonatomic,strong)Lable_ImageButton * haoYouShangXianButton;

@property(nonatomic,strong)UIButton * haoYouShangXianLingQuButton;

@property(nonatomic,strong)UIButton * vipLingQuButton;

@property(nonatomic,strong)UIView * guiZeShuoMingKuangView;

@property(nonatomic,strong)NSArray * duiJiangHaoMaArray;
@property(nonatomic,strong)UIView * duiJiangHaoMaKuangView;


@property(nonatomic,strong)UIView * lingQuDuiJiangMaTipView;
@end

@implementation JingCaiFuLiViewController

-(UIView *)lingQuDuiJiangMaTipView
{
    if (!_lingQuDuiJiangMaTipView) {
        
        _lingQuDuiJiangMaTipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _lingQuDuiJiangMaTipView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [[UIApplication sharedApplication].keyWindow addSubview:_lingQuDuiJiangMaTipView];
        
        UIView * kuangView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-274*BiLiWidth)/2, 287*BiLiWidth, 274*BiLiWidth)];
        kuangView.layer.cornerRadius = 8*BiLiWidth;
        kuangView.layer.masksToBounds = YES;
        kuangView.backgroundColor = [UIColor whiteColor];
        [_lingQuDuiJiangMaTipView addSubview:kuangView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangView.left+kuangView.width-33*BiLiWidth/2*1.5, kuangView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeLingQuDuiJiangMaTipView) forControlEvents:UIControlEventTouchUpInside];
        [_lingQuDuiJiangMaTipView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33*BiLiWidth, kuangView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"提示";
        [kuangView addSubview:tipLable1];
        
        UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(20*BiLiWidth, tipLable1.top+tipLable1.height+18*BiLiWidth, kuangView.width-40*BiLiWidth, 34*BiLiWidth)];
        tipLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
        tipLable2.textColor = RGBFormUIColor(0x333333);
        tipLable2.textAlignment = NSTextAlignmentCenter;
        tipLable2.text = @"恭喜您已成功领取兑奖号码，您可到购买记录中查看兑奖码信息";
        tipLable2.numberOfLines = 2;
        [kuangView addSubview:tipLable2];
        
        UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangView.width-209*BiLiWidth)/2, tipLable2.top+tipLable2.height+20*BiLiWidth, 209*BiLiWidth, 40*BiLiWidth)];
        [sureButton addTarget:self action:@selector(closeLingQuDuiJiangMaTipView) forControlEvents:UIControlEventTouchUpInside];
        [kuangView addSubview:sureButton];
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
        
        UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sureButton.width, sureButton.height)];
        tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        tiJiaoLable.text = @"我知道了";
        tiJiaoLable.textAlignment = NSTextAlignmentCenter;
        tiJiaoLable.textColor = [UIColor whiteColor];
        [sureButton addSubview:tiJiaoLable];

        kuangView.height = sureButton.top+sureButton.height+30*BiLiWidth;
        kuangView.top = (HEIGHT_PingMu-kuangView.height)/2;
        closeButton.top = kuangView.top-33*BiLiWidth/2;
        
    }
    return _lingQuDuiJiangMaTipView;
}
-(void)closeLingQuDuiJiangMaTipView
{
    self.lingQuDuiJiangMaTipView.hidden = YES;
}

-(void)initDuiJiangHaoMaKuangView
{
    
    [self.duiJiangHaoMaKuangView removeFromSuperview];

    
    self.duiJiangHaoMaKuangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    self.duiJiangHaoMaKuangView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [[UIApplication sharedApplication].keyWindow addSubview:self.duiJiangHaoMaKuangView];
    
    
    UIView * kuangView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-274*BiLiWidth)/2, 287*BiLiWidth, 274*BiLiWidth)];
    kuangView.layer.cornerRadius = 8*BiLiWidth;
    kuangView.layer.masksToBounds = YES;
    kuangView.backgroundColor = [UIColor whiteColor];
    [self.duiJiangHaoMaKuangView addSubview:kuangView];
    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangView.left+kuangView.width-33*BiLiWidth/2*1.5, kuangView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.duiJiangHaoMaKuangView addSubview:closeButton];
    
    UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33*BiLiWidth, kuangView.width, 17*BiLiWidth)];
    tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
    tipLable1.textColor = RGBFormUIColor(0x343434);
    tipLable1.textAlignment = NSTextAlignmentCenter;
    tipLable1.text = @"兑奖号码";
    [kuangView addSubview:tipLable1];
    
    UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, tipLable1.top+tipLable1.height+20*BiLiWidth, kuangView.width, 14*BiLiWidth)];
    tipLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
    tipLable2.textColor = RGBFormUIColor(0x333333);
    tipLable2.textAlignment = NSTextAlignmentCenter;
    tipLable2.text = @"金币越多中奖概率越大";
    [kuangView addSubview:tipLable2];
    
    UIScrollView * duiJianScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, tipLable2.top+tipLable2.height+20*BiLiWidth, kuangView.width, 0)];
    duiJianScrollView.showsVerticalScrollIndicator = NO;
    duiJianScrollView.showsHorizontalScrollIndicator = NO;
    [kuangView addSubview:duiJianScrollView];
    
    
    float originY = 0;
    float originX = (kuangView.width-20*BiLiWidth*6)/7;
    for (int i=0; i<self.duiJiangHaoMaArray.count; i++) {
        
        NSNumber * number = [self.duiJiangHaoMaArray objectAtIndex:i];
        NSString * str = [NSString stringWithFormat:@"%d",number.intValue];
        NSMutableArray * sourceArray = [NSMutableArray array];
        for (int j=0; j<str.length; j++) {
            [sourceArray addObject:[str substringWithRange:NSMakeRange(j, 1)]];
        }
        
        for (int e=0; e<sourceArray.count; e++) {
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originX+(20*BiLiWidth+originX)*e, originY, 20*BiLiWidth, 20*BiLiWidth)];
            [button setBackgroundImage:[UIImage imageNamed:@"duiJiangHaoMa_bg"] forState:UIControlStateNormal];
            [button setTitle:[sourceArray objectAtIndex:e] forState:UIControlStateNormal];
            [button setTitleColor:RGBFormUIColor(0xFFFFFF) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
            [duiJianScrollView addSubview:button];
        }
        originY = originY+15*BiLiWidth+20*BiLiWidth;
        originX = (kuangView.width-20*BiLiWidth*6)/7;
    }
    if (originY>300*BiLiHeight) {
        
        duiJianScrollView.height = 300*BiLiHeight;
        [duiJianScrollView setContentSize:CGSizeMake(duiJianScrollView.width, originY)];
    }
    else
    {
        duiJianScrollView.height = originY;
    }
    UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangView.width-209*BiLiWidth)/2, duiJianScrollView.top+duiJianScrollView.height+20*BiLiWidth, 209*BiLiWidth, 40*BiLiWidth)];
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [kuangView addSubview:sureButton];
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
    
    UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sureButton.width, sureButton.height)];
    tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiJiaoLable.text = @"我知道了";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [sureButton addSubview:tiJiaoLable];
    
    
    kuangView.height = sureButton.top+sureButton.height+30*BiLiWidth;
    kuangView.top = (HEIGHT_PingMu-kuangView.height)/2;
    closeButton.top = kuangView.top-33*BiLiWidth/2;
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(void)sureButtonClick
{
    [self.duiJiangHaoMaKuangView removeFromSuperview];
}
-(UIView *)guiZeShuoMingKuangView
{
    if (!_guiZeShuoMingKuangView) {
        
        _guiZeShuoMingKuangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _guiZeShuoMingKuangView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [[UIApplication sharedApplication].keyWindow addSubview:_guiZeShuoMingKuangView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-274*BiLiWidth)/2, 287*BiLiWidth, 274*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [_guiZeShuoMingKuangView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [_guiZeShuoMingKuangView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"规则说明";
        [kuangImageView addSubview:tipLable1];
        
        self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(39*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiHeight,kuangImageView.width-39*BiLiWidth*2,152*BiLiWidth)];
        self.contentTextView.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.contentTextView.textColor = RGBFormUIColor(0x343434);
        self.contentTextView.editable = NO;
        self.contentTextView.backgroundColor = [UIColor clearColor];
        [kuangImageView addSubview:self.contentTextView];
    }
    return _guiZeShuoMingKuangView;
}

-(void)closeTipKuangView
{
    self.guiZeShuoMingKuangView.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self xianShiTabBar];
    NSNumber * auth_vip = [NormalUse defaultsGetObjectKey:@"UserAlsoVip"];

    if (auth_vip.intValue==3) {//蛟龙炮神卡
        
        self.vipButton.button_lable1.text = [NSString stringWithFormat:@"永久VIP用户每日可免费领取%@组兑奖号码",[NormalUse getJinBiStr:@"svip_ticket_nums_day"]];
        self.vipButton.button_lable.text = [NSString stringWithFormat:@"永久VIP免费领取%@组兑奖号码",[NormalUse getJinBiStr:@"svip_ticket_nums_day"]];

    }
    else if (auth_vip.intValue==2)
    {
        self.vipButton.button_lable1.text = [NSString stringWithFormat:@"VIP用户每日可免费领取%@组兑奖号码",[NormalUse getJinBiStr:@"vip_ticket_nums_day"]];//svip_ticket_nums_day
        self.vipButton.button_lable.text = [NSString stringWithFormat:@"VIP免费领取%@组兑奖号码",[NormalUse getJinBiStr:@"vip_ticket_nums_day"]];

    }
    else
    {
        self.vipButton.button_lable1.text = [NSString stringWithFormat:@"VIP用户每日可免费领取%@组兑奖号码",[NormalUse getJinBiStr:@"vip_ticket_nums_day"]];
        self.vipButton.button_lable.text = [NSString stringWithFormat:@"VIP免费领取%@组兑奖号码",[NormalUse getJinBiStr:@"vip_ticket_nums_day"]];

    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    number = 1;
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu-BottomHeight_PingMu)];
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu*767/360)];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
    }
    [self.view addSubview:self.mainScrollView];
    
    MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mainScrollView.mj_header = mjHeader;

    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, WIDTH_PingMu*767/360)];
    bottomImageView.image = [UIImage imageNamed:@"fuLi_bg"];
    bottomImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:bottomImageView];
    
    self.topNavView.backgroundColor = [UIColor clearColor];
    self.lineView.hidden = YES;
    self.backImageView.hidden = YES;
    [bottomImageView addSubview:self.topNavView];

    self.topTitleLale.text = @"精彩福利";
    self.topTitleLale.font = [UIFont systemFontOfSize:17*BiLiWidth];
    self.topTitleLale.textColor = RGBFormUIColor(0xFFFFFF);
    
    
    Lable_ImageButton * kaiJiangJiLuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-11.5*BiLiWidth-69.5*BiLiWidth, 0, 69*BiLiWidth, self.topNavView.height)];
    kaiJiangJiLuButton.button_imageView.frame = CGRectMake(0, (kaiJiangJiLuButton.height-14*BiLiWidth)/2, 14*BiLiWidth, 14*BiLiWidth);
    kaiJiangJiLuButton.button_imageView.image = [UIImage imageNamed:@"fuLi_jiLu"];
    kaiJiangJiLuButton.button_lable.frame = CGRectMake(kaiJiangJiLuButton.button_imageView.left+kaiJiangJiLuButton.button_imageView.width+5*BiLiWidth, 0, 50*BiLiWidth, kaiJiangJiLuButton.height);
    kaiJiangJiLuButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    kaiJiangJiLuButton.button_lable.textColor = RGBFormUIColor(0xFFFFFF);
    kaiJiangJiLuButton.button_lable.text = @"开奖记录";
    [kaiJiangJiLuButton addTarget:self action:@selector(kaiJiangListButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topNavView addSubview:kaiJiangJiLuButton];


    
    UILabel * jiangJinTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+28*BiLiWidth, WIDTH_PingMu, 12*BiLiWidth)];
    jiangJinTipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    jiangJinTipLable.textAlignment = NSTextAlignmentCenter;
    jiangJinTipLable.textColor = RGBFormUIColor(0x333333);
    jiangJinTipLable.text = @"奖金累积";
    [bottomImageView addSubview:jiangJinTipLable];
    
    CGSize size = [NormalUse setSize:@"0" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:22*BiLiWidth];
    self.jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH_PingMu-size.width)/2, jiangJinTipLable.top+jiangJinTipLable.height+15*BiLiWidth, size.width, 22*BiLiWidth)];
    self.jinBiLable.textColor = RGBFormUIColor(0xFFA217);
    self.jinBiLable.font = [UIFont systemFontOfSize:22*BiLiWidth];
    [bottomImageView addSubview:self.jinBiLable];
    
    self.danWeiLable = [[UILabel alloc] initWithFrame:CGRectMake(self.jinBiLable.left+self.jinBiLable.width+12*BiLiWidth, self.jinBiLable.top+6*BiLiWidth, 50, 13*BiLiWidth)];
    self.danWeiLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.danWeiLable.textColor = RGBFormUIColor(0x333333);
    self.danWeiLable.text = @"金币";
    [bottomImageView addSubview:self.danWeiLable];
    
    self.daoJiShiLable = [[UILabel alloc] initWithFrame:CGRectMake(26.5*BiLiWidth, self.jinBiLable.top+self.jinBiLable.height+21*BiLiWidth, 250*BiLiWidth, 11*BiLiWidth)];
    self.daoJiShiLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    self.daoJiShiLable.textColor = RGBFormUIColor(0x999999);
    [bottomImageView addSubview:self.daoJiShiLable];

    
    UIView * controlView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-171.5*BiLiWidth-137*BiLiWidth)/2, self.daoJiShiLable.top+self.daoJiShiLable.height+5.5*BiLiWidth, 171.5*BiLiWidth+137*BiLiWidth, 40*BiLiWidth)];
    controlView.layer.cornerRadius = 5*BiLiWidth;
    controlView.layer.masksToBounds = YES;
    controlView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [bottomImageView addSubview:controlView];
    
    UIButton * jianButton = [[UIButton alloc] initWithFrame:CGRectMake(17*BiLiWidth, 10*BiLiWidth, 20*BiLiWidth, 20*BiLiWidth)];
    [jianButton setBackgroundImage:[UIImage imageNamed:@"number_jian"] forState:UIControlStateNormal];
    [jianButton addTarget:self action:@selector(jianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:jianButton];
    
    self.numberLable = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, 0, 97.5*BiLiWidth, controlView.height)];
    self.numberLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.numberLable.textColor = RGBFormUIColor(0xFFA217);
    self.numberLable.textAlignment = NSTextAlignmentCenter;
    self.numberLable.text = @"1";
    [controlView addSubview:self.numberLable];
    
    UIButton * jiaButton = [[UIButton alloc] initWithFrame:CGRectMake(self.numberLable.left+self.numberLable.width, 10*BiLiWidth, 20*BiLiWidth, 20*BiLiWidth)];
    [jiaButton setBackgroundImage:[UIImage imageNamed:@"number_jia"] forState:UIControlStateNormal];
    [jiaButton addTarget:self action:@selector(jiaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:jiaButton];
    
    self.ticket_buy_coin = [NormalUse getJinBiStr:@"ticket_buy_coin"];
    
    self.jinBiGouMaiButton = [[UIButton alloc] initWithFrame:CGRectMake(171.5*BiLiWidth, 0, 137*BiLiWidth, 40*BiLiWidth)];
    self.jinBiGouMaiButton.backgroundColor = RGBFormUIColor(0x333333);
    [self.jinBiGouMaiButton setTitleColor:RGBFormUIColor(0xFFFFFF) forState:UIControlStateNormal];
    [self.jinBiGouMaiButton setTitle:[NSString stringWithFormat:@"%@金币购买",self.ticket_buy_coin] forState:UIControlStateNormal];
    self.jinBiGouMaiButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
    [self.jinBiGouMaiButton addTarget:self action:@selector(jinBiGouMaiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:self.jinBiGouMaiButton];
    
    float originY;
    if (TopHeight_PingMu==35) {
        
        originY = 27*BiLiHeight;

    }
    else
    {
        originY = 47*BiLiHeight;
    }
    Lable_ImageButton * shuoMingButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(23*BiLiWidth, controlView.top+controlView.height+originY, 69*BiLiWidth, 14*BiLiWidth)];
    shuoMingButton.button_imageView.frame = CGRectMake(0, 0, 14*BiLiWidth, 14*BiLiWidth);
    shuoMingButton.button_imageView.image = [UIImage imageNamed:@"fuLi_shuoMing"];
    shuoMingButton.button_lable.frame = CGRectMake(shuoMingButton.button_imageView.left+shuoMingButton.button_imageView.width+5*BiLiWidth, shuoMingButton.button_imageView.top, 50*BiLiWidth, 14*BiLiWidth);
    shuoMingButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    shuoMingButton.button_lable.textColor = RGBFormUIColor(0xFFFFFF);
    shuoMingButton.button_lable.text = @"规则说明";
    [shuoMingButton addTarget:self action:@selector(shuoMingButton) forControlEvents:UIControlEventTouchUpInside];
    [bottomImageView addSubview:shuoMingButton];
    
    
    Lable_ImageButton * gouMaiJiLuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(271*BiLiWidth, shuoMingButton.top, 69*BiLiWidth, 14*BiLiWidth)];
    gouMaiJiLuButton.button_imageView.frame = CGRectMake(0, 0, 14*BiLiWidth, 14*BiLiWidth);
    gouMaiJiLuButton.button_imageView.image = [UIImage imageNamed:@"fuLi_jiLu"];
    gouMaiJiLuButton.button_lable.frame = CGRectMake(shuoMingButton.button_imageView.left+shuoMingButton.button_imageView.width+5*BiLiWidth, shuoMingButton.button_imageView.top, 50*BiLiWidth, 14*BiLiWidth);
    gouMaiJiLuButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    gouMaiJiLuButton.button_lable.textColor = RGBFormUIColor(0xFFFFFF);
    gouMaiJiLuButton.button_lable.text = @"购买记录";
    [bottomImageView addSubview:gouMaiJiLuButton];
    [gouMaiJiLuButton addTarget:self action:@selector(gouMaiJiLuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    


    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(32*BiLiWidth, gouMaiJiLuButton.top+gouMaiJiLuButton.height+90*BiLiWidth, 100*BiLiWidth, 15*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0x333333);
    tipLable.text = @"免费领取金币";
    [bottomImageView addSubview:tipLable];
    
    //VIP免费领取1组兑奖号码
    self.vipButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, tipLable.top+tipLable.height+20*BiLiWidth, WIDTH_PingMu, 33*BiLiWidth)];
    self.vipButton.button_imageView.frame = CGRectMake(32*BiLiWidth, 0, 33*BiLiWidth, 33*BiLiWidth);
    self.vipButton.button_imageView.image = [UIImage imageNamed:@"vip_lingQuChouJiang"];
    self.vipButton.button_lable.frame = CGRectMake(self.vipButton.button_imageView.left+self.vipButton.button_imageView.width+7*BiLiWidth, 0, 200*BiLiWidth, 12*BiLiWidth);
    self.vipButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.vipButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.vipButton.button_lable.text = [NSString stringWithFormat:@"VIP免费领取%@组兑奖号码",[NormalUse getJinBiStr:@"vip_ticket_nums_day"]];
    self.vipButton.button_lable1.frame = CGRectMake(self.vipButton.button_lable.left, self.vipButton.button_lable.top+self.vipButton.button_lable.height+5.5*BiLiWidth, 200*BiLiWidth, 10*BiLiWidth);
    self.vipButton.button_lable1.font = [UIFont systemFontOfSize:10*BiLiWidth];
    self.vipButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    self.vipButton.button_lable1.text = [NSString stringWithFormat:@"VIP用户每日可免费领取%@组兑奖号码",[NormalUse getJinBiStr:@"vip_ticket_nums_day"]];
    
    [bottomImageView addSubview:self.vipButton];

    self.vipLingQuButton = [[UIButton alloc] initWithFrame:CGRectMake(271*BiLiWidth, (self.vipButton.height-21*BiLiWidth)/2, 52*BiLiWidth, 21*BiLiWidth)];
    self.vipLingQuButton.layer.cornerRadius = 21*BiLiWidth/2;
    self.vipLingQuButton.backgroundColor = RGBFormUIColor(0xFFA217);
    [self.vipLingQuButton setTitle:@"领取" forState:UIControlStateNormal];
    [self.vipLingQuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.vipLingQuButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [self.vipLingQuButton addTarget:self action:@selector(vipLingQuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.vipButton addSubview:self.vipLingQuButton];

    //好友每日上线1次获得50金币
    self.haoYouShangXianButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, self.vipButton.top+self.vipButton.height+23*BiLiWidth, WIDTH_PingMu, 33*BiLiWidth)];
    self.haoYouShangXianButton.button_imageView.frame = CGRectMake(32*BiLiWidth, 0, 33*BiLiWidth, 33*BiLiWidth);
    self.haoYouShangXianButton.button_imageView.image = [UIImage imageNamed:@"haoYouShangXian_lingJinBi"];
    self.haoYouShangXianButton.button_lable.frame = CGRectMake(self.vipButton.button_imageView.left+self.vipButton.button_imageView.width+7*BiLiWidth, 0, 200*BiLiWidth, 12*BiLiWidth);
    self.haoYouShangXianButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.haoYouShangXianButton.button_lable.textColor = RGBFormUIColor(0x333333);
    self.haoYouShangXianButton.button_lable.text = [NSString stringWithFormat:@"好友每日上线1次获得%@金币",[NormalUse getJinBiStr:@"ticket_coin_day"]];
    self.haoYouShangXianButton.button_lable1.frame = CGRectMake(self.vipButton.button_lable.left, self.vipButton.button_lable.top+self.vipButton.button_lable.height+5.5*BiLiWidth, 200*BiLiWidth, 10*BiLiWidth);
    self.haoYouShangXianButton.button_lable1.font = [UIFont systemFontOfSize:10*BiLiWidth];
    self.haoYouShangXianButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    [bottomImageView addSubview:self.haoYouShangXianButton];

    self.haoYouShangXianLingQuButton = [[UIButton alloc] initWithFrame:CGRectMake(271*BiLiWidth, (self.vipButton.height-21*BiLiWidth)/2, 52*BiLiWidth, 21*BiLiWidth)];
    self.haoYouShangXianLingQuButton.layer.cornerRadius = 21*BiLiWidth/2;
    self.haoYouShangXianLingQuButton.backgroundColor = RGBFormUIColor(0xFFA217);
    [self.haoYouShangXianLingQuButton setTitle:@"领取" forState:UIControlStateNormal];
    [self.haoYouShangXianLingQuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.haoYouShangXianLingQuButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [self.haoYouShangXianLingQuButton addTarget:self action:@selector(haoYouShangXianLingQuButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self.haoYouShangXianButton addSubview:self.haoYouShangXianLingQuButton];
    
    
    [self.mainScrollView.mj_header beginRefreshing];

    /*
    //每4小时可领取50金币一次
    Lable_ImageButton * fourHoursLingQuButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, haoYouShangXianButton.top+haoYouShangXianButton.height+23*BiLiWidth, WIDTH_PingMu, 33*BiLiWidth)];
    fourHoursLingQuButton.button_imageView.frame = CGRectMake(32*BiLiWidth, 0, 33*BiLiWidth, 33*BiLiWidth);
    fourHoursLingQuButton.button_imageView.backgroundColor = [UIColor redColor];
    fourHoursLingQuButton.button_lable.frame = CGRectMake(vipButton.button_imageView.left+vipButton.button_imageView.width+7*BiLiWidth, 0, 200*BiLiWidth, 12*BiLiWidth);
    fourHoursLingQuButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    fourHoursLingQuButton.button_lable.textColor = RGBFormUIColor(0x333333);
    fourHoursLingQuButton.button_lable.text = @"每4小时可领取50金币一次";
    fourHoursLingQuButton.button_lable1.frame = CGRectMake(vipButton.button_lable.left, vipButton.button_lable.top+vipButton.button_lable.height+5.5*BiLiWidth, 160*BiLiWidth, 10*BiLiWidth);
    fourHoursLingQuButton.button_lable1.font = [UIFont systemFontOfSize:10*BiLiWidth];
    fourHoursLingQuButton.button_lable1.textColor = RGBFormUIColor(0x999999);
    fourHoursLingQuButton.button_lable1.text = @"邀请好友一名以上可免费领取，最高可得5000金币";
    [bottomImageView addSubview:fourHoursLingQuButton];

    UIButton * fhLingQuButton = [[UIButton alloc] initWithFrame:CGRectMake(271*BiLiWidth, (vipButton.height-21*BiLiWidth)/2, 52*BiLiWidth, 21*BiLiWidth)];
    fhLingQuButton.layer.cornerRadius = 21*BiLiWidth/2;
    fhLingQuButton.backgroundColor = RGBFormUIColor(0xFFA217);
    [fhLingQuButton setTitle:@"领取" forState:UIControlStateNormal];
    [fhLingQuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fhLingQuButton.titleLabel.font = [UIFont systemFontOfSize:11*BiLiWidth];
    [fourHoursLingQuButton addSubview:fhLingQuButton];


    */
    
    self.guiZeShuoMingKuangView.hidden = YES;

}
-(void)loadNewLsit
{
    [HTTPModel getHuoDongHomeInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [self.mainScrollView.mj_header endRefreshing];
        if (status==1) {
            
            self.messageInfo = responseObject;
            
            NSNumber * friend_online_nums = [self.messageInfo objectForKey:@"friend_online_nums"];
            self.haoYouShangXianButton.button_lable1.text = [NSString stringWithFormat:@"今日上线人数%d人",friend_online_nums.intValue];
            
            NSNumber * can_get_ticket = [self.messageInfo objectForKey:@"can_get_ticket"];
            if (can_get_ticket.intValue==0) {
             
                self.vipLingQuButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
                [self.vipLingQuButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
                self.vipLingQuButton.enabled = NO;
            }
            else
            {
                self.vipLingQuButton.backgroundColor = RGBFormUIColor(0xFFA217);
                [self.vipLingQuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.vipLingQuButton.enabled = YES;


            }
            NSNumber * can_get_coin = [self.messageInfo objectForKey:@"can_get_coin"];
            if (can_get_coin.intValue==0) {
                
                [self.haoYouShangXianLingQuButton setBackgroundColor:RGBFormUIColor(0xEEEEEE)];
                [self.haoYouShangXianLingQuButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
                self.haoYouShangXianLingQuButton.enabled = NO;
            }
            else
            {
                self.haoYouShangXianLingQuButton.backgroundColor = RGBFormUIColor(0xFFA217);
                [self.haoYouShangXianLingQuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.haoYouShangXianLingQuButton.enabled = YES;
            }

            
            
            NSNumber * base_coinNumber = [self.messageInfo objectForKey:@"base_coin"];
            NSString * base_coinStr = [NSString stringWithFormat:@"%d",base_coinNumber.intValue];
            
            CGSize size = [NormalUse setSize:base_coinStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:22*BiLiWidth];
            self.jinBiLable.left = (WIDTH_PingMu-size.width)/2;
            self.jinBiLable.width = size.width;
            self.jinBiLable.text = base_coinStr;
            self.danWeiLable.left = self.jinBiLable.left+self.jinBiLable.width+12*BiLiWidth;
            //当前时间
            NSString *timeSpNow = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970])];
            NSNumber * draw_time = [self.messageInfo objectForKey:@"draw_time"];//开奖时间
            NSTimeInterval timeSpNowInt = [timeSpNow doubleValue];
            NSTimeInterval timeSpInt = [draw_time doubleValue];
            
            self->shengYuTime = (int)difftime(timeSpInt, timeSpNowInt);
            
            if (self->shengYuTime>0) {
                
                [self.timer invalidate];
                self.timer = nil;
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRecord) userInfo:nil repeats:YES];

            }
            else
            {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"距离下次开奖时间还有%@天%@时%@分%@秒",@"00",@"00",@"00",@"00"]];
                [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(10, 2)];
                [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(13, 2)];
                [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(16, 2)];
                [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(19, 2)];
                self.daoJiShiLable.attributedText = str;

            }
            
            NSString * contentStr = [self.messageInfo objectForKey:@"rules"];
//            self.contentTextView.text = contentStr;
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            self.contentTextView.attributedText = attrStr;
//            [self.contentTextView sizeToFit];
            
            [self.mainScrollView setContentSize:CGSizeMake(self.mainScrollView.width, self.contentTextView.top+self.contentTextView.height)];

        }
    }];

}
#pragma mark -- NSTimer_Action
-(void)timerRecord
{
    //eg:总共十分钟 600秒
    shengYuTime --;
    
    int shengYuDay = shengYuTime/(3600*24);
    
    NSString *  dayStr = shengYuDay >= 10 ? [NSString stringWithFormat:@"%d",shengYuDay] : [NSString stringWithFormat:@"0%d",shengYuDay];

    
    int shengYuHour = (shengYuTime%(3600*24))/3600;
    
    NSString *  hourStr = shengYuHour >= 10 ? [NSString stringWithFormat:@"%d",shengYuHour] : [NSString stringWithFormat:@"0%d",shengYuHour];

    
    int shengYuMinutes = (shengYuTime%3600)/60;
    
    NSString *  minutesStr = shengYuMinutes >= 10 ? [NSString stringWithFormat:@"%d",shengYuMinutes] : [NSString stringWithFormat:@"0%d",shengYuMinutes];
    
    int shengYusecond = shengYuTime%60;
    
    NSString * secondStr = shengYusecond >= 10 ? [NSString stringWithFormat:@"%d",shengYusecond] : [NSString stringWithFormat:@"0%d",shengYusecond];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"距离下次开奖时间还有%@天%@时%@分%@秒",dayStr,hourStr,minutesStr,secondStr]];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(10, 2)];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(13, 2)];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(16, 2)];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFA217) range:NSMakeRange(19, 2)];
    self.daoJiShiLable.attributedText = str;
}

#pragma mark -- UIButtonClick

-(void)vipLingQuButtonClick
{
    
    NSNumber * idNumber = [self.messageInfo objectForKey:@"id"];

    [HTTPModel buyTicket:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"nums",[NSString stringWithFormat:@"%d",idNumber.intValue],@"ticket_id",@"1",@"vip_ticket_flag", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.lingQuDuiJiangMaTipView.hidden = NO;

            [self loadNewLsit];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
}
-(void)haoYouShangXianLingQuButtonClick
{
    [HTTPModel getFriendCoins:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            [NormalUse showToastView:@"领取成功" view:self.view];
            [self loadNewLsit];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }

    }];
}
-(void)jianButtonClick
{
    if (number>1) {
     
        number --;
        self.numberLable.text = [NSString stringWithFormat:@"%d",number];
        [self.jinBiGouMaiButton setTitle:[NSString stringWithFormat:@"%d金币购买",number*self.ticket_buy_coin.intValue] forState:UIControlStateNormal];

    }
}
-(void)jiaButtonClick
{
    number ++;
    self.numberLable.text = [NSString stringWithFormat:@"%d",number];
    [self.jinBiGouMaiButton setTitle:[NSString stringWithFormat:@"%d金币购买",number*self.ticket_buy_coin.intValue] forState:UIControlStateNormal];

}
-(void)jinBiGouMaiButtonClick
{
    NSNumber * idNumber = [self.messageInfo objectForKey:@"id"];
    [HTTPModel buyTicket:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",number],@"nums",[NSString stringWithFormat:@"%d",idNumber.intValue],@"ticket_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.duiJiangHaoMaArray = responseObject;
            [self initDuiJiangHaoMaKuangView];
            [NormalUse showToastView:@"购买成功" view:self.view];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
    
}
-(void)shuoMingButton
{
    self.guiZeShuoMingKuangView.hidden = NO;

}
-(void)kaiJiangListButtonClick
{
    KaiJiangJiLuListViewController * vc = [[KaiJiangJiLuListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)gouMaiJiLuButtonClick
{
    GouMaiJiLuListViewController * vc = [[GouMaiJiLuListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
