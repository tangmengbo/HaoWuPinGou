//
//  QiDongViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/22.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "QiDongViewController.h"
#import "ZYNetworkAccessibility.h"


@interface QiDongViewController ()
{
    int timeNumber;
    BOOL alsoShowAlert;
}
@property (nonatomic, strong)AVPlayer *player;
@property (nonatomic,strong)AVPlayerLayer *layer;

@property(nonatomic,strong)UIImageView * bottomImageView;

@property(nonatomic,strong)UIButton * daojiShiButton;
@property(nonatomic,strong,nullable)NSTimer * timer;

@property(nonatomic,strong)NSArray * qiDongSourceArray;

@end

@implementation QiDongViewController


-(void)getNetWorkStatus
{
    [ZYNetworkAccessibility setStateDidUpdateNotifier:^(ZYNetworkAccessibleState state) {
        NSLog(@"setStateDidUpdateNotifier > %zd", state);
        
        if (ZYNetworkRestricted == state) {//没有网络权限
            
            if(!self->alsoShowAlert)
            {
                self->alsoShowAlert = YES;
                
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"网络连接失败" message:@"检测到网络权限可能未开启，您可以在“设置”中检查蜂窝移动网络" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        self->alsoShowAlert = NO;
                    }]];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        self->alsoShowAlert = NO;

                        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
                            [[UIApplication sharedApplication] openURL:settingsURL];
                            
                        }
                    }]];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil] ;

            }
            
        }
        if (state == ZYNetworkAccessible) {//网络可用
            
            [ZYNetworkAccessibility stop];

            [HTTPModel getAppJinBiList:nil callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
               
                if (status==1) {
                    
                    NSDictionary * info = [NormalUse removeNullFromDictionary:responseObject];
                    [NormalUse defaultsSetObject:info forKey:JinBiShuoMing];
                }
            }];

            //未登录用户先 获取初始化账号
            [HTTPModel registerInit:[[NSDictionary alloc]initWithObjectsAndKeys:[NormalUse getSheBeiBianMa],@"phone_ucode", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                
                if (status==1) {
                    
                    if ([NormalUse isValidDictionary:[responseObject objectForKey:@"info"]]) {
                        
                        NSDictionary * userInfo = [responseObject objectForKey:@"info"];
                        [NormalUse defaultsSetObject:[userInfo objectForKey:@"ryuser"] forKey:UserRongYunInfo];
                        [[RongYManager getInstance] connectRongCloud];

                    }

                    //获取初始化账号 成功后调用登录 获取到logintoken
                    [HTTPModel login:[[NSDictionary alloc]initWithObjectsAndKeys:[NormalUse getSheBeiBianMa],@"phone_ucode", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                        
                        if (status==1) {
                            
                            [self timeFinish];

                            NSString *  logintoken = [responseObject objectForKey:@"logintoken"];
                            [NormalUse defaultsSetObject:logintoken forKey:LoginToken];

                        }
                    }];
                }
            }];
            
        }
    }];
    
    [ZYNetworkAccessibility start];

}

-(void)playVideo
{
//    NSString *string = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"mp4"];
//    NSURL *videoUrl = [NSURL fileURLWithPath:string];
//    // 创建AVPlayerItem
//    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:videoUrl];
//    //2.把AVPlayerItem放在AVPlayer上
//    self.avPlayer = [[AVPlayer alloc] initWithPlayerItem:playerItem];
//    //3 再把AVPlayer放到 AVPlayerLayer上
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
//    [self.view.layer addSublayer:playerLayer];
//    playerLayer.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.width);

    NSString * path = [[NSBundle mainBundle] pathForResource:@"qiDongVideo" ofType:@"mp4"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    //[NSURL URLWithString:@"http://129.28.198.178:8090/upload/62d04dc395912080/df6c14114db9ef32.mp4"]
    // 2.创建AVPlayerItem
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    // 3.创建AVPlayer
    self.player = [AVPlayer playerWithPlayerItem:item];
    
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];

    // 4.添加AVPlayerLayer
    self.layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    //设置视频大小和AVPlayerLayer的frame一样大(全屏播放)
    self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.layer];
    
    [self.player play];


}
-(void)playbackFinished:(NSNotification *)notification
{
    NSLog(@"视频播放完成.");
    
    [self.player pause];
    [self.layer removeFromSuperlayer];
    self.layer=nil;
    self.player = nil;
    
    if ([NormalUse isValidArray:self.qiDongSourceArray]) {
        
        NSDictionary * info = [self.qiDongSourceArray objectAtIndex:0];

        NSNumber * limit_sec = [info objectForKey:@"limit_sec"];
        self->timeNumber = limit_sec.intValue;
        
        
        self.daojiShiButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_PingMu-90, TopHeight_PingMu+10, 80, 30)];
        self.daojiShiButton.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        self.daojiShiButton.layer.cornerRadius = 15;
        self.daojiShiButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.daojiShiButton setTitle:[NSString stringWithFormat:@"跳过(%d)",self->timeNumber] forState:UIControlStateNormal];
        [self.daojiShiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.daojiShiButton addTarget:self action:@selector(tiaoGuo) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.daojiShiButton];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRecord) userInfo:nil repeats:YES];
        
        
    }
    else
    {
        
        [self timeFinish];
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.topNavView.hidden = YES;
    self.statusBarView.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
    self.bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
//    self.bottomImageView.image = [UIImage imageNamed:@"flash"];
    self.bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bottomImageView.autoresizingMask = UIViewAutoresizingNone;
    self.bottomImageView.clipsToBounds = YES;
    [self.view addSubview:self.bottomImageView];
    
    [HTTPModel getBannerList:[[NSDictionary alloc]initWithObjectsAndKeys:@"0",@"type_id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        if (status==1) {
            
            NSArray * array = responseObject;
            if ([NormalUse isValidArray:array])
            {
                self.qiDongSourceArray = array;
                
                if ([NormalUse isValidArray:self.qiDongSourceArray]) {
                    
                    NSDictionary * info = [self.qiDongSourceArray objectAtIndex:0];
                    NSString * imagePath = [NSString stringWithFormat:@"%@%@",HTTP_REQUESTURL,[info objectForKey:@"picture"]];
                    [self.bottomImageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
                }
                
            }
            else
            {
                
                [self timeFinish];
                
            }
            
        }
        else
        {
            //用户首次安装没有网络权限
            if ([msg isEqualToString:NET_ERROR_MSG] && ![NormalUse isValidString:[NormalUse defaultsGetObjectKey:LoginToken]]) {
                
                [self getNetWorkStatus];
                    
            }
            else
            {
                
                [self timeFinish];
                
            }
        }
    }];
    [self playVideo];

    
}
-(void)timerRecord
{
    timeNumber = timeNumber-1;
    if (timeNumber==0) {
        
        [self.timer invalidate];
        self.timer = nil;
        [self timeFinish];
    }
    [self.daojiShiButton setTitle:[NSString stringWithFormat:@"跳过(%d)",timeNumber] forState:UIControlStateNormal];

}
-(void)tiaoGuo
{
    [self.timer invalidate];
    self.timer = nil;
    [self timeFinish];
}
-(void)timeFinish
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate setYiDengLuTabBar];

}

@end
