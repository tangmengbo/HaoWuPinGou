//
//  GaoDuanViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "GaoDuanViewController.h"
#import "GaoDuanHomeCell.h"
#import "GaoDuanShaiXuanView.h"
#import "JiaoSeWeiRenZhengFaTieVC.h"

@interface GaoDuanViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,ForeignCityListViewControllerDelegate,CityListViewControllerDelegate>
{
    NvShenListViewController * nvShenListVC;
    WaiWeiListViewController * waiWeiVC;
    PeiWanListViewController * peiWanVC;
}

@property(nonatomic,strong)UILabel * locationLable;

@property(nonatomic,strong)NSMutableArray * listButtonArray;

@property(nonatomic,strong)UIScrollView * contentScrollView;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong,nullable)NewPagedFlowView *pageView;
@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)Lable_ImageButton * pingFenButton;

@property(nonatomic,strong)UIButton * zuiXinButton;
@property(nonatomic,strong)UIButton * zuiReButton;

@property(nonatomic,strong)UIView * itemButtonContentView;
@property(nonatomic,strong)Lable_ImageButton * pingFenButton1;
@property(nonatomic,strong)UIButton * zuiXinButton1;
@property(nonatomic,strong)UIButton * zuiReButton1;

@property(nonatomic,assign)CGFloat  lastcontentOffset;

@property(nonatomic,strong)NSString * zuiXinOrZuiRe;//1 最新 2 最热

@property(nonatomic,strong)NSArray * guanFangTuiJianDianPuArray;//官方推荐列表

@property(nonatomic,strong)NSMutableArray * jingJiRenListArray;//官方推荐列表

@property(nonatomic,strong)GaoDuanShaiXuanView * gaoDuanShaiXuanView;

@property(nonatomic,strong)NSString * shaiXuanLeiXingStr;//删选的类型

@property(nonatomic,strong)NSString * field;
@property(nonatomic,strong)NSString * order;

@property(nonatomic,strong)UIView * sanDaJiaSeFaTieRenZhengView;
@property(nonatomic,strong)UILabel * sanDaJiaSeFaTieRenZhengViewTipLable;
@property(nonatomic,strong)UIButton * sanDaJiaSeFaTieRenZhengViewFaTieButton;
@property(nonatomic,strong)NSString * renZhengType;
@property(nonatomic,assign)int   renZhengStatus;
@end

@implementation GaoDuanViewController

-(UIView *)jingJiRenRenZhengTipView
{
    if (!_jingJiRenRenZhengTipView) {
        
        _jingJiRenRenZhengTipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _jingJiRenRenZhengTipView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [[UIApplication sharedApplication].keyWindow addSubview:_jingJiRenRenZhengTipView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-274*BiLiWidth)/2, 287*BiLiWidth, 274*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [_jingJiRenRenZhengTipView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeChaXiaoErRenZhengTipView) forControlEvents:UIControlEventTouchUpInside];
        [_jingJiRenRenZhengTipView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33.5*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"提示";
        [kuangImageView addSubview:tipLable1];
        
        UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 80*BiLiWidth)];
        tipLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
        tipLable2.textColor = RGBFormUIColor(0x343434);
        tipLable2.numberOfLines = 4;
        tipLable2.text = @"要求真实妹子数量大于5人，认证后拥有官方独立信息展示区、官方推荐资格和官方认证标识同时平台给予更多流量扶持";
        [kuangImageView addSubview:tipLable2];
        
        
        UIButton * faTieButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-85.5*BiLiWidth-11.5*BiLiWidth-115*BiLiWidth)/2, tipLable2.top+tipLable2.height+25*BiLiWidth, 85.5*BiLiWidth, 40*BiLiWidth)];
        [faTieButton setTitle:@"取消" forState:UIControlStateNormal];
        faTieButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
        faTieButton.layer.cornerRadius = 20*BiLiWidth;
        [faTieButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        faTieButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [faTieButton addTarget:self action:@selector(closeChaXiaoErRenZhengTipView) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:faTieButton];

        
        UIButton * renZhengButton = [[UIButton alloc] initWithFrame:CGRectMake(faTieButton.left+faTieButton.width+11.5*BiLiWidth, faTieButton.top, 115*BiLiWidth, 40*BiLiWidth)];
        [renZhengButton addTarget:self action:@selector(chaXiaoErRenZhengTipViewRenZhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:renZhengButton];
        
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = renZhengButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [renZhengButton.layer addSublayer:gradientLayer1];
        
        UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, renZhengButton.width, renZhengButton.height)];
        sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        sureLable.text = @"继续认证";
        sureLable.textAlignment = NSTextAlignmentCenter;
        sureLable.textColor = [UIColor whiteColor];
        [renZhengButton addSubview:sureLable];
        
    }
    return _jingJiRenRenZhengTipView;
}
-(void)closeChaXiaoErRenZhengTipView
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.jingJiRenRenZhengTipView.transform = CGAffineTransformMakeScale(0.1, 0.1);

    } completion:^(BOOL finished) {
             
        self.jingJiRenRenZhengTipView.hidden = YES;

    }];
}

-(void)chaXiaoErRenZhengTipViewRenZhengButtonClick
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.jingJiRenRenZhengTipView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
    } completion:^(BOOL finished) {
        
        self.jingJiRenRenZhengTipView.hidden = YES;

    }];
    
    JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
    vc.renZhengType = @"2";
    [self.navigationController pushViewController:vc animated:YES];

}

-(UIView *)sanDaJiaSeFaTieRenZhengView
{
    if (!_sanDaJiaSeFaTieRenZhengView) {
        
        _sanDaJiaSeFaTieRenZhengView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _sanDaJiaSeFaTieRenZhengView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [[UIApplication sharedApplication].keyWindow addSubview:_sanDaJiaSeFaTieRenZhengView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-274*BiLiWidth)/2, 287*BiLiWidth, 274*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [_sanDaJiaSeFaTieRenZhengView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [_sanDaJiaSeFaTieRenZhengView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33.5*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"提示";
        [kuangImageView addSubview:tipLable1];
        
        self.sanDaJiaSeFaTieRenZhengViewTipLable = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 80*BiLiWidth)];
        self.sanDaJiaSeFaTieRenZhengViewTipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        self.sanDaJiaSeFaTieRenZhengViewTipLable.textColor = RGBFormUIColor(0x343434);
        self.sanDaJiaSeFaTieRenZhengViewTipLable.numberOfLines = 4;
        self.sanDaJiaSeFaTieRenZhengViewTipLable.text = @"您当前是未认证用户，发布的信息不会得到官方认证。若需要获得官方认证，请先进行身份认证或者开通会员！";
        [kuangImageView addSubview:self.sanDaJiaSeFaTieRenZhengViewTipLable];
        
        
        self.sanDaJiaSeFaTieRenZhengViewFaTieButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-85.5*BiLiWidth-11.5*BiLiWidth-115*BiLiWidth)/2, self.sanDaJiaSeFaTieRenZhengViewTipLable.top+self.sanDaJiaSeFaTieRenZhengViewTipLable.height+25*BiLiWidth, 85.5*BiLiWidth, 40*BiLiWidth)];
        [self.sanDaJiaSeFaTieRenZhengViewFaTieButton setTitle:@"继续发帖" forState:UIControlStateNormal];
        self.sanDaJiaSeFaTieRenZhengViewFaTieButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
        self.sanDaJiaSeFaTieRenZhengViewFaTieButton.layer.cornerRadius = 20*BiLiWidth;
        [self.sanDaJiaSeFaTieRenZhengViewFaTieButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        self.sanDaJiaSeFaTieRenZhengViewFaTieButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [self.sanDaJiaSeFaTieRenZhengViewFaTieButton addTarget:self action:@selector(faTieButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:self.sanDaJiaSeFaTieRenZhengViewFaTieButton];

        UIButton * renZhengButton = [[UIButton alloc] initWithFrame:CGRectMake(self.sanDaJiaSeFaTieRenZhengViewFaTieButton.left+self.sanDaJiaSeFaTieRenZhengViewFaTieButton.width+11.5*BiLiWidth, self.sanDaJiaSeFaTieRenZhengViewFaTieButton.top, 115*BiLiWidth, 40*BiLiWidth)];
        [renZhengButton addTarget:self action:@selector(quRenZheng) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:renZhengButton];
        
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = renZhengButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [renZhengButton.layer addSublayer:gradientLayer1];
        
        UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, renZhengButton.width, renZhengButton.height)];
        sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        sureLable.text = @"去认证";
        sureLable.textAlignment = NSTextAlignmentCenter;
        sureLable.textColor = [UIColor whiteColor];
        [renZhengButton addSubview:sureLable];
        

        

    }
    return _sanDaJiaSeFaTieRenZhengView;
}
-(void)closeTipKuangView
{
    self.sanDaJiaSeFaTieRenZhengView.hidden = YES;
}
-(void)faTieButtonClick
{
    self.sanDaJiaSeFaTieRenZhengView.hidden = YES;

    if (self.sanDaJiaSeFaTieRenZhengView.tag!=3) {
        
        JiaoSeWeiRenZhengFaTieVC * vc = [[JiaoSeWeiRenZhengFaTieVC alloc] init];
        vc.renZhengType = self.renZhengType;
        [self.navigationController pushViewController:vc animated:YES];

    }

}
-(void)quRenZheng
{
    self.sanDaJiaSeFaTieRenZhengView.hidden = YES;

        if (self.renZhengStatus==0) {//未认证
            
            NvShenRenZhengStep1VC * vc = [[NvShenRenZhengStep1VC alloc] init];
            vc.renZhengType = self.renZhengType;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if (self.renZhengStatus==1)//已认证
        {
            
        }
        else if(self.renZhengStatus==2)//审核中
        {
            NvShenRenZhengStep4VC * vc = [[NvShenRenZhengStep4VC alloc] init];
            vc.alsoShowBackButton = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
}
-(GaoDuanShaiXuanView *)gaoDuanShaiXuanView
{
    if (!_gaoDuanShaiXuanView) {
        
        _gaoDuanShaiXuanView = [[GaoDuanShaiXuanView alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu, WIDTH_PingMu, HEIGHT_PingMu)];
        [[UIApplication sharedApplication].keyWindow addSubview:_gaoDuanShaiXuanView];
        
        __weak typeof(self) wself = self;
        [_gaoDuanShaiXuanView setPaiXuSelect:^(NSString * _Nonnull field, NSString * _Nonnull order, NSString * _Nonnull titleStr) {
            wself.shaiXuanLeiXingStr = titleStr;
            
            wself.pingFenButton1.button_lable.text = titleStr;
            wself.pingFenButton.button_lable.text = titleStr;

            
           CGSize  size = [NormalUse setSize:titleStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
            
            wself.pingFenButton1.button_lable.width = size.width;
            wself.pingFenButton1.button_imageView.left = wself.pingFenButton1.button_lable.width+wself.pingFenButton1.button_lable.left+5*BiLiWidth;

            wself.pingFenButton.button_lable.width = size.width;
            wself.pingFenButton.button_imageView.left = wself.pingFenButton.button_lable.width+wself.pingFenButton.button_lable.left+5*BiLiWidth;

            wself.field = field;
            wself.order = order;
            [wself loadNewLsit];
            
        }];
    }
    return _gaoDuanShaiXuanView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self xianShiTabBar];
    [self setLocationStr];
    //获取当前用户角色
    if ([NormalUse isValidString:[NormalUse defaultsGetObjectKey:LoginToken]]) {
        
        [HTTPModel getUserRole:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if(status==1)
            {
                //0 未认证 1 已认证 2 审核中
                //"auth_nomal":0,//茶馆儿认证：无
                //auth_agent":1,//经纪人认证：有
                //auth_goddess":1,//女神认证：有
                //auth_global":0,//全球陪玩:无
                //auth_peripheral":0//外围认证：无
                //auth_couple  :夫妻交认证
                
                NSDictionary * info = responseObject;
                

                NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
                NSString * defaultsKey = [UserRole stringByAppendingString:token];

                NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
                
                if ([NormalUse isValidDictionary:userRoleDic]) {
                    
                    if (![info isEqual:userRoleDic]) {
                        
                        [NormalUse defaultsSetObject:info forKey:defaultsKey];
                        [self.mainTableView reloadData];

                    }
                    
                }
                else
                {
                    [NormalUse defaultsSetObject:info forKey:defaultsKey];
                    [self.mainTableView reloadData];
                }
            }
        }];

    }
}
-(void)setLocationStr
{
    if ((int)(self.contentScrollView.contentOffset.x/WIDTH_PingMu)==3) {
        
        NSDictionary * info = [NormalUse defaultsGetObjectKey:@"ForeignCityInfoDefaults"];
        if ([NormalUse isValidDictionary:info]) {
            
           self.locationLable.text = [info objectForKey:@"cityName"];

        }
        else
        {
            self.locationLable.text = @"选择城市";

        }
    }
    else
    {
        NSDictionary * info = [NormalUse defaultsGetObjectKey:@"CityInfoDefaults"];
        if ([NormalUse isValidDictionary:info]) {
            
            self.locationLable.text = [info objectForKey:@"cityName"];

        }
        else
        {
            self.locationLable.text = @"选择城市";

        }

    }

}
-(void)shaiXuanButtonClick
{
    if (self.contentScrollView.contentOffset.x/WIDTH_PingMu==3) {
        
        ForeignCityListViewController * vc = [[ForeignCityListViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];

    }
    else
    {
        CityListViewController * vc = [[CityListViewController alloc] init];
        vc.alsoFromHome = YES;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];

    }
}
-(void)foreignCitySelect:(NSDictionary *)info
{
    self.locationLable.text = [info objectForKey:@"cityName"];
    NSString * cityCode = [info objectForKey:@"cityCode"];
    if (cityCode.intValue==-1001) {
        
        [NormalUse defaultsSetObject:nil forKey:@"ForeignCityInfoDefaults"];
    }
    else
    {
        [NormalUse defaultsSetObject:info forKey:@"ForeignCityInfoDefaults"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityChangeReloadQuanQiuPeiWanMessageNotification" object:nil];
}
- (void)citySelect:(NSDictionary *)info
{
    self.locationLable.text = [info objectForKey:@"cityName"];
    NSString * cityCode = [info objectForKey:@"cityCode"];
    if (cityCode.intValue==-1001) {
        
        [NormalUse defaultsSetObject:nil forKey:@"CityInfoDefaults"];

    }
    else
    {
        [NormalUse defaultsSetObject:info forKey:@"CityInfoDefaults"];

    }
    [self loadNewLsit];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityChangeReloadMessageNotification" object:nil];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shaiXuanLeiXingStr = @"评分最高";
    
    self.backImageView.hidden = YES;
    self.lineView.hidden = YES;
    
    self.topNavView.hidden = NO;
    UIImageView * locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16*BiLiWidth, (self.topNavView.height-14*BiLiWidth)/2, 11*BiLiWidth, 14*BiLiWidth)];
    locationImageView.image = [UIImage imageNamed:@"home_location"];
    [self.topNavView addSubview:locationImageView];
    
    self.locationLable = [[UILabel alloc] initWithFrame:CGRectMake(locationImageView.left+locationImageView.width+5*BiLiWidth, locationImageView.top, 150*BiLiWidth, locationImageView.height)];
    self.locationLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.locationLable.adjustsFontSizeToFitWidth = YES;
    self.locationLable.textColor = RGBFormUIColor(0x333333);
    self.locationLable.text = @"选择城市";
    [self.topNavView addSubview:self.locationLable];
    
    UIButton * citySelectButton = [[UIButton alloc] initWithFrame:CGRectMake(locationImageView.left, locationImageView.top, 200*BiLiWidth, locationImageView.height)];
    [citySelectButton addTarget:self action:@selector(shaiXuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topNavView addSubview:citySelectButton];

    self.listButtonArray = [NSMutableArray array];
    NSArray * array = [[NSArray alloc] initWithObjects:@"经纪人",@"认证女神",@"外围空降",@"全球陪玩", nil];
    float originx = 20*BiLiWidth;
    CGSize size;
    for (int i=0; i<array.count; i++) {
        
        UIButton * button;
        
        size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
        button  = [[UIButton alloc] initWithFrame:CGRectMake(originx,self.topNavView.top+self.topNavView.height, size.width, 17*BiLiWidth)];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        if (i==0) {
            
            button.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }
        
        button.tag = i;
        [button addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        originx = button.left+button.width+20*BiLiWidth;
        
        [self.listButtonArray addObject:button];
    }
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(10.5*BiLiWidth,TopHeight_PingMu+57*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
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


    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.sliderView.top+self.sliderView.height+5*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(self.sliderView.top+self.sliderView.height+5*BiLiWidth+BottomHeight_PingMu))];
    [self.contentScrollView setContentSize:CGSizeMake(WIDTH_PingMu*array.count, self.contentScrollView.height)];
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.tag = 1001;
    self.contentScrollView.delegate = self;
    [self.view addSubview:self.contentScrollView];

    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, self.contentScrollView.height)style:UITableViewStyleGrouped];
   self.mainTableView.delegate = self;
   self.mainTableView.dataSource = self;
   self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tag = 1002;
   [self.contentScrollView addSubview:self.mainTableView];
    
    MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mainTableView.mj_header = mjHeader;
    [self.mainTableView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter * mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreList)];
    self.mainTableView.mj_footer = mjFooter;

    
    nvShenListVC = [[NvShenListViewController alloc] init];
    nvShenListVC.view.frame = CGRectMake(WIDTH_PingMu, 0, WIDTH_PingMu, self.contentScrollView.height);
    [self.contentScrollView addSubview:nvShenListVC.view];
    
    waiWeiVC = [[WaiWeiListViewController alloc] init];
    waiWeiVC.view.frame = CGRectMake(WIDTH_PingMu*2, 0, WIDTH_PingMu, self.contentScrollView.height);
    [self.contentScrollView addSubview:waiWeiVC.view];

    peiWanVC = [[PeiWanListViewController alloc] init];
    peiWanVC.view.frame = CGRectMake(WIDTH_PingMu*3, 0, WIDTH_PingMu, self.contentScrollView.height);
    [self.contentScrollView addSubview:peiWanVC.view];


    self.itemButtonContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.sliderView.top+self.sliderView.height+5*BiLiWidth, WIDTH_PingMu, 14.5*BiLiWidth*2+12*BiLiWidth)];
    self.itemButtonContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.itemButtonContentView];
    
    self.zuiXinOrZuiRe = @"1";
    
    size = [NormalUse setSize:@"评分最高" withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];

    self.pingFenButton1 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(13*BiLiWidth, 0*BiLiWidth, 100*BiLiWidth, self.itemButtonContentView.height)];
    self.pingFenButton1.button_lable.frame = CGRectMake(0, 0, size.width, self.pingFenButton1.height);
    self.pingFenButton1.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.pingFenButton1.button_lable.textColor = RGBFormUIColor(0x666666);
    self.pingFenButton1.button_lable.text = @"评分最高";
    self.pingFenButton1.button_imageView.frame = CGRectMake(self.self.pingFenButton1.button_lable.width+self.self.pingFenButton1.button_lable.left+5*BiLiWidth, (self.itemButtonContentView.height-5.5*BiLiWidth)/2, 10*BiLiWidth, 5.5*BiLiWidth);
    self.pingFenButton1.button_imageView.image = [UIImage imageNamed:@"mobileCode_xia"];
    [self.pingFenButton1 addTarget:self action:@selector(pingFenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.itemButtonContentView addSubview:self.pingFenButton1];
    
    

    
//    self.zuiXinButton1 = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton1.left+self.pingFenButton1.width+33*BiLiWidth, self.pingFenButton1.top, 33.5*BiLiWidth, 12*BiLiWidth)];
//    [self.zuiXinButton1 setTitle:@"最新" forState:UIControlStateNormal];
//    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
//    self.zuiXinButton1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
//    [self.zuiXinButton1 addTarget:self action:@selector(zuiXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.itemButtonContentView addSubview:self.zuiXinButton1];
//
//    self.zuiReButton1 = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton1.left+self.pingFenButton1.width+79*BiLiWidth, self.pingFenButton1.top, 33.5*BiLiWidth, 12*BiLiWidth)];
//    [self.zuiReButton1 setTitle:@"最热" forState:UIControlStateNormal];
//    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
//    self.zuiReButton1.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
//    [self.zuiReButton1 addTarget:self action:@selector(zuiReButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.itemButtonContentView addSubview:self.zuiReButton1];

    self.itemButtonContentView.hidden = YES;
    
    [HTTPModel getBannerList:[[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.bannerArray = responseObject;
            
            if([NormalUse isValidArray:self.bannerArray])
            {
                [self.mainTableView reloadData];

            }
                

        }
    }];
    [HTTPModel getGuanFangTuiJianDianPu:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.guanFangTuiJianDianPuArray = responseObject;
            [self.mainTableView reloadData];
            
        }
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewLsit) name:@"cityChangeReloadMessageNotification" object:nil];
}
-(void)loadNewLsit
{
    [HTTPModel getGuanFangTuiJianDianPu:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.guanFangTuiJianDianPuArray = responseObject;
            [self.mainTableView reloadData];
            
        }
    }];

    page = 1;
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    if ([NormalUse isValidString:self.field]) {
        
        [info setObject:self.field forKey:@"field"];
    }
    if ([NormalUse isValidString:self.order]) {
        
        [info setObject:self.order forKey:@"order"];

    }

    [HTTPModel getJingJiRenList:info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self->page = self->page+1;
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            self.jingJiRenListArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.mainTableView.mj_header endRefreshing];
            if (dataArray.count>=10) {
                
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
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    [info setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    if ([NormalUse isValidString:self.field]) {
        
        [info setObject:self.field forKey:@"field"];
    }
    if ([NormalUse isValidString:self.order]) {
        
        [info setObject:self.order forKey:@"order"];

    }
    [HTTPModel getJingJiRenList:info callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self->page = self->page+1;
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary * info in dataArray) {
                
                [self.jingJiRenListArray addObject:info];
            }
            if (dataArray.count>=10) {
                
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
#pragma mark--顶部按钮点击
-(void)listTopButtonClick:(UIButton *)selectButton
{
    [self.contentScrollView setContentOffset:CGPointMake(selectButton.tag*WIDTH_PingMu, 0) animated:NO];
    for (int i=0; i<self.listButtonArray.count; i++) {
        
        UIButton * button = [self.listButtonArray objectAtIndex:i];
        if (button.tag==selectButton.tag) {
            
            [UIView animateWithDuration:0.5 animations:^{
                
                button.transform = CGAffineTransformMakeScale(1.3, 1.3);

                self.sliderView.left = button.left+(button.width-self.sliderView.width)/2;
            }];

            
        }
        else
        {
            button.transform = CGAffineTransformIdentity;

        }

        
    }
    
    if (selectButton.tag==0 && self.itemButtonContentView.tag==1) {
        
        self.itemButtonContentView.hidden = NO;
    }
    else
    {
        self.itemButtonContentView.hidden = YES;

    }
    
    [self setLocationStr];
}

#pragma mark--经纪人认证 女神认证 全国空降 陪玩

-(void)jingJiRenRenZhengButtonClick:(UIButton *)button
{
    if (button.tag==0) {
        
        self.jingJiRenRenZhengTipView.hidden = NO;
        self.jingJiRenRenZhengTipView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:0.5 animations:^{
            
            self.jingJiRenRenZhengTipView.transform = CGAffineTransformIdentity;
        }];

    }
    else if (button.tag==1)//已认证
    {
        CreateTieZiViewController * vc = [[CreateTieZiViewController alloc] init];
        vc.from_flg = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(button.tag==2)//审核中
    {
        JingJiRenRenZhengStep3VC * vc = [[JingJiRenRenZhengStep3VC alloc] init];
        vc.alsoShowBackButton = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
-(void)nvShenRenZhengButtonClick:(UIButton *)button
{
    self.renZhengType = @"1";
    self.renZhengStatus = (int)button.tag;
    
    if (button.tag==1) {
        
        JiaoSeWeiRenZhengFaTieVC * vc = [[JiaoSeWeiRenZhengFaTieVC alloc] init];
        vc.renZhengType = self.renZhengType;
        vc.renZhengStatus = self.renZhengStatus;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else
    {
        self.sanDaJiaSeFaTieRenZhengView.hidden = NO;
        self.sanDaJiaSeFaTieRenZhengView.tag=1;
        [self.sanDaJiaSeFaTieRenZhengViewFaTieButton setTitle:@"继续发帖" forState:UIControlStateNormal];
        self.sanDaJiaSeFaTieRenZhengViewTipLable.text = @"女神必须本人真实认证，认证后拥有官方独立信息展示区、官方推荐资格和官方认证标识同时平台给予更多流量扶持";

    }

    
//    if (button.tag==0) {//未认证
//
//        NvShenRenZhengStep1VC * vc = [[NvShenRenZhengStep1VC alloc] init];
//        vc.renZhengType = @"1";
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
//    else if (button.tag==1)//已认证
//    {
//
//    }
//    else if(button.tag==2)//审核中
//    {
//        NvShenRenZhengStep4VC * vc = [[NvShenRenZhengStep4VC alloc] init];
//        vc.alsoShowBackButton = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//
//
//    }
    
}

-(void)kongJiangButtonClick:(UIButton *)button
{
    
    self.renZhengType = @"2";
    self.renZhengStatus = (int)button.tag;
    
    if (button.tag==1) {
        
        JiaoSeWeiRenZhengFaTieVC * vc = [[JiaoSeWeiRenZhengFaTieVC alloc] init];
        vc.renZhengType = self.renZhengType;
        vc.renZhengStatus = self.renZhengStatus;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else
    {
        self.sanDaJiaSeFaTieRenZhengView.hidden = NO;
        self.sanDaJiaSeFaTieRenZhengView.tag=2;
        [self.sanDaJiaSeFaTieRenZhengViewFaTieButton setTitle:@"继续发帖" forState:UIControlStateNormal];
        self.sanDaJiaSeFaTieRenZhengViewTipLable.text = @"外围空降必须真实本人信息，认证后拥有官方独立信息展示区、官方推荐资格和官方认证标识同时平台给予更多流量扶持";

    }


//    if (button.tag==0) {//未认证
//
//        NvShenRenZhengStep1VC * vc = [[NvShenRenZhengStep1VC alloc] init];
//        vc.renZhengType = @"2";
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
//    else if (button.tag==1)//已认证
//    {
//
//    }
//    else if(button.tag==2)//审核中
//    {
//        NvShenRenZhengStep4VC * vc = [[NvShenRenZhengStep4VC alloc] init];
//        vc.alsoShowBackButton = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }


}

-(void)peiWanButtonClick:(UIButton *)button
{
    self.renZhengType = @"3";
    self.renZhengStatus = (int)button.tag;

    if (button.tag==1) {

        JiaoSeWeiRenZhengFaTieVC * vc = [[JiaoSeWeiRenZhengFaTieVC alloc] init];
        vc.renZhengType = self.renZhengType;
        [self.navigationController pushViewController:vc animated:YES];

    }
    else
    {
        self.sanDaJiaSeFaTieRenZhengView.hidden = NO;
        self.sanDaJiaSeFaTieRenZhengView.tag=3;
        [self.sanDaJiaSeFaTieRenZhengViewFaTieButton setTitle:@"取消" forState:UIControlStateNormal];
        self.sanDaJiaSeFaTieRenZhengViewTipLable.text = @"全球伴游必须真实国家地区信息，外围空降必须真实本人信息，认证后拥有官方独立信息展示区、官方推荐资格和官方认证标识同时平台给予更多流量扶持";

    }
    
//    if (button.tag==0) {//未认证
//
//        NvShenRenZhengStep1VC * vc = [[NvShenRenZhengStep1VC alloc] init];
//        vc.renZhengType = @"3";
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
//    else if (button.tag==1)//已认证
//    {
//        self.renZhengType = @"3";
//        self.renZhengStatus = (int)button.tag;
//
//        JiaoSeWeiRenZhengFaTieVC * vc = [[JiaoSeWeiRenZhengFaTieVC alloc] init];
//        vc.renZhengType = self.renZhengType;
//        vc.renZhengStatus = self.renZhengStatus;
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
//    else if(button.tag==2)//审核中
//    {
//        NvShenRenZhengStep4VC * vc = [[NvShenRenZhengStep4VC alloc] init];
//        vc.alsoShowBackButton = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }

}


  

#pragma mark---scrollviewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (scrollView.tag==1001) {
        
        int  specialIndex = scrollView.contentOffset.x/WIDTH_PingMu;
        
        UIButton * button = [self.listButtonArray objectAtIndex:specialIndex];
        [button sendActionsForControlEvents:UIControlEventTouchUpInside];
    }

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==1002) {
        
        
        CGFloat hight = scrollView.frame.size.height;
        CGFloat contentOffset = scrollView.contentOffset.y;
        CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
        CGFloat offset = contentOffset - self.lastcontentOffset;
        self.lastcontentOffset = contentOffset;

        if (offset > 0 && contentOffset > 0) {
           NSLog(@"上拉行为");
            if (scrollView.contentOffset.y>=500*BiLiWidth) {
                
                self.itemButtonContentView.hidden = NO;
                self.itemButtonContentView.tag = 1;
            }

        }
        if (offset < 0 && distanceFromBottom > hight) {
            NSLog(@"下拉行为");
            if (scrollView.contentOffset.y<=500*BiLiWidth) {
                
                
            self.itemButtonContentView.hidden = YES;
                self.itemButtonContentView.tag = 0;

                       
            }
        }

    }
  

}
#pragma mark UItableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jingJiRenListArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * info = [self.jingJiRenListArray objectAtIndex:indexPath.row];
    if ([NormalUse isValidArray:[info objectForKey:@"post_list"]]) {
        
        return  197*BiLiWidth+48*BiLiWidth+21*BiLiWidth+8*BiLiWidth;

    }
    else
    {
        return  197*BiLiWidth+48*BiLiWidth+21*BiLiWidth+8*BiLiWidth-132*BiLiWidth;

    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"GaoDuanHomeCellCell"] ;
    GaoDuanHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[GaoDuanHomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    [cell contentViewSetData:[self.jingJiRenListArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * info = [self.jingJiRenListArray objectAtIndex:indexPath.row];
    DianPuDetailViewController * vc = [[DianPuDetailViewController alloc] init];
    NSNumber * idNumber = [info objectForKey:@"id"];
    vc.dianPuId = [NSString stringWithFormat:@"%d",idNumber.intValue];
    [self.navigationController pushViewController:vc animated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        
    return 501*BiLiWidth+24*BiLiWidth+47*BiLiWidth;
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 501*BiLiWidth+24*BiLiWidth)];
    headerView.backgroundColor = [UIColor whiteColor];
    //顶部轮播图
    if ([NormalUse isValidArray:self.bannerArray]) {
        
        NewPagedFlowView *pageView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 147*BiLiWidth)];
        pageView.delegate = self;
        pageView.dataSource = self;
        pageView.minimumPageAlpha = 0.1;
        pageView.isCarousel = YES;
        pageView.orientation = NewPagedFlowViewOrientationHorizontal;
        pageView.isOpenAutoScroll = YES;
        pageView.orginPageCount = self.bannerArray.count;
        [pageView reloadData];
        [headerView addSubview:pageView];

        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, pageView.top+pageView.height+8*BiLiWidth, 200*BiLiWidth, 10)];
        self.pageControl.currentPage = 0;      //设置当前页指示点
        self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
        self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
        self.pageControl.numberOfPages = self.bannerArray.count;
        [headerView addSubview:self.pageControl];
    }
   
    
    //分类scrollview
    MyScrollView * fenLeiScrollView = [[MyScrollView alloc] initWithFrame:CGRectMake(0, self.pageControl.top+self.pageControl.height+25*BiLiWidth, WIDTH_PingMu, 57*BiLiWidth)];
    [headerView addSubview:fenLeiScrollView];
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(12*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_jingJiRenRenZheng"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(jingJiRenRenZhengButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button1];
    
    
    
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(button1.left+button1.width+5.5*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_nuShenRenZheng"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(nvShenRenZhengButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button2];
    
    
    UIButton * button3 = [[UIButton alloc] initWithFrame:CGRectMake(button2.left+button2.width+5.5*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button3 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_waiWei"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(kongJiangButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button3];
    
    
    UIButton * button4 = [[UIButton alloc] initWithFrame:CGRectMake(button3.left+button3.width+5.5*BiLiWidth, 0, 147*BiLiWidth, 57*BiLiWidth)];
    [button4 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_quanQiuPeiWan"] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(peiWanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [fenLeiScrollView addSubview:button4];
    [fenLeiScrollView setContentSize:CGSizeMake(button4.left+button4.width+12*BiLiWidth, fenLeiScrollView.height)];
    
    //0 未认证 1 已认证 2 审核中
    //"auth_nomal":0,//茶馆儿认证：无
    //auth_agent":1,//经纪人认证：有
    //auth_goddess":1,//女神认证：有
    //auth_global":0,//全球陪玩:无
    //auth_peripheral":0//外围认证：无
    if ([NormalUse isValidString:[NormalUse defaultsGetObjectKey:LoginToken]]) {

        NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
        NSString * defaultsKey = [UserRole stringByAppendingString:token];
        
        NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
        
        if ([NormalUse isValidDictionary:userRoleDic]) {
            
            NSNumber * auth_agent = [userRoleDic objectForKey:@"auth_agent"];
            if([auth_agent isKindOfClass:[NSNumber class]])
            {
                button1.tag = auth_agent.intValue;
                if (auth_agent.intValue==1) {
                    
                    [button1 setBackgroundImage:nil forState:UIControlStateNormal];
                    [button1 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_jingJiRenFaBuXinXi"] forState:UIControlStateNormal];


                }
                else if (auth_agent.intValue==2)
                {
                    [button1 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_jingJiRenRenZheng"] forState:UIControlStateNormal];

                }
                else
                {
                    [button1 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_jingJiRenRenZheng"] forState:UIControlStateNormal];

                }
            }
            
            NSNumber * auth_goddess = [userRoleDic objectForKey:@"auth_goddess"];
            
            if([auth_goddess isKindOfClass:[NSNumber class]])
            {
                button2.tag = auth_goddess.intValue;
                if (auth_goddess.intValue==1) {
                    
                    [button2 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_nvShenYiRenZheng"] forState:UIControlStateNormal];

                }
                else if (auth_goddess.intValue==2)
                {
                    [button2 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_nuShenRenZheng"] forState:UIControlStateNormal];

                }
                else
                {
                    [button2 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_nuShenRenZheng"] forState:UIControlStateNormal];

                }
            }
            
            NSNumber * auth_peripheral = [userRoleDic objectForKey:@"auth_peripheral"];
            if([auth_peripheral isKindOfClass:[NSNumber class]])
            {
                button3.tag = auth_peripheral.intValue;
                if (auth_peripheral.intValue==1) {
                    
                    [button3 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_waiWeiYiRenZheng"] forState:UIControlStateNormal];

                }
                else if (auth_peripheral.intValue==2)
                {
                    [button3 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_waiWei"] forState:UIControlStateNormal];

                }
                else
                {
                    [button3 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_waiWei"] forState:UIControlStateNormal];

                }
            }

            NSNumber * auth_global = [userRoleDic objectForKey:@"auth_global"];
            if([auth_global isKindOfClass:[NSNumber class]])
            {
                button4.tag = auth_global.intValue;
                if (auth_global.intValue==1) {
                    
                    [button4 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_quanQiuPeiWanYiRenZheng"] forState:UIControlStateNormal];

                }
                else if (auth_global.intValue==2)
                {
                    [button4 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_quanQiuPeiWan"] forState:UIControlStateNormal];

                }
                else
                {
                    [button4 setBackgroundImage:[UIImage imageNamed:@"gaoDuan_quanQiuPeiWan"] forState:UIControlStateNormal];

                }
            }


        }

        
    }
    //官方推荐
    UILabel * guanFangTuiJianLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, fenLeiScrollView.top+fenLeiScrollView.height+24*BiLiWidth, 200*BiLiWidth, 17*BiLiWidth)];
    guanFangTuiJianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17*BiLiWidth];
    guanFangTuiJianLable.textColor = RGBFormUIColor(0x333333);
    guanFangTuiJianLable.text = @"官方推荐";
    [headerView addSubview:guanFangTuiJianLable];
    
    UIScrollView * guanFangTuiJianScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, guanFangTuiJianLable.top+guanFangTuiJianLable.height+13*BiLiWidth, WIDTH_PingMu, 176*BiLiWidth)];
    [headerView addSubview:guanFangTuiJianScrollView];
    
    for (int i=0; i<self.guanFangTuiJianDianPuArray.count; i++) {
        
        NSDictionary * info = [self.guanFangTuiJianDianPuArray objectAtIndex:i];
        
        UIButton * contentView = [[UIButton alloc] initWithFrame:CGRectMake(12*BiLiWidth+156*BiLiWidth*i, 0, 151.5*BiLiWidth, 176*BiLiWidth)];
        contentView.layer.cornerRadius = 4*BiLiWidth;
        contentView.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
        contentView.layer.borderWidth = 1;
        contentView.clipsToBounds = YES;
        [guanFangTuiJianScrollView addSubview:contentView];
        
        
        [guanFangTuiJianScrollView setContentSize:CGSizeMake(contentView.left+contentView.width+12*BiLiWidth, guanFangTuiJianScrollView.height)];
        
        
        UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentView.width, 126*BiLiWidth)];
        headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        headerImageView.autoresizingMask = UIViewAutoresizingNone;
        headerImageView.clipsToBounds = YES;
        [contentView addSubview:headerImageView];
       // [headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"image"]]];
        [headerImageView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"header_kong"]];

        
        UIView *  jiaoBiaoView = [[UILabel alloc] initWithFrame:CGRectMake(contentView.width-39*BiLiWidth,0,39*BiLiWidth,18*BiLiWidth)];
        [contentView addSubview:jiaoBiaoView];
        
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = jiaoBiaoView.bounds;
        gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.locations = @[@0,@1];
        [jiaoBiaoView.layer addSublayer:gradientLayer];
        
        UILabel *  jiaoBiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(contentView.width-39*BiLiWidth,0,39*BiLiWidth,18*BiLiWidth)];
        jiaoBiaoLable.textAlignment = NSTextAlignmentCenter;
        jiaoBiaoLable.textColor = RGBFormUIColor(0xFFFFFF);
        jiaoBiaoLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        jiaoBiaoLable.adjustsFontSizeToFitWidth = YES;
        jiaoBiaoLable.text = [NormalUse getobjectForKey:[info objectForKey:@"city_name"]];
        [contentView addSubview:jiaoBiaoLable];

        
        //某个角圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:jiaoBiaoLable.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4*BiLiWidth, 4*BiLiWidth)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = jiaoBiaoLable.bounds;
        maskLayer.path = maskPath.CGPath;
        jiaoBiaoLable.layer.mask = maskLayer;
        
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, headerImageView.top+headerImageView.height+9.5*BiLiWidth, contentView.width, 14*BiLiWidth)];
        titleLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        titleLable.textColor = RGBFormUIColor(0x333333);
        titleLable.text = [info objectForKey:@"name"];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:titleLable];
        
        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLable.top+titleLable.height+7*BiLiWidth, contentView.width, 11*BiLiWidth)];
        messageLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        messageLable.textColor = RGBFormUIColor(0x999999);
        NSNumber * deal_num = [info objectForKey:@"deal_num"];
        messageLable.text = [NSString stringWithFormat:@"成交数量:%d",deal_num.intValue];
        messageLable.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:messageLable];
        
        UIButton * clickButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, contentView.width, contentView.height)];
        clickButton.tag = i;
        [clickButton addTarget:self action:@selector(guanFangTuiJianClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:clickButton];

        
    }
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, guanFangTuiJianScrollView.top+guanFangTuiJianScrollView.height+21*BiLiWidth, WIDTH_PingMu, 8*BiLiWidth)];
    lineView.backgroundColor = RGBFormUIColor(0xEDEDED);
    [headerView addSubview:lineView];
    
    //官方推荐
    UILabel * wangPaiJingJiRenLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BiLiWidth, lineView.top+lineView.height+14*BiLiWidth, 200*BiLiWidth, 17*BiLiWidth)];
    wangPaiJingJiRenLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17*BiLiWidth];
    wangPaiJingJiRenLable.textColor = RGBFormUIColor(0x333333);
    wangPaiJingJiRenLable.text = @"王牌经纪人";
    [headerView addSubview:wangPaiJingJiRenLable];
    
    CGSize  size = [NormalUse setSize:self.shaiXuanLeiXingStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];

    self.pingFenButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(13*BiLiWidth, wangPaiJingJiRenLable.top+wangPaiJingJiRenLable.height+2.5*BiLiWidth, 100*BiLiWidth, 36*BiLiWidth)];
    self.pingFenButton.button_lable.frame = CGRectMake(0, 0, size.width, self.pingFenButton.height);
    self.pingFenButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.pingFenButton.button_lable.textColor = RGBFormUIColor(0x666666);
    self.pingFenButton.button_lable.text = self.shaiXuanLeiXingStr;
    self.pingFenButton.button_imageView.frame = CGRectMake(self.pingFenButton.button_lable.width+self.pingFenButton.button_lable.left+5*BiLiWidth, (self.pingFenButton.height-5.5*BiLiWidth)/2, 10*BiLiWidth, 5.5*BiLiWidth);
    self.pingFenButton.button_imageView.image = [UIImage imageNamed:@"mobileCode_xia"];
    [self.pingFenButton addTarget:self action:@selector(pingFenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.pingFenButton];
    
    

    
//    self.zuiXinButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+33*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
//    [self.zuiXinButton setTitle:@"最新" forState:UIControlStateNormal];
//    self.zuiXinButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
//    [self.zuiXinButton addTarget:self action:@selector(zuiXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:self.zuiXinButton];
//
//    self.zuiReButton = [[UIButton alloc] initWithFrame:CGRectMake(self.pingFenButton.left+self.pingFenButton.width+79*BiLiWidth, self.pingFenButton.top, 33.5*BiLiWidth, 12*BiLiWidth)];
//    [self.zuiReButton setTitle:@"最热" forState:UIControlStateNormal];
//    self.zuiReButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
//    [self.zuiReButton addTarget:self action:@selector(zuiReButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:self.zuiReButton];
    
//    if ([@"1" isEqualToString:self.zuiXinOrZuiRe]) {
//
//        [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
//        [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
//
//
//    }
//    else
//    {
//        [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
//        [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
//
//    }
    
    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    return nil;
}
#pragma mark--UIButtonClick
-(void)guanFangTuiJianClick:(UIButton *)button
{
    NSDictionary * info = [self.guanFangTuiJianDianPuArray objectAtIndex:button.tag];
    DianPuDetailViewController * vc = [[DianPuDetailViewController alloc] init];
    NSNumber * idNumber = [info objectForKey:@"id"];
    vc.dianPuId = [NSString stringWithFormat:@"%d",idNumber.intValue];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pingFenButtonClick
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.gaoDuanShaiXuanView.top = 0;
        self.gaoDuanShaiXuanView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];

    }];
}
-(void)zuiXinButtonClick
{
    self.field = @"";
    self.zuiXinOrZuiRe = @"1";
    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
    [self loadNewLsit];
}
-(void)zuiReButtonClick
{
    self.field = @"hot_value";
    self.zuiXinOrZuiRe = @"2";

    [self.zuiXinButton setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    [self.zuiXinButton1 setTitleColor:RGBFormUIColor(0x666666) forState:UIControlStateNormal];
    
    [self.zuiReButton setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
    [self.zuiReButton1 setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];

    [self loadNewLsit];
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    
    return CGSizeMake(WIDTH_PingMu-60*BiLiWidth,flowView.frame.size.height);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    if (subIndex==-1) {
        subIndex = subIndex+1;
    }
    NSDictionary * info = [self.bannerArray objectAtIndex:subIndex];
    if ([NormalUse isValidString:[info objectForKey:@"url"]]) {
        
        WKWebViewController * vc = [[WKWebViewController alloc] init];
        vc.titleStr = [info objectForKey:@"title"];
        vc.url = [info objectForKey:@"url"];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    self.pageControl.currentPage = pageNumber;
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.bannerArray.count;
    
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
          NSDictionary * info = [self.bannerArray objectAtIndex:index];
          //[bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_REQUESTURL,[info objectForKey:@"picture"]]]];

    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_REQUESTURL,[info objectForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"banner_kong"]];

    return bannerView;
}

@end
