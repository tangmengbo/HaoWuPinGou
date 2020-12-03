//
//  TuiGuangZhuanQianViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "TuiGuangZhuanQianViewController.h"

@interface TuiGuangZhuanQianViewController ()

@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)UIImage * screenImage;

@end

@implementation TuiGuangZhuanQianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.mainScrollView];
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10*BiLiWidth, WIDTH_PingMu, WIDTH_PingMu*1839/1172)];
    bottomImageView.image = [UIImage imageNamed:@"tuiGuang_bg"];
    [self.mainScrollView addSubview:bottomImageView];
    
    self.statusBarView.backgroundColor = [UIColor blackColor];
    [self.view bringSubviewToFront:self.topNavView];
    self.topNavView.backgroundColor = [UIColor clearColor];
    self.backImageView.frame = CGRectMake(self.backImageView.left, (self.topNavView.height-16*BiLiWidth)/2, 9*BiLiWidth, 16*BiLiWidth);
    self.backImageView.image = [UIImage imageNamed:@"white_back"];

    
    UIImageView * titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-219*BiLiWidth)/2, 150*BiLiWidth, 219*BiLiWidth, 39*BiLiWidth)];
    //titleImageView.image = [UIImage imageNamed:@"tuiGuang_wenZiTip"];
    [self.mainScrollView addSubview:titleImageView];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(48*BiLiWidth, titleImageView.top+titleImageView.height-30*BiLiWidth, WIDTH_PingMu-48*BiLiWidth*2, 30*BiLiWidth)];
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    tipLable.numberOfLines = 2;
    tipLable.textColor = [UIColor whiteColor];
    tipLable.text = [NSString stringWithFormat:@"每成功邀请1名用户注册，获得%@金币，同时邀请的用户消费金币时您可获得高额抽成",[NormalUse getJinBiStr:@"share_coin"]] ;
    [self.mainScrollView addSubview:tipLable];
    
    UIImageView * erWeiMaImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-103*BiLiWidth)/2, tipLable.top+tipLable.height+26*BiLiWidth, 103*BiLiWidth, 103*BiLiWidth)];
    erWeiMaImageView.image = [NormalUse shengChengErWeiMa:[NSString stringWithFormat:@"%@?share_code=%@",[NormalUse defaultsGetObjectKey:@"ios_pkg"],self.share_code]];
    [self.mainScrollView addSubview:erWeiMaImageView];
    
    UILabel * tuiGuangMaLable = [[UILabel alloc] initWithFrame:CGRectMake(0, erWeiMaImageView.top+erWeiMaImageView.height+28*BiLiWidth, WIDTH_PingMu, 15*BiLiWidth)];
    tuiGuangMaLable.textAlignment = NSTextAlignmentCenter;
    tuiGuangMaLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tuiGuangMaLable.textColor = RGBFormUIColor(0xFF2474);
    [self.mainScrollView addSubview:tuiGuangMaLable];

    
    NSString * renZhengStr = [NSString stringWithFormat:@"您的推广码 %@",self.share_code];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:renZhengStr];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0xFFFFFF) range:NSMakeRange(0, 5)];
    tuiGuangMaLable.attributedText = str;

    
    UIButton * fuZhiLianJieButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-123*BiLiWidth*2-21*BiLiWidth)/2, tuiGuangMaLable.top+tuiGuangMaLable.height+50*BiLiWidth, 123*BiLiWidth, 40*BiLiWidth)];
    [fuZhiLianJieButton addTarget:self action:@selector(fuZhiLianJieButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:fuZhiLianJieButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = fuZhiLianJieButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [fuZhiLianJieButton.layer addSublayer:gradientLayer1];
    
    UILabel * fuZhiLianJieLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, fuZhiLianJieButton.width, fuZhiLianJieButton.height)];
    fuZhiLianJieLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    fuZhiLianJieLable.text = @"复制链接";
    fuZhiLianJieLable.textAlignment = NSTextAlignmentCenter;
    fuZhiLianJieLable.textColor = [UIColor whiteColor];
    [fuZhiLianJieButton addSubview:fuZhiLianJieLable];
    
    
    UIButton * baoCunTuPianButton = [[UIButton alloc] initWithFrame:CGRectMake(fuZhiLianJieButton.left+fuZhiLianJieButton.width+20*BiLiWidth, tuiGuangMaLable.top+tuiGuangMaLable.height+50*BiLiWidth, 123*BiLiWidth, 40*BiLiWidth)];
    [baoCunTuPianButton addTarget:self action:@selector(baoCunTuPianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:baoCunTuPianButton];
    //渐变设置
    gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = baoCunTuPianButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [baoCunTuPianButton.layer addSublayer:gradientLayer1];
    
    UILabel * baoCunTuPianLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, baoCunTuPianButton.width, baoCunTuPianButton.height)];
    baoCunTuPianLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    baoCunTuPianLable.text = @"保存图片";
    baoCunTuPianLable.textAlignment = NSTextAlignmentCenter;
    baoCunTuPianLable.textColor = [UIColor whiteColor];
    [baoCunTuPianButton addSubview:baoCunTuPianLable];

    UILabel * tuiGuangXuZhi = [[UILabel alloc] initWithFrame:CGRectMake(33*BiLiWidth, baoCunTuPianButton.top+baoCunTuPianButton.height+75*BiLiWidth, 200*BiLiWidth, 14*BiLiWidth)];
    tuiGuangXuZhi.font = [UIFont systemFontOfSize:14*BiLiWidth];
    tuiGuangXuZhi.textColor = [UIColor whiteColor];
    tuiGuangXuZhi.text = @"推广须知";
    [self.mainScrollView addSubview:tuiGuangXuZhi];
    
    UILabel * tipMessageLable = [[UILabel alloc] initWithFrame:CGRectMake(33*BiLiWidth, tuiGuangXuZhi.top+tuiGuangXuZhi.height+15*BiLiWidth, WIDTH_PingMu-66*BiLiWidth, 13*BiLiWidth)];
    tipMessageLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    tipMessageLable.textColor = RGBFormUIColor(0xFFFFFF);
    tipMessageLable.numberOfLines = 0;
    [self.mainScrollView addSubview:tipMessageLable];
    
    NSString * neiRongStr = @"1、发送推广链接给其他新用户，用户第一次安装并打开app后才算邀请成功，或者被邀请的用户也可以在个人中心中输入您的推广码。\n2、注意，请勿使用微信或者QQ等第三方内置浏览器打开，因为包含色情内容会导致被屏蔽，推荐使用手机自带浏览器打开";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    tipMessageLable.attributedText = attributedString;
    [tipMessageLable  sizeToFit];

    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, tipMessageLable.top+tipMessageLable.height+20*BiLiWidth)];
    
    

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.screenImage = [NormalUse imageWithScreenshot];

}
-(void)fuZhiLianJieButtonClick
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NormalUse defaultsGetObjectKey:@"ios_pkg"];
    
    [NormalUse showToastView:@"链接已复制" view:self.view];
}

-(void)baoCunTuPianButtonClick
{
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
        
        [NormalUse showToastView:@"因为系统原因, 无法访问相册" view:self.view];
    } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册(用户当初点击了"不允许")
       NSLog(@"提醒用户去[设置-隐私-照片-xxx]打开访问开关");
    } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册(用户当初点击了"好")
        [self saveImage];
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                [self saveImage];
            }
        }];
    }

}

-(void)saveImage
{
    // PHAsset : 一个资源, 比如一张图片\一段视频
    // PHAssetCollection : 一个相簿
    
    // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetLocalIdentifier = nil;
    
    // 如果想对"相册"进行修改(增删改), 那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.保存图片A到"相机胶卷"中
        // 创建图片的请求
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.screenImage].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {

            dispatch_async(dispatch_get_main_queue(), ^{
                
                [NormalUse showToastView:@"保存图片失败!" view:self.view];

            });
            return;
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [NormalUse showToastView:@"保存图片成功" view:self.view];

            });
        }
        
        
    }];
    
}
@end
