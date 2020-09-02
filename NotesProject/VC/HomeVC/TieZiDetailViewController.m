//
//  TieZiDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/31.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "TieZiDetailViewController.h"

@interface TieZiDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation TieZiDetailViewController

-(void)rightClick
{
    JvBaoViewController * vc = [[JvBaoViewController alloc] init];
    vc.post_id = self.post_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    self.backImageView.frame = CGRectMake(self.backImageView.left, (self.topNavView.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.backImageView.image = [UIImage imageNamed:@"white_back"];

    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.mainScrollView];
    
    [self.rightButton setTitle:@"投诉" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.topNavView.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:self.topNavView];
    
    JYCarousel *scrollLunBo = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 0,WIDTH_PingMu,WIDTH_PingMu) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
        carouselConfig.pageContollType = MiddlePageControl;
        carouselConfig.pageTintColor = [UIColor whiteColor];
        carouselConfig.currentPageTintColor = [UIColor lightGrayColor];
        carouselConfig.placeholder = [UIImage imageNamed:@"default"];
        carouselConfig.faileReloadTimes = 5;
        return carouselConfig;
    } target:self];
    scrollLunBo.layer.masksToBounds = YES;
    [self.mainScrollView addSubview:scrollLunBo];
    
    NSMutableArray * imageArray = [[NSMutableArray alloc] init];
    [imageArray addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598848496759&di=5eab6d091e7b04cfbd3427030fcb2120&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D86853839%2C3576305254%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D750%26h%3D390"];
    [imageArray addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598848517122&di=b8369dc4048b491e1a5facfee8f3a066&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D3923875871%2C1613462878%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D854"];
    [imageArray addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598848517122&di=a1cbc871ebf45d927a21799054dfaa76&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D2266751744%2C4253267866%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D854"];
        //开始轮播
    [scrollLunBo startCarouselWithArray:imageArray];

    self.messageContentView  = [[UIView alloc] initWithFrame:CGRectMake(0, scrollLunBo.height-60*BiLiWidth, WIDTH_PingMu, 325*BiLiWidth)];
    self.messageContentView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.messageContentView];
    //某个角圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.messageContentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8*BiLiWidth, 8*BiLiWidth)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.messageContentView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.messageContentView.layer.mask = maskLayer;

    [self initTopMessageView];
}
-(void)initTopMessageView
{
    NSString * nickStr = @"青春活力美少女";
    CGSize size = [NormalUse setSize:nickStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
    UILabel * nickLable = [[UILabel alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, 11*BiLiWidth, size.width, 17*BiLiWidth)];
    nickLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    nickLable.textColor = RGBFormUIColor(0x343434);
    nickLable.text = nickStr;
    [self.messageContentView addSubview:nickLable];
    
    UIImageView * vImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nickLable.left+nickLable.width+4.5*BiLiWidth, nickLable.top+(nickLable.height-14.5*BiLiWidth)/2, 16*BiLiWidth, 14.5*BiLiWidth)];
    vImageView.backgroundColor = [UIColor redColor];
    [self.messageContentView addSubview:vImageView];
    
    UIImageView * guanFangRenZhengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(vImageView.left+vImageView.width+7.5*BiLiWidth, nickLable.top+(nickLable.height-13.5*BiLiWidth)/2, 56*BiLiWidth, 13.5*BiLiWidth)];
    guanFangRenZhengImageView.backgroundColor = [UIColor redColor];
    [self.messageContentView addSubview:guanFangRenZhengImageView];
    
    UILabel * cityLable = [[UILabel alloc] initWithFrame:CGRectMake(nickLable.left, nickLable.top+nickLable.height+10*BiLiWidth, 200*BiLiWidth, 11*BiLiWidth)];
    cityLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    cityLable.textColor = RGBFormUIColor(0x9A9A9A);
    cityLable.text = @"上海市";
    [self.messageContentView addSubview:cityLable];
    
    Lable_ImageButton * shouCangButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-21*BiLiWidth-14*BiLiWidth, 14*BiLiWidth, 21*BiLiWidth, 35.5*BiLiWidth)];
    shouCangButton.button_imageView.frame = CGRectMake((shouCangButton.width-19.5*BiLiWidth)/2, 0, 19.5*BiLiWidth, 18*BiLiWidth);
    shouCangButton.button_imageView.backgroundColor = [UIColor redColor];
    shouCangButton.button_lable.frame = CGRectMake(0, shouCangButton.button_imageView.top+shouCangButton.button_imageView.height+6.5*BiLiWidth, 21*BiLiWidth, 11*BiLiWidth);
    shouCangButton.button_lable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    shouCangButton.button_lable.textColor = RGBFormUIColor(0x9A9A9A);
    shouCangButton.button_lable.text = @"收藏";
    shouCangButton.button_lable.adjustsFontSizeToFitWidth = YES;
    [self.messageContentView addSubview:shouCangButton];


    UIView * pingFenView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, cityLable.top+cityLable.height+16.5*BiLiWidth, 321*BiLiWidth, 95*BiLiWidth)];
    pingFenView.layer.cornerRadius = 5*BiLiWidth;
    pingFenView.layer.masksToBounds = NO;
    pingFenView.backgroundColor = [UIColor whiteColor];
    [self.messageContentView addSubview:pingFenView];
    pingFenView.layer.shadowOpacity = 0.2f;
    pingFenView.layer.shadowColor = [UIColor blackColor].CGColor;
    pingFenView.layer.shadowOffset = CGSizeMake(0, 3);//CGSizeZero; //设置偏移量为0,四周都有阴影
    
    UILabel * pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(53.5*BiLiWidth, 25.5*BiLiWidth, 50*BiLiWidth, 33*BiLiWidth)];
    pingFenLable.font = [UIFont systemFontOfSize:33*BiLiWidth];
    pingFenLable.textColor = RGBFormUIColor(0xFFA218);
    pingFenLable.text = @"4.5";
    [pingFenView addSubview:pingFenLable];
    
    UILabel * pingFenTipLable = [[UILabel alloc] initWithFrame:CGRectMake(pingFenLable.left, 63.5*BiLiWidth, pingFenLable.width, 11*BiLiWidth)];
    pingFenTipLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    pingFenTipLable.textColor = RGBFormUIColor(0x9A9A9A);
    pingFenTipLable.text = @"综合评分";
    pingFenLable.textAlignment = NSTextAlignmentCenter;
    [pingFenView addSubview:pingFenTipLable];
    
    UILabel * yanZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(160*BiLiWidth, 15*BiLiWidth,24*BiLiWidth, 12*BiLiWidth)];
    yanZhiLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    yanZhiLable.textColor = RGBFormUIColor(0x9A9A9A);
    yanZhiLable.text = @"颜值";
    yanZhiLable.textAlignment = NSTextAlignmentCenter;
    [pingFenView addSubview:yanZhiLable];

    
    for (int i=0; i<5; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(yanZhiLable.left+yanZhiLable.width+19*BiLiWidth+20*BiLiWidth*i, yanZhiLable.top, 12*BiLiWidth, 12*BiLiWidth)];
        imageView.backgroundColor = [UIColor redColor];
        [pingFenView addSubview:imageView];
        
    }
    
    UILabel * jiShuLable = [[UILabel alloc] initWithFrame:CGRectMake(160*BiLiWidth, yanZhiLable.top+yanZhiLable.height+15*BiLiWidth,24*BiLiWidth, 12*BiLiWidth)];
    jiShuLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    jiShuLable.textColor = RGBFormUIColor(0x9A9A9A);
    jiShuLable.text = @"技术";
    jiShuLable.textAlignment = NSTextAlignmentCenter;
    [pingFenView addSubview:jiShuLable];

    
    for (int i=0; i<5; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(jiShuLable.left+jiShuLable.width+19*BiLiWidth+20*BiLiWidth*i, jiShuLable.top, 12*BiLiWidth, 12*BiLiWidth)];
        imageView.backgroundColor = [UIColor redColor];
        [pingFenView addSubview:imageView];
        
    }

    
    UILabel * huanJingLable = [[UILabel alloc] initWithFrame:CGRectMake(160*BiLiWidth, jiShuLable.top+jiShuLable.height+15*BiLiWidth,24*BiLiWidth, 12*BiLiWidth)];
    huanJingLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    huanJingLable.textColor = RGBFormUIColor(0x9A9A9A);
    huanJingLable.text = @"环境";
    huanJingLable.textAlignment = NSTextAlignmentCenter;
    [pingFenView addSubview:huanJingLable];

    
    for (int i=0; i<5; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(huanJingLable.left+huanJingLable.width+19*BiLiWidth+20*BiLiWidth*i, huanJingLable.top, 12*BiLiWidth, 12*BiLiWidth)];
        imageView.backgroundColor = [UIColor redColor];
        [pingFenView addSubview:imageView];
        
    }


    Lable_ImageButton * jieSuoButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-321*BiLiWidth)/2, pingFenView.top+pingFenView.height+19*BiLiWidth, 321*BiLiWidth, 57*BiLiWidth)];
    [jieSuoButton setBackgroundColor:[UIColor purpleColor]];
    jieSuoButton.button_lable.frame = CGRectMake(19.5*BiLiWidth, 0, 150*BiLiWidth, jieSuoButton.height);
    jieSuoButton.button_lable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    jieSuoButton.button_lable.textColor = RGBFormUIColor(0xFFE1B0);
    jieSuoButton.button_lable.text = @"查看地址联系方式";
    jieSuoButton.button_lable1.frame = CGRectMake(227*BiLiWidth, 0, 150*BiLiWidth, jieSuoButton.height);
    jieSuoButton.button_lable1.font = [UIFont systemFontOfSize:13*BiLiWidth];
    jieSuoButton.button_lable1.textColor = RGBFormUIColor(0xFFE1B0);
    jieSuoButton.button_lable1.text = @"100金币解锁";
    [self.messageContentView addSubview:jieSuoButton];
    
    self.tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, jieSuoButton.top+jieSuoButton.height+11*BiLiWidth, WIDTH_PingMu, 10*BiLiWidth)];
    self.tipLable.textAlignment = NSTextAlignmentCenter;
    self.tipLable.text = @"未见本人就要定金 、押金 、路费的。100%是骗子，切记！";
    self.tipLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
    self.tipLable.textColor = RGBFormUIColor(0xFF0101);
    [self.messageContentView addSubview:self.tipLable];
    
    

    self.jiBenXinXiButton = [[UIButton alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, self.tipLable.top+self.tipLable.height+25*BiLiWidth, 70*BiLiWidth, 16*BiLiWidth)];
    [self.jiBenXinXiButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.jiBenXinXiButton.titleLabel.font = [UIFont systemFontOfSize:16*BiLiWidth];
    [self.jiBenXinXiButton setTitle:@"基本资料" forState:UIControlStateNormal];
    self.jiBenXinXiButton.tag = 0;
    self.jiBenXinXiButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.jiBenXinXiButton addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageContentView addSubview:self.jiBenXinXiButton];
    
    self.xiangQingJieShaoButton = [[UIButton alloc] initWithFrame:CGRectMake(self.jiBenXinXiButton.left+self.jiBenXinXiButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth)];
    [self.xiangQingJieShaoButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.xiangQingJieShaoButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.xiangQingJieShaoButton setTitle:@"详情介绍" forState:UIControlStateNormal];
    self.xiangQingJieShaoButton.tag = 1;
    self.xiangQingJieShaoButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.xiangQingJieShaoButton addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageContentView addSubview:self.xiangQingJieShaoButton];

    
    self.cheYouPingJiaButton = [[UIButton alloc] initWithFrame:CGRectMake(self.xiangQingJieShaoButton.left+self.xiangQingJieShaoButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth)];
    [self.cheYouPingJiaButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
    self.cheYouPingJiaButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.cheYouPingJiaButton setTitle:@"车友评价" forState:UIControlStateNormal];
    self.cheYouPingJiaButton.tag = 2;
    self.cheYouPingJiaButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.cheYouPingJiaButton addTarget:self action:@selector(listTopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageContentView addSubview:self.cheYouPingJiaButton];


    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(19.5*BiLiWidth,self.tipLable.top+self.tipLable.height+36.5*BiLiWidth,53*BiLiWidth,7*BiLiWidth)];
    self.sliderView.layer.cornerRadius = 7*BiLiWidth/2;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.alpha = 0.8;
    [self.messageContentView addSubview:self.sliderView];
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


    self.bottomContentScollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.messageContentView.top+self.messageContentView.height, WIDTH_PingMu, 0)];
    self.bottomContentScollView.pagingEnabled = YES;
    [self.bottomContentScollView setContentSize:CGSizeMake(WIDTH_PingMu*3, 0)];
    self.bottomContentScollView.tag = 1001;
    self.bottomContentScollView.delegate = self;
    [self.mainScrollView addSubview:self.bottomContentScollView];

    [self initJiBenZiLiaoView];
    [self initXiangQingJieShaoView];
    [self initChenYouPingJiaTableView];
}
-(void)initJiBenZiLiaoView
{
    self.jiBenXinXiContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 0)];
    [self.bottomContentScollView addSubview:self.jiBenXinXiContentView];
    
    //价格
    UIImageView * jiaGeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 0, 12*BiLiWidth, 12*BiLiWidth)];
    jiaGeImageView.backgroundColor = [UIColor redColor];
    [self.jiBenXinXiContentView addSubview:jiaGeImageView];
    
    UILabel * jiaGeLable = [[UILabel alloc] initWithFrame:CGRectMake(21.5*BiLiWidth, 0, 200*BiLiWidth, 12*BiLiWidth)];
    jiaGeLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    jiaGeLable.textColor = RGBFormUIColor(0x666666);
    jiaGeLable.text = @"价格：1500-3000";
    [self.jiBenXinXiContentView addSubview:jiaGeLable];
    
    //数量
    UIImageView * shuLiangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, jiaGeImageView.top+jiaGeImageView.height+14*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
    shuLiangImageView.backgroundColor = [UIColor redColor];
    [self.jiBenXinXiContentView addSubview:shuLiangImageView];
    
    UILabel * shuLiangLableLable = [[UILabel alloc] initWithFrame:CGRectMake(21.5*BiLiWidth, shuLiangImageView.top, 200*BiLiWidth, 12*BiLiWidth)];
    shuLiangLableLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    shuLiangLableLable.textColor = RGBFormUIColor(0x666666);
    shuLiangLableLable.text = @"数量：5";
    [self.jiBenXinXiContentView addSubview:shuLiangLableLable];

    //年龄
    UIImageView * ageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, shuLiangImageView.top+shuLiangImageView.height+14*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
    ageImageView.backgroundColor = [UIColor redColor];
    [self.jiBenXinXiContentView addSubview:ageImageView];
    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(21.5*BiLiWidth,ageImageView.top , 200*BiLiWidth, 12*BiLiWidth)];
    ageLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    ageLable.textColor = RGBFormUIColor(0x666666);
    ageLable.text = @"年龄：26";
    [self.jiBenXinXiContentView addSubview:ageLable];

    //项目
    UIImageView * xiangMuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, ageImageView.top+ageImageView.height+14*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth)];
    xiangMuImageView.backgroundColor = [UIColor redColor];
    [self.jiBenXinXiContentView addSubview:xiangMuImageView];
    
    UILabel * xiangMuLable = [[UILabel alloc] initWithFrame:CGRectMake(21.5*BiLiWidth, xiangMuImageView.top, 300*BiLiWidth, 12*BiLiWidth)];
    xiangMuLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    xiangMuLable.textColor = RGBFormUIColor(0x666666);
    xiangMuLable.text = @"项目：踩背、推油、按摩、丝袜制服";
    xiangMuLable.adjustsFontSizeToFitWidth = YES;
    [self.jiBenXinXiContentView addSubview:xiangMuLable];

    self.jiBenXinXiContentView.height = xiangMuLable.top+xiangMuLable.height+20*BiLiWidth;
    
    self.bottomContentScollView.height = self.jiBenXinXiContentView.height;
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.bottomContentScollView.top+self.bottomContentScollView.height)];
    
}
-(void)initXiangQingJieShaoView
{
    self.xiangQingJieShaoContentView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_PingMu, 0, WIDTH_PingMu, 0)];
    [self.bottomContentScollView addSubview:self.xiangQingJieShaoContentView];
    
    UIImageView * headerImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(12*BiLiWidth, 0, 48*BiLiWidth, 48*BiLiWidth)];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    headerImageView.clipsToBounds = YES;
    headerImageView.layer.cornerRadius = 24*BiLiWidth;
    headerImageView.backgroundColor = [UIColor redColor];
    [self.xiangQingJieShaoContentView addSubview:headerImageView];
    
    NSString * nickStr = @"青春活力美少女";
    CGSize size = [NormalUse setSize:nickStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:14*BiLiWidth];
    UILabel * nickLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left+headerImageView.width+13.5*BiLiWidth, 6*BiLiWidth, size.width, 14*BiLiWidth)];
    nickLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    nickLable.textColor = RGBFormUIColor(0x343434);
    nickLable.text = nickStr;
    [self.xiangQingJieShaoContentView addSubview:nickLable];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(nickLable.left+nickLable.width+9*BiLiWidth, 6*BiLiWidth, 26*BiLiWidth, 14*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:9*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0xFFFFFF);
    tipLable.layer.cornerRadius = 4*BiLiWidth;
    tipLable.clipsToBounds = YES;
    tipLable.text = @"作者";
    [self.xiangQingJieShaoContentView addSubview:tipLable];

    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(nickLable.left, tipLable.top+tipLable.height+11.5*BiLiWidth, 100*BiLiWidth, 11*BiLiWidth)];
    timeLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    timeLable.textColor = RGBFormUIColor(0x9A9A9A);
    timeLable.text = @"2020-08-28";
    [self.xiangQingJieShaoContentView addSubview:timeLable];
    
    
    UILabel * pingFenTipLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.left, headerImageView.top+headerImageView.height+20.5*BiLiWidth, 45*BiLiWidth, 11*BiLiWidth)];
    pingFenTipLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    pingFenTipLable.textColor = RGBFormUIColor(0x9A9A9A);
    pingFenTipLable.text = @"综合评分";
    [self.xiangQingJieShaoContentView addSubview:pingFenTipLable];


    UILabel * pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(pingFenTipLable.left+pingFenTipLable.width+12*BiLiWidth, headerImageView.top+headerImageView.height+17.5*BiLiWidth, 45*BiLiWidth, 18*BiLiWidth)];
    pingFenLable.font = [UIFont systemFontOfSize:18*BiLiWidth];
    pingFenLable.textColor = RGBFormUIColor(0x343434);
    pingFenLable.text = @"4.5";
    [self.xiangQingJieShaoContentView addSubview:pingFenLable];

    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(pingFenTipLable.left, pingFenTipLable.top+pingFenTipLable.height+17.5*BiLiWidth, 333*BiLiWidth, 0)];
    messageLable.numberOfLines = 0;
    messageLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    messageLable.textColor = RGBFormUIColor(0x343434);
    [self.xiangQingJieShaoContentView addSubview:messageLable];

    NSString * neiRongStr = @"1.整理好仪容仪表，化淡妆，准时点到，不迟到、早退、绝对服从餐厅领班的领导和只会 ......\n2.上班前了解就餐人数及时间，了解宴请来宾有无其他特殊要求，做好针对个性化服务工作。";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    messageLable.attributedText = attributedString;
    //设置自适应
    [messageLable  sizeToFit];
    
    self.xiangQingJieShaoContentView.height = messageLable.top+messageLable.height+20*BiLiWidth;


}
-(void)initChenYouPingJiaTableView
{
    NSDictionary * info = [[NSDictionary alloc] initWithObjectsAndKeys:@"1.整理好仪容仪表，化淡妆，准时点到，不迟到、早退、绝对服从餐厅领班的领导和只会 ......\n2.上班前了解就餐人数及时间，了解宴请来宾有无其他特殊要求，做好针对个性化服务工作。",@"decription", nil];
    
    NSDictionary * info1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"1.整理好仪容仪表，化淡妆，准时点到，不迟到、早退、绝对服从餐厅领班的领导和只会",@"decription", nil];

    NSDictionary * info2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"1.整理好仪容仪表，化淡妆，准时点到，不迟到、早退、绝对服从餐厅领班的领导和只会 ......\n2.上班前了解就餐人数及时间，了解宴请来宾有无其他特殊要求，做好针对个性化服务工作。",@"decription", nil];

    self.pingLunArray = [[NSArray alloc] initWithObjects:info,info1,info2, nil];
    
    float tableViewHeight = 0;
    for (NSDictionary * info in self.pingLunArray) {
        
        tableViewHeight = tableViewHeight+[CheYouPingJiaCell cellHegiht:info];
    }
    
    self.cheYouPingJiaTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_PingMu*2, 0, WIDTH_PingMu, tableViewHeight)];
    self.cheYouPingJiaTableView.delegate = self;
    self.cheYouPingJiaTableView.dataSource = self;
    self.cheYouPingJiaTableView.scrollEnabled = NO;
    self.cheYouPingJiaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.bottomContentScollView addSubview:self.cheYouPingJiaTableView];
    
    
}
#pragma mark UItableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.pingLunArray.count;

    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return  [CheYouPingJiaCell cellHegiht:[self.pingLunArray objectAtIndex:indexPath.row]];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"HomeListCellCell"] ;
    CheYouPingJiaCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[CheYouPingJiaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    [cell initContentView:[self.pingLunArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark---scrollviewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (scrollView.tag==1001) {
        
        int  specialIndex = scrollView.contentOffset.x/WIDTH_PingMu;
            
        if (specialIndex==0) {
            
            [self.jiBenXinXiButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        else if (specialIndex==1)
        {
            [self.xiangQingJieShaoButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [self.cheYouPingJiaButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }

}

#pragma mark--UIButtonClick

-(void)listTopButtonClick:(UIButton *)button
{
    if (button.tag==0) {
        
        self.jiBenXinXiButton.frame = CGRectMake(11.5*BiLiWidth, self.tipLable.top+self.tipLable.height+25*BiLiWidth, 70*BiLiWidth, 16*BiLiWidth);
        self.jiBenXinXiButton.titleLabel.font = [UIFont systemFontOfSize:16*BiLiWidth];
        
        self.xiangQingJieShaoButton.frame = CGRectMake(self.jiBenXinXiButton.left+self.jiBenXinXiButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.xiangQingJieShaoButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];

        self.cheYouPingJiaButton.frame = CGRectMake(self.xiangQingJieShaoButton.left+self.xiangQingJieShaoButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.cheYouPingJiaButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];

        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.sliderView.left = self.jiBenXinXiButton.left+(self.jiBenXinXiButton.width-self.sliderView.width)/2;
        }];
        
        [self.bottomContentScollView setContentOffset:CGPointMake(0, 0)];
        self.bottomContentScollView.height = self.jiBenXinXiContentView.height;
        

        
    }
    else if (button.tag==1)
    {
        self.jiBenXinXiButton.frame = CGRectMake(11.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.jiBenXinXiButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];

        
        self.xiangQingJieShaoButton.frame = CGRectMake(self.jiBenXinXiButton.left+self.jiBenXinXiButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+25*BiLiWidth, 70*BiLiWidth, 16*BiLiWidth);
        self.xiangQingJieShaoButton.titleLabel.font = [UIFont systemFontOfSize:16*BiLiWidth];

        
        self.cheYouPingJiaButton.frame = CGRectMake(self.xiangQingJieShaoButton.left+self.xiangQingJieShaoButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.cheYouPingJiaButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];


        [UIView animateWithDuration:0.5 animations:^{
            
            self.sliderView.left = self.xiangQingJieShaoButton.left+(self.xiangQingJieShaoButton.width-self.sliderView.width)/2;
        }];
        
        [self.bottomContentScollView setContentOffset:CGPointMake(WIDTH_PingMu, 0)];
        
        self.bottomContentScollView.height = self.xiangQingJieShaoContentView.height;
        


    }
    else
    {
        self.jiBenXinXiButton.frame = CGRectMake(11.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.jiBenXinXiButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];

        self.xiangQingJieShaoButton.frame = CGRectMake(self.jiBenXinXiButton.left+self.jiBenXinXiButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+28.5*BiLiWidth, 52*BiLiWidth, 12*BiLiWidth);
        self.xiangQingJieShaoButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];

        self.cheYouPingJiaButton.frame = CGRectMake(self.xiangQingJieShaoButton.left+self.xiangQingJieShaoButton.width+12.5*BiLiWidth, self.tipLable.top+self.tipLable.height+25*BiLiWidth, 70*BiLiWidth, 16*BiLiWidth);
        self.cheYouPingJiaButton.titleLabel.font = [UIFont systemFontOfSize:16*BiLiWidth];


        [UIView animateWithDuration:0.5 animations:^{
            
            self.sliderView.left = self.cheYouPingJiaButton.left+(self.cheYouPingJiaButton.width-self.sliderView.width)/2;
        }];
        
        [self.bottomContentScollView setContentOffset:CGPointMake(HEIGHT_PingMu*2, 0)];


        self.bottomContentScollView.height = self.cheYouPingJiaTableView.height;
        

    }
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, self.bottomContentScollView.top+self.bottomContentScollView.height)];

}

#pragma mark--JYCarouselDelegate
-(void)carouseScrollToIndex:(NSInteger)index
{
    
}
- (void)carouselViewClick:(NSInteger)index
{
    
}

@end
