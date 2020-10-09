//
//  FaBuYanZhengViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/14.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "FaBuYanZhengViewController.h"

@interface FaBuYanZhengViewController ()<UIScrollViewDelegate,UITextViewDelegate,LeiXiangSelectViewControllerDelegate,CityListViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UITextField * meiZiHuaMingTF;
@property(nonatomic,strong)UIButton * leiXingButton;
@property(nonatomic,strong)UIButton * diQuButton;
@property(nonatomic,strong)UIButton * fuWuXiangMuButton;
@property(nonatomic,strong)UIButton * tiYanTimeButton;
@property(nonatomic,strong)UITextField * xiaoFeiTF;

@property(nonatomic,strong)NSDictionary * cityInfo;

@property(nonatomic,strong)UIView * pickRootView;
@property(nonatomic,strong)UIDatePicker * datePickView;

@property(nonatomic,strong)NSMutableArray * yanZhiStarButtonArray;
@property(nonatomic,strong)NSString * yanZhiStarValue;

@property(nonatomic,strong)NSMutableArray * jiShuStarButtonArray;
@property(nonatomic,strong)NSString * jiShuStarValue;

@property(nonatomic,strong)NSMutableArray * huanJingStarButtonArray;
@property(nonatomic,strong)NSString * huanJingStarValue;

@property(nonatomic,strong)Lable_ImageButton * hongBangTuiJianButton;

@property(nonatomic,strong)UITextView * xiangQingTextView;

@property(nonatomic,strong)UIView * photoContentView;
@property(nonatomic,strong)NSMutableArray * photoArray;
@property(nonatomic,strong)UIImagePickerController * imagePickerController;
@property(nonatomic,strong)NSMutableArray * photoPathArray;

@property(nonatomic,strong)NSString * imagePathId;

@property(nonatomic,strong)UIButton * tiJiaoButton;



@end

@implementation FaBuYanZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    maxImageSelected = 4;
    
    self.loadingFullScreen = @"yes";
    self.topTitleLale.text = @"发布验证";
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.mainScrollView addGestureRecognizer:tap];

    [self initContentMessage];

    [self initPickView];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self viewTap];
}
-(void)viewTap
{
    [self.meiZiHuaMingTF resignFirstResponder];
    [self.xiaoFeiTF resignFirstResponder];
    [self.xiangQingTextView resignFirstResponder];
}

-(void)initContentMessage
{
    
    UILabel * meiZiHuaMingLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 12*BiLiWidth, 100*BiLiWidth, 39.5*BiLiWidth)];
    meiZiHuaMingLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    meiZiHuaMingLable.textColor = RGBFormUIColor(0x333333);
    meiZiHuaMingLable.text = @"妹子花名";
    [self.mainScrollView addSubview:meiZiHuaMingLable];

    self.meiZiHuaMingTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-213.5*BiLiWidth, meiZiHuaMingLable.top, 200*BiLiWidth, 39.5*BiLiWidth)];
    self.meiZiHuaMingTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NormalUse setTextFieldPlaceholder:@"妹子编号或名称" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.meiZiHuaMingTF];
    self.meiZiHuaMingTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.meiZiHuaMingTF.textColor = RGBFormUIColor(0x343434);
    self.meiZiHuaMingTF.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:self.meiZiHuaMingTF];

    UIView * lineViewHuaMing = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, meiZiHuaMingLable.top+meiZiHuaMingLable.height, 270*BiLiWidth, 1)];
    lineViewHuaMing.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineViewHuaMing];

    
   UILabel * xinXiLeiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineViewHuaMing.top+lineViewHuaMing.height, 100*BiLiWidth, 39.5*BiLiWidth)];
   xinXiLeiXingLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
   xinXiLeiXingLable.textColor = RGBFormUIColor(0x333333);
   xinXiLeiXingLable.text = @"类型";
   [self.mainScrollView addSubview:xinXiLeiXingLable];

   self.leiXingButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-213.5*BiLiWidth, xinXiLeiXingLable.top, 200*BiLiWidth, 39.5*BiLiWidth)];
   self.leiXingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.leiXingButton setTitleColor:RGBFormUIColor(0xDEDEDE) forState:UIControlStateNormal];
    [self.leiXingButton setTitle:@"服务类型>" forState:UIControlStateNormal];
    self.leiXingButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.leiXingButton.titleLabel.font = [UIFont systemFontOfSize:13*BiLiWidth];
    [self.leiXingButton addTarget:self action:@selector(leiXingButtonClick) forControlEvents:UIControlEventTouchUpInside];
   [self.mainScrollView addSubview:self.leiXingButton];

    UIView * lineViewXinXi = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, xinXiLeiXingLable.top+xinXiLeiXingLable.height, 270*BiLiWidth, 1)];
    lineViewXinXi.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineViewXinXi];

    
    UILabel * diquLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineViewXinXi.top+lineViewXinXi.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    diquLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    diquLable.textColor = RGBFormUIColor(0x333333);
    diquLable.text = @"所在地区";
    [self.mainScrollView addSubview:diquLable];

    self.diQuButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-213.5*BiLiWidth, diquLable.top, 200*BiLiWidth, 39.5*BiLiWidth)];
    [self.diQuButton setTitle:@"选择所在地区>" forState:UIControlStateNormal];
    [self.diQuButton setTitleColor:RGBFormUIColor(0xDEDEDE) forState:UIControlStateNormal];
    self.diQuButton.titleLabel.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.diQuButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.diQuButton addTarget:self action:@selector(diQuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.diQuButton];

    UIView * diQuLineView = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, diquLable.top+diquLable.height, 270*BiLiWidth, 1)];
    diQuLineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:diQuLineView];
    
    UILabel * fuWuXiangMuLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, diQuLineView.top+diQuLineView.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    fuWuXiangMuLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    fuWuXiangMuLable.textColor = RGBFormUIColor(0x333333);
    fuWuXiangMuLable.text = @"服务项目";
    [self.mainScrollView addSubview:fuWuXiangMuLable];
    
    self.fuWuXiangMuButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-213.5*BiLiWidth, fuWuXiangMuLable.top, 200*BiLiWidth, 39.5*BiLiWidth)];
    self.fuWuXiangMuButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.fuWuXiangMuButton setTitle:@"选择服务项目>" forState:UIControlStateNormal];
    [self.fuWuXiangMuButton setTitleColor:RGBFormUIColor(0xDEDEDE) forState:UIControlStateNormal];
    self.fuWuXiangMuButton.titleLabel.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.fuWuXiangMuButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.fuWuXiangMuButton addTarget:self action:@selector(xiangMuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.fuWuXiangMuButton];
    
    UIView * fuWuXiangMuLineView = [[UIView alloc] initWithFrame:CGRectMake(diQuLineView.left, fuWuXiangMuLable.top+fuWuXiangMuLable.height, diQuLineView.width, 1)];
    fuWuXiangMuLineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:fuWuXiangMuLineView];


    UILabel * tiYanTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, fuWuXiangMuLineView.top+fuWuXiangMuLineView.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    tiYanTimeLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    tiYanTimeLable.textColor = RGBFormUIColor(0x333333);
    tiYanTimeLable.text = @"体验时间";
    [self.mainScrollView addSubview:tiYanTimeLable];
    
    self.tiYanTimeButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-213.5*BiLiWidth, tiYanTimeLable.top, 200*BiLiWidth, 39.5*BiLiWidth)];
    self.tiYanTimeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.tiYanTimeButton setTitle:@"选择体验时间>" forState:UIControlStateNormal];
    [self.tiYanTimeButton setTitleColor:RGBFormUIColor(0xDEDEDE) forState:UIControlStateNormal];
    self.tiYanTimeButton.titleLabel.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.tiYanTimeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.tiYanTimeButton addTarget:self action:@selector(tiYanTimeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.tiYanTimeButton];
    
    UIView * tiYanTimeLineView = [[UIView alloc] initWithFrame:CGRectMake(diQuLineView.left, tiYanTimeLable.top+tiYanTimeLable.height, diQuLineView.width, 1)];
    tiYanTimeLineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:tiYanTimeLineView];


    UILabel * xiaoFeiLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, tiYanTimeLineView.top+tiYanTimeLineView.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    xiaoFeiLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    xiaoFeiLable.textColor = RGBFormUIColor(0x333333);
    xiaoFeiLable.text = @"消费情况";
    [self.mainScrollView addSubview:xiaoFeiLable];

    self.xiaoFeiTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-213.5*BiLiWidth, xiaoFeiLable.top, 200*BiLiWidth, 39.5*BiLiWidth)];
    self.xiaoFeiTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NormalUse setTextFieldPlaceholder:@"消费的具体金额" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.xiaoFeiTF];
    self.xiaoFeiTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.xiaoFeiTF.textColor = RGBFormUIColor(0x343434);
    self.xiaoFeiTF.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:self.xiaoFeiTF];

    UIView * xiaoFeiLineView = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, xiaoFeiLable.top+xiaoFeiLable.height, 270*BiLiWidth, 1)];
    xiaoFeiLineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:xiaoFeiLineView];

    

    UILabel * zhengTiPingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, xiaoFeiLineView.top+xiaoFeiLineView.height+26*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    zhengTiPingFenLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    zhengTiPingFenLable.textColor = RGBFormUIColor(0x333333);
    zhengTiPingFenLable.text = @"整体评分";
    [self.mainScrollView addSubview:zhengTiPingFenLable];
    
    UILabel * yanZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BiLiWidth, zhengTiPingFenLable.top+zhengTiPingFenLable.height+18*BiLiWidth, 28*BiLiWidth, 13*BiLiWidth)];
    yanZhiLable.text = @"颜值";
    yanZhiLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    yanZhiLable.textColor = RGBFormUIColor(0x333333);
    [self.mainScrollView addSubview:yanZhiLable];
    
    self.yanZhiStarButtonArray = [NSMutableArray array];
    for (int i=1; i<=5; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(yanZhiLable.left+yanZhiLable.width+14*BiLiWidth+26*BiLiWidth*(i-1), yanZhiLable.top, 13*BiLiWidth, 13*BiLiWidth)];
        button.tag = i;
        [button addTarget:self action:@selector(yanZhiStarClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"star_hui"] forState:UIControlStateNormal];
        [self.mainScrollView addSubview:button];
        
        [self.yanZhiStarButtonArray addObject:button];
    }
    
    UILabel * jiShuLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BiLiWidth, yanZhiLable.top+yanZhiLable.height+28*BiLiWidth, 28*BiLiWidth, 13*BiLiWidth)];
    jiShuLable.text = @"技术";
    jiShuLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    jiShuLable.textColor = RGBFormUIColor(0x333333);
    [self.mainScrollView addSubview:jiShuLable];
    
    self.jiShuStarButtonArray = [NSMutableArray array];
    for (int i=1; i<=5; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(jiShuLable.left+jiShuLable.width+14*BiLiWidth+26*BiLiWidth*(i-1), jiShuLable.top, 13*BiLiWidth, 13*BiLiWidth)];
        button.tag = i;
        [button addTarget:self action:@selector(jiShuStarClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"star_hui"] forState:UIControlStateNormal];
        [self.mainScrollView addSubview:button];
        
        [self.jiShuStarButtonArray addObject:button];
    }

    
    UILabel * huanJingLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BiLiWidth, jiShuLable.top+jiShuLable.height+28*BiLiWidth, 28*BiLiWidth, 13*BiLiWidth)];
    huanJingLable.text = @"环境";
    huanJingLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    huanJingLable.textColor = RGBFormUIColor(0x333333);
    [self.mainScrollView addSubview:huanJingLable];
    
    self.huanJingStarButtonArray = [NSMutableArray array];
    for (int i=1; i<=5; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(huanJingLable.left+huanJingLable.width+14*BiLiWidth+26*BiLiWidth*(i-1), huanJingLable.top, 13*BiLiWidth, 13*BiLiWidth)];
        button.tag = i;
        [button addTarget:self action:@selector(huanJingStarClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"star_hui"] forState:UIControlStateNormal];
        [self.mainScrollView addSubview:button];
        
        [self.huanJingStarButtonArray addObject:button];
    }
    
    UILabel * hongBangTuiJianTipLable = [[UILabel alloc] initWithFrame:CGRectMake(xiaoFeiLable.left, huanJingLable.top+huanJingLable.height+30*BiLiWidth, WIDTH_PingMu, 14*BiLiWidth)];
    hongBangTuiJianTipLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    hongBangTuiJianTipLable.textColor = RGBFormUIColor(0x333333);
    hongBangTuiJianTipLable.text = @"是否做红榜推荐";
    [self.mainScrollView addSubview:hongBangTuiJianTipLable];
    
    self.hongBangTuiJianButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-100*BiLiWidth, hongBangTuiJianTipLable.top-5*BiLiWidth,100*BiLiWidth,24*BiLiWidth)];
    [self.hongBangTuiJianButton addTarget:self action:@selector(hongBangTuiJianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.hongBangTuiJianButton.tag = 0;
    self.hongBangTuiJianButton.button_imageView.frame = CGRectMake((self.hongBangTuiJianButton.width-12*BiLiWidth)/2, 6*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth);
    self.hongBangTuiJianButton.button_imageView.layer.cornerRadius = 6*BiLiWidth;
    self.hongBangTuiJianButton.button_imageView.layer.masksToBounds = YES;
    self.hongBangTuiJianButton.button_imageView.layer.borderWidth = 1;
    self.hongBangTuiJianButton.button_imageView.layer.borderColor = [RGBFormUIColor(0x999999) CGColor];
    self.hongBangTuiJianButton.button_imageView1.frame = CGRectMake(self.hongBangTuiJianButton.button_imageView.left+1.5*BiLiWidth, self.hongBangTuiJianButton.button_imageView.top+1.5*BiLiWidth, 9*BiLiWidth, 9*BiLiWidth);
    self.hongBangTuiJianButton.button_imageView1.layer.cornerRadius = 4.5*BiLiWidth;
    self.hongBangTuiJianButton.button_imageView1.layer.masksToBounds = YES;
    [self.mainScrollView addSubview:self.hongBangTuiJianButton];



    UILabel * xiangQingLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, hongBangTuiJianTipLable.top+hongBangTuiJianTipLable.height+30*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    xiangQingLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    xiangQingLable.textColor = RGBFormUIColor(0x333333);
    xiangQingLable.text = @"详情介绍";
    [self.mainScrollView addSubview:xiangQingLable];
    
    self.xiangQingTextView = [[UITextView alloc] initWithFrame:CGRectMake(12*BiLiWidth,xiangQingLable.top+xiangQingLable.height+13*BiLiWidth, WIDTH_PingMu-24*BiLiWidth, 130*BiLiWidth-30*BiLiWidth)];
    self.xiangQingTextView.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:15*BiLiWidth];
    self.xiangQingTextView.textColor = RGBFormUIColor(0x999999);
    self.xiangQingTextView.backgroundColor = [UIColor clearColor];
    self.xiangQingTextView.delegate = self;
    self.xiangQingTextView.layer.cornerRadius = 4*BiLiWidth;
    self.xiangQingTextView.layer.borderWidth = 1;
    self.xiangQingTextView.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
    self.xiangQingTextView.placeholder = @"服务过程中的感受...";
    self.xiangQingTextView.font = [UIFont systemFontOfSize:13*BiLiWidth];
    [self.mainScrollView addSubview:self.xiangQingTextView];


    
    UILabel *  zhaoPianSelectLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, self.xiangQingTextView.top+self.xiangQingTextView.height+33*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    zhaoPianSelectLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    zhaoPianSelectLable.textColor = RGBFormUIColor(0x333333);
    zhaoPianSelectLable.text = @"照片";
    [self.mainScrollView addSubview:zhaoPianSelectLable];
    
    self.photoArray = [NSMutableArray array];

    self.photoContentView = [[UIView alloc] initWithFrame:CGRectMake(15*BiLiWidth, zhaoPianSelectLable.frame.origin.y+zhaoPianSelectLable.frame.size.height+20*BiLiWidth, WIDTH_PingMu-30*BiLiWidth, 72*BiLiWidth)];
    [self.mainScrollView addSubview:self.photoContentView];
    
    
    self.tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, self.photoContentView.top+self.photoContentView.height+35*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [self.tiJiaoButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.tiJiaoButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = self.tiJiaoButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [self.tiJiaoButton.layer addSublayer:gradientLayer1];
    
    UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tiJiaoButton.width, self.tiJiaoButton.height)];
    tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiJiaoLable.text = @"下一步";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [self.tiJiaoButton addSubview:tiJiaoLable];

    
    [self.mainScrollView setContentSize: CGSizeMake(WIDTH_PingMu, self.tiJiaoButton.top+self.tiJiaoButton.height+50*BiLiWidth)];
    
    [self initphotoContentView];

    
}
-(void)initphotoContentView
{
    [self.photoContentView removeAllSubviews];
    
    float imageHeight = (WIDTH_PingMu-30*BiLiWidth-15*BiLiWidth)/4;
    
    for (int i=0; i<self.photoArray.count; i++)
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i%4)*(imageHeight+5*BiLiWidth), (imageHeight+5*BiLiWidth)*(i/4), imageHeight, imageHeight)];
        imageView.userInteractionEnabled = YES;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [self.photoArray objectAtIndex:i];
        [self.photoContentView addSubview:imageView];
        
        UIImageView * imageDelete = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.size.width-21*BiLiWidth, 0, 21*BiLiWidth, 21*BiLiWidth)];
        imageDelete.image = [UIImage imageNamed:@"create_dongtai_shanchu"];
        [imageView addSubview:imageDelete];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.size.width-30*BiLiWidth, 0, 30*BiLiWidth, 30*BiLiWidth)];
        button.tag = i;
        [button addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        
    }
    
    if(self.photoArray.count==maxImageSelected)
    {
        self.photoContentView.frame = CGRectMake(self.photoContentView.frame.origin.x, self.photoContentView.frame.origin.y, self.photoContentView.frame.size.width, (imageHeight+5*BiLiWidth)*(self.photoArray.count/4)+imageHeight+15*BiLiWidth);

    }
    else
    {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((self.photoArray.count%4)*(imageHeight+5*BiLiWidth), (imageHeight+5*BiLiWidth)*(self.photoArray.count/4), imageHeight, imageHeight)];
        [button setImage:[UIImage imageNamed:@"dongtai_tianjia"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addMediaButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.photoContentView addSubview:button];
        
        self.photoContentView.frame = CGRectMake(self.photoContentView.frame.origin.x, self.photoContentView.frame.origin.y, self.photoContentView.frame.size.width, button.frame.origin.y+button.frame.size.height+15*BiLiWidth);
    }
    
    self.tiJiaoButton.top = self.photoContentView.top+self.photoContentView.height+20*BiLiWidth;
    self.mainScrollView.contentSize = CGSizeMake(WIDTH_PingMu, self.tiJiaoButton.top+self.tiJiaoButton.height+50*BiLiWidth);

}
#pragma mark--Delegate
#pragma mark--选择城市后的代理
-(void)citySelect:(NSDictionary *)info
{
    self.cityInfo = info;
    [self.diQuButton setTitle:[info objectForKey:@"cityName"] forState:UIControlStateNormal];
    [self.diQuButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
}

#pragma mark--选择服务项目后的代理
-(void)itemSelected:(NSString *)str type:(NSString *)type
{
    if ([@"xinxi" isEqualToString:type]) {
        
        [self.leiXingButton setTitle:str forState:UIControlStateNormal];
        [self.leiXingButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];

    }
    else
    {
        [self.fuWuXiangMuButton setTitle:str forState:UIControlStateNormal];
        [self.fuWuXiangMuButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];

    }
}


#pragma mark--UIButtonClick

-(void)leiXingButtonClick
{
    LeiXiangSelectViewController * vc = [[LeiXiangSelectViewController alloc] init];
    vc.type = @"xinxi";
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)diQuButtonClick
{
    CityListViewController * vc = [[CityListViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)xiangMuButtonClick
{
    LeiXiangSelectViewController * vc = [[LeiXiangSelectViewController alloc] init];
    vc.type = @"fuwu";
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)yanZhiStarClick:(UIButton *)selectButton
{
    self.yanZhiStarValue = [NSString stringWithFormat:@"%d",(int)selectButton.tag];
    
    for (UIButton * button in self.yanZhiStarButtonArray) {
        
        if (button.tag<=selectButton.tag) {
            
            [button setBackgroundImage:[UIImage imageNamed:@"star_yellow"] forState:UIControlStateNormal];
        }
        else
        {
            [button setBackgroundImage:[UIImage imageNamed:@"star_hui"] forState:UIControlStateNormal];

        }
    }
}
-(void)jiShuStarClick:(UIButton *)selectButton
{
    self.jiShuStarValue = [NSString stringWithFormat:@"%d",(int)selectButton.tag];
    
    for (UIButton * button in self.jiShuStarButtonArray) {
        
        if (button.tag<=selectButton.tag) {
            
            [button setBackgroundImage:[UIImage imageNamed:@"star_yellow"] forState:UIControlStateNormal];
        }
        else
        {
            [button setBackgroundImage:[UIImage imageNamed:@"star_hui"] forState:UIControlStateNormal];

        }
    }
}
-(void)huanJingStarClick:(UIButton *)selectButton
{
    self.huanJingStarValue = [NSString stringWithFormat:@"%d",(int)selectButton.tag];
    
    for (UIButton * button in self.huanJingStarButtonArray) {
        
        if (button.tag<=selectButton.tag) {
            
            [button setBackgroundImage:[UIImage imageNamed:@"star_yellow"] forState:UIControlStateNormal];
        }
        else
        {
            [button setBackgroundImage:[UIImage imageNamed:@"star_hui"] forState:UIControlStateNormal];

        }
    }
}
-(void)hongBangTuiJianButtonClick
{
    if (self.hongBangTuiJianButton.tag==0) {
        
        self.hongBangTuiJianButton.tag = 1;
        self.hongBangTuiJianButton.button_imageView.layer.borderColor = [RGBFormUIColor(0xFF0876) CGColor];
        self.hongBangTuiJianButton.button_imageView1.backgroundColor = RGBFormUIColor(0xFF0876);
        self.hongBangTuiJianButton.button_lable.textColor = RGBFormUIColor(0x333333);
    }
    else
    {
        self.hongBangTuiJianButton.tag = 0;
        self.hongBangTuiJianButton.button_imageView.layer.borderColor = [RGBFormUIColor(0x999999) CGColor];
        self.hongBangTuiJianButton.button_imageView1.backgroundColor = [UIColor clearColor];
        self.hongBangTuiJianButton.button_lable.textColor = RGBFormUIColor(0x999999);

    }
}
-(void)tiYanTimeButtonClick
{
    [self viewTap];
    self.pickRootView.hidden = NO;
}
-(void)initPickView
{
    self.pickRootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    self.pickRootView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:self.pickRootView];

    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickRootViewTap)];
    [self.pickRootView addGestureRecognizer:tapGesture];
    
    self.datePickView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu-162, WIDTH_PingMu, 162)];
    self.datePickView.datePickerMode=UIDatePickerModeDate;
    [self.pickRootView addSubview:self.datePickView];
    self.datePickView.maximumDate = [NSDate date];
    
    NSDate * currentDate = [NSDate date];
     [self.datePickView setDate:currentDate animated:YES];//设置滚动到的时间
        
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
//    [lastMonthComps setYear:1];
    //[lastMonthComps setMonth:1];// month = 1表示1月后的时间 month = -1为1月前的日期 year day 类推
    //NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];

    //[self.datePickView setMinimumDate:currentDate];//设置最小时间
    [self.datePickView setMaximumDate:currentDate];//设置最大时间

    self.datePickView.backgroundColor = [UIColor whiteColor];
    [self.datePickView addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    self.pickRootView.hidden = YES;
}
-(void)oneDatePickerValueChanged:(UIDatePicker *) sender
{
    NSDate * select = [sender date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString * selectData = [selectDateFormatter stringFromDate:select];
    [self.tiYanTimeButton setTitle:selectData forState:UIControlStateNormal];
    [self.tiYanTimeButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
}
-(void)pickRootViewTap
{
    self.pickRootView.hidden = YES;
}

#pragma mark--选择照片

-(void)addMediaButtonClick
{
    
    __weak typeof(self) wself = self;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [wself addMeidFromCamera];
    }];
    UIAlertAction * libraryAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          
        [wself addMediaFromLibaray:@"image"];
      }];
    [alert addAction:cancleAction];
    [alert addAction:photoAction];
    [alert addAction:libraryAction];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)addMeidFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController = [[UIImagePickerController alloc] init] ;
        self.imagePickerController.delegate = self;
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController.allowsEditing = YES;
        
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}
-(void)addMediaFromLibaray:(NSString *)type
{
    TZImagePickerController *imagePickController;
    NSInteger count = 0;
    
    if ([@"image" isEqualToString:type]) {
        
        count = maxImageSelected - self.photoArray.count;
        imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:self];
        //是否 在相册中显示拍照按钮
        imagePickController.allowTakePicture = NO;
        //是否可以选择显示原图
        imagePickController.allowPickingOriginalPhoto = NO;

        //是否 在相册中可以选择照片
        imagePickController.allowPickingImage= YES;
        //是否 在相册中可以选择视频
        imagePickController.allowPickingVideo = NO;

    }
    else
    {
        imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        //是否 在相册中显示拍照按钮
        imagePickController.allowTakePicture = NO;
        //是否可以选择显示原图
        imagePickController.allowPickingOriginalPhoto = NO;

        //是否 在相册中可以选择照片
        imagePickController.allowPickingImage= NO;
        //是否 在相册中可以选择视频
        imagePickController.allowPickingVideo = YES;

    }
    [imagePickController pushPhotoPickerVc];
    imagePickController.modalPresentationStyle = 0;
    [self.navigationController presentViewController:imagePickController animated:YES completion:nil];
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{   //判断是否设置头像
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.photoArray addObject:image];
    [self initphotoContentView];
}
#pragma mark - TZImagePickerController Delegate
//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    
    [[LLImagePickerManager manager] getMediaInfoFromAsset:[assets objectAtIndex:0] completion:^(NSString *name, id pathData) {
        
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
        model.name = name;
        model.uploadType = pathData;
        model.image = photos[0];
        for (UIImage * image in photos) {
            
            [self.photoArray addObject:image];
        }
        [self initphotoContentView];
    }];
    
    
}
-(void)deleteImageButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    [self.photoArray removeObjectAtIndex:button.tag];
    [self initphotoContentView];
}

#pragma mark--提交按钮点击

-(void)tiJiaoButtonClick
{
    if (![NormalUse isValidString:self.meiZiHuaMingTF.text]) {
        
        [NormalUse showToastView:@"请填写标题信息" view:self.view];
        return;;
    }
    if ([@"服务类型>" isEqualToString:self.leiXingButton.titleLabel.text]) {
        
        [NormalUse showToastView:@"请选择服务类型" view:self.view];
        return;

    }
    if (![NormalUse isValidDictionary:self.cityInfo]) {
        
        [NormalUse showToastView:@"请选择所在区域" view:self.view];
        return;
    }
    if ([@"选择服务项目>" isEqualToString:self.fuWuXiangMuButton.titleLabel.text]) {
        
        [NormalUse showToastView:@"请选择服务项目" view:self.view];
        return;
    }
    if([@"选择体验时间>" isEqualToString:self.tiYanTimeButton.titleLabel.text])
    {
        [NormalUse showToastView:@"请选择体验时间" view:self.view];
         return;
    }
    if(![NormalUse isValidString:self.xiaoFeiTF.text])
    {
        [NormalUse showToastView:@"请填写消费情况" view:self.view];
         return;
    }
    
    if(![NormalUse isValidString:self.yanZhiStarValue])
    {
        [NormalUse showToastView:@"请选择颜值评分" view:self.view];
        return;
    }
    if(![NormalUse isValidString:self.jiShuStarValue])
    {
        [NormalUse showToastView:@"请选择技术评分" view:self.view];
        return;
    }
    
    if(![NormalUse isValidString:self.huanJingStarValue])
    {
        [NormalUse showToastView:@"请选择环境评分" view:self.view];
        return;
    }

    if (![NormalUse isValidString:self.xiangQingTextView.text]) {
        
        [NormalUse showToastView:@"请填写描述类容" view:self.view];
         return;
    }
    

    if (![NormalUse isValidArray:self.photoArray]) {
        
        [NormalUse showToastView:@"请选择照片" view:self.view];
         return;

    }
    
    [self xianShiLoadingView:@"提交中..." view:self.view];
    

    uploadImageIndex = 0;
    self.imagePathId = nil;
    
    self.photoPathArray = [NSMutableArray array];
    [self uploadImage];
    

}
-(void)uploadImage
{
    UIImage *image = [self.photoArray objectAtIndex:uploadImageIndex];
    
    UIImage * uploadImage = [NormalUse scaleToSize:image size:CGSizeMake(400, 400*(image.size.height/image.size.width))];
    //png和jpeg的压缩
    NSData *imageData = UIImagePNGRepresentation(uploadImage);
    
    unsigned long long size = imageData.length;
    NSString * videoFileSize = [NSString stringWithFormat:@"%.2f", size / pow(10, 6)];
    NSLog(@"%@",videoFileSize);

    [HTTPModel uploadImageVideo:[[NSDictionary alloc] initWithObjectsAndKeys:imageData,@"file",@"&%&*HDSdahjd.dasiH23",@"upload_key",@"img",@"file_type", nil]
                       callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            [self.photoPathArray addObject:[responseObject objectForKey:@"filename"]];

        }
        self->uploadImageIndex = self->uploadImageIndex+1;
        if (self->uploadImageIndex<self.photoArray.count) {
            
            [self uploadImage];

        }
        else
        {
            self->uploadImageIndex = 0;
            [self getImagePathId];
        }
        
    }];
    

}
-(void)getImagePathId
{
    if ([NormalUse isValidArray:self.photoPathArray]&& self.photoPathArray.count>0) {
    
        [HTTPModel saveFile:[[NSDictionary alloc]initWithObjectsAndKeys:[self.photoPathArray objectAtIndex:uploadImageIndex],@"filepath", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            self->uploadImageIndex = self->uploadImageIndex+1;
            
            if (status==1) {
                
                if (![NormalUse isValidString:self.imagePathId]) {
                    
                    self.imagePathId = [responseObject objectForKey:@"fileId"];
                }
                else
                {
                    self.imagePathId = [[self.imagePathId stringByAppendingString:@"|"] stringByAppendingString:[responseObject objectForKey:@"fileId"]];
                }
            }


            if (self->uploadImageIndex<self.photoArray.count) {

                [self getImagePathId];
            }
            else
            {
                
                
                
                NSMutableDictionary * dicInfo = [[NSMutableDictionary alloc] init];
                [dicInfo setObject:self.type_id forKey:@"type_id"];
                [dicInfo setObject:self.post_id forKey:@"post_id"];
                [dicInfo setObject:self.meiZiHuaMingTF.text forKey:@"girl_name"];
                [dicInfo setObject:self.leiXingButton.titleLabel.text forKey:@"message_type"];
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dicInfo setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"city_code"];
                [dicInfo setObject:self.fuWuXiangMuButton.titleLabel.text forKey:@"service_type"];
                [dicInfo setObject:self.tiYanTimeButton.titleLabel.text forKey:@"experience_date"];
                [dicInfo setObject:self.xiaoFeiTF.text forKey:@"trade_money"];
                
                   
                if(self.hongBangTuiJianButton.tag==0)
                {
                    [dicInfo setObject:@"0" forKey:@"is_good"];

                }
                else
                {
                    [dicInfo setObject:@"1" forKey:@"is_good"];

                }
                [dicInfo setObject:self.yanZhiStarValue forKey:@"face_value"];
                [dicInfo setObject:self.jiShuStarValue forKey:@"skill_value"];
                [dicInfo setObject:self.huanJingStarValue forKey:@"ambience_value"];
                [dicInfo setObject:self.xiangQingTextView.text forKey:@"decription"];
                [dicInfo setObject:self.imagePathId forKey:@"images"];
                NSLog(@"%@",dicInfo);
                
                [HTTPModel faBuTiYanBaoGao:dicInfo callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                   
                    [self yinCangLoadingView];
                    
                    if (status==1) {
                        
                        [self.delegate faBuYanZhengSuccess];
                        [self.navigationController popViewControllerAnimated:YES];
                        [NormalUse showToastView:@"发布成功" view:[NormalUse getCurrentVC].view];
                    }
                    else
                    {
                        [NormalUse showToastView:msg view:self.view];
                    }
                }];
                
            }

        }];
        
        
    }

}
@end
