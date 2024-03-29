//
//  HomeViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/19.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HomeViewController.h"
#import "YanCheBaoGaoTableViewCell.h"
#import "HomeShaiXuanView.h"
#import "ZYNetworkAccessibility.h"
#import "JiaoSeWeiRenZhengFaTieVC.h"


@interface HomeViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,CityListViewControllerDelegate>

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSArray * bannerArray;

@property(nonatomic,strong)NSMutableArray * vipFuncationArray;
@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)UILabel * locationLable;

@property(nonatomic,strong)Lable_ImageButton * dingZhi;

@property(nonatomic,strong)UIView * itemButtonContentView;
@property(nonatomic,assign)CGFloat  lastcontentOffset;


@property(nonatomic,assign)CGFloat  tableView1LastContentOffset;
@property(nonatomic,assign)CGFloat  tableView2LastContentOffset;
@property(nonatomic,assign)CGFloat  tableView3LastContentOffset;
@property(nonatomic,assign)CGFloat  tableView4LastContentOffset;




@property(nonatomic,strong)NSMutableArray * listButtonArray;

@property(nonatomic,strong)NSMutableArray * tableViewArray;//存放tableview
@property(nonatomic,strong)NSMutableArray * pageIndexArray;//存放pageindex
@property(nonatomic,strong)NSMutableArray * dataSourceArray;//存放数据源


@property(nonatomic,strong)UIScrollView * contentScrollView;

@property(nonatomic,strong)NSString * field;
@property(nonatomic,strong)NSString * order;
@property(nonatomic,strong)NSString * message_type;

@property(nonatomic,strong)NSString * nvShenField;//女神筛选条件

@property(nonatomic,strong)Lable_ImageButton * noMessageTipButotn1;
@property(nonatomic,strong)Lable_ImageButton * noMessageTipButotn2;
@property(nonatomic,strong)Lable_ImageButton * noMessageTipButotn3;
@property(nonatomic,strong)Lable_ImageButton * noMessageTipButotn4;

@property(nonatomic,strong)UIView * uploadTipView;

@property(nonatomic,strong)UIImageView * cityKuangView;



@end

@implementation HomeViewController

-(UIView *)uploadTipView
{
    if (!_uploadTipView) {
        
        _uploadTipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _uploadTipView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [[UIApplication sharedApplication].keyWindow addSubview:_uploadTipView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-274*BiLiWidth)/2, 287*BiLiWidth, 274*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [_uploadTipView addSubview:kuangImageView];
        
//        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
//        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
//        [closeButton addTarget:self action:@selector(closeUploadTipKuangView) forControlEvents:UIControlEventTouchUpInside];
//        [_uploadTipView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 33*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"滴滴约提示";
        [kuangImageView addSubview:tipLable1];
        
        UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(20*BiLiWidth, tipLable1.top+tipLable1.height+30*BiLiWidth, kuangImageView.width-40*BiLiWidth, 50*BiLiWidth)];
        tipLable2.font = [UIFont systemFontOfSize:12*BiLiWidth];
        tipLable2.textColor = RGBFormUIColor(0x343434);
        tipLable2.numberOfLines = 2;
        tipLable2.text = @"当前版本即将过期，为了不影响您的使用，请及时更新";
        [kuangImageView addSubview:tipLable2];

        NSString * haveto_update_app = [NormalUse getJinBiStr:@"haveto_update_app"];//0 不需要更新 1 普通更新 2 强制更新

        if([@"2" isEqualToString:haveto_update_app])
        {
            
            UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-115*BiLiWidth)/2, tipLable2.top+tipLable2.height+55*BiLiWidth, 115*BiLiWidth, 40*BiLiWidth)];
            [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
            sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
            sureLable.text = @"确定";
            sureLable.textAlignment = NSTextAlignmentCenter;
            sureLable.textColor = [UIColor whiteColor];
            [sureButton addSubview:sureLable];

        }
        else
        {
            UIButton * quXiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-85.5*BiLiWidth-11.5*BiLiWidth-115*BiLiWidth)/2, tipLable2.top+tipLable2.height+55*BiLiWidth, 85.5*BiLiWidth, 40*BiLiWidth)];
            [quXiaoButton setTitle:@"取消" forState:UIControlStateNormal];
            quXiaoButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
            quXiaoButton.layer.cornerRadius = 20*BiLiWidth;
            [quXiaoButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
            quXiaoButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
            [quXiaoButton addTarget:self action:@selector(closeUploadTipKuangView) forControlEvents:UIControlEventTouchUpInside];
            [kuangImageView addSubview:quXiaoButton];

            UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake(quXiaoButton.left+quXiaoButton.width+11.5*BiLiWidth, quXiaoButton.top, 115*BiLiWidth, 40*BiLiWidth)];
            [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
            sureLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
            sureLable.text = @"去更新";
            sureLable.textAlignment = NSTextAlignmentCenter;
            sureLable.textColor = [UIColor whiteColor];
            [sureButton addSubview:sureLable];

        }


        
    }
    return _uploadTipView;
}
-(void)sureButtonClick
{
    
    NSString * haveto_update_app = [NormalUse getJinBiStr:@"haveto_update_app"];//0 不需要更新 1 普通更新 2 强制更新
    if(![@"2" isEqualToString:haveto_update_app])
    {
        [self closeUploadTipKuangView];

    }
    NSString *textURL = [NormalUse getJinBiStr:@"update_app_url"];
    NSURL *cleanURL = [NSURL URLWithString:[NormalUse getobjectForKey:textURL]];
    [[UIApplication sharedApplication] openURL:cleanURL options:nil completionHandler:^(BOOL success) {
        
    }];
}
-(void)closeUploadTipKuangView
{
    self.uploadTipView.hidden = YES;
    [self getGongGaiMessage];
}


-(Lable_ImageButton *)noMessageTipButotn1
{
    if (!_noMessageTipButotn1) {
        
        _noMessageTipButotn1 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, 10*BiLiWidth, WIDTH_PingMu, 90*BiLiWidth)];
        _noMessageTipButotn1.button_imageView.frame = CGRectMake((_noMessageTipButotn1.width-60*BiLiWidth)/2, 0, 60*BiLiWidth, 60*BiLiWidth);
        _noMessageTipButotn1.button_imageView.image = [UIImage imageNamed:@"noMessage_tip"];
        _noMessageTipButotn1.button_lable.frame = CGRectMake(0, _noMessageTipButotn1.button_imageView.top+_noMessageTipButotn1.button_imageView.height+10*BiLiWidth, _noMessageTipButotn1.width, 12*BiLiWidth);
        _noMessageTipButotn1.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        _noMessageTipButotn1.button_lable.textColor = RGBFormUIColor(0x343434);
        _noMessageTipButotn1.button_lable.textAlignment = NSTextAlignmentCenter;
        _noMessageTipButotn1.button_lable.text = @"暂无信息";
        
    }
    return _noMessageTipButotn1;
}
-(Lable_ImageButton *)noMessageTipButotn2
{
    if (!_noMessageTipButotn2) {
        
        _noMessageTipButotn2 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, 10*BiLiWidth, WIDTH_PingMu, 90*BiLiWidth)];
        _noMessageTipButotn2.button_imageView.frame = CGRectMake((_noMessageTipButotn2.width-60*BiLiWidth)/2, 0, 60*BiLiWidth, 60*BiLiWidth);
        _noMessageTipButotn2.button_imageView.image = [UIImage imageNamed:@"noMessage_tip"];
        _noMessageTipButotn2.button_lable.frame = CGRectMake(0, _noMessageTipButotn2.button_imageView.top+_noMessageTipButotn2.button_imageView.height+10*BiLiWidth, _noMessageTipButotn2.width, 12*BiLiWidth);
        _noMessageTipButotn2.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        _noMessageTipButotn2.button_lable.textColor = RGBFormUIColor(0x343434);
        _noMessageTipButotn2.button_lable.textAlignment = NSTextAlignmentCenter;
        _noMessageTipButotn2.button_lable.text = @"暂无信息";
        
    }
    return _noMessageTipButotn2;
}
-(Lable_ImageButton *)noMessageTipButotn3
{
    if (!_noMessageTipButotn3) {
        
        _noMessageTipButotn3 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, 10*BiLiWidth, WIDTH_PingMu, 90*BiLiWidth)];
        _noMessageTipButotn3.button_imageView.frame = CGRectMake((_noMessageTipButotn3.width-60*BiLiWidth)/2, 0, 60*BiLiWidth, 60*BiLiWidth);
        _noMessageTipButotn3.button_imageView.image = [UIImage imageNamed:@"noMessage_tip"];
        _noMessageTipButotn3.button_lable.frame = CGRectMake(0, _noMessageTipButotn3.button_imageView.top+_noMessageTipButotn3.button_imageView.height+10*BiLiWidth, _noMessageTipButotn3.width, 12*BiLiWidth);
        _noMessageTipButotn3.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        _noMessageTipButotn3.button_lable.textColor = RGBFormUIColor(0x343434);
        _noMessageTipButotn3.button_lable.textAlignment = NSTextAlignmentCenter;
        _noMessageTipButotn3.button_lable.text = @"暂无信息";
        
    }
    return _noMessageTipButotn3;
}
-(Lable_ImageButton *)noMessageTipButotn4
{
    if (!_noMessageTipButotn4) {
        
        _noMessageTipButotn4 = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(0, 10*BiLiWidth, WIDTH_PingMu, 90*BiLiWidth)];
        _noMessageTipButotn4.button_imageView.frame = CGRectMake((_noMessageTipButotn4.width-60*BiLiWidth)/2, 0, 60*BiLiWidth, 60*BiLiWidth);
        _noMessageTipButotn4.button_imageView.image = [UIImage imageNamed:@"noMessage_tip"];
        _noMessageTipButotn4.button_lable.frame = CGRectMake(0, _noMessageTipButotn4.button_imageView.top+_noMessageTipButotn4.button_imageView.height+10*BiLiWidth, _noMessageTipButotn4.width, 12*BiLiWidth);
        _noMessageTipButotn4.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        _noMessageTipButotn4.button_lable.textColor = RGBFormUIColor(0x343434);
        _noMessageTipButotn4.button_lable.textAlignment = NSTextAlignmentCenter;
        _noMessageTipButotn4.button_lable.text = @"暂无信息";
        
    }
    return _noMessageTipButotn4;
}


-(HomeShaiXuanView *)shaiXuanView
{
    if (!_shaiXuanView) {
        
        __weak typeof(self) wself = self;
        _shaiXuanView = [[HomeShaiXuanView alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu, WIDTH_PingMu, 0)];
        
        [_shaiXuanView setPaiXuSelect:^(NSString * _Nonnull field, NSString * _Nonnull order) {
          
            wself.field = field;
            wself.order = order;
            
            [wself firstGetTieZiList];
            [wself firstGetRedList];
//            [wself firstGetYanZhengBangDanList];
//            [wself firstGetYanCheBaoGaoList];

        }];
        [_shaiXuanView setLeiXingSelect:^(NSString * _Nonnull message_type) {
            
            wself.message_type = message_type;
            [wself firstGetTieZiList];
            [wself firstGetRedList];
//            [wself firstGetYanZhengBangDanList];
//            [wself firstGetYanCheBaoGaoList];

        }];
        [[UIApplication sharedApplication].keyWindow addSubview:_shaiXuanView];
                
    }
    
    return _shaiXuanView;
    
}
-(HomeNvShenShaiXuanView *)nvShenShaiXuanView
{
    if (!_nvShenShaiXuanView) {
        
        _nvShenShaiXuanView = [[HomeNvShenShaiXuanView alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu, WIDTH_PingMu, HEIGHT_PingMu)];
        [[UIApplication sharedApplication].keyWindow addSubview:_nvShenShaiXuanView];
        
        __weak typeof(self) wself = self;
        [_nvShenShaiXuanView setPaiXuSelect:^(NSString * _Nonnull field) {
            
            wself.nvShenField = field;
            [wself firstGetHuiYuanZhuanQuList];
            
        }];
    }
    return _nvShenShaiXuanView;
}

-(UIView *)chaXiaoErFaTieRenZhengView1
{
    if (!_chaXiaoErFaTieRenZhengView1) {
        
        _chaXiaoErFaTieRenZhengView1 = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu, WIDTH_PingMu, HEIGHT_PingMu)];
        _chaXiaoErFaTieRenZhengView1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [[UIApplication sharedApplication].keyWindow addSubview:_chaXiaoErFaTieRenZhengView1];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu-210*BiLiWidth, WIDTH_PingMu, 210*BiLiWidth)];
        kuangImageView.backgroundColor = [UIColor whiteColor];
        kuangImageView.userInteractionEnabled = YES;
        [_chaXiaoErFaTieRenZhengView1 addSubview:kuangImageView];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:kuangImageView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8*BiLiWidth, 8*BiLiWidth)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = kuangImageView.bounds;
        maskLayer.path = maskPath.CGPath;
        kuangImageView.layer.mask = maskLayer;
        

        
        self.renZhengButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(16*BiLiWidth, 35.5*BiLiWidth, 70*BiLiWidth, 84*BiLiWidth)];
        self.renZhengButton.button_imageView.frame = CGRectMake(0*BiLiWidth, 0, 70*BiLiWidth, 70*BiLiWidth);
        self.renZhengButton.button_imageView.image = [UIImage imageNamed:@"home_RenZheng"];
        self.renZhengButton.button_lable.frame = CGRectMake(0, 70*BiLiWidth, self.renZhengButton.width, 14*BiLiWidth);
        self.renZhengButton.button_lable.textAlignment = NSTextAlignmentCenter;
        self.renZhengButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.renZhengButton.button_lable.textColor = RGBFormUIColor(0x343434);
        self.renZhengButton.button_lable.adjustsFontSizeToFitWidth = YES;
        self.renZhengButton.button_lable.text = @"滴滴约认证";
        self.renZhengButton.tag = 1;
        [self.renZhengButton addTarget:self action:@selector(chaXiaoErRenZheng:) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:self.renZhengButton];
        
        self.chaXiaErYiRenZhengLable = [[UILabel alloc] initWithFrame:CGRectMake(self.renZhengButton.left, self.renZhengButton.top+self.renZhengButton.height+5, self.renZhengButton.width, 12*BiLiWidth)];
        self.chaXiaErYiRenZhengLable.textAlignment = NSTextAlignmentCenter;
        self.chaXiaErYiRenZhengLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.chaXiaErYiRenZhengLable.textColor = RGBFormUIColor(0xFF0876);
        self.chaXiaErYiRenZhengLable.adjustsFontSizeToFitWidth = YES;
        [kuangImageView addSubview:self.chaXiaErYiRenZhengLable];

        
        Lable_ImageButton * faTieButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(100*BiLiWidth, 35.5*BiLiWidth, 70*BiLiWidth, 84*BiLiWidth)];
        faTieButton.button_imageView.frame = CGRectMake(0*BiLiWidth, 0, 70*BiLiWidth, 70*BiLiWidth);
        faTieButton.button_imageView.image = [UIImage imageNamed:@"home_FaTie"];
        faTieButton.button_lable.frame = CGRectMake(0, 70*BiLiWidth, faTieButton.width, 14*BiLiWidth);
        faTieButton.button_lable.textAlignment = NSTextAlignmentCenter;
        faTieButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        faTieButton.button_lable.textColor = RGBFormUIColor(0x343434);
        faTieButton.button_lable.adjustsFontSizeToFitWidth = YES;
        faTieButton.button_lable.text = @"发布信息";
        faTieButton.tag = 0;
        [faTieButton addTarget:self action:@selector(faTieButtonClick1:) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:faTieButton];
        
        UIView * lineViewFenGe = [[UIView alloc] initWithFrame:CGRectMake(faTieButton.right+8*BiLiWidth, faTieButton.top, 2, 70*BiLiWidth)];
        lineViewFenGe.backgroundColor = RGBFormUIColor(0xE5E5E5);
        [kuangImageView addSubview:lineViewFenGe];

        
        self.nvShenRenZhengButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(188*BiLiWidth, 35.5*BiLiWidth, 70*BiLiWidth, 84*BiLiWidth)];
        self.nvShenRenZhengButton.button_imageView.frame = CGRectMake(0*BiLiWidth, 0, 70*BiLiWidth, 70*BiLiWidth);
        self.nvShenRenZhengButton.button_imageView.image = [UIImage imageNamed:@"home_nvShenRenZheng"];
        self.nvShenRenZhengButton.button_lable.frame = CGRectMake(0, 70*BiLiWidth, self.renZhengButton.width, 14*BiLiWidth);
        self.nvShenRenZhengButton.button_lable.textAlignment = NSTextAlignmentCenter;
        self.nvShenRenZhengButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.nvShenRenZhengButton.button_lable.textColor = RGBFormUIColor(0x343434);
        self.nvShenRenZhengButton.button_lable.adjustsFontSizeToFitWidth = YES;
        self.nvShenRenZhengButton.button_lable.text = @"会员专区认证";
        [self.nvShenRenZhengButton addTarget:self action:@selector(huiYuanRenZhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:self.nvShenRenZhengButton];
        
        self.nvShenRenZhengLable = [[UILabel alloc] initWithFrame:CGRectMake(self.nvShenRenZhengButton.left, self.renZhengButton.top+self.renZhengButton.height+5, self.nvShenRenZhengButton.width, 12*BiLiWidth)];
        self.nvShenRenZhengLable.textAlignment = NSTextAlignmentCenter;
        self.nvShenRenZhengLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        self.nvShenRenZhengLable.textColor = RGBFormUIColor(0xFF0876);
        self.nvShenRenZhengLable.adjustsFontSizeToFitWidth = YES;
        [kuangImageView addSubview:self.nvShenRenZhengLable];

        
        Lable_ImageButton * nvShenFaBuXinXiButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(275*BiLiWidth, 35.5*BiLiWidth, 70*BiLiWidth, 84*BiLiWidth)];
        nvShenFaBuXinXiButton.button_imageView.frame = CGRectMake(0*BiLiWidth, 0, 70*BiLiWidth, 70*BiLiWidth);
        nvShenFaBuXinXiButton.button_imageView.image = [UIImage imageNamed:@"home_nvShenFaBu"];
        nvShenFaBuXinXiButton.button_lable.frame = CGRectMake(0, 70*BiLiWidth, faTieButton.width, 14*BiLiWidth);
        nvShenFaBuXinXiButton.button_lable.textAlignment = NSTextAlignmentCenter;
        nvShenFaBuXinXiButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
        nvShenFaBuXinXiButton.button_lable.textColor = RGBFormUIColor(0x343434);
        nvShenFaBuXinXiButton.button_lable.adjustsFontSizeToFitWidth = YES;
        nvShenFaBuXinXiButton.button_lable.text = @"会员专区发帖";
        nvShenFaBuXinXiButton.tag = 1;
        [nvShenFaBuXinXiButton addTarget:self action:@selector(faTieButtonClick1:) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:nvShenFaBuXinXiButton];


        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kuangImageView.height-54*BiLiWidth, WIDTH_PingMu, 1)];
        lineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [kuangImageView addSubview:lineView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, lineView.top+lineView.height,WIDTH_PingMu, 53*BiLiWidth)];
        [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [closeButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
        closeButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        [closeButton addTarget:self action:@selector(closeTipKuangView1) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:closeButton];


    }
    return _chaXiaoErFaTieRenZhengView1;
}
-(void)closeTipKuangView1
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.chaXiaoErFaTieRenZhengView1.top = HEIGHT_PingMu;
    }];
}

-(void)faTieButtonClick1:(UIButton *)button
{
    NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
    NSString * defaultsKey = [UserRole stringByAppendingString:token];
    NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];

    if (button.tag==0) {
        
        NSNumber * auth_nomal = [userRoleDic objectForKey:@"auth_nomal"];
        if (auth_nomal.intValue==1)
        {
            self.nvShenFaTieOrChaXiaoErFaTie = @"0";

            [self faTieButtonClick];
        }
        else
        {
            self.nvShenFaTieOrChaXiaoErFaTie = @"0";
            
            self.chaXiaoErFaTieRenZhengView.hidden = NO;
            self.chaXiaoErFaTieRenZhengView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            [UIView animateWithDuration:0.5 animations:^{
                
                self.chaXiaoErFaTieRenZhengView.transform = CGAffineTransformIdentity;
            }];

        }

    }
    else
    {
        if (self.auth_vip.intValue!=3&&self.auth_vip_cetf.intValue!=1) {
            
            
            if(self.auth_vip.intValue==0)
            {
                ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:@"只有完成会员认证或成为蛟龙炮神会员才可以发布会员专区的帖子哦，认证通过后帖子会得到官方的认证标示" message2:@"" button1Title:@"开通会员" button2Title:@""];
                alertView.button1Click = ^{
                    
                    HuiYuanViewController * vc = [[HuiYuanViewController alloc] init];
                    vc.info = self.userInfo;
                    vc.vipListInfo = self.vipListInfo;
                    [self.navigationController pushViewController:vc animated:YES];

                };
                alertView.button2Click = ^{
                    
                };
                [[UIApplication sharedApplication].keyWindow addSubview:alertView];
            }
            else
            {
                ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:@"只有完成会员认证或成为蛟龙炮神会员才可以发布会员专区的帖子哦，认证通过后帖子会得到官方的认证标示" message2:@"" button1Title:@"去认证" button2Title:@"开通会员"];
                alertView.button1Click = ^{
                    
                    JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
                    vc.renZhengType = @"3";
                    [self.navigationController pushViewController:vc animated:YES];

                };
                alertView.button2Click = ^{
                  
                    HuiYuanViewController * vc = [[HuiYuanViewController alloc] init];
                    vc.info = self.userInfo;
                    vc.vipListInfo = self.vipListInfo;
                    [self.navigationController pushViewController:vc animated:YES];

                };
                [[UIApplication sharedApplication].keyWindow addSubview:alertView];
            }

        }
        else
        {
            CreateTieZiViewController * vc = [[CreateTieZiViewController alloc] init];
            vc.from_flg = @"2";
            [self.navigationController pushViewController:vc animated:YES];
            self.chaXiaoErFaTieRenZhengView.hidden = YES;

        }
    }
//    else
//    {
//        NSNumber * auth_goddess = [userRoleDic objectForKey:@"auth_goddess"];
//        if (auth_goddess.intValue==1) {
//
//            JiaoSeWeiRenZhengFaTieVC * vc = [[JiaoSeWeiRenZhengFaTieVC alloc] init];
//            vc.renZhengType = @"1";
//            vc.renZhengStatus = 1;
//            [self.navigationController pushViewController:vc animated:YES];
//
//        }
//        else
//        {
//            self.nvShenFaTieOrChaXiaoErFaTie = @"1";
//
//            self.chaXiaoErFaTieRenZhengView.hidden = NO;
//            self.chaXiaoErFaTieRenZhengView.transform = CGAffineTransformMakeScale(0.001, 0.001);
//            [UIView animateWithDuration:0.5 animations:^{
//
//                self.chaXiaoErFaTieRenZhengView.transform = CGAffineTransformIdentity;
//            }];
//
//        }
//
//    }
    

    [UIView animateWithDuration:0.5 animations:^{
        
        self.chaXiaoErFaTieRenZhengView1.top = HEIGHT_PingMu;
    }];

    
}

-(UIView *)chaXiaoErFaTieRenZhengView
{
    if (!_chaXiaoErFaTieRenZhengView) {
        
        _chaXiaoErFaTieRenZhengView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _chaXiaoErFaTieRenZhengView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [[UIApplication sharedApplication].keyWindow addSubview:_chaXiaoErFaTieRenZhengView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-274*BiLiWidth)/2, 287*BiLiWidth, 274*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [_chaXiaoErFaTieRenZhengView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [_chaXiaoErFaTieRenZhengView addSubview:closeButton];
        
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
        tipLable2.text = @"您当前是未认证用户，发布的信息不会得到官方认证。若需要获得官方认证，请先进行身份认证或者开通会员！";
        [kuangImageView addSubview:tipLable2];
        
        
        UIButton * faTieButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-85.5*BiLiWidth-11.5*BiLiWidth-115*BiLiWidth)/2, tipLable2.top+tipLable2.height+25*BiLiWidth, 85.5*BiLiWidth, 40*BiLiWidth)];
        [faTieButton setTitle:@"继续发帖" forState:UIControlStateNormal];
        faTieButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
        faTieButton.layer.cornerRadius = 20*BiLiWidth;
        [faTieButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        faTieButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [faTieButton addTarget:self action:@selector(faTieButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:faTieButton];

        
        UIButton * renZhengButton = [[UIButton alloc] initWithFrame:CGRectMake(faTieButton.left+faTieButton.width+11.5*BiLiWidth, faTieButton.top, 115*BiLiWidth, 40*BiLiWidth)];
        renZhengButton.tag = 0;
        [renZhengButton addTarget:self action:@selector(chaXiaoErRenZheng1:) forControlEvents:UIControlEventTouchUpInside];
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
    return _chaXiaoErFaTieRenZhengView;
}
-(void)closeTipKuangView
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.chaXiaoErFaTieRenZhengView.transform = CGAffineTransformMakeScale(0.001, 0.001);

    } completion:^(BOOL finished) {
             
        self.chaXiaoErFaTieRenZhengView.hidden = YES;

    }];
}
-(void)chaXiaoErRenZheng1:(UIButton *)button
{
    self.chaXiaoErFaTieRenZhengView.hidden = YES;
    if ([@"0" isEqualToString:self.nvShenFaTieOrChaXiaoErFaTie]) {
        
        JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
        vc.renZhengType = @"1";
        [self.navigationController pushViewController:vc animated:YES];

    }
    else
    {
        NvShenRenZhengStep1VC * vc = [[NvShenRenZhengStep1VC alloc] init];
        vc.renZhengType = @"1";
        [self.navigationController pushViewController:vc animated:YES];

    }

}
-(void)chaXiaoErRenZheng:(UIButton *)button
{
//    self.chaXiaoErFaTieRenZhengView.hidden = YES;
//    if ([@"0" isEqualToString:self.nvShenFaTieOrChaXiaoErFaTie]) {
//
//        JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
//        vc.renZhengType = @"1";
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
//    else
//    {
//        NvShenRenZhengStep1VC * vc = [[NvShenRenZhengStep1VC alloc] init];
//        vc.renZhengType = @"1";
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }

    if (button.tag==0) {

        [UIView animateWithDuration:0.5 animations:^{

            self.chaXiaoErFaTieRenZhengView1.top = HEIGHT_PingMu;
        }];

        [UIView animateWithDuration:0.25 animations:^{

            self.chaXiaoErFaTieRenZhengView.transform = CGAffineTransformMakeScale(0.001, 0.001);

        } completion:^(BOOL finished) {

            self.chaXiaoErFaTieRenZhengView.hidden = YES;

        }];

        NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
        NSString * defaultsKey = [UserRole stringByAppendingString:token];
        NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
        NSNumber * auth_nomal = [userRoleDic objectForKey:@"auth_nomal"];

        if ([auth_nomal isKindOfClass:[NSNumber class]]) {

            if (auth_nomal.intValue==0) {

                JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
                vc.renZhengType = @"1";
                [self.navigationController pushViewController:vc animated:YES];

            }
            else if (auth_nomal.intValue==2)
            {
                JingJiRenRenZhengStep3VC * vc = [[JingJiRenRenZhengStep3VC alloc] init];
                vc.alsoShowBackButton = YES;
                [self.navigationController pushViewController:vc animated:YES];

            }
        }
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{

            self.chaXiaoErFaTieRenZhengView1.top = HEIGHT_PingMu;
        }];


        self.chaXiaoErRenZhengTipView.hidden = NO;
        self.chaXiaoErRenZhengTipView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        [UIView animateWithDuration:0.5 animations:^{

            self.chaXiaoErRenZhengTipView.transform = CGAffineTransformIdentity;
        }];

    }
//
    
}
-(void)faTieButtonClick
{
    self.chaXiaoErFaTieRenZhengView.hidden = YES;
    if ([@"0" isEqualToString:self.nvShenFaTieOrChaXiaoErFaTie]) {
        
        CreateTieZiViewController * vc = [[CreateTieZiViewController alloc] init];
        vc.from_flg = @"0";
        [self.navigationController pushViewController:vc animated:YES];
        self.chaXiaoErFaTieRenZhengView.hidden = YES;

    }
    else
    {
        JiaoSeWeiRenZhengFaTieVC * vc = [[JiaoSeWeiRenZhengFaTieVC alloc] init];
        vc.renZhengType = @"1";
        [self.navigationController pushViewController:vc animated:YES];

    }

}
-(UIView *)chaXiaoErRenZhengTipView
{
    if (!_chaXiaoErRenZhengTipView) {
        
        _chaXiaoErRenZhengTipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _chaXiaoErRenZhengTipView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [[UIApplication sharedApplication].keyWindow addSubview:_chaXiaoErRenZhengTipView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-274*BiLiWidth)/2, 287*BiLiWidth, 274*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [_chaXiaoErRenZhengTipView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeChaXiaoErRenZhengTipView) forControlEvents:UIControlEventTouchUpInside];
        [_chaXiaoErRenZhengTipView addSubview:closeButton];
        
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
        tipLable2.text = @"必须是真实信息和有效联系方式，认证后可在首页发布信息且拥有官方认证标识和官方推荐红榜特权";
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
    return _chaXiaoErRenZhengTipView;
}
-(void)closeChaXiaoErRenZhengTipView
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.chaXiaoErRenZhengTipView.transform = CGAffineTransformMakeScale(0.001, 0.001);

    } completion:^(BOOL finished) {
             
        self.chaXiaoErRenZhengTipView.hidden = YES;

    }];
}

-(void)chaXiaoErRenZhengTipViewRenZhengButtonClick
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.chaXiaoErFaTieRenZhengView1.top = HEIGHT_PingMu;
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.chaXiaoErRenZhengTipView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        
    } completion:^(BOOL finished) {
        
        self.chaXiaoErRenZhengTipView.hidden = YES;

    }];

    NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
    NSString * defaultsKey = [UserRole stringByAppendingString:token];
    NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
    NSNumber * auth_nomal = [userRoleDic objectForKey:@"auth_nomal"];
    
    if ([auth_nomal isKindOfClass:[NSNumber class]]) {
        
        if (auth_nomal.intValue==0) {
            
            JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
            vc.renZhengType = @"1";
            [self.navigationController pushViewController:vc animated:YES];

        }
        else if (auth_nomal.intValue==2)
        {
            JingJiRenRenZhengStep3VC * vc = [[JingJiRenRenZhengStep3VC alloc] init];
            vc.alsoShowBackButton = YES;
            [self.navigationController pushViewController:vc animated:YES];

        }
    }

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
        
        UILabel * sanDaJiaSeFaTieRenZhengViewTipLable = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 80*BiLiWidth)];
        sanDaJiaSeFaTieRenZhengViewTipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
        sanDaJiaSeFaTieRenZhengViewTipLable.textColor = RGBFormUIColor(0x343434);
        sanDaJiaSeFaTieRenZhengViewTipLable.numberOfLines = 4;
        sanDaJiaSeFaTieRenZhengViewTipLable.text = @"女神必须本人真实认证，认证后拥有官方独立信息展示区、官方推荐资格和官方认证标识同时平台给予更多流量扶持";
        [kuangImageView addSubview:sanDaJiaSeFaTieRenZhengViewTipLable];
        
        
        UIButton * sanDaJiaSeFaTieRenZhengViewFaTieButton = [[UIButton alloc] initWithFrame:CGRectMake((kuangImageView.width-85.5*BiLiWidth-11.5*BiLiWidth-115*BiLiWidth)/2, sanDaJiaSeFaTieRenZhengViewTipLable.top+sanDaJiaSeFaTieRenZhengViewTipLable.height+25*BiLiWidth, 85.5*BiLiWidth, 40*BiLiWidth)];
        [sanDaJiaSeFaTieRenZhengViewFaTieButton setTitle:@"取消" forState:UIControlStateNormal];
        sanDaJiaSeFaTieRenZhengViewFaTieButton.backgroundColor = RGBFormUIColor(0xEEEEEE);
        sanDaJiaSeFaTieRenZhengViewFaTieButton.layer.cornerRadius = 20*BiLiWidth;
        [sanDaJiaSeFaTieRenZhengViewFaTieButton setTitleColor:RGBFormUIColor(0x9A9A9A) forState:UIControlStateNormal];
        sanDaJiaSeFaTieRenZhengViewFaTieButton.titleLabel.font = [UIFont systemFontOfSize:14*BiLiWidth];
        [sanDaJiaSeFaTieRenZhengViewFaTieButton addTarget:self action:@selector(quXiaoNvShenRenZheng) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:sanDaJiaSeFaTieRenZhengViewFaTieButton];

        UIButton * renZhengButton = [[UIButton alloc] initWithFrame:CGRectMake(sanDaJiaSeFaTieRenZhengViewFaTieButton.left+sanDaJiaSeFaTieRenZhengViewFaTieButton.width+11.5*BiLiWidth, sanDaJiaSeFaTieRenZhengViewFaTieButton.top, 115*BiLiWidth, 40*BiLiWidth)];
        [renZhengButton addTarget:self action:@selector(nvShenRenZheng) forControlEvents:UIControlEventTouchUpInside];
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
    return _sanDaJiaSeFaTieRenZhengView;
}
-(void)huiYuanRenZhengButtonClick
{
    
    self.chaXiaoErFaTieRenZhengView1.top = HEIGHT_PingMu;
    
    ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:@"必须是真实信息和有效的联系方式，认证后可在会员专区发布信息且拥有官方认证标识" message2:@"" button1Title:@"去认证" button2Title:@""];
    alertView.button1Click = ^{
        
        JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
        vc.renZhengType = @"3";
        [self.navigationController pushViewController:vc animated:YES];
    };
    alertView.button2Click = ^{
      
    };
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];

    /*
    if(self.auth_vip.intValue==0)
    {
        ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:@"您当前未开通任何会员，开通会员后才可以进行会员专区认证" message2:@"" button1Title:@"开通会员" button2Title:@""];
        alertView.button1Click = ^{
            
            HuiYuanViewController * vc = [[HuiYuanViewController alloc] init];
            vc.info = self.userInfo;
            vc.vipListInfo = self.vipListInfo;
            [self.navigationController pushViewController:vc animated:YES];

        };
        alertView.button2Click = ^{
          
        };
        [[UIApplication sharedApplication].keyWindow addSubview:alertView];

    }
    else
    {
        JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
        vc.renZhengType = @"3";
        [self.navigationController pushViewController:vc animated:YES];
    }
     */
    
//    [UIView animateWithDuration:0.5 animations:^{
//
//        self.chaXiaoErFaTieRenZhengView1.top = HEIGHT_PingMu;
//    }];
//
//    self.sanDaJiaSeFaTieRenZhengView.hidden = NO;

}
-(void)nvShenRenZheng
{
    
//    self.sanDaJiaSeFaTieRenZhengView.hidden = YES;
//    NvShenRenZhengStep1VC * vc = [[NvShenRenZhengStep1VC alloc] init];
//    vc.renZhengType =@"1";
//    [self.navigationController pushViewController:vc animated:YES];

}
-(void)quXiaoNvShenRenZheng
{
    self.sanDaJiaSeFaTieRenZhengView.hidden = YES;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setLocationStr];
    
    [self xianShiTabBar];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

    
    self.chaXiaoErFaTieRenZhengView1.top = HEIGHT_PingMu;
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
                //auth_vip_cetf 会员是否已认证（只有会员身份才能认证该身份）
                
                NSDictionary * info = responseObject;

                NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
                NSString * defaultsKey = [UserRole stringByAppendingString:token];
                
                NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
                
                if ([NormalUse isValidDictionary:userRoleDic]) {
                    
                    if (![info isEqual:userRoleDic]&&[NormalUse isValidDictionary:info]) {
                        
                        [NormalUse defaultsSetObject:info forKey:defaultsKey];
                    }
                }
                else
                {
                    if([NormalUse isValidDictionary:info])
                    {
                        [NormalUse defaultsSetObject:info forKey:defaultsKey];

                    }
                }
                NSNumber * auth_nomal = [userRoleDic objectForKey:@"auth_nomal"];
                if (auth_nomal.intValue==1) {
                    
                    self.renZhengButton.enabled = NO;
                    self.chaXiaErYiRenZhengLable.text = @"(已认证)";
                }
                else if (auth_nomal.intValue==2)
                {

                    self.renZhengButton.enabled = NO;
                    self.chaXiaErYiRenZhengLable.text = @"(审核中)";

                }
                else
                {
                    self.renZhengButton.enabled = YES;
                    self.chaXiaErYiRenZhengLable.text = @"";
                }

                
                
                self.auth_vip_cetf = [userRoleDic objectForKey:@"auth_vip_cetf"];
                self.auth_vip = [NormalUse defaultsGetObjectKey:@"UserAlsoVip"];
                //蛟龙炮神自动完成会员认证
                if (self.auth_vip_cetf.intValue==1||self.auth_vip.intValue==3) {
                    
                    self.nvShenRenZhengButton.enabled = NO;
                    self.nvShenRenZhengLable.text = @"(已认证)";
                    if (self.auth_vip.intValue==3) {
                        
                        self.nvShenRenZhengLable.text = @"(蛟龙炮神免认证)";

                    }

                }
                else if (self.auth_vip_cetf.intValue==2)
                {
                    self.nvShenRenZhengButton.enabled = NO;
                    self.nvShenRenZhengLable.text = @"(审核中)";

                }
                else
                {
                    self.nvShenRenZhengButton.enabled = YES;
                    self.nvShenRenZhengLable.text = @"";

                }


            }
        }];
        
    }
    
    
}
-(void)setLocationStr
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
-(void)registerInit
{
    if (![NormalUse isValidString:[NormalUse defaultsGetObjectKey:LoginToken]]) {
        
        [HTTPModel getAppJinBiList:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                NSDictionary * info = [NormalUse removeNullFromDictionary:responseObject];
                [NormalUse defaultsSetObject:info forKey:JinBiShuoMing];
            }
        }];
        
        //未登录用户先 获取初始化账号
        [HTTPModel registerInit:[[NSDictionary alloc]initWithObjectsAndKeys:[NormalUse getSheBeiBianMa],@"phone_ucode",@"2",@"platform", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                if ([NormalUse isValidDictionary:[responseObject objectForKey:@"info"]]) {
                    
                    NSDictionary * userInfo = [responseObject objectForKey:@"info"];
                    [NormalUse defaultsSetObject:[userInfo objectForKey:@"ryuser"] forKey:UserRongYunInfo];
                    [[RongYManager getInstance] connectRongCloud];


                }
                //获取初始化账号 成功后调用登录 获取到logintoken
                [HTTPModel login:[[NSDictionary alloc]initWithObjectsAndKeys:[NormalUse getSheBeiBianMa],@"phone_ucode", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                    
                    if (status==1) {
                                                
                        NSString *  logintoken = [responseObject objectForKey:@"logintoken"];
                        [NormalUse defaultsSetObject:logintoken forKey:LoginToken];
                        
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        [formatter setDateFormat:@"YYYY-MM-dd"];
                        NSDate *datenow = [NSDate date];
                        NSString *currentTimeString = [formatter stringFromDate:datenow];

                        [NormalUse defaultsSetObject:@"1" forKey:currentTimeString];

                    }
                }];
            }
        }];
        
    }
    
    
}
-(void)getGongGaiMessage
{
    [HTTPModel getXiTongGongGao:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            
            NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:responseObject,@"message", nil];
            GongGaoAlertView * gongGaoView = [[GongGaoAlertView alloc] initWithFrame:CGRectZero messageInfo:dic];
            gongGaoView.closeView = ^{
                
            };
            gongGaoView.toUpload = ^{
                
            };
            [[UIApplication sharedApplication].keyWindow addSubview:gongGaoView];

        }
    }];

}
-(void)viewDidAppear:(BOOL)animated
{
    
//    for (int i=0; i<9; i++) {
//        
//        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*i, 50, 30, 30)];
//        [self.view addSubview:imageView];
//        
//        NSString * imageUrl = [NSString stringWithFormat:@"https://xcypzp.com/upload/202101201455/110000/32821/test%d.jpg",i];
//        // 创建URL对象
//        NSURL *url = [NSURL URLWithString:imageUrl];
//        // 创建request对象
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        // 发送异步请求
//    //    [NSURLSession]
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            // 如果请求到数据
//            if (data) {
//                NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                receiveStr = [receiveStr stringByReplacingOccurrencesOfString:@"data:image/jpg;base64," withString:@""];
//                NSData * showData = [[NSData alloc]initWithBase64EncodedString:receiveStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
//                imageView.image = [UIImage imageWithData:showData];
//            }
//        }];
//
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HTTPModel huiYuanMiaoShuXinXi:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.vipListInfo =  responseObject;
        }
    }];
    [HTTPModel getUserInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            self.userInfo = responseObject;
            self.auth_vip = [self.userInfo objectForKey:@"auth_vip"];

        }
    }];

        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNewLsit) name:@"cityChangeReloadMessageNotification" object:nil];

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    //用户每天调用一下登录接口
    if(![@"1" isEqualToString:[NormalUse defaultsGetObjectKey:currentTimeString]])
    {
     
        [HTTPModel login:[[NSDictionary alloc]initWithObjectsAndKeys:[NormalUse getSheBeiBianMa],@"phone_ucode", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            [NormalUse defaultsSetObject:[responseObject objectForKey:@"logintoken"] forKey:LoginToken];
            [NormalUse defaultsSetObject:@"1" forKey:currentTimeString];
        }];


    }


    
    [self registerInit];
    
     
    NSString * haveto_update_app = [NormalUse getJinBiStr:@"haveto_update_app"];//0 不需要更新 1 普通更新 2 强制更新
    NSString * ipa_version = [NormalUse getJinBiStr:@"ipa_version"];
    NSString * now_version = [NSString stringWithFormat:@"V%@",[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
    if (![now_version isEqualToString:ipa_version]) {
        
        if ([@"1" isEqualToString:haveto_update_app] ||[@"2" isEqualToString:haveto_update_app]) {
            
            self.uploadTipView.hidden = NO;
        }
        else
        {
            [self getGongGaiMessage];
        }

    }
    else
    {
        [self getGongGaiMessage];
    }
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.height+self.topNavView.top, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.height+self.topNavView.top+BottomHeight_PingMu))];
    self.mainScrollView.delegate = self;
    self.mainScrollView.tag = 1002;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    
    MJRefreshNormalHeader * mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLsit)];
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mainScrollView.mj_header = mjHeader;
    
    
    MJRefreshBackNormalFooter * mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreList)];
    self.mainScrollView.mj_footer = mjFooter;


    [NormalUse xianShiGifLoadingView:self];
    [HTTPModel getBannerList:[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        [NormalUse quXiaoGifLoadingView:self];
        if (status==1) {
            
            self.bannerArray = responseObject;
            [self initContentView];

        }
    }];
    

    
        
    self.backImageView.hidden = YES;
    self.lineView.hidden = YES;
    
    
    UIImageView * locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16*BiLiWidth, (self.topNavView.height-14*BiLiWidth)/2, 11*BiLiWidth, 14*BiLiWidth)];
    locationImageView.image = [UIImage imageNamed:@"home_location"];
    [self.topNavView addSubview:locationImageView];
    
    self.cityKuangView = [[UIImageView alloc] initWithFrame:CGRectMake(85*BiLiWidth, locationImageView.top-5.5*BiLiWidth, 133*BiLiWidth, 25*BiLiWidth)];
    self.cityKuangView.image = [UIImage imageNamed:@"city_selectTip"];
    [self.topNavView addSubview:self.cityKuangView];

    
    self.locationLable = [[UILabel alloc] initWithFrame:CGRectMake(locationImageView.left+locationImageView.width+5*BiLiWidth, locationImageView.top, 150*BiLiWidth, locationImageView.height)];
    self.locationLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.locationLable.adjustsFontSizeToFitWidth = YES;
    self.locationLable.textColor = RGBFormUIColor(0x333333);
    [self.topNavView addSubview:self.locationLable];
    
    UIButton * citySelectButton = [[UIButton alloc] initWithFrame:CGRectMake(locationImageView.left, locationImageView.top, 200*BiLiWidth, locationImageView.height)];
    [citySelectButton addTarget:self action:@selector(shaiXuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topNavView addSubview:citySelectButton];
    
    NSDictionary * cityInfo = [NormalUse defaultsGetObjectKey:@"CityInfoDefaults"];
    
    if ([NormalUse isValidDictionary:cityInfo]) {
     
        self.locationLable.text = [cityInfo objectForKey:@"cityName"];

    }
    else
    {
        [HTTPModel getCurrentCity:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            [NormalUse defaultsSetObject:responseObject forKey:CurrentCity];
        }];

        self.locationLable.text = @"选择城市";

    }

}
-(void)initContentView
{
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 147*BiLiWidth)];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.isCarousel = YES;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = YES;
    pageFlowView.orginPageCount = self.bannerArray.count;
    [pageFlowView reloadData];
    [self.mainScrollView addSubview:pageFlowView];

    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, pageFlowView.top+pageFlowView.height+8*BiLiWidth, 200*BiLiWidth, 10*BiLiWidth)];
    self.pageControl.currentPage = 0;      //设置当前页指示点
    self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
    self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
    self.pageControl.numberOfPages = self.bannerArray.count;
    [self.mainScrollView addSubview:self.pageControl];
    
    Lable_ImageButton * tiYanBaoGao = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(13.5*BiLiWidth, pageFlowView.top+pageFlowView.height+5*BiLiWidth, 69.5*BiLiWidth, 76.5*BiLiWidth)];
    [tiYanBaoGao addTarget:self action:@selector(tiYanBaoGaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    tiYanBaoGao.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    tiYanBaoGao.button_imageView.image = [UIImage imageNamed:@"home_tiYan"];
    tiYanBaoGao.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    tiYanBaoGao.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    tiYanBaoGao.button_lable.textColor = RGBFormUIColor(0x333333);
    tiYanBaoGao.button_lable.textAlignment = NSTextAlignmentCenter;
    tiYanBaoGao.button_lable.text = @"体验报告";
    [self.mainScrollView addSubview:tiYanBaoGao];
    
    Lable_ImageButton * fangLei = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(tiYanBaoGao.left+tiYanBaoGao.width+16.5*BiLiWidth, tiYanBaoGao.top, tiYanBaoGao.width, tiYanBaoGao.height)];
    [fangLei addTarget:self action:@selector(fangLeiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    fangLei.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    fangLei.button_imageView.image = [UIImage imageNamed:@"home_dangLei"];
    fangLei.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    fangLei.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    fangLei.button_lable.textColor = RGBFormUIColor(0x333333);
    fangLei.button_lable.textAlignment = NSTextAlignmentCenter;
    fangLei.button_lable.text = @"防雷防骗";
    [self.mainScrollView addSubview:fangLei];

    
    Lable_ImageButton * heiDian = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(fangLei.left+fangLei.width+16.5*BiLiWidth, tiYanBaoGao.top, tiYanBaoGao.width, tiYanBaoGao.height)];
    [heiDian addTarget:self action:@selector(heiDianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    heiDian.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    heiDian.button_imageView.image = [UIImage imageNamed:@"home_heiDian"];
    heiDian.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    heiDian.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    heiDian.button_lable.textColor = RGBFormUIColor(0x333333);
    heiDian.button_lable.textAlignment = NSTextAlignmentCenter;
    heiDian.button_lable.text = @"黑店曝光";
    [self.mainScrollView addSubview:heiDian];

    
    self.dingZhi = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(heiDian.left+heiDian.width+16.5*BiLiWidth, tiYanBaoGao.top, tiYanBaoGao.width, tiYanBaoGao.height)];
    [self.dingZhi addTarget:self action:@selector(dingZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.dingZhi.button_imageView.frame = CGRectMake(0, 0, 69.5*BiLiWidth, 69.5*BiLiWidth);
    self.dingZhi.button_imageView.image = [UIImage imageNamed:@"home_dingZhi"];
    self.dingZhi.button_lable.frame = CGRectMake(0, 65*BiLiWidth, tiYanBaoGao.width, 12*BiLiWidth);
    self.dingZhi.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.dingZhi.button_lable.textColor = RGBFormUIColor(0x333333);
    self.dingZhi.button_lable.textAlignment = NSTextAlignmentCenter;
    self.dingZhi.button_lable.text = @"定制服务";
    [self.mainScrollView addSubview:self.dingZhi];

    self.itemButtonContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.dingZhi.top+self.dingZhi.height+17.5*BiLiWidth, WIDTH_PingMu, 37*BiLiWidth)];
    self.itemButtonContentView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.itemButtonContentView];
    
    self.listButtonArray = [NSMutableArray array];
//    NSArray * array = [[NSArray alloc] initWithObjects:@"最新上传",@"红榜推荐",@"验证榜单",@"验车报告", nil];
    NSArray * array = [[NSArray alloc] initWithObjects:@"最新发布",@"红榜推荐",@"会员专区",nil];

    float originx = 20*BiLiWidth;
    CGSize size;
    for (int i=0; i<array.count; i++) {
        
        UIButton * button;
        
        size  = [NormalUse setSize:[array objectAtIndex:i] withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:12*BiLiWidth];
        button  = [[UIButton alloc] initWithFrame:CGRectMake(originx,10*BiLiWidth, size.width, 17*BiLiWidth)];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
        if(i==2)
        {
            [button setTitleColor:RGBFormUIColor(0xFF0876) forState:UIControlStateNormal];
        }
        button.tag = i;
        [button addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemButtonContentView addSubview:button];
        [button.titleLabel sizeToFit];
        originx = button.left+button.width+20*BiLiWidth;
        
        if (i==0) {
            
            button.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }

        
        [self.listButtonArray addObject:button];
        

    }
    
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(19.5*BiLiWidth,22.5*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
    self.sliderView.layer.cornerRadius = 7*BiLiWidth/2;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.alpha = 0.8;
    [self.itemButtonContentView addSubview:self.sliderView];
    
    Lable_ImageButton * shaiXuanButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(self.itemButtonContentView.width-52*BiLiWidth-13.5*BiLiWidth, (self.itemButtonContentView.height-22*BiLiWidth)/2, 52*BiLiWidth, 22*BiLiWidth)];
    shaiXuanButton.button_lable.frame = CGRectMake(0, 0, 30*BiLiWidth, 22*BiLiWidth);
    shaiXuanButton.button_lable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    shaiXuanButton.button_lable.text = @"筛选";
    shaiXuanButton.button_lable.textAlignment = NSTextAlignmentCenter;
    shaiXuanButton.button_lable.textColor = RGBFormUIColor(0xFF0876);
    shaiXuanButton.button_imageView.frame = CGRectMake(30*BiLiWidth, 0, 22*BiLiWidth, 22*BiLiWidth);
    shaiXuanButton.button_imageView.image = [UIImage imageNamed:@"icon_post_fild"];
    [shaiXuanButton addTarget:self action:@selector(tiJianuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.itemButtonContentView addSubview:shaiXuanButton];
    
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

    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.dingZhi.top+self.dingZhi.height+64.5*BiLiWidth, WIDTH_PingMu, HEIGHT_PingMu-(self.dingZhi.top+self.dingZhi.height+64.5*BiLiWidth+BottomHeight_PingMu))];
    [self.contentScrollView setContentSize:CGSizeMake(WIDTH_PingMu*array.count, 0)];
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.tag = 1001;
    self.contentScrollView.delegate = self;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    [self.mainScrollView addSubview:self.contentScrollView];
    
    self.pageIndexArray = [NSMutableArray array];
    self.tableViewArray = [NSMutableArray array];
    self.dataSourceArray = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        
        NSNumber * pageIndexNumber = [NSNumber numberWithInt:0];
        [self.pageIndexArray addObject:pageIndexNumber];
        
        NSMutableArray * sourceArray = [[NSMutableArray alloc] init];
        [self.dataSourceArray addObject:sourceArray];
        
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*i, 0, WIDTH_PingMu, self.contentScrollView.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.scrollEnabled = NO;
        [self.contentScrollView addSubview:tableView];
        
        [self.tableViewArray addObject:tableView];
        

    }
    [self firstGetTieZiList];
    [self firstGetRedList];
    [self firstGetHuiYuanZhuanQuList];
//    [self firstGetYanZhengBangDanList];
//    [self firstGetYanCheBaoGaoList];
    
    UIButton * faTieButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-80*BiLiWidth, HEIGHT_PingMu-70*BiLiWidth-BottomHeight_PingMu-84*BiLiWidth, 70*BiLiWidth, 70*BiLiWidth)];
    [faTieButton setBackgroundImage:[UIImage imageNamed:@"home_faBurenZheng"] forState:UIControlStateNormal];
    faTieButton.layer.cornerRadius = 25*BiLiWidth;
    [faTieButton addTarget:self action:@selector(faTieOrRenZhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:faTieButton];
    
    self.shakeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_PingMu-143*BiLiWidth, faTieButton.bottom+4*BiLiWidth, 133*BiLiWidth, 64*BiLiWidth)];
    self.shakeImageView.image = [UIImage imageNamed:@"home_renZhengFabuTipKuang"];
    [self.view addSubview:self.shakeImageView];
    [NormalUse shakeAnimationForView:self.shakeImageView];
}
-(void)firstGetTieZiList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    if ([NormalUse isValidString:self.field]) {
        
        [dic setObject:self.field forKey:@"field"];
    }
    if ([NormalUse isValidString:self.order]) {
        
        [dic setObject:self.order forKey:@"order"];
    }
    if ([NormalUse isValidString:self.message_type]) {
        
        [dic setObject:self.message_type forKey:@"message_type"];
    }
    [dic setObject:@"1" forKey:@"page"];

    [HTTPModel getTieZiList:dic
                   callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:0 withObject:pageIndexNumber];
            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:0 withObject:sourceArray];
            
            UITableView * tableView = [self.tableViewArray objectAtIndex:0];
            [self.mainScrollView.mj_header endRefreshing];
            [self.mainScrollView.mj_footer endRefreshing];
            
            if([NormalUse isValidArray:dataArray])
            {
                [self.noMessageTipButotn1 removeFromSuperview];
                tableView.height = (144*BiLiWidth+20*BiLiWidth)*sourceArray.count;

            }
            else
            {
                [tableView addSubview:self.noMessageTipButotn1];
                tableView.height = self.noMessageTipButotn1.top+self.noMessageTipButotn1.height;
            }

            
            [tableView reloadData];
            
            
            if (self.contentScrollView.contentOffset.x==0) {
                
                [self setMainScrollViewContentSize:tableView];
            }
        }
        
    }];
    
}
-(void)firstGetRedList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    if ([NormalUse isValidString:self.field]) {
        
        [dic setObject:self.field forKey:@"field"];
    }
    if ([NormalUse isValidString:self.order]) {
        
        [dic setObject:self.order forKey:@"order"];
    }
    if ([NormalUse isValidString:self.message_type]) {
        
        [dic setObject:self.message_type forKey:@"message_type"];
    }
    [dic setObject:@"1" forKey:@"page"];

    [HTTPModel getRedList:dic
                 callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];

            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:1 withObject:sourceArray];

            UITableView * tableView = [self.tableViewArray objectAtIndex:1];
            [self.mainScrollView.mj_header endRefreshing];
            [self.mainScrollView.mj_footer endRefreshing];
            
            if([NormalUse isValidArray:dataArray])
            {
                [self.noMessageTipButotn2 removeFromSuperview];
                tableView.height = (144*BiLiWidth+20*BiLiWidth)*sourceArray.count;

            }
            else
            {
                [tableView addSubview:self.noMessageTipButotn2];
                tableView.height = self.noMessageTipButotn2.top+self.noMessageTipButotn2.height;
            }

            
            [tableView reloadData];
            

            if (self.contentScrollView.contentOffset.x==WIDTH_PingMu) {
                
                [self setMainScrollViewContentSize:tableView];
            }


        }
        
    }];

}
-(void)firstGetHuiYuanZhuanQuList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:2 withObject:pageIndexNumber];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:@"1" forKey:@"type_id"];
    if ([NormalUse isValidString:self.nvShenField]) {
        
        [dic setObject:[NormalUse getobjectForKey:self.nvShenField] forKey:@"field"];
    }

    
    [HTTPModel getVipZhuanQuList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        
        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:2 withObject:pageIndexNumber];
            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:2 withObject:sourceArray];
            
            
            UITableView * tableView = [self.tableViewArray objectAtIndex:2];
            [self.mainScrollView.mj_header endRefreshing];
            [self.mainScrollView.mj_footer endRefreshing];
            
            if([NormalUse isValidArray:dataArray])
            {
                [self.noMessageTipButotn3 removeFromSuperview];
                tableView.height = (144*BiLiWidth+20*BiLiWidth)*sourceArray.count;
                
            }
            else
            {
                [tableView addSubview:self.noMessageTipButotn3];
                tableView.height = self.noMessageTipButotn3.top+self.noMessageTipButotn3.height;
            }
            
            [tableView reloadData];
            
            if (self.contentScrollView.contentOffset.x==WIDTH_PingMu*2) {
                
                [self setMainScrollViewContentSize:tableView];
            }
            
            
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
    
}
-(void)firstGetYanZhengBangDanList
{
    
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:2 withObject:pageIndexNumber];

    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    if ([NormalUse isValidString:self.field]) {
        
        [dic setObject:self.field forKey:@"field"];
    }
    if ([NormalUse isValidString:self.order]) {
        
        [dic setObject:self.order forKey:@"order"];
    }
    if ([NormalUse isValidString:self.message_type]) {
        
        [dic setObject:self.message_type forKey:@"message_type"];
    }
    [dic setObject:@"1" forKey:@"page"];

    [HTTPModel getYanZhengList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:2 withObject:pageIndexNumber];

            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:2 withObject:sourceArray];
            
            
            UITableView * tableView = [self.tableViewArray objectAtIndex:2];
            [self.mainScrollView.mj_header endRefreshing];
            [self.mainScrollView.mj_footer endRefreshing];
            
            if([NormalUse isValidArray:dataArray])
            {
                [self.noMessageTipButotn3 removeFromSuperview];
                tableView.height = (144*BiLiWidth+20*BiLiWidth)*sourceArray.count;

            }
            else
            {
                [tableView addSubview:self.noMessageTipButotn3];
                tableView.height = self.noMessageTipButotn3.top+self.noMessageTipButotn3.height;
            }

            

            [tableView reloadData];
            

            if (self.contentScrollView.contentOffset.x==WIDTH_PingMu*2) {
                
                [self setMainScrollViewContentSize:tableView];
            }


        }
        
    }];
}
-(void)firstGetYanCheBaoGaoList
{
    NSNumber * pageIndexNumber = [NSNumber numberWithInt:1];
    [self.pageIndexArray replaceObjectAtIndex:3 withObject:pageIndexNumber];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    if ([NormalUse isValidString:self.field]) {
        
        [dic setObject:self.field forKey:@"field"];
    }
    if ([NormalUse isValidString:self.order]) {
        
        [dic setObject:self.order forKey:@"order"];
    }
    if ([NormalUse isValidString:self.message_type]) {
        
        [dic setObject:self.message_type forKey:@"message_type"];
    }
    [dic setObject:@"1" forKey:@"page"];

    [HTTPModel getYanCheBaoGaoList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSNumber * pageIndexNumber = [NSNumber numberWithInt:2];
            [self.pageIndexArray replaceObjectAtIndex:3 withObject:pageIndexNumber];

            
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
            [self.dataSourceArray replaceObjectAtIndex:3 withObject:sourceArray];

            UITableView * tableView = [self.tableViewArray objectAtIndex:3];
            [self.mainScrollView.mj_header endRefreshing];
            [self.mainScrollView.mj_footer endRefreshing];
            
            if([NormalUse isValidArray:dataArray])
            {
                [self.noMessageTipButotn4 removeFromSuperview];
                float tableViewHeight  = 0;
                for (NSDictionary * info in sourceArray) {
                    
                    tableViewHeight = tableViewHeight+[YanCheBaoGaoTableViewCell cellHegiht:info];
                }
                
                tableView.height = tableViewHeight;

            }
            else
            {
                [tableView addSubview:self.noMessageTipButotn4];
                tableView.height = self.noMessageTipButotn4.top+self.noMessageTipButotn4.height;
            }

            
            [tableView reloadData];
            
            
            if (self.contentScrollView.contentOffset.x==WIDTH_PingMu*3) {
                
                [self setMainScrollViewContentSize:tableView];
            }


        }

    }];
}
-(void)loadNewLsit
{
    int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;
    if (index==0) {
            
        [self firstGetTieZiList];
    }
    else if(index==1)
    {
        [self firstGetRedList];

    }
    else if(index==2)
    {
        [self firstGetHuiYuanZhuanQuList];
       // [self firstGetYanZhengBangDanList];
    }
    else if(index==3)
    {
        //[self firstGetYanCheBaoGaoList];
    }
    

}
-(void)loadMoreList
{
    int index = self.contentScrollView.contentOffset.x/WIDTH_PingMu;
    if (index==0) {
        
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidString:self.field]) {
            
            [dic setObject:self.field forKey:@"field"];
        }
        if ([NormalUse isValidString:self.order]) {
            
            [dic setObject:self.order forKey:@"order"];
        }
        if ([NormalUse isValidString:self.message_type]) {
            
            [dic setObject:self.message_type forKey:@"message_type"];
        }

        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:0];
        
        [dic setObject:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue] forKey:@"page"];


        [HTTPModel getTieZiList:dic
                       callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:0];
                pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
                [self.pageIndexArray replaceObjectAtIndex:0 withObject:pageIndexNumber];

                NSArray * dataArray = [responseObject objectForKey:@"data"];
                NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:0];
                for (NSDictionary * info in dataArray) {
                    
                    [sourceArray addObject:info];
                }
                [self.dataSourceArray replaceObjectAtIndex:0 withObject:sourceArray];

                UITableView * tableView = [self.tableViewArray objectAtIndex:0];
                    
                [self.mainScrollView.mj_footer endRefreshing];

                [tableView reloadData];

                tableView.height = (144*BiLiWidth+20*BiLiWidth)*sourceArray.count;

                
                if (self.contentScrollView.contentOffset.x==0) {
                    
                    [self setMainScrollViewContentSize:tableView];
                }


                
            }
            
        }];

        
    }
    else if(index==1)
    {
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([NormalUse isValidString:self.field]) {
            
            [dic setObject:self.field forKey:@"field"];
        }
        if ([NormalUse isValidString:self.order]) {
            
            [dic setObject:self.order forKey:@"order"];
        }
        if ([NormalUse isValidString:self.message_type]) {
            
            [dic setObject:self.message_type forKey:@"message_type"];
        }

        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:1];
        
        [dic setObject:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue] forKey:@"page"];

        [HTTPModel getRedList:dic
                     callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:1];
                pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
                [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];

                NSArray * dataArray = [responseObject objectForKey:@"data"];
                NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:1];
                for (NSDictionary * info in dataArray) {
                    
                    [sourceArray addObject:info];
                }
                [self.dataSourceArray replaceObjectAtIndex:1 withObject:sourceArray];

                UITableView * tableView = [self.tableViewArray objectAtIndex:1];
                    
                [self.mainScrollView.mj_footer endRefreshing];
                

                [tableView reloadData];
                
                tableView.height = (144*BiLiWidth+20*BiLiWidth)*sourceArray.count;

                if (self.contentScrollView.contentOffset.x==WIDTH_PingMu) {
                    
                    [self setMainScrollViewContentSize:tableView];
                }

            }
            
        }];



    }
    else if (index==2)
    {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"1" forKey:@"type_id"];
        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:2];
        [dic setObject:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue] forKey:@"page"];
        if ([NormalUse isValidString:self.nvShenField]) {
            
            [dic setObject:[NormalUse getobjectForKey:self.nvShenField] forKey:@"field"];
        }

        [HTTPModel getVipZhuanQuList:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            
            if (status==1) {
                
                NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:2];
                pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
                [self.pageIndexArray replaceObjectAtIndex:2 withObject:pageIndexNumber];
                
                NSArray * dataArray = [responseObject objectForKey:@"data"];
                NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:2];
                for (NSDictionary * info in dataArray) {
                    
                    [sourceArray addObject:info];
                }
                [self.dataSourceArray replaceObjectAtIndex:2 withObject:sourceArray];
                
                UITableView * tableView = [self.tableViewArray objectAtIndex:2];
                
                [self.mainScrollView.mj_footer endRefreshing];
                [tableView reloadData];
                
                tableView.height = (144*BiLiWidth+20*BiLiWidth)*sourceArray.count;
                
                if (self.contentScrollView.contentOffset.x==WIDTH_PingMu*2) {
                    
                    [self setMainScrollViewContentSize:tableView];
                }
            }
            else
            {
                [NormalUse showToastView:msg view:self.view];
            }
        }];
    }
//    else if(index==2)
//    {
//
//        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
//        if ([NormalUse isValidString:self.field]) {
//
//            [dic setObject:self.field forKey:@"field"];
//        }
//        if ([NormalUse isValidString:self.order]) {
//
//            [dic setObject:self.order forKey:@"order"];
//        }
//        if ([NormalUse isValidString:self.message_type]) {
//
//            [dic setObject:self.message_type forKey:@"message_type"];
//        }
//
//        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:2];
//
//        [dic setObject:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue] forKey:@"page"];
//
//        [HTTPModel getYanZhengList:dic
//                          callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
//
//            if (status==1) {
//
//                NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:2];
//                pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
//                [self.pageIndexArray replaceObjectAtIndex:1 withObject:pageIndexNumber];
//
//                NSArray * dataArray = [responseObject objectForKey:@"data"];
//                NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:2];
//                for (NSDictionary * info in dataArray) {
//
//                    [sourceArray addObject:info];
//                }
//                [self.dataSourceArray replaceObjectAtIndex:2 withObject:sourceArray];
//
//                UITableView * tableView = [self.tableViewArray objectAtIndex:2];
//
//                [self.mainScrollView.mj_footer endRefreshing];
//                [tableView reloadData];
//
//                tableView.height = (144*BiLiWidth+20*BiLiWidth)*sourceArray.count;
//
//                if (self.contentScrollView.contentOffset.x==WIDTH_PingMu*2) {
//
//                    [self setMainScrollViewContentSize:tableView];
//                }
//
//
//
//            }
//
//        }];
//
//
//    }
//    else if(index==3)
//    {
//        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
//        if ([NormalUse isValidString:self.field]) {
//
//            [dic setObject:self.field forKey:@"field"];
//        }
//        if ([NormalUse isValidString:self.order]) {
//
//            [dic setObject:self.order forKey:@"order"];
//        }
//        if ([NormalUse isValidString:self.message_type]) {
//
//            [dic setObject:self.message_type forKey:@"message_type"];
//        }
//
//        NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:3];
//
//        [dic setObject:[NSString stringWithFormat:@"%d",pageIndexNumber.intValue] forKey:@"page"];
//
//        [HTTPModel getYanCheBaoGaoList:dic
//                              callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
//
//            if (status==1) {
//
//                NSNumber * pageIndexNumber = [self.pageIndexArray objectAtIndex:3];
//                pageIndexNumber = [NSNumber numberWithInt:pageIndexNumber.intValue+1];
//                [self.pageIndexArray replaceObjectAtIndex:3 withObject:pageIndexNumber];
//
//                NSArray * dataArray = [responseObject objectForKey:@"data"];
//                NSMutableArray * sourceArray = [self.dataSourceArray objectAtIndex:3];
//                for (NSDictionary * info in dataArray) {
//
//                    [sourceArray addObject:info];
//                }
//                [self.dataSourceArray replaceObjectAtIndex:3 withObject:sourceArray];
//
//                UITableView * tableView = [self.tableViewArray objectAtIndex:3];
//
//                [self.mainScrollView.mj_footer endRefreshing];
//
//                [tableView reloadData];
//
//
//                float tableViewHeight  = 0;
//                for (NSDictionary * info in sourceArray) {
//
//                    tableViewHeight = tableViewHeight+[CheYouPingJiaCell cellHegiht:info];
//                }
//
//                tableView.height = tableViewHeight;
//
//                if (self.contentScrollView.contentOffset.x==WIDTH_PingMu*3) {
//
//                    [self setMainScrollViewContentSize:tableView];
//                }
//
//
//            }
//
//        }];
//
//    }

}
-(void)setMainScrollViewContentSize:(UITableView *)tableView
{
    self.contentScrollView.height = tableView.top+tableView.height;
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.contentScrollView.top+self.contentScrollView.height)];

}
#pragma mark -- 分类buttonclick
-(void)listTopButtonClick:(UIButton *)selectButton
{
    BOOL alsoShowAlert= NO;
    if (selectButton.tag==2&&self.auth_vip.intValue==0) {
        
        alsoShowAlert = YES;
    }
    if (alsoShowAlert) {
        
        UIButton * button = [self.listButtonArray objectAtIndex:1];
        [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        
        ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:@"开通会员后才可以预约会员专区的妹子,平台担保交易,信息绝对真实有效,任何问题平台包赔,让你约到心仪的妹子" message2:@"" button1Title:@"开通会员" button2Title:@""];
        alertView.button1Click = ^{
            
            HuiYuanViewController * vc = [[HuiYuanViewController alloc] init];
            vc.info = self.userInfo;
            vc.vipListInfo = self.vipListInfo;
            [self.navigationController pushViewController:vc animated:YES];

        };
        alertView.button2Click = ^{
          
        };
        [[UIApplication sharedApplication].keyWindow addSubview:alertView];

    }
    else
    {
        [self.contentScrollView setContentOffset:CGPointMake(selectButton.tag*WIDTH_PingMu, 0) animated:YES];
        UITableView * tableView = [self.tableViewArray objectAtIndex:selectButton.tag];
        [self setMainScrollViewContentSize:tableView];
        
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

    }
    
}
#pragma mark---scrollviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==1002) {

        CGFloat hight = scrollView.frame.size.height;
        CGFloat contentOffset = scrollView.contentOffset.y;
        CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
        CGFloat offset = contentOffset - self.lastcontentOffset;
        self.lastcontentOffset = contentOffset;

       // NSLog(@"上拉行为");
        if (offset > 0 && contentOffset > 0) {

            //如果mainScrollview上滑到 buttonItemView的位置 则把buttonItemView添加到当前view上(实现悬浮效果)
            if (scrollView.contentOffset.y>=267*BiLiWidth) {

                self.itemButtonContentView.top = self.topNavView.height+self.topNavView.top;
                [self.view addSubview:self.itemButtonContentView];
            }
        }
        //NSLog(@"下拉行为");
        if (offset < 0 && distanceFromBottom > hight) {

            //如果mainScrollview下滑到 buttonItemView的位置 则把buttonItemView添加到scrollview上(让buttonItemView和scrollview一起滚动)

            if (scrollView.contentOffset.y<=267*BiLiWidth) {

                self.itemButtonContentView.top = self.dingZhi.top+self.dingZhi.height+17.5*BiLiWidth;
                [self.mainScrollView addSubview:self.itemButtonContentView];


            }

        }

    }

}

-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (scrollView.tag==1001) {
        
        int  specialIndex = scrollView.contentOffset.x/WIDTH_PingMu;
        
        UIButton * button = [self.listButtonArray objectAtIndex:specialIndex];
        [button sendActionsForControlEvents:UIControlEventTouchUpInside];
    }

}

#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0) {
        
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:0];
        return sourcerray.count;
    }
    else if (tableView.tag==1)
    {
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:1];
        return sourcerray.count;

    }
    else if (tableView.tag==2)
    {
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:2];
        return sourcerray.count;

    }
    else if (tableView.tag==3)
    {
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:3];
        return sourcerray.count;

    }
    else
    {
        return 5;

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==3) {
        
        NSMutableArray * sourcerray = [self.dataSourceArray objectAtIndex:3];

        return [CheYouPingJiaCell cellHegiht:[sourcerray objectAtIndex:indexPath.row]];
    }
    else
    {
        return  144*BiLiWidth+20*BiLiWidth;

    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==3) {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"CheYouPingJiaCell"] ;
        YanCheBaoGaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[YanCheBaoGaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor clearColor];
        NSMutableArray * sourcerray;
        sourcerray = [self.dataSourceArray objectAtIndex:3];
        [cell initContentView:[sourcerray objectAtIndex:indexPath.row]];
        
        return cell;

    }
    else if(tableView.tag==2)
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"HomeNvShenCell"] ;
        HomeNvShenCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[HomeNvShenCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.cellType = VipRenZhengFaTie;
        cell.backgroundColor = [UIColor clearColor];
        NSMutableArray * sourcerray;
        sourcerray = [self.dataSourceArray objectAtIndex:2];
        [cell contentViewSetData:[sourcerray objectAtIndex:indexPath.row]];
        return cell;
    }
    else
    {
        NSString *tableIdentifier = [NSString stringWithFormat:@"HomeListCellCell"] ;
        HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[HomeListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.backgroundColor = [UIColor clearColor];
        NSMutableArray * sourcerray;
        if (tableView.tag==0) {
            
             sourcerray = [self.dataSourceArray objectAtIndex:0];
            [cell contentViewSetData:[sourcerray objectAtIndex:indexPath.row] cellType:ZuiXinShangChuan];

        }
        else if (tableView.tag==1)
        {
            sourcerray = [self.dataSourceArray objectAtIndex:1];
            [cell contentViewSetData:[sourcerray objectAtIndex:indexPath.row] cellType:HongBangTuiJian];


        }
//        else if (tableView.tag==2)
//        {
//            sourcerray = [self.dataSourceArray objectAtIndex:2];
//            [cell contentViewSetData:[sourcerray objectAtIndex:indexPath.row] cellType:YanZhengBangDan];
//
//
//        }
        return cell;

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag!=3) {
        
        NSMutableArray * sourcerray;
        if (tableView.tag==0) {
            
             sourcerray = [self.dataSourceArray objectAtIndex:0];
        }
        else if (tableView.tag==1)
        {
            sourcerray = [self.dataSourceArray objectAtIndex:1];

        }
        else if (tableView.tag==2)
        {
            sourcerray = [self.dataSourceArray objectAtIndex:2];

        }
        else
        {
            sourcerray = [self.dataSourceArray objectAtIndex:3];

        }
        NSDictionary * info = [sourcerray objectAtIndex:indexPath.row];
        if (tableView.tag==2) {
            
            if(self.auth_vip.intValue==0)
            {
                ZDYAlertView * alertView = [[ZDYAlertView alloc] initWithFrame:CGRectZero title:@"" message1:@"开通会员后才可以预约会员专区的妹子,平台担保交易,信息绝对真实有效,任何问题平台包赔,让你约到心仪的妹子" message2:@"" button1Title:@"开通会员" button2Title:@""];
                alertView.button1Click = ^{
                    
                    HuiYuanViewController * vc = [[HuiYuanViewController alloc] init];
                    vc.info = self.userInfo;
                    vc.vipListInfo = self.vipListInfo;
                    [self.navigationController pushViewController:vc animated:YES];

                };
                alertView.button2Click = ^{
                  
                };
                [[UIApplication sharedApplication].keyWindow addSubview:alertView];

            }
            else
            {
                VipRenZhengTieZeDetailVC * vc = [[VipRenZhengTieZeDetailVC alloc] init];
                NSNumber * idNumber = [info objectForKey:@"id"];
                if ([idNumber isKindOfClass:[NSNumber class]]) {
                    vc.post_id = [NSString stringWithFormat:@"%d",idNumber.intValue];
                }
                [self.navigationController pushViewController:vc animated:YES];

            }
        }
        else
        {
            TieZiDetailViewController * vc = [[TieZiDetailViewController alloc] init];
            NSNumber * idNumber = [info objectForKey:@"id"];
            if ([idNumber isKindOfClass:[NSNumber class]]) {
                
                vc.post_id = [NSString stringWithFormat:@"%d",idNumber.intValue];
            }
            [self.navigationController pushViewController:vc animated:YES];

        }

    }
}
#pragma mark UIButtonClick

-(void)tiJianuanButtonClick
{
    if ((int)(self.contentScrollView.contentOffset.x/WIDTH_PingMu)==2) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.nvShenShaiXuanView.top  =0;
            self.nvShenShaiXuanView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        }];

    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.shaiXuanView.top  =0;
            self.shaiXuanView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        }];

    }
    
}
-(void)faTieOrRenZhengButtonClick
{
    [self.shakeImageView removeFromSuperview];
    self.chaXiaoErFaTieRenZhengView1.top = 0;

//    NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
//    NSString * defaultsKey = [UserRole stringByAppendingString:token];
//    NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
//    NSNumber * auth_nomal = [userRoleDic objectForKey:@"auth_nomal"];
//
//    if ([auth_nomal isKindOfClass:[NSNumber class]]) {
//
//        if (auth_nomal.intValue==0) {//未认证
//
//            [UIView animateWithDuration:0.5 animations:^{
//
//                self.chaXiaoErFaTieRenZhengView1.top = 0;
//            }];
//
//        }
//        else if (auth_nomal.intValue==1)//已认证
//        {
//            [self faTieButtonClick];
//        }
//        else if (auth_nomal.intValue==2)//审核中
//        {
//            [UIView animateWithDuration:0.5 animations:^{
//
//                self.chaXiaoErFaTieRenZhengView1.top = 0;
//            }];
//
//        }
//
//    }
    

}
-(void)shaiXuanButtonClick
{
    [self.cityKuangView removeFromSuperview];
    CityListViewController * vc = [[CityListViewController alloc] init];
    vc.alsoFromHome = YES;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
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
    [self reloadNewLsit];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityChangeReloadMessageNotification" object:nil];
}
-(void)reloadNewLsit
{
    [self firstGetTieZiList];
    [self firstGetRedList];
//    [self firstGetYanZhengBangDanList];
//    [self firstGetYanCheBaoGaoList];

}
-(void)tiYanBaoGaoButtonClick
{
    TiYanBaoGaoViewController * vc = [[TiYanBaoGaoViewController alloc] init];
    vc.userInfo = self.userInfo;
    vc.vipListInfo = self.vipListInfo;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)fangLeiButtonClick
{
    FangLeiFangPianViewController * vc = [[FangLeiFangPianViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)heiDianButtonClick
{
    HeiDianBaoGuangViewController * vc = [[HeiDianBaoGuangViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)dingZhiButtonClick
{
    DingZhiFuWuViewController * vc = [[DingZhiFuWuViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark NewPagedFlowView Delegate
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
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTP_REQUESTURL,[info objectForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"banner_kong"]];
//    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}



@end
