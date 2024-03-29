//
//  TiYanBaoGaoDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/31.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "TiYanBaoGaoDetailViewController.h"

@interface TiYanBaoGaoDetailViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>

@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong) NewPagedFlowView * pageView;
@property(nonatomic,strong) UIPageControl * pageControl;
@property(nonatomic,strong)NSArray * images;

@end

@implementation TiYanBaoGaoDetailViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.pageView stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"报告详情";
    
    self.images = [self.info objectForKey:@"images"];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    [self.view addSubview:self.mainScrollView];
    
    self.pageView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 147*BiLiWidth)];
    self.pageView.delegate = self;
    self.pageView.dataSource = self;
    self.pageView.minimumPageAlpha = 0.1;
    self.pageView.isCarousel = YES;
    self.pageView.orientation = NewPagedFlowViewOrientationHorizontal;
    self.pageView.isOpenAutoScroll = YES;
    self.pageView.orginPageCount = self.images.count;
    [self.pageView reloadData];
    [self.mainScrollView addSubview:self.pageView];

    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.width-200*BiLiWidth)/2, self.pageView.top+self.pageView.height+8*BiLiWidth, 200*BiLiWidth, 10)];
    self.pageControl.currentPage = 0;      //设置当前页指示点
    self.pageControl.pageIndicatorTintColor = RGBFormUIColor(0xEEEEEE);        //设置未激活的指示点颜色
    self.pageControl.currentPageIndicatorTintColor = RGBFormUIColor(0x999999);     //设置当前页指示点颜色
    self.pageControl.numberOfPages = self.images.count;
    [self.mainScrollView addSubview:self.pageControl];
    
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth, self.pageControl.top+self.pageControl.height+16.5*BiLiWidth, 48*BiLiWidth, 48*BiLiWidth)];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    headerImageView.clipsToBounds = YES;
    headerImageView.layer.cornerRadius = 24*BiLiWidth;
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:[self.info objectForKey:@"avatar"]]];
    [self.mainScrollView addSubview:headerImageView];
    
    UILabel * nickLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left+headerImageView.width+13.5*BiLiWidth, self.pageControl.top+self.pageControl.height+22*BiLiWidth, 250*BiLiWidth, 15*BiLiWidth)];
    nickLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    nickLable.textColor = RGBFormUIColor(0x343434);
    nickLable.adjustsFontSizeToFitWidth = YES;
    nickLable.text = [self.info objectForKey:@"nickname"];
    [self.mainScrollView addSubview:nickLable];
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left+headerImageView.width+13.5*BiLiWidth, nickLable.top+nickLable.height+9.5*BiLiWidth, 80*BiLiWidth, 12*BiLiWidth)];
    timeLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    timeLable.textColor = RGBFormUIColor(0x9A9A9A);
    timeLable.text = [self.info objectForKey:@"experience_date"];//[NSString stringWithFormat:@"%@",[self.info objectForKey:@"friendly_date"]];
    [self.mainScrollView addSubview:timeLable];
    
    NSNumber * auth_vip = [self.info objectForKey:@"auth_vip"];
    //2终身会员 1年会员 3蛟龙炮神 0非会员
    if ([auth_vip isKindOfClass:[NSNumber class]]) {
        
        UIImageView * vImageView = [[UIImageView alloc] initWithFrame:CGRectMake(timeLable.right, timeLable.top-6.5*BiLiWidth, 25*BiLiWidth*170/60, 25*BiLiWidth)];
        [self.mainScrollView addSubview:vImageView];

        if (auth_vip.intValue==1) {

            vImageView.image = [UIImage imageNamed:@"vip_zuanShi"];

        }
        else if (auth_vip.intValue==2)
        {
            vImageView.image = [UIImage imageNamed:@"vip_wangZhe"];

        }
        else if (auth_vip.intValue==3)
        {
            vImageView.image = [UIImage imageNamed:@"vip_paoShen"];

        }
        else if (auth_vip.intValue==0)
        {
            vImageView.image = nil;

        }

    }

    
    UILabel * meiZiNameLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, headerImageView.top+headerImageView.height+12.5*BiLiWidth, 200*BiLiWidth, 39.5*BiLiWidth)];
    meiZiNameLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    meiZiNameLable.textColor = RGBFormUIColor(0x9A9A9A);
    meiZiNameLable.text = @"妹子花名";
    [self.mainScrollView addSubview:meiZiNameLable];
    
    UILabel * bianHaoLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-16.5*BiLiWidth-100*BiLiWidth, meiZiNameLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    bianHaoLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    bianHaoLable.textColor  = RGBFormUIColor(0x343434);
    bianHaoLable.textAlignment = NSTextAlignmentRight;
    bianHaoLable.text = [self.info objectForKey:@"girl_name"];
    [self.mainScrollView addSubview:bianHaoLable];

    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(meiZiNameLable.left, meiZiNameLable.top+meiZiNameLable.height,WIDTH_PingMu-24*BiLiWidth, 1)];
    lineView1.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView1];
    
    UILabel * leiXingTipLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, lineView1.top+lineView1.height, 200*BiLiWidth, 39.5*BiLiWidth)];
    leiXingTipLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    leiXingTipLable.textColor = RGBFormUIColor(0x9A9A9A);
    leiXingTipLable.text = @"类型";
    [self.mainScrollView addSubview:leiXingTipLable];
    
    UILabel * leiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-16.5*BiLiWidth-200*BiLiWidth, leiXingTipLable.top, 200*BiLiWidth, 39.5*BiLiWidth)];
    leiXingLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    leiXingLable.textColor  = RGBFormUIColor(0x343434);
    leiXingLable.text = [self.info objectForKey:@"message_type"];
    leiXingLable.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:leiXingLable];

    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(meiZiNameLable.left, leiXingLable.top+leiXingLable.height,WIDTH_PingMu-24*BiLiWidth, 1)];
    lineView2.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView2];
    
    UILabel * cityTipLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, lineView2.top+lineView2.height, 200*BiLiWidth, 39.5*BiLiWidth)];
    cityTipLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    cityTipLable.textColor = RGBFormUIColor(0x9A9A9A);
    cityTipLable.text = @"地区";
    [self.mainScrollView addSubview:cityTipLable];
    
    UILabel * cityLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-16.5*BiLiWidth-100*BiLiWidth, cityTipLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    cityLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    cityLable.textColor  = RGBFormUIColor(0x343434);
    cityLable.text = [NormalUse getobjectForKey:[self.info objectForKey:@"city_name"]];
    cityLable.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:cityLable];

    UIView * lineView3 = [[UIView alloc] initWithFrame:CGRectMake(meiZiNameLable.left, cityLable.top+cityLable.height,WIDTH_PingMu-24*BiLiWidth, 1)];
    lineView3.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView3];


    UILabel * xiaoFeiTipLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, lineView3.top+lineView3.height, 200*BiLiWidth, 39.5*BiLiWidth)];
    xiaoFeiTipLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    xiaoFeiTipLable.textColor = RGBFormUIColor(0x9A9A9A);
    xiaoFeiTipLable.text = @"消费情况";
    [self.mainScrollView addSubview:xiaoFeiTipLable];
    
    UILabel * xiaoFeiLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-16.5*BiLiWidth-100*BiLiWidth, xiaoFeiTipLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    xiaoFeiLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    xiaoFeiLable.textColor  = RGBFormUIColor(0x343434);
    xiaoFeiLable.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:xiaoFeiLable];
    
    NSNumber * trade_money = [self.info objectForKey:@"trade_money"];
    if ([trade_money isKindOfClass:[NSNumber class]]) {
        xiaoFeiLable.text = [NSString stringWithFormat:@"%d",trade_money.intValue];
    }

    UIView * lineView4 = [[UIView alloc] initWithFrame:CGRectMake(meiZiNameLable.left, xiaoFeiLable.top+xiaoFeiLable.height,WIDTH_PingMu-24*BiLiWidth, 1)];
    lineView4.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView4];
    
    UILabel * yanZhiTipLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, lineView4.top+lineView4.height, 200*BiLiWidth, 39.5*BiLiWidth)];
    yanZhiTipLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    yanZhiTipLable.textColor = RGBFormUIColor(0x9A9A9A);
    yanZhiTipLable.text = @"颜值";
    [self.mainScrollView addSubview:yanZhiTipLable];
    
    NSNumber * face_value = [self.info objectForKey:@"face_value"];
    if ([face_value isKindOfClass:[NSNumber class]]) {
        
        for (int i=1; i<6; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-124.5*BiLiWidth-25*BiLiWidth)+25*BiLiWidth*i, lineView4.top+lineView4.height+13.5*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
            [self.mainScrollView addSubview:imageView];
            if (i<=face_value.intValue) {
                
                imageView.image = [UIImage imageNamed:@"star_yellow"];
            }
            else
            {
                imageView.image = [UIImage imageNamed:@"star_hui"];

            }
        }
    }

    
    UIView * lineView5 = [[UIView alloc] initWithFrame:CGRectMake(meiZiNameLable.left, yanZhiTipLable.top+yanZhiTipLable.height,WIDTH_PingMu-24*BiLiWidth, 1)];
    lineView5.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView5];


    UILabel * jiShuTipLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, lineView5.top+lineView5.height, 200*BiLiWidth, 39.5*BiLiWidth)];
    jiShuTipLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    jiShuTipLable.textColor = RGBFormUIColor(0x9A9A9A);
    jiShuTipLable.text = @"技术";
    [self.mainScrollView addSubview:jiShuTipLable];
    //[9]    (null)    @"ambience_value" : (long)4    [7]    (null)    @"skill_value" : (long)4

    NSNumber * skill_value = [self.info objectForKey:@"skill_value"];
    if ([face_value isKindOfClass:[NSNumber class]]) {
        
        for (int i=1; i<6; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-124.5*BiLiWidth-25*BiLiWidth)+25*BiLiWidth*i, lineView5.top+lineView5.height+13.5*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
            [self.mainScrollView addSubview:imageView];
            if (i<=skill_value.intValue) {
                
                imageView.image = [UIImage imageNamed:@"star_yellow"];
            }
            else
            {
                imageView.image = [UIImage imageNamed:@"star_hui"];

            }
        }
    }

    
    UIView * lineView6 = [[UIView alloc] initWithFrame:CGRectMake(meiZiNameLable.left, jiShuTipLable.top+jiShuTipLable.height,WIDTH_PingMu-24*BiLiWidth, 1)];
    lineView6.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView6];


    UILabel * huanJingTipLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, lineView6.top+lineView6.height, 200*BiLiWidth, 39.5*BiLiWidth)];
    huanJingTipLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    huanJingTipLable.textColor = RGBFormUIColor(0x9A9A9A);
    huanJingTipLable.text = @"环境";
    [self.mainScrollView addSubview:huanJingTipLable];

    NSNumber * ambience_value = [self.info objectForKey:@"ambience_value"];
    if ([face_value isKindOfClass:[NSNumber class]]) {
        
        for (int i=1; i<6; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-124.5*BiLiWidth-25*BiLiWidth)+25*BiLiWidth*i, lineView6.top+lineView6.height+13.5*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
            [self.mainScrollView addSubview:imageView];
            if (i<=ambience_value.intValue) {
                
                imageView.image = [UIImage imageNamed:@"star_yellow"];
            }
            else
            {
                imageView.image = [UIImage imageNamed:@"star_hui"];

            }
        }
    }

    
    UIView * lineView7 = [[UIView alloc] initWithFrame:CGRectMake(meiZiNameLable.left, huanJingTipLable.top+huanJingTipLable.height,WIDTH_PingMu-24*BiLiWidth, 1)];
    lineView7.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView7];
    
    UILabel * deFenTipLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, lineView7.top+lineView7.height, 200*BiLiWidth, 39.5*BiLiWidth)];
    deFenTipLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    deFenTipLable.textColor = RGBFormUIColor(0x9A9A9A);
    deFenTipLable.text = @"综合得分";
    [self.mainScrollView addSubview:deFenTipLable];
    
    UILabel * deFenLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-16.5*BiLiWidth-100*BiLiWidth, deFenTipLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    deFenLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BiLiWidth];
    deFenLable.textColor  = RGBFormUIColor(0x343434);
    deFenLable.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:deFenLable];
    
    NSNumber * avg_value =[self.info objectForKey:@"avg_value"];
    if ([avg_value isKindOfClass:[NSNumber class]]) {
        
        deFenLable.text = [NSString stringWithFormat:@"%d",avg_value.intValue];
    }


    UIView * lineView8 = [[UIView alloc] initWithFrame:CGRectMake(meiZiNameLable.left, deFenTipLable.top+deFenTipLable.height,WIDTH_PingMu-24*BiLiWidth, 1)];
    lineView8.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView8];

    UILabel * fuWuTipLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, lineView8.top+lineView8.height, 200*BiLiWidth, 39.5*BiLiWidth)];
    fuWuTipLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    fuWuTipLable.textColor = RGBFormUIColor(0x9A9A9A);
    fuWuTipLable.text = @"服务详情";
    [self.mainScrollView addSubview:fuWuTipLable];
    
    UILabel *  fuwuLable = [[UILabel alloc] initWithFrame:CGRectMake(fuWuTipLable.left, fuWuTipLable.top+fuWuTipLable.height, WIDTH_PingMu-26*BiLiWidth, 0*BiLiWidth)];
    fuwuLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    fuwuLable.textColor = RGBFormUIColor(0x343434);
    fuwuLable.numberOfLines = 0;
    [self.mainScrollView addSubview:fuwuLable];
    NSString * neiRongStr = [self.info objectForKey:@"decription"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    fuwuLable.attributedText = attributedString;
    //设置自适应
    [fuwuLable  sizeToFit];

    
    UIButton * chaKanButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-153*BiLiWidth)/2, fuwuLable.top+fuwuLable.height+50*BiLiWidth, 153*BiLiWidth, 40*BiLiWidth)];
    [chaKanButton addTarget:self action:@selector(chaKanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:chaKanButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = chaKanButton.bounds;
    gradientLayer.cornerRadius = 20*BiLiWidth;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    [chaKanButton.layer addSublayer:gradientLayer];
    
    UILabel * chaKanLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, chaKanButton.width, chaKanButton.height)];
    chaKanLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    chaKanLable.text = @"查看原帖";
    chaKanLable.textAlignment = NSTextAlignmentCenter;
    chaKanLable.textColor = [UIColor whiteColor];
    [chaKanButton addSubview:chaKanLable];

    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, chaKanButton.top+chaKanButton.height+60*BiLiWidth)];

}
#pragma mark--UIButtonClick

-(void)chaKanButtonClick
{
    NSNumber * type_id = [self.info objectForKey:@"type_id"];
    if (type_id.intValue==5) {
        
        NSNumber *  auth_vip = [NormalUse defaultsGetObjectKey:@"UserAlsoVip"];
        if (auth_vip.intValue==0) {
                        
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
            NSNumber * idNumber = [self.info objectForKey:@"post_id"];
            if ([idNumber isKindOfClass:[NSNumber class]]) {
                vc.post_id = [NSString stringWithFormat:@"%d",idNumber.intValue];
            }
            [self.navigationController pushViewController:vc animated:YES];

        }
    }
    else
    {
        TieZiDetailViewController * vc = [[TieZiDetailViewController alloc] init];
        NSNumber * post_id = [self.info objectForKey:@"post_id"];
        vc.post_id = [NSString stringWithFormat:@"%d",post_id.intValue];
        [self.navigationController pushViewController:vc animated:YES];

    }

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
    
    NSMutableArray * photos = [NSMutableArray array];
    
    NSArray * images = self.images;
    if ([NormalUse isValidArray:images]) {
        
        for (int i=0;i<images.count;i++) {
            
            MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[images objectAtIndex:i]]];
            [photos addObject:photo];
        }

    }
    
//    NSArray * videos = [self.tieZiInfo objectForKey:@"videos"];
//    if ([NormalUse isValidArray:videos]) {
//        for (int i=0;i<videos.count;i++) {
//            NSDictionary * info = [videos objectAtIndex:i];
//            if ([NormalUse isValidString:[info objectForKey:@"fframe"]]) {
//
//                MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[info objectForKey:@"fframe"]]];
//                photo.videoURL = [NSURL URLWithString:[info objectForKey:@"url"]];
//                [photos addObject:photo];
//
//            }
//        }
//
//    }

    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser setCurrentPhotoIndex:subIndex];
    [[NormalUse getCurrentVC].navigationController pushViewController:browser animated:YES];

 
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    self.pageControl.currentPage = pageNumber;
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.images.count;
    
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
         //[bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[self.images objectAtIndex:index]]];

    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[self.images objectAtIndex:index]] placeholderImage:[UIImage imageNamed:@"banner_kong"]];

    return bannerView;
}


@end
