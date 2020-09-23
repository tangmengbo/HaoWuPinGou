//
//  CreateDianPuViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/16.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "EditDianPuViewController.h"

@interface EditDianPuViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * mainScrollView;

@end

@implementation EditDianPuViewController

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self viewTap];
}
-(void)viewTap
{
    [self.dianPuNameTF resignFirstResponder];
//    [self.telTF resignFirstResponder];
//    [self.qqTF resignFirstResponder];
//    [self.weiXinTF resignFirstResponder];
    [self.lianXiFangShiTF resignFirstResponder];

    [self.jianJieTextView resignFirstResponder];
    
    [self.peiFuMoneyTF resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self yinCangTabbar];
    
    self.topTitleLale.text = @"设置店铺信息";
    
    maxImageSelected = 1;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.mainScrollView addGestureRecognizer:tap];
    
    
    UILabel * dianPuTouXiangLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, 10*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    dianPuTouXiangLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    dianPuTouXiangLable.textColor = RGBFormUIColor(0x333333);
    dianPuTouXiangLable.text = @"店铺头像";
    [self.mainScrollView addSubview:dianPuTouXiangLable];
    
    self.photoArray = [NSMutableArray array];

    self.photoContentView = [[UIView alloc] initWithFrame:CGRectMake(15*BiLiWidth, dianPuTouXiangLable.frame.origin.y+dianPuTouXiangLable.frame.size.height+20*BiLiWidth, WIDTH_PingMu-30*BiLiWidth, 72*BiLiWidth)];
    [self.mainScrollView addSubview:self.photoContentView];
    
    [self initphotoContentView];
    
    UILabel * biaoTiXinXiLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, self.photoContentView.top+self.photoContentView.height+10*BiLiWidth, 100*BiLiWidth, 39.5*BiLiWidth)];
    biaoTiXinXiLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    biaoTiXinXiLable.textColor = RGBFormUIColor(0x333333);
    biaoTiXinXiLable.text = @"店铺名称";
    [self.mainScrollView addSubview:biaoTiXinXiLable];

    self.dianPuNameTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, biaoTiXinXiLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    self.dianPuNameTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NormalUse setTextFieldPlaceholder:@"填写信息标题" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.dianPuNameTF];
    self.dianPuNameTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.dianPuNameTF.textColor = RGBFormUIColor(0x343434);
    self.dianPuNameTF.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:self.dianPuNameTF];

    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, biaoTiXinXiLable.top+biaoTiXinXiLable.height, 270*BiLiWidth, 1)];
    lineView1.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView1];

    
    UILabel * diquLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView1.top+lineView1.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    diquLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    diquLable.textColor = RGBFormUIColor(0x333333);
    diquLable.text = @"服务地区";
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
    
    UILabel * lianXiFangShiLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView2.top+lineView2.height, 100*BiLiWidth, 39.5*BiLiWidth)];
    lianXiFangShiLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    lianXiFangShiLable.textColor = RGBFormUIColor(0x343434);
    lianXiFangShiLable.text = @"联系方式";
    [self.mainScrollView addSubview:lianXiFangShiLable];

    self.lianXiFangShiTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, lianXiFangShiLable.top, 100*BiLiWidth, 39.5*BiLiWidth)];
    [NormalUse setTextFieldPlaceholder:@"填写联系方式" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.lianXiFangShiTF];
    self.lianXiFangShiTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
    self.lianXiFangShiTF.textColor = RGBFormUIColor(0x343434);
    self.lianXiFangShiTF.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:self.lianXiFangShiTF];

    UIView * lineView4 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, lianXiFangShiLable.top+lianXiFangShiLable.height, 270*BiLiWidth, 1)];
    lineView4.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [self.mainScrollView addSubview:lineView4];


//    UILabel * lianXiFangShiLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView2.top+lineView2.height+13*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
//    lianXiFangShiLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
//    lianXiFangShiLable.textColor = RGBFormUIColor(0x333333);
//    lianXiFangShiLable.text = @"联系方式";
//    [self.mainScrollView addSubview:lianXiFangShiLable];
//
//    UILabel * lianXiFangShiTipLable = [[UILabel alloc] initWithFrame:CGRectMake(lianXiFangShiLable.left, lianXiFangShiLable.top+lianXiFangShiLable.height+10*BiLiWidth, 63*BiLiWidth, 25*BiLiWidth)];
//    lianXiFangShiTipLable.font = [UIFont systemFontOfSize:10*BiLiWidth];
//    lianXiFangShiTipLable.textColor = RGBFormUIColor(0xDEDEDE);
//    lianXiFangShiTipLable.numberOfLines = 2;
//    lianXiFangShiTipLable.text = @"(填写一种联系方式即可）";
//    [self.mainScrollView addSubview:lianXiFangShiTipLable];
//
//
//    self.weiXinTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, lineView2.top+lineView2.height, 100*BiLiWidth, 39.5*BiLiWidth)];
//    self.weiXinTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
//    [NormalUse setTextFieldPlaceholder:@"请填写微信号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.weiXinTF];
//    self.weiXinTF.textAlignment = NSTextAlignmentRight;
//    self.weiXinTF.textColor  = RGBFormUIColor(0x343434);
//    [self.mainScrollView addSubview:self.weiXinTF];
//
//    UIView * lineView6 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, lineView2.top+lineView2.height+39.5*BiLiWidth, 270*BiLiWidth, 1)];
//    lineView6.backgroundColor = RGBFormUIColor(0xEEEEEE);
//    [self.mainScrollView addSubview:lineView6];
//
//    self.qqTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, lineView6.top+lineView6.height, 100*BiLiWidth, 39.5*BiLiWidth)];
//    self.qqTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
//    [NormalUse setTextFieldPlaceholder:@"请填写QQ号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.qqTF];
//    self.qqTF.textColor  = RGBFormUIColor(0x343434);
//    self.qqTF.textAlignment = NSTextAlignmentRight;
//    self.qqTF.keyboardType = UIKeyboardTypeNumberPad;
//    [self.mainScrollView addSubview:self.qqTF];
//
//    UIView * lineView7 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, lineView6.top+lineView6.height+39.5*BiLiWidth, 270*BiLiWidth, 1)];
//    lineView7.backgroundColor = RGBFormUIColor(0xEEEEEE);
//    [self.mainScrollView addSubview:lineView7];
//
//
//    self.telTF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_PingMu-113.5*BiLiWidth, lineView7.top+lineView7.height, 100*BiLiWidth, 39.5*BiLiWidth)];
//    self.telTF.font = [UIFont systemFontOfSize:13*BiLiWidth];
//    [NormalUse setTextFieldPlaceholder:@"请填写手机号" placeHoldColor:RGBFormUIColor(0xDEDEDE) textField:self.telTF];
//    self.telTF.textAlignment = NSTextAlignmentRight;
//    self.telTF.textColor  = RGBFormUIColor(0x343434);
//    self.telTF.keyboardType = UIKeyboardTypeNumberPad;
//    [self.mainScrollView addSubview:self.telTF];
//
//    UIView * lineView8 = [[UIView alloc] initWithFrame:CGRectMake(77.5*BiLiWidth, lineView7.top+lineView7.height+39.5*BiLiWidth, 270*BiLiWidth, 1)];
//    lineView8.backgroundColor = RGBFormUIColor(0xEEEEEE);
//    [self.mainScrollView addSubview:lineView8];
    
    UILabel * jianJieLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, lineView4.top+lineView4.height+33*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    jianJieLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    jianJieLable.textColor = RGBFormUIColor(0x333333);
    jianJieLable.text = @"店铺简介";
    [self.mainScrollView addSubview:jianJieLable];
    
    
    self.jianJieTextView = [[UITextView alloc] initWithFrame:CGRectMake(12*BiLiWidth,jianJieLable.top+jianJieLable.height+13*BiLiWidth, WIDTH_PingMu-24*BiLiWidth, 130*BiLiWidth-30*BiLiWidth)];
    self.jianJieTextView.layer.borderWidth = 1;
    self.jianJieTextView.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
    self.jianJieTextView.zw_limitCount = 500;
    self.jianJieTextView.layer.cornerRadius = 4*BiLiWidth;
    self.jianJieTextView.placeholder = @"请对店铺进行详细的描述...";
    self.jianJieTextView.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.jianJieTextView.zw_inputLimitLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.jianJieTextView.zw_inputLimitLabel.backgroundColor = [UIColor clearColor];
    [self.mainScrollView addSubview:self.jianJieTextView];

    
    UILabel * dianPuBiaoShiLable = [[UILabel alloc] initWithFrame:CGRectMake(11.5*BiLiWidth, self.jianJieTextView.top+self.jianJieTextView.height+33*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    dianPuBiaoShiLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    dianPuBiaoShiLable.textColor = RGBFormUIColor(0x333333);
    dianPuBiaoShiLable.text = @"店铺简介";
    [self.mainScrollView addSubview:dianPuBiaoShiLable];
    
    self.markButton = [[Lable_ImageButton alloc] initWithFrame:CGRectMake(40*BiLiWidth, dianPuBiaoShiLable.top+dianPuBiaoShiLable.height+15*BiLiWidth,40*BiLiWidth,24*BiLiWidth)];
    [self.markButton addTarget:self action:@selector(markButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.markButton.tag = 0;
    self.markButton.button_imageView.frame = CGRectMake(0, 6*BiLiWidth, 12*BiLiWidth, 12*BiLiWidth);
    self.markButton.button_imageView.layer.cornerRadius = 6*BiLiWidth;
    self.markButton.button_imageView.layer.masksToBounds = YES;
    self.markButton.button_imageView.layer.borderWidth = 1;
    self.markButton.button_imageView.layer.borderColor = [RGBFormUIColor(0x999999) CGColor];
    self.markButton.button_imageView1.frame = CGRectMake(self.markButton.button_imageView.left+1.5*BiLiWidth, self.markButton.button_imageView.top+1.5*BiLiWidth, 9*BiLiWidth, 9*BiLiWidth);
    self.markButton.button_imageView1.layer.cornerRadius = 4.5*BiLiWidth;
    self.markButton.button_imageView1.layer.masksToBounds = YES;
    [self.mainScrollView addSubview:self.markButton];

    UILabel * peiFuLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.markButton.left+self.markButton.width, self.markButton.top, 15*BiLiWidth*5*BiLiWidth, self.markButton.height)];
    peiFuLable1.text = @"赔付保证金";
    peiFuLable1.textColor = RGBFormUIColor(0x333333);
    peiFuLable1.font = [UIFont systemFontOfSize:15*BiLiWidth];
    [self.mainScrollView addSubview:peiFuLable1];
    
    self.peiFuMoneyTF = [[UITextField alloc] initWithFrame:CGRectMake(peiFuLable1.width+peiFuLable1.left, peiFuLable1.top, 70*BiLiWidth, peiFuLable1.height)];
    self.peiFuMoneyTF.textColor = RGBFormUIColor(0x333333);
    self.peiFuMoneyTF.textAlignment = NSTextAlignmentCenter;
    self.peiFuMoneyTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.peiFuMoneyTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.mainScrollView addSubview:self.peiFuMoneyTF];
    
    UIView * peiFuLineView = [[UIView alloc] initWithFrame:CGRectMake(self.peiFuMoneyTF.left, self.peiFuMoneyTF.top+self.peiFuMoneyTF.height, self.peiFuMoneyTF.width, 1)];
    peiFuLineView.backgroundColor = RGBFormUIColor(0x343434);
    [self.mainScrollView addSubview:peiFuLineView];
    
    UILabel * peiFuLable2 = [[UILabel alloc] initWithFrame:CGRectMake(self.peiFuMoneyTF.left+self.peiFuMoneyTF.width, self.markButton.top, 15*BiLiWidth*5*BiLiWidth, self.markButton.height)];
    peiFuLable2.text = @"元";
    peiFuLable2.textColor = RGBFormUIColor(0x333333);
    peiFuLable2.font = [UIFont systemFontOfSize:15*BiLiWidth];
    [self.mainScrollView addSubview:peiFuLable2];


    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, peiFuLable1.top+peiFuLable1.height+50*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [tiJiaoButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:tiJiaoButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = tiJiaoButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [tiJiaoButton.layer addSublayer:gradientLayer1];
    
    UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tiJiaoButton.width, tiJiaoButton.height)];
    tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiJiaoLable.text = @"保存";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [tiJiaoButton addSubview:tiJiaoLable];
    
    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, tiJiaoButton.top+tiJiaoButton.height+200*BiLiWidth)];

}
#pragma mark--UIButtonClick
-(void)diQuButtonClick
{
    CityListViewController * vc = [[CityListViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark--选择城市后的代理
-(void)citySelect:(NSDictionary *)info
{
    self.cityInfo = info;
    [self.diQuButton setTitle:[info objectForKey:@"cityName"] forState:UIControlStateNormal];
    [self.diQuButton setTitleColor:RGBFormUIColor(0x343434) forState:UIControlStateNormal];
}

-(void)markButtonClick
{
    if (self.markButton.tag==0) {
        
        self.markButton.tag = 1;
        self.markButton.button_imageView.layer.borderColor = [RGBFormUIColor(0xFF0876) CGColor];
        self.markButton.button_imageView1.backgroundColor = RGBFormUIColor(0xFF0876);
        self.markButton.button_lable.textColor = RGBFormUIColor(0x333333);
        
        
    }
    else
    {
        self.markButton.tag = 0;
        self.markButton.button_imageView.layer.borderColor = [RGBFormUIColor(0x999999) CGColor];
        self.markButton.button_imageView1.backgroundColor = [UIColor clearColor];
        self.markButton.button_lable.textColor = RGBFormUIColor(0x999999);
        
    }
}
-(void)nextButtonClick
{
    if(![NormalUse isValidArray:self.photoArray])
    {
        [NormalUse showToastView:@"请设置店铺头像" view:self.view];
        return;
    }

    if (![NormalUse isValidString:self.dianPuNameTF.text]) {
        
        [NormalUse showToastView:@"请填写标题名称" view:self.view];
        return;;
    }
    if (![NormalUse isValidDictionary:self.cityInfo]) {
        
        [NormalUse showToastView:@"请选择所在区域" view:self.view];
        return;
    }
//    if(![NormalUse isValidString:self.weiXinTF.text]&&![NormalUse isValidString:self.qqTF.text]&&![NormalUse isValidString:self.telTF.text])
//    {
//        [NormalUse showToastView:@"请填写联系方式" view:self.view];
//         return;
//
//    }
    if(![NormalUse isValidString:self.lianXiFangShiTF.text])
    {
        [NormalUse showToastView:@"请填写联系方式" view:self.view];
        return;
        
    }

    if(![NormalUse isValidString:self.jianJieTextView.text])
    {
        [NormalUse showToastView:@"请填写店铺简介" view:self.view];
        return;
        
    }
    if(self.markButton.tag==1)
    {
        if (![NormalUse isValidString:self.peiFuMoneyTF.text]) {
            
            [NormalUse showToastView:@"请填赔付金额" view:self.view];
            return;

        }
        if(self.peiFuMoneyTF.text.intValue==0)
        {
            [NormalUse showToastView:@"赔付金额不能为0" view:self.view];
            return;

        }
    }
    
    uploadImageIndex = 0;
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
                [dicInfo setObject:self.imagePathId forKey:@"image"];
                [dicInfo setObject:self.dianPuNameTF.text forKey:@"name"];
                NSNumber * cityCode  = [self.cityInfo objectForKey:@"cityCode"];
                [dicInfo setObject:[NSString stringWithFormat:@"%d",cityCode.intValue] forKey:@"city_code"];
//                [dicInfo setObject:[NormalUse getobjectForKey:self.telTF.text] forKey:@"mobile"];
//                [dicInfo setObject:[NormalUse getobjectForKey:self.qqTF.text] forKey:@"qq"];
//                [dicInfo setObject:[NormalUse getobjectForKey:self.weiXinTF.text] forKey:@"wechat"];
                [dicInfo setObject:[NormalUse getobjectForKey:self.lianXiFangShiTF.text] forKey:@"contact"];
                [dicInfo setObject:self.jianJieTextView.text forKey:@"description"];
                
                if (self.markButton.tag==1) {
                    
                    [dicInfo setObject:@"1" forKey:@"is_mark"];
                    [dicInfo setObject:self.peiFuMoneyTF.text forKey:@"mark_cny"];

                }
                
                
                [HTTPModel createDianPu:dicInfo callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                    
                    if (status==1) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        [NormalUse showToastView:@"创建成功" view:[NormalUse getCurrentVC].view];
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
    

}
-(void)deleteImageButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    [self.photoArray removeObjectAtIndex:button.tag];
    [self initphotoContentView];
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
@end
