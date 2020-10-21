//
//  CreateTieZiViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/8.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "CreateTieZiViewController.h"
#import "RAFileManager.h"


@interface CreateTieZiViewController ()

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSNumber * is_free;


@end

@implementation CreateTieZiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    self.topTitleLale.text = @"发布帖子";
    self.loadingFullScreen = @"yes";
    
    maxImageSelected = 4;
    maxVideoSelected = 2;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.mainScrollView addGestureRecognizer:tap];
    
    [self initTopStepView];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    if ([@"1" isEqualToString:self.from_flg]) {
        
        [dic setObject:@"1" forKey:@"is_agent"];
    }
    [HTTPModel faTieAlsoFree:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            self.is_free = [responseObject objectForKey:@"is_free"];
            if (self.is_free.intValue==1) {
                
                self.tiJiaoLable.text = @"提交";

            }
        }
        
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self viewTap];
}
-(void)viewTap
{
    [self.biaoTiTF resignFirstResponder];
    [self.ageTF resignFirstResponder];
    [self.chanPinShuLiangTF resignFirstResponder];
    [self.beginPriceTF resignFirstResponder];
    [self.endPriceTF resignFirstResponder];
    [self.telTF resignFirstResponder];
    [self.qqTF resignFirstResponder];
    [self.weiXinTF resignFirstResponder];
    [self.xiangQingTextView resignFirstResponder];
}
-(void)initTopStepView
{
    
   UILabel * xinXiLeiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 12*BiLiWidth, 100*BiLiWidth, 39.5*BiLiWidth)];
   xinXiLeiXingLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
   xinXiLeiXingLable.textColor = RGBFormUIColor(0x333333);
   xinXiLeiXingLable.text = @"信息类型";
   [self.mainScrollView addSubview:xinXiLeiXingLable];

   self.xinXiButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-213.5*BiLiWidth, xinXiLeiXingLable.top, 200*BiLiWidth, 39.5*BiLiWidth)];
   self.xinXiButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.xinXiButton setTitleColor:RGBFormUIColor(0xDEDEDE) forState:UIControlStateNormal];
    [self.xinXiButton setTitle:@"选择信息类型>" forState:UIControlStateNormal];
    self.xinXiButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.xinXiButton.titleLabel.font = [UIFont systemFontOfSize:13*BiLiWidth];
    [self.xinXiButton addTarget:self action:@selector(xinXiButtonClick) forControlEvents:UIControlEventTouchUpInside];
   [self.mainScrollView addSubview:self.xinXiButton];

   UIView * lineViewXinXi = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, xinXiLeiXingLable.top+xinXiLeiXingLable.height, 270*BiLiWidth, 1)];
   lineViewXinXi.backgroundColor = RGBFormUIColor(0xEEEEEE);
   [self.mainScrollView addSubview:lineViewXinXi];

    
    UILabel * biaoTiXinXiLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineViewXinXi.top+lineViewXinXi.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    biaoTiXinXiLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    biaoTiXinXiLable.textColor = RGBFormUIColor(0x333333);
    biaoTiXinXiLable.text = @"信息标题";
    [self.mainScrollView addSubview:biaoTiXinXiLable];

    self.biaoTiTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth-80*BiLiWidth, biaoTiXinXiLable.top, 100*BiLiWidth+80*BiLiWidth, 39.5*BiLiWidth)];
    self.biaoTiTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NormalUse setTextFieldPlaceholder:@"填写信息标题" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.biaoTiTF];
    self.biaoTiTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.biaoTiTF.textColor = RGBFormUIColor(0x343434);
    self.biaoTiTF.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:self.biaoTiTF];

    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, biaoTiXinXiLable.top+biaoTiXinXiLable.height, 270*BiLiWidth, 1)];
    lineView1.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView1];

    
    UILabel * diquLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView1.top+lineView1.height, 100*BiLiWidth, 39.5*BiLiWidth)];
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

    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, diquLable.top+diquLable.height, 270*BiLiWidth, 1)];
    lineView2.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView2];

    
    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView2.top+lineView2.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    ageLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    ageLable.textColor = RGBFormUIColor(0x333333);
    ageLable.text = @"小姐年龄";
    [self.mainScrollView addSubview:ageLable];

    self.ageTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, ageLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    self.ageTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NormalUse setTextFieldPlaceholder:@"填写小姐年龄" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.ageTF];
    self.ageTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.ageTF.textColor = RGBFormUIColor(0x343434);
    self.ageTF.textAlignment = NSTextAlignmentRight;
    self.ageTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.mainScrollView addSubview:self.ageTF];

    UIView * lineView3 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, ageLable.top+ageLable.height, 270*BiLiWidth, 1)];
    lineView3.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView3];
    
    UILabel * chanPinShuLiangLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView3.top+lineView3.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    chanPinShuLiangLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    chanPinShuLiangLable.textColor = RGBFormUIColor(0x333333);
    chanPinShuLiangLable.text = @"小姐数量";
    [self.mainScrollView addSubview:chanPinShuLiangLable];

    self.chanPinShuLiangTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, chanPinShuLiangLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    self.chanPinShuLiangTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NormalUse setTextFieldPlaceholder:@"填写小姐数量" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.chanPinShuLiangTF];
    self.chanPinShuLiangTF.textAlignment = NSTextAlignmentRight;
    self.chanPinShuLiangTF.keyboardType = UIKeyboardTypeNumberPad;
    self.chanPinShuLiangTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.chanPinShuLiangTF.textColor = RGBFormUIColor(0x343434);
    [self.mainScrollView addSubview:self.chanPinShuLiangTF];

    UIView * lineViewNumber = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, chanPinShuLiangLable.top+chanPinShuLiangLable.height, 270*BiLiWidth, 1)];
    lineViewNumber.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineViewNumber];

    
    UILabel * fuWuJiaGeLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineViewNumber.top+lineViewNumber.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    fuWuJiaGeLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    fuWuJiaGeLable.textColor = RGBFormUIColor(0x333333);
    fuWuJiaGeLable.text = @"服务价格";
    [self.mainScrollView addSubview:fuWuJiaGeLable];
    
    self.beginPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(200*BiLiWidth, lineViewNumber.top+lineViewNumber.height, 58*BiLiWidth, 39.5*BiLiWidth)];
    self.beginPriceTF.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.beginPriceTF.placeholder = @"最低价格";
    self.beginPriceTF.textColor  = RGBFormUIColor(0x343434);
    self.beginPriceTF.keyboardType = UIKeyboardTypeNumberPad;
    self.beginPriceTF.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:self.beginPriceTF];

    UIView * priceLineView = [[UIView alloc] initWithFrame:CGRectMake(self.beginPriceTF.left+self.beginPriceTF.width+14*BiLiWidth, (self.beginPriceTF.height-1)/2+self.beginPriceTF.top,7*BiLiWidth, 1)];
    priceLineView.backgroundColor = RGBFormUIColor(0x343434);
    [self.mainScrollView addSubview:priceLineView];


    self.endPriceTF = [[UITextField alloc] initWithFrame:CGRectMake(priceLineView.left+priceLineView.width+14*BiLiWidth, lineViewNumber.top+lineViewNumber.height, 58*BiLiWidth, 39.5*BiLiWidth)];
    self.endPriceTF.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.endPriceTF.placeholder = @"最高价格";
    self.endPriceTF.textColor  = RGBFormUIColor(0x343434);
    self.endPriceTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.mainScrollView addSubview:self.endPriceTF];

    UIView * lineView4 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, fuWuJiaGeLable.top+fuWuJiaGeLable.height, 270*BiLiWidth, 1)];
    lineView4.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView4];

    

    UILabel * fuWuXiangMuLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView4.top+lineView4.height, 100*BiLiWidth, 39.5*BiLiWidth)];
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
    
    UIView * lineView5 = [[UIView alloc] initWithFrame:CGRectMake(lineView4.left, fuWuXiangMuLable.top+fuWuXiangMuLable.height, lineView4.width, 1)];
    lineView5.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView5];
    
    UILabel * lianXiFangShiLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView5.top+lineView5.height+13*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    lianXiFangShiLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    lianXiFangShiLable.textColor = RGBFormUIColor(0x333333);
    lianXiFangShiLable.text = @"联系方式";
    [self.mainScrollView addSubview:lianXiFangShiLable];
    
    UILabel * lianXiFangShiTipLable = [[UILabel alloc] initWithFrame:CGRectMake(lianXiFangShiLable.left, lianXiFangShiLable.top+lianXiFangShiLable.height+10*BiLiWidth, 63*BiLiWidth, 25*BiLiWidth)];
    lianXiFangShiTipLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
    lianXiFangShiTipLable.textColor = RGBFormUIColor(0xDEDEDE);
    lianXiFangShiTipLable.numberOfLines = 2;
    lianXiFangShiTipLable.text = @"(填写一种联系方式即可）";
    [self.mainScrollView addSubview:lianXiFangShiTipLable];
    
    
    self.weiXinTF = [[UITextField alloc] initWithFrame:CGRectMake(self.ageTF.left, lineView5.top+lineView5.height, self.ageTF.width, 39.5*BiLiWidth)];
    self.weiXinTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    [NormalUse setTextFieldPlaceholder:@"请填写微信号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.weiXinTF];
    self.weiXinTF.textAlignment = NSTextAlignmentRight;
    self.weiXinTF.textColor  = RGBFormUIColor(0x343434);
    [self.mainScrollView addSubview:self.weiXinTF];
    
    UIView * lineView6 = [[UIView alloc] initWithFrame:CGRectMake(lineView5.left, lineView5.top+lineView5.height+39.5*BiLiWidth, lineView5.width, 1)];
    lineView6.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView6];
    
    self.qqTF = [[UITextField alloc] initWithFrame:CGRectMake(self.ageTF.left, lineView6.top+lineView6.height, self.ageTF.width, 39.5*BiLiWidth)];
    self.qqTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    [NormalUse setTextFieldPlaceholder:@"请填写QQ号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.qqTF];
    self.qqTF.textColor  = RGBFormUIColor(0x343434);
    self.qqTF.textAlignment = NSTextAlignmentRight;
    self.qqTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.mainScrollView addSubview:self.qqTF];
    
    UIView * lineView7 = [[UIView alloc] initWithFrame:CGRectMake(lineView5.left, lineView6.top+lineView6.height+39.5*BiLiWidth, lineView5.width, 1)];
    lineView7.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView7];

    
    self.telTF = [[UITextField alloc] initWithFrame:CGRectMake(self.ageTF.left, lineView7.top+lineView7.height, self.ageTF.width, 39.5*BiLiWidth)];
    self.telTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    [NormalUse setTextFieldPlaceholder:@"请填写手机号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.telTF];
    self.telTF.textAlignment = NSTextAlignmentRight;
    self.telTF.textColor  = RGBFormUIColor(0x343434);
    self.telTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.mainScrollView addSubview:self.telTF];
    
    UIView * lineView8 = [[UIView alloc] initWithFrame:CGRectMake(lineView5.left, lineView7.top+lineView7.height+39.5*BiLiWidth, lineView5.width, 1)];
    lineView8.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView8];
    
    
    UILabel * zhengTiPingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView8.top+lineView8.height+26*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
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

    UILabel * geRenShiPinLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, huanJingLable.top+huanJingLable.height+37*BiLiWidth, 150*BiLiWidth, 14*BiLiWidth)];
    geRenShiPinLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    geRenShiPinLable.textColor = RGBFormUIColor(0x333333);
    geRenShiPinLable.text = @"个人视频（可选）";
    [self.mainScrollView addSubview:geRenShiPinLable];
    
    self.videoArray = [NSMutableArray array];
    
    self.videoContentView = [[UIView alloc] initWithFrame:CGRectMake(15*BiLiWidth, geRenShiPinLable.frame.origin.y+geRenShiPinLable.frame.size.height+20*BiLiWidth, WIDTH_PingMu-30*BiLiWidth, 72*BiLiWidth)];
    [self.mainScrollView addSubview:self.videoContentView];

    [self initVideoContentView];

    
    self.zhaoPianSelectLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, self.videoContentView.top+self.videoContentView.height+33*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    self.zhaoPianSelectLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    self.zhaoPianSelectLable.textColor = RGBFormUIColor(0x333333);
    self.zhaoPianSelectLable.text = @"实拍照片";
    [self.mainScrollView addSubview:self.zhaoPianSelectLable];
    
    self.photoArray = [NSMutableArray array];

    self.photoContentView = [[UIView alloc] initWithFrame:CGRectMake(15*BiLiWidth, self.zhaoPianSelectLable.frame.origin.y+self.zhaoPianSelectLable.frame.size.height+20*BiLiWidth, WIDTH_PingMu-30*BiLiWidth, 72*BiLiWidth)];
    [self.mainScrollView addSubview:self.photoContentView];
    
    [self initphotoContentView];
    
    self.xiangQingLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, self.photoContentView.top+self.photoContentView.height+33*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    self.xiangQingLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    self.xiangQingLable.textColor = RGBFormUIColor(0x333333);
    self.xiangQingLable.text = @"详情介绍";
    [self.mainScrollView addSubview:self.xiangQingLable];
    
    self.xiangQingTextView = [[UITextView alloc] initWithFrame:CGRectMake(12*BiLiWidth,self.xiangQingLable.top+self.xiangQingLable.height+13*BiLiWidth, WIDTH_PingMu-24*BiLiWidth, 130*BiLiWidth-30*BiLiWidth)];
    self.xiangQingTextView.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:15*BiLiWidth];
    self.xiangQingTextView.textColor = RGBFormUIColor(0x999999);
    self.xiangQingTextView.backgroundColor = [UIColor clearColor];
    self.xiangQingTextView.delegate = self;
    self.xiangQingTextView.layer.cornerRadius = 4*BiLiWidth;
    self.xiangQingTextView.layer.borderWidth = 1;
    self.xiangQingTextView.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
    self.xiangQingTextView.placeholder = @"请对女神进行详细的描述...";
    self.xiangQingTextView.font = [UIFont systemFontOfSize:13*BiLiWidth];
    [self.mainScrollView addSubview:self.xiangQingTextView];


    
    self.tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, self.xiangQingTextView.top+self.xiangQingTextView.height+35*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [self.tiJiaoButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
    
    self.tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tiJiaoButton.width, self.tiJiaoButton.height)];
    self.tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.tiJiaoLable.text = @"下一步";
    self.tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    self.tiJiaoLable.textColor = [UIColor whiteColor];
    [self.tiJiaoButton addSubview:self.tiJiaoLable];

    
    
    
    [self.mainScrollView setContentSize: CGSizeMake(WIDTH_PingMu, self.tiJiaoButton.top+self.tiJiaoButton.height+250*BiLiWidth)];

    
    
    


    
}
-(void)initVideoContentView
{
    [self.videoContentView removeAllSubviews];
    
    float imageHeight = (WIDTH_PingMu-30*BiLiWidth-15*BiLiWidth)/4;
       
       for (int i=0; i<self.videoArray.count; i++)
       {
           UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i%4)*(imageHeight+5*BiLiWidth), (imageHeight+5*BiLiWidth)*(i/4), imageHeight, imageHeight)];
           imageView.userInteractionEnabled = YES;
           imageView.clipsToBounds = YES;
           imageView.contentMode = UIViewContentModeScaleAspectFill;
           LLImagePickerModel * model = [self.videoArray objectAtIndex:i];
           imageView.image = model.image;
           [self.videoContentView addSubview:imageView];
           
           UIImageView * imageDelete = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.size.width-21*BiLiWidth, 0, 21*BiLiWidth, 21*BiLiWidth)];
           imageDelete.image = [UIImage imageNamed:@"create_dongtai_shanchu"];
           [imageView addSubview:imageDelete];
           
           UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.size.width-30*BiLiWidth, 0, 30*BiLiWidth, 30*BiLiWidth)];
           button.tag = i;
           [button addTarget:self action:@selector(deleteVideoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
           [imageView addSubview:button];
           
       }
       
       if(self.videoArray.count==maxVideoSelected)
       {
           self.videoContentView.frame = CGRectMake(self.videoContentView.frame.origin.x, self.videoContentView.frame.origin.y, self.videoContentView.frame.size.width, (imageHeight+5*BiLiWidth)*(self.videoArray.count/4)+imageHeight+15*BiLiWidth);

       }
       else
       {
           UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((self.videoArray.count%4)*(imageHeight+5*BiLiWidth), (imageHeight+5*BiLiWidth)*(self.videoArray.count/4), imageHeight, imageHeight)];
           [button setImage:[UIImage imageNamed:@"dongtai_tianjia"] forState:UIControlStateNormal];
           [button addTarget:self action:@selector(addVideoButtonClick) forControlEvents:UIControlEventTouchUpInside];
           [self.videoContentView addSubview:button];
           
           self.videoContentView.frame = CGRectMake(self.videoContentView.frame.origin.x, self.videoContentView.frame.origin.y, self.videoContentView.frame.size.width, button.frame.origin.y+button.frame.size.height+15*BiLiWidth);
       }
       
    self.zhaoPianSelectLable.top = self.videoContentView.top+self.videoContentView.height+33*BiLiWidth;
    self.photoContentView.top = self.zhaoPianSelectLable.top+self.zhaoPianSelectLable.height+20*BiLiWidth;
    self.xiangQingLable.top =  self.photoContentView.top+self.photoContentView.height+33*BiLiWidth;
    self.xiangQingTextView.top = self.xiangQingLable.top+self.xiangQingLable.height+13*BiLiWidth;
    self.tiJiaoButton.top = self.xiangQingTextView.top+self.xiangQingTextView.height+35*BiLiWidth;
    self.mainScrollView.contentSize = CGSizeMake(WIDTH_PingMu, self.tiJiaoButton.top+self.tiJiaoButton.height+250*BiLiWidth);

    
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
    
    self.xiangQingLable.top =  self.photoContentView.top+self.photoContentView.height+33*BiLiWidth;
    self.xiangQingTextView.top = self.xiangQingLable.top+self.xiangQingLable.height+13*BiLiWidth;
    self.tiJiaoButton.top = self.xiangQingTextView.top+self.xiangQingTextView.height+35*BiLiWidth;
    self.mainScrollView.contentSize = CGSizeMake(WIDTH_PingMu, self.tiJiaoButton.top+self.tiJiaoButton.height+250*BiLiWidth);

}
#pragma mark--选择视频

-(void)addVideoButtonClick
{
    [self addMediaFromLibaray:@"video"];
}
-(void)deleteVideoButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    [self.videoArray removeObjectAtIndex:button.tag];
    [self initVideoContentView];

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
///选取视频后的回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    
    [[LLImagePickerManager manager] getMediaInfoFromAsset:asset completion:^(NSString *name, id pathData) {
        
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
        model.name = name;
        model.uploadType = pathData;
        model.image = coverImage;
        model.isVideo = YES;
        model.asset = asset;
        [self.videoArray addObject:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            [self initVideoContentView];
            
          });


    }];
}

- (NSString*)dataPath
{
    NSString *dataPath = [NSString stringWithFormat:@"%@/Library/appdata/chatbuffer", NSHomeDirectory()];
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:dataPath]){
        [fm createDirectoryAtPath:dataPath
      withIntermediateDirectories:YES
                       attributes:nil
                            error:nil];
    }
    return dataPath;
}

-(void)deleteImageButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    [self.photoArray removeObjectAtIndex:button.tag];
    [self initphotoContentView];
}

#pragma mark--UIButtonClick
-(void)diQuButtonClick
{
    CityListViewController * vc = [[CityListViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)xinXiButtonClick
{
    LeiXiangSelectViewController * vc = [[LeiXiangSelectViewController alloc] init];
    vc.type = @"xinxi";
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

-(void)nextButtonClick
{
    if(![NormalUse isValidString:self.xinXiButton.titleLabel.text]||[@"选择信息类型>" isEqualToString:self.xinXiButton.titleLabel.text])
    {
        [NormalUse showToastView:@"请设置服务项目" view:self.view];
        return;
    }
    
    if (![NormalUse isValidString:self.biaoTiTF.text]) {
        
        [NormalUse showToastView:@"请填写标题信息" view:self.view];
        return;;
    }
    if (![NormalUse isValidDictionary:self.cityInfo]) {
        
        [NormalUse showToastView:@"请选择所在区域" view:self.view];
        return;
    }
    if (![NormalUse isValidString:self.ageTF.text]) {
        
        [NormalUse showToastView:@"请填写年龄" view:self.view];
        return;
    }
    if (![NormalUse isValidString:self.chanPinShuLiangTF.text]) {
        
        [NormalUse showToastView:@"请填写小姐数量" view:self.view];
        return;
    }
    
    if(![NormalUse isValidString:self.beginPriceTF.text])
    {
        [NormalUse showToastView:@"请设置最低价格" view:self.view];
        return;
    }
    if(![NormalUse isValidString:self.endPriceTF.text])
    {
        [NormalUse showToastView:@"请设置最高价格" view:self.view];
        return;
    }
    NSString * beginPrice = self.beginPriceTF.text;
    NSString * endPrice = self.endPriceTF.text;
    
    if(endPrice.intValue<beginPrice.intValue)
    {
        [NormalUse showToastView:@"最高价格不能小于最低价格" view:self.view];
        return;
    }
    
    
    if(![NormalUse isValidString:self.fuWuXiangMuButton.titleLabel.text]||[@"选择服务项目>" isEqualToString:self.fuWuXiangMuButton.titleLabel.text])
    {
        [NormalUse showToastView:@"请设置服务项目" view:self.view];
        return;
    }
    
    
    if(![NormalUse isValidString:self.weiXinTF.text]&&![NormalUse isValidString:self.qqTF.text]&&![NormalUse isValidString:self.telTF.text])
    {
        [NormalUse showToastView:@"请填写联系方式" view:self.view];
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
    
    if (![NormalUse isValidArray:self.photoArray]) {
        
        [NormalUse showToastView:@"请选择照片" view:self.view];
        return;
        
    }
    
    
    if (![NormalUse isValidString:self.xiangQingTextView.text]) {
        
        [NormalUse showToastView:@"请填写描述类容" view:self.view];
        return;
    }
    
    
    

    BOOL alsoKouFei = NO;//是否需要扣费
    if ([@"1" isEqualToString:self.from_flg]) {
        
        NSString *  enabled_post_agent = [NormalUse getJinBiStr:@"enabled_post_agent"];//经纪人是否允许免费发帖

        if ([@"1" isEqualToString:enabled_post_agent]) {
          
            alsoKouFei = NO;
        }
        else
        {
            alsoKouFei = YES;
        }
    }
    else
    {
        NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
        NSString * defaultsKey = [UserRole stringByAppendingString:token];
        NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
        NSNumber * auth_nomal = [userRoleDic objectForKey:@"auth_nomal"];

        NSString * enabled_post_normal = [NormalUse getJinBiStr:@"enabled_post_normal"];//1茶小二可以免费发帖

        if (auth_nomal.intValue==1 && [@"1" isEqualToString:enabled_post_normal])
        {
            alsoKouFei = NO;
        }
        else
        {
            alsoKouFei = YES;
        }
        
    }
    
    //if (!alsoKouFei)
    if (self.is_free.intValue==1) {
        [self xianShiLoadingView:@"提交中..." view:self.view];
        uploadVideoIndex = 0;
        self.videoPathId = nil;
        self.videoShouZhenPathId = nil;
        [self.videoPathArray removeAllObjects];
        
        uploadImageIndex = 0;
        self.imagePathId = nil;
        [self.photoPathArray removeAllObjects];
        
        if ([NormalUse isValidArray:self.videoArray]) {
            
            self.videoPathArray = [NSMutableArray array];
            self.videoShouZhenImagePathArray = [NSMutableArray array];
            [self uploadVideo];
        }
        else
        {
            self.photoPathArray = [NSMutableArray array];
            [self uploadImage];
        }
        
    }
    else
    {
        CreateTieZiKouFeiViewController * vc = [[CreateTieZiKouFeiViewController alloc] init];
        vc.message_type = self.xinXiButton.titleLabel.text;
        vc.titleStr = self.biaoTiTF.text;
        NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
        vc.city_code = [NSString stringWithFormat:@"%d",cityCode.intValue];
        vc.age = self.ageTF.text;
        vc.nums = self.chanPinShuLiangTF.text;
        vc.min_price = self.beginPriceTF.text;
        vc.max_price = self.endPriceTF.text;
        vc.service_type = self.fuWuXiangMuButton.titleLabel.text;
        vc.mobile = [NormalUse getobjectForKey:self.telTF.text];
        vc.qq = [NormalUse getobjectForKey:self.qqTF.text];
        vc.wechat = [NormalUse getobjectForKey:self.weiXinTF.text];
        vc.face_value = self.yanZhiStarValue;
        vc.skill_value = self.jiShuStarValue;
        vc.ambience_value = self.huanJingStarValue;
        vc.decription = self.xiangQingTextView.text;
        vc.from_flg = self.from_flg;
        vc.photoArray = self.photoArray;
        vc.videoArray = self.videoArray;
        [self.navigationController pushViewController:vc animated:YES];

    }
    
}
-(void)uploadVideo
{
    LLImagePickerModel *model = [self.videoArray objectAtIndex:uploadVideoIndex];
    [self getVideoFromPHAsset:model];
}
//获取视频文件的路径
- (void) getVideoFromPHAsset: (LLImagePickerModel *) model {
    
    
    UIImage * shouZhenImage = model.image;
    UIImage * uploadImage = [NormalUse scaleToSize:shouZhenImage size:CGSizeMake(400, 400*(shouZhenImage.size.height/shouZhenImage.size.width))];
    //png和jpeg的压缩
    NSData *imageData = UIImagePNGRepresentation(uploadImage);
    
    unsigned long long size = imageData.length;
    NSString * videoFileSize = [NSString stringWithFormat:@"%.2f", size / pow(10, 6)];
    NSLog(@"%@",videoFileSize);

    [HTTPModel uploadImageVideo:[[NSDictionary alloc] initWithObjectsAndKeys:imageData,@"file",@"&%&*HDSdahjd.dasiH23",@"upload_key",@"img",@"file_type", nil]
                       callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            [self.videoShouZhenImagePathArray addObject:[responseObject objectForKey:@"filename"]];
            
            if (model.asset.mediaType == PHAssetMediaTypeVideo) {
                PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
                options.version = PHImageRequestOptionsVersionCurrent;
                options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
                
                PHImageManager *manager = [PHImageManager defaultManager];
                [manager requestAVAssetForVideo:model.asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                    AVURLAsset *urlAsset = (AVURLAsset *)asset;
                    NSURL *url = urlAsset.URL;
                    
                    // mov格式转mp4
                    // NSURL *mp4 = [self convertToMp4:url];
                    
                    [self yaSuoAndUploadVideo:url];
                    

                }];
            }

        }
        else
        {
            
            if (self->uploadVideoIndex<self.videoArray.count) {
                
                LLImagePickerModel *model = [self.videoArray objectAtIndex:self->uploadVideoIndex];
                [self getVideoFromPHAsset:model];
            }
            else
            {
                self->uploadVideoIndex = 0;
                [self getVideoShouZhenPathId];

            }

        }
        
    }];

    
}
#pragma 视频名以当前日期为名
- (NSString*)getVideoSaveFilePathString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString* nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return nowTimeStr;
}

//压缩视频并上传
-(void)yaSuoAndUploadVideo :(NSURL *)fileURL
{
    NSString * yaSuoPath = [self getVideoSaveFilePathString];
    NSURL *yaSuoUrl = [[RAFileManager defaultManager] filePathUrlWithUrl:yaSuoPath];
    // 视频压缩
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = yaSuoUrl;
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exportSession.status;
        switch (exportStatus)
        {
            case AVAssetExportSessionStatusFailed:
            {
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                [NormalUse showToastView:@"视频格式有误请重新选择" view:self.view];
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                NSData *data = [NSData dataWithContentsOfURL:yaSuoUrl];
                
                unsigned long long size = data.length;
                NSString * videoFileSize = [NSString stringWithFormat:@"%.2f", size / pow(10, 6)];
                //视频大于5兆不让上传
                if (videoFileSize.intValue>5) {
                    
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        [self yinCangLoadingView];
                        [NormalUse showToastView:@"视频过大请重新选择" view:self.view];
                        
                    });
                    
                }
                else
                {
                    [self uploadVideo:data];
                }
            }
        }
    }];
    
    
}
-(void)uploadVideo:(NSData *)videoData
{

    [HTTPModel uploadImageVideo:[[NSDictionary alloc] initWithObjectsAndKeys:videoData,@"file",@"&%&*HDSdahjd.dasiH23",@"upload_key",@"video",@"file_type", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        if (status==1) {
            
            [self.videoPathArray addObject:[responseObject objectForKey:@"filename"]];
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }

        self->uploadVideoIndex = self->uploadVideoIndex+1;

        if (self->uploadVideoIndex<self.videoArray.count) {
            
            LLImagePickerModel *model = [self.videoArray objectAtIndex:self->uploadVideoIndex];
            [self getVideoFromPHAsset:model];
        }
        else
        {
            self->uploadVideoIndex = 0;
            [self getVideoShouZhenPathId];

        }

    }];

}
-(void)getVideoShouZhenPathId
{
    if ([NormalUse isValidArray:self.videoShouZhenImagePathArray]&& self.videoShouZhenImagePathArray.count>0) {
    
        [HTTPModel saveFile:[[NSDictionary alloc]initWithObjectsAndKeys:[self.videoShouZhenImagePathArray objectAtIndex:uploadVideoIndex],@"filepath", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            self->uploadVideoIndex = self->uploadVideoIndex+1;
            
            if (status==1) {
                
                if (![NormalUse isValidString:self.videoShouZhenPathId]) {
                    
                    self.videoShouZhenPathId = [responseObject objectForKey:@"fileId"];
                }
                else
                {
                    self.videoShouZhenPathId = [[self.videoShouZhenPathId stringByAppendingString:@"|"] stringByAppendingString:[responseObject objectForKey:@"fileId"]];
                }
            }


            if (self->uploadVideoIndex<self.videoArray.count) {

                [self getVideoShouZhenPathId];
            }
            else
            {
                self->uploadVideoIndex = 0;
                [self getVideoPathId];
            }

        }];
        
        
    }
    else
    {
        self->uploadVideoIndex = 0;
        [self getVideoPathId];
    }

}
-(void)getVideoPathId
{
    if ([NormalUse isValidArray:self.videoPathArray]&& self.videoPathArray.count>0) {
    
        [HTTPModel saveFile:[[NSDictionary alloc]initWithObjectsAndKeys:[self.videoPathArray objectAtIndex:uploadVideoIndex],@"filepath", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            self->uploadVideoIndex = self->uploadVideoIndex+1;
            
            if (status==1) {
                
                if (![NormalUse isValidString:self.videoPathId]) {
                    
                    self.videoPathId = [responseObject objectForKey:@"fileId"];
                }
                else
                {
                    self.videoPathId = [[self.videoPathId stringByAppendingString:@"|"] stringByAppendingString:[responseObject objectForKey:@"fileId"]];
                }
            }


            if (self->uploadVideoIndex<self.videoArray.count) {

                [self getVideoPathId];
            }
            else
            {
                self.photoPathArray = [NSMutableArray array];
                [self uploadImage];
            }

        }];
        
        
    }
    else
    {
         self.photoPathArray = [NSMutableArray array];
        [self uploadImage];
    }
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
                [dicInfo setObject:self.xinXiButton.titleLabel.text forKey:@"message_type"];
                [dicInfo setObject:self.biaoTiTF.text forKey:@"title"];
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dicInfo setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"city_code"];
                [dicInfo setObject:self.ageTF.text forKey:@"age"];
                [dicInfo setObject:self.chanPinShuLiangTF.text forKey:@"nums"];
                [dicInfo setObject:self.beginPriceTF.text forKey:@"min_price"];
                [dicInfo setObject:self.endPriceTF.text forKey:@"max_price"];
                [dicInfo setObject:self.fuWuXiangMuButton.titleLabel.text forKey:@"service_type"];
                [dicInfo setObject:[NormalUse getobjectForKey:self.telTF.text] forKey:@"mobile"];
                [dicInfo setObject:[NormalUse getobjectForKey:self.qqTF.text] forKey:@"qq"];
                [dicInfo setObject:[NormalUse getobjectForKey:self.weiXinTF.text] forKey:@"wechat"];
                [dicInfo setObject:self.yanZhiStarValue forKey:@"face_value"];
                [dicInfo setObject:self.jiShuStarValue forKey:@"skill_value"];
                [dicInfo setObject:self.huanJingStarValue forKey:@"ambience_value"];
                [dicInfo setObject:[NormalUse getobjectForKey:self.videoPathId] forKey:@"videos"];
                [dicInfo setObject:[NormalUse getobjectForKey:self.videoShouZhenPathId] forKey:@"v_first_frames"];
                [dicInfo setObject:self.imagePathId forKey:@"images"];
                [dicInfo setObject:self.xiangQingTextView.text forKey:@"decription"];
                [dicInfo setObject:self.from_flg forKey:@"from_flg"];
                
                [HTTPModel faBuTieZi:dicInfo callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                   
                    if (status==1) {
                        
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
-(void)tiJiaoRenZhengMessage
{
    
}
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
        
        [self.xinXiButton setTitle:str forState:UIControlStateNormal];
        [self.xinXiButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];

    }
    else
    {
        [self.fuWuXiangMuButton setTitle:str forState:UIControlStateNormal];
        [self.fuWuXiangMuButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];

    }
}

// 视频转换为MP4
- (NSURL *)convertToMp4:(NSURL *)movUrl
{
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        NSString *mp4Path = [NSString stringWithFormat:@"%@/%d%d.mp4", [self dataPath], (int)[[NSDate date] timeIntervalSince1970], arc4random() % 100000];
        mp4Url = [NSURL fileURLWithPath:mp4Path];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    return mp4Url;
}

@end
