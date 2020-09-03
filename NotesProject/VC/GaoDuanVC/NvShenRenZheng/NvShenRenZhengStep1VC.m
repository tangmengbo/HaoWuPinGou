//
//  NvShenRenZhengStep1VC.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/1.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "NvShenRenZhengStep1VC.h"
#import "RAFileManager.h"

@interface NvShenRenZhengStep1VC ()<AVCaptureFileOutputRecordingDelegate>
{
    //时间长度
    float timeLength;
    //是否录制
    BOOL startOrStopRecordVideo;
    //摄像头是前置还是后置
    BOOL isFront;
    
    BOOL alsoSwitchCameraToFinishRecord;//是否是由于前后置摄像头切换导致录进入录制视频结束的回调

}

@property (nonatomic, strong) AVCaptureSession* session;
/**
 *  视频输入设备
 */
@property (nonatomic, strong) AVCaptureDeviceInput* videoInput;
/**
 *  声音输入
 */
@property (nonatomic, strong) AVCaptureDeviceInput* audioInput;
/**
 *  视频输出流
 */
@property(nonatomic,strong)AVCaptureMovieFileOutput *movieFileOutput;
/**
 *  预览图层
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;

@property(nonatomic,strong)NSURL * fileSavePath;//视频存储路径
@property(nonatomic,strong)UIImage * videoCutImage;//首贞图


@property (nonatomic, strong)NSTimer* timer;
@property (nonatomic,strong)UILabel * timeLable;


@property(nonatomic,strong)UIView * jinDuBottomView;
@property(nonatomic,strong)UIView * jinDuView;

@property(nonatomic,strong)UIButton * beginAndStopRecordButton;



@end

@implementation NvShenRenZhengStep1VC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self startSession];
    if ([NormalUse isValidString:self.luZhiVideoPathId]) {
        
        self.tiJiaoButton.enabled = YES;
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    [self stopSession];
    
    [self.timer invalidate];
    self.timer = nil;
}
- (void)startSession{
    
    if (![self.session isRunning]) {
        
        [self.session startRunning];
    }
}

- (void)stopSession{
    
    if ([self.session isRunning]) {
        
        [self.session stopRunning];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"认证";
    self.loadingFullScreen = @"yes";
    [self yinCangTabbar];
    
    [self initTopStepView];
    
}
-(void)initTopStepView
{
    float distance = (WIDTH_PingMu-37*BiLiWidth*2-22*BiLiWidth*4)/3;
    
    UIButton * step1BottomView = [[UIButton alloc] initWithFrame:CGRectMake(37*BiLiWidth, self.topNavView.top+self.topNavView.height+10*BiLiWidth, 22*BiLiWidth, 22*BiLiWidth)];
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.cornerRadius = 11*BiLiWidth;
    gradientLayer.frame = step1BottomView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    [step1BottomView.layer addSublayer:gradientLayer];
    [self.view addSubview:step1BottomView];
    
    UILabel * step1Lable = [[UILabel alloc] initWithFrame:step1BottomView.frame];
    step1Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step1Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step1Lable.textAlignment = NSTextAlignmentCenter;
    step1Lable.text = @"1";
    [self.view addSubview:step1Lable];
    
    UILabel * step1TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step1BottomView.left-30*BiLiWidth,step1BottomView.top+step1BottomView.height+8.5*BiLiWidth , step1BottomView.width+60*BiLiWidth, 12*BiLiWidth)];
    step1TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step1TipLable.textColor = RGBFormUIColor(0x343434);
    step1TipLable.text = @"录制认证视频";
    step1TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step1TipLable];
    
    UILabel * step2Lable = [[UILabel alloc] initWithFrame:CGRectMake(step1Lable.left+step1Lable.width+distance, step1Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step2Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step2Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step2Lable.textAlignment = NSTextAlignmentCenter;
    step2Lable.layer.cornerRadius = 11*BiLiWidth;
    step2Lable.layer.masksToBounds = YES;
    step2Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step2Lable.text = @"2";
    [self.view addSubview:step2Lable];
    
    UILabel * step2TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step2Lable.left-30*BiLiWidth,step2Lable.top+step2Lable.height+8.5*BiLiWidth , step2Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step2TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step2TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step2TipLable.text = @"填写个人资料";
    step2TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step2TipLable];
    
    
    UILabel * step3Lable = [[UILabel alloc] initWithFrame:CGRectMake(step2Lable.left+step2Lable.width+distance, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step3Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step3Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step3Lable.textAlignment = NSTextAlignmentCenter;
    step3Lable.layer.cornerRadius = 11*BiLiWidth;
    step3Lable.layer.masksToBounds = YES;
    step3Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step3Lable.text = @"3";
    [self.view addSubview:step3Lable];
    
    UILabel * step3TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step3Lable.left-30*BiLiWidth,step3Lable.top+step3Lable.height+8.5*BiLiWidth , step3Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step3TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step3TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step3TipLable.text = @"缴纳押金";
    step3TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step3TipLable];
    
    UILabel * step4Lable = [[UILabel alloc] initWithFrame:CGRectMake(step3Lable.left+step3Lable.width+distance, step2Lable.top, 22*BiLiWidth, 22*BiLiWidth)];
    step4Lable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    step4Lable.textColor = RGBFormUIColor(0xFFFFFF);
    step4Lable.textAlignment = NSTextAlignmentCenter;
    step4Lable.layer.cornerRadius = 11*BiLiWidth;
    step4Lable.layer.masksToBounds = YES;
    step4Lable.backgroundColor = RGBFormUIColor(0xDEDEDE);
    step4Lable.text = @"4";
    [self.view addSubview:step4Lable];
    
    UILabel * step4TipLable = [[UILabel alloc] initWithFrame:CGRectMake(step4Lable.left-30*BiLiWidth,step4Lable.top+step4Lable.height+8.5*BiLiWidth , step3Lable.width+60*BiLiWidth, 12*BiLiWidth)];
    step4TipLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    step4TipLable.textColor = RGBFormUIColor(0xDEDEDE);
    step4TipLable.text = @"等待审核";
    step4TipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:step4TipLable];

    [self initAVCaptureSession:step4TipLable];
    
    self.jinDuBottomView = [[UIView alloc] initWithFrame:CGRectMake(26*BiLiWidth, self.previewLayer.frame.origin.y+self.previewLayer.frame.size.height+17*BiLiWidth, WIDTH_PingMu-52*BiLiWidth, 3*BiLiWidth)];
    self.jinDuBottomView.backgroundColor = RGBFormUIColor(0xC0C0C0);
    [self.view addSubview:self.jinDuBottomView];
    
    self.jinDuView = [[UIView alloc] initWithFrame:CGRectMake(26*BiLiWidth, self.previewLayer.frame.origin.y+self.previewLayer.frame.size.height+17*BiLiWidth, 0, 3*BiLiWidth)];
    self.jinDuView.backgroundColor = RGBFormUIColor(0xFF2A74);
    [self.view addSubview:self.jinDuView];
    
    self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_PingMu-127*BiLiWidth, self.jinDuView.top+self.jinDuView.height+7.5*BiLiWidth, 100*BiLiWidth, 12*BiLiWidth)];
    self.timeLable.textColor = RGBFormUIColor(0x343434);
    self.timeLable.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.timeLable.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.timeLable];

    self.beginAndStopRecordButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-25*BiLiWidth)/2,self.jinDuBottomView.top+self.jinDuBottomView.height+20*BiLiWidth, 25*BiLiWidth, 27*BiLiWidth)];
    self.beginAndStopRecordButton.tag = 0;
    [self.beginAndStopRecordButton setBackgroundImage:[UIImage imageNamed:@"kaiShi_luZhi"] forState:UIControlStateNormal];    [self.beginAndStopRecordButton addTarget:self action:@selector(beginAndRecord:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.beginAndStopRecordButton];
    
    self.tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, self.beginAndStopRecordButton.top+self.beginAndStopRecordButton.height+20*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [self.tiJiaoButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tiJiaoButton];
    //渐变设置
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
    
    self.tiJiaoButton.enabled = NO;


    
}
-(void)boFang:(NSURL *)url
{
    
    // 2.创建AVPlayerItem
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    
    // 3.创建AVPlayer
    self.player = [AVPlayer playerWithPlayerItem:item];
    
    // 4.添加AVPlayerLayer
    self.layer = [AVPlayerLayer playerLayerWithPlayer:self.player];

    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu/4, HEIGHT_PingMu/4)];
    [self.view addSubview:self.containerView];


    self.layer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:self.layer];

    [self.player play];
    
    
}
#pragma mark--UIButtonClick

-(void)nextButtonClick
{
    [self xianShiLoadingView:@"上传中..." view:self.view];
    
     // mov格式转mp4
    // NSURL *mp4 = [self convertToMp4:self.fileSavePath];

    
    [self yaSuoAndUploadVideo:self.fileSavePath];
    
    
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
                [self uploadVideo:self.fileSavePath];
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
                        [NormalUse showToastView:@"视频过大请重新录制" view:self.view];
                        
                    });
                    
                }
                else
                {
                    [self uploadVideo:yaSuoUrl];
                }
            }
        }
    }];
    
    
}
-(void)uploadVideo:(NSURL *)videoUrl
{
     NSData *data = [NSData dataWithContentsOfURL:videoUrl];

    [HTTPModel uploadImageVideo:[[NSDictionary alloc] initWithObjectsAndKeys:data,@"file",@"&%&*HDSdahjd.dasiH23",@"upload_key",@"video",@"file_type", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {

        if (status==1) {
            
            [HTTPModel saveFile:[[NSDictionary alloc]initWithObjectsAndKeys:[responseObject objectForKey:@"filename"],@"filepath", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                
                [self yinCangLoadingView];
                if (status==1)
                {
                    NvShenRenZhengStep2VC * vc = [[NvShenRenZhengStep2VC alloc] init];
                    vc.renZhengType = self.renZhengType;
                    self.luZhiVideoPathId = [responseObject objectForKey:@"fileId"];
                    vc.luZhiVideoPathId = [responseObject objectForKey:@"fileId"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    [NormalUse showToastView:msg view:self.view];
                }


            }];
        }
        else
        {
            [self yinCangLoadingView];

            [NormalUse showToastView:msg view:self.view];

        }
    }];

}


#pragma mark--开始录制视频
-(void)beginAndRecord:(UIButton *)button
{
    if (button.tag==0) {
        button.tag=1;
        [self.beginAndStopRecordButton setBackgroundImage:[UIImage imageNamed:@"tingzhi_luZhi"] forState:UIControlStateNormal];
        [self startVideoRecorder];

    }
    else
    {
        [self.beginAndStopRecordButton setBackgroundImage:[UIImage imageNamed:@"kaiShi_luZhi"] forState:UIControlStateNormal];

        button.tag=0;
        [self stopVideoRecorder];

    }
}
#pragma 视频名以当前日期为名
- (NSString*)getVideoSaveFilePathString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString* nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return nowTimeStr;
}
#pragma mark 开始录制和结束录制
- (void)startVideoRecorder{
    
    AVCaptureConnection *movieConnection = [self.movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    AVCaptureVideoOrientation avcaptureOrientation = AVCaptureVideoOrientationPortrait;
    [movieConnection setVideoOrientation:avcaptureOrientation];
    [movieConnection setVideoScaleAndCropFactor:1.0];
    NSString * path = [self getVideoSaveFilePathString];
    NSURL *url = [[RAFileManager defaultManager] filePathUrlWithUrl:path];
    [self.movieFileOutput startRecordingToOutputFileURL:url recordingDelegate:self];
    [self timerFired];
    
}
- (void)timerFired{
    
    timeLength = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(timerRecord) userInfo:nil repeats:YES];
}
- (void)timerRecord{
    
    timeLength = timeLength + TIMER_INTERVAL;
    if(timeLength>=10.0)
    {
        self.timeLable.text = [NSString stringWithFormat:@"00:%.0f",timeLength];

    }
    else
    {
        self.timeLable.text = [NSString stringWithFormat:@"00:0%.0f",timeLength];

    }
    self.jinDuView.width =  timeLength*(self.jinDuBottomView.width/VIDEO_RECORDER_MAX_TIME);
    
    if (timeLength/VIDEO_RECORDER_MAX_TIME >= 1) {
        
        self.beginAndStopRecordButton.tag = 0;
        [self stopVideoRecorder];
        
        [self timerStop];
        
        self.tiJiaoButton.enabled = YES;
    }
}
- (void)stopVideoRecorder{
    
    [self.beginAndStopRecordButton setBackgroundImage:[UIImage imageNamed:@"kaiShi_luZhi"] forState:UIControlStateNormal];
    [self.movieFileOutput stopRecording];
    [self timerStop];
    
}
- (void)timerStop{
    
    if ([self.timer isValid]) {
        
        [self.timer invalidate];
        self.timer = nil;
    }
}
#pragma mark - 视频输出
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    
    __weak typeof(self) wself = self;

    if (CMTimeGetSeconds(captureOutput.recordedDuration) < VIDEO_RECORDER_MIN_TIME) {
        
        self.tiJiaoButton.enabled = NO;
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"录制时间不能小于%d秒",VIDEO_RECORDER_MIN_TIME] message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self.beginAndStopRecordButton setBackgroundImage:[UIImage imageNamed:@"kaiShi_luZhi"] forState:UIControlStateNormal];
            
        }];
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    self.tiJiaoButton.enabled = YES;
    NSLog(@"%s-- url = %@ ,recode = %f , int %lld kb", __func__, outputFileURL, CMTimeGetSeconds(captureOutput.recordedDuration), captureOutput.recordedFileSize / 1024);
    self.fileSavePath = outputFileURL;
    [self movieToImageHandler:^(UIImage *movieImage) {
        
        self.videoCutImage = movieImage;
        
    }];
    
}
//获取视频第一帧的图片
- (void)movieToImageHandler:(void (^)(UIImage *movieImage))handler {
    NSURL *url = self.fileSavePath;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = TRUE;
    CMTime thumbTime = CMTimeMakeWithSeconds(0, 60);
    generator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    AVAssetImageGeneratorCompletionHandler generatorHandler =
    ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
        if (result == AVAssetImageGeneratorSucceeded) {
            UIImage *thumbImg = [UIImage imageWithCGImage:im];
            
            
            if (handler) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(thumbImg);
                });
            }
        }
    };
    [generator generateCGImagesAsynchronouslyForTimes:
     [NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:generatorHandler];
}


#pragma mark-初始化预览图层
-(void)initAVCaptureSession:(UIView *)view
{
    self.session = [[AVCaptureSession alloc] init];
    
    //这里根据需要设置  可以设置4K
    self.session.sessionPreset = AVCaptureSessionPreset1280x720;
    
    NSError *error;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [device lockForConfiguration:nil];
    //设置闪光灯为自动
    //  [device setFlashMode:AVCaptureFlashModeAuto];
    [device unlockForConfiguration];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    self.audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio] error:nil];
    
    if (error) {
        NSLog(@"%@",error);
        
    }
    self.movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    if ([self.session canAddInput:self.videoInput]) {
        
        [self.session addInput:self.videoInput];
    }
    
    if ([self.session canAddInput:self.audioInput]) {
        
        [self.session addInput:self.audioInput];
    }
    
    if ([self.session canAddOutput:self.movieFileOutput]) {
        
        [self.session addOutput:self.movieFileOutput];
    }
    
    //初始化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = CGRectMake((WIDTH_PingMu-307*BiLiWidth)/2, view.top+view.height+20*BiLiWidth,307*BiLiWidth, 376*BiLiWidth);
    self.previewLayer.cornerRadius = 8*BiLiWidth;
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    [self switchCamera];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH_PingMu-155*BiLiWidth)/2, view.top+view.height+34*BiLiWidth, 155*BiLiWidth, 50*BiLiWidth)];
    tipLable.backgroundColor = [RGBFormUIColor(0x1A1A1A) colorWithAlphaComponent:0.3];
    tipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    tipLable.textColor = [UIColor whiteColor];
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.layer.cornerRadius = 4*BiLiWidth;
    tipLable.layer.masksToBounds = YES;
    tipLable.numberOfLines = 2;
    tipLable.text = @"请清晰读出数字\n235612";
    [self.view addSubview:tipLable];
    
    
}
- (void)switchCamera {
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = [[_videoInput device] position];
        
        if (position == AVCaptureDevicePositionBack)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
        else if (position == AVCaptureDevicePositionFront)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
        else
            return;
        
        if (newVideoInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.videoInput];
            if ([self.session canAddInput:newVideoInput]) {
                [self.session addInput:newVideoInput];
                [self setVideoInput:newVideoInput];
            } else {
                [self.session addInput:self.videoInput];
            }
            [self.session commitConfiguration];
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}
//用来返回是前置摄像头还是后置摄像头
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    
    if (AVCaptureDevicePositionFront == position) {
        
        NSLog(@"前边");
        isFront = YES;
    }
    else
    {
        isFront = NO;
    }
    //返回和视频录制相关的所有默认设备
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    //遍历这些设备返回跟position相关的设备
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}
//返回前置摄像头
- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

//返回后置摄像头
- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
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
@end
