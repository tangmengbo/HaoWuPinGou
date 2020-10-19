//
//  CreateTieZiKouFeiViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "CreateTieZiKouFeiViewController.h"
#import "ZhangHuDetailViewController.h"
#import "RAFileManager.h"


@interface CreateTieZiKouFeiViewController ()

@property(nonatomic,strong)NSString * publish_post_coin;//发帖所需金币
@property(nonatomic,strong)NSString * yuEStr;
@property(nonatomic,strong)UILabel * tiJiaoLable;

@end

@implementation CreateTieZiKouFeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingFullScreen = @"yes";

    self.topTitleLale.text = @"支付";
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height+10*BiLiWidth, WIDTH_PingMu, 12*BiLiWidth)];
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.textColor = RGBFormUIColor(0x999999);
    [self.view addSubview:tipLable];
    
    NSString * token = [NormalUse defaultsGetObjectKey:LoginToken];
    NSString * defaultsKey = [UserRole stringByAppendingString:token];
    NSDictionary * userRoleDic = [NormalUse defaultsGetObjectKey:defaultsKey];
    NSNumber * auth_nomal = [userRoleDic objectForKey:@"auth_nomal"];
    if (auth_nomal.intValue!=1) {
        
        tipLable.text = @"您当前是未认证用户，发布帖子需要支付相应费用";

    }
    
    self.publish_post_coin = [NormalUse getJinBiStr:@"publish_post_coin"];
    
    UILabel * jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, tipLable.top+tipLable.height+54*BiLiWidth, WIDTH_PingMu, 21*BiLiWidth)];
    jinBiLable.font = [UIFont systemFontOfSize:16*BiLiWidth];
    jinBiLable.textColor = RGBFormUIColor(0x333333);
    jinBiLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:jinBiLable];
    
    NSString * renZhengStr = [NSString stringWithFormat:@"%@金币",self.publish_post_coin];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:renZhengStr];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:21*BiLiWidth] range:NSMakeRange(0, self.publish_post_coin.length)];
    jinBiLable.attributedText = str;

    
    UILabel * yuELable = [[UILabel alloc] initWithFrame:CGRectMake(0, jinBiLable.top+jinBiLable.height+16*BiLiWidth, WIDTH_PingMu, 14*BiLiWidth)];
    yuELable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*BiLiWidth];
    yuELable.textColor = RGBFormUIColor(0xFECF61);
    yuELable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:yuELable];
    
    
    [HTTPModel getUserInfo:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        if (status==1) {
            

            NSNumber * coin = [responseObject objectForKey:@"coin"];
            self.yuEStr = [NSString stringWithFormat:@"%d",coin.intValue];
            NSString * yuEStr = [NSString stringWithFormat:@"当前可用金币：%d",coin.intValue];
            NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:yuEStr];
            [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x333333) range:NSMakeRange(0, 7)];
            yuELable.attributedText = str;
            
            if (self.publish_post_coin.intValue<=self.yuEStr.intValue) {
                
                self.tiJiaoLable.text = @"立即支付";

            }
            else
            {
                self.tiJiaoLable.text = @"充值";

            }

        }

    }];
    
    UIButton * nextButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, yuELable.top+yuELable.height+69*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = nextButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [nextButton.layer addSublayer:gradientLayer1];
    
    self.tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, nextButton.width, nextButton.height)];
    self.tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    self.tiJiaoLable.textColor = [UIColor whiteColor];
    [nextButton addSubview:self.tiJiaoLable];

    
    if (auth_nomal.intValue!=1) {
        
        UILabel * tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(50*BiLiWidth, nextButton.top+nextButton.height+15*BiLiWidth, WIDTH_PingMu-50*BiLiWidth*2, 30*BiLiWidth)];
        tipsLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
        tipsLable.textColor = RGBFormUIColor(0xFF002A);
        tipsLable.numberOfLines = 2;
        tipsLable.userInteractionEnabled = YES;
        [self.view addSubview:tipsLable];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quRenZheng)];
        [tipsLable addGestureRecognizer:tap];

        
        NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc] initWithString:@"*注：未认证用户发布帖子不会显示【官方认证】标识，若您想获得标识请先进行认证。去认证"];
        [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(str1.length-3, 3)];
        tipsLable.attributedText = str1;

    }



}
-(void)nextButtonClick
{
    if (self.publish_post_coin.intValue<=self.yuEStr.intValue) {
        
        [self xianShiLoadingView:@"提交中..." view:self.view];
        
        uploadVideoIndex = 0;
        self.videoPathId = nil;
        self.videoShouZhenPathId = nil;
        
        [self.videoPathArray removeAllObjects];
        [self.videoShouZhenImagePathArray removeAllObjects];
        
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
//        ZhangHuDetailViewController * vc = [[ZhangHuDetailViewController alloc] init];
//        vc.yuEStr = self.yuEStr;
//        [self.navigationController pushViewController:vc animated:YES];

        JinChanWebViewController * vc = [[JinChanWebViewController alloc] init];
        vc.forWhat = @"mall";
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
                [dicInfo setObject:self.message_type forKey:@"message_type"];
                [dicInfo setObject:self.titleStr forKey:@"title"];
                [dicInfo setObject:self.city_code forKey:@"city_code"];
                [dicInfo setObject:self.age forKey:@"age"];
                [dicInfo setObject:self.nums forKey:@"nums"];
                [dicInfo setObject:self.min_price forKey:@"min_price"];
                [dicInfo setObject:self.max_price forKey:@"max_price"];
                [dicInfo setObject:self.service_type forKey:@"service_type"];
                [dicInfo setObject:[NormalUse getobjectForKey:self.mobile] forKey:@"mobile"];
                [dicInfo setObject:[NormalUse getobjectForKey:self.qq] forKey:@"qq"];
                [dicInfo setObject:[NormalUse getobjectForKey:self.wechat] forKey:@"wechat"];
                [dicInfo setObject:self.face_value forKey:@"face_value"];
                [dicInfo setObject:self.skill_value forKey:@"skill_value"];
                [dicInfo setObject:self.ambience_value forKey:@"ambience_value"];
                [dicInfo setObject:[NormalUse getobjectForKey:self.videoPathId] forKey:@"videos"];
                [dicInfo setObject:[NormalUse getobjectForKey:self.videoShouZhenPathId] forKey:@"v_first_frames"];
                [dicInfo setObject:self.imagePathId forKey:@"images"];
                [dicInfo setObject:self.decription forKey:@"decription"];
                [dicInfo setObject:self.from_flg forKey:@"from_flg"];
                
                [HTTPModel faBuTieZi:dicInfo callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                   
                    if (status==1) {
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
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
-(void)quRenZheng
{
    JingJiRenRenZhengStep1VC * vc = [[JingJiRenRenZhengStep1VC alloc] init];
    vc.renZhengType = @"1";
    [self.navigationController pushViewController:vc animated:YES];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
