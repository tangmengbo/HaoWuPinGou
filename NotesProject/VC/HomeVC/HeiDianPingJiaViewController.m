//
//  HeiDianPingJiaViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/16.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "HeiDianPingJiaViewController.h"

@interface HeiDianPingJiaViewController ()

@property(nonatomic,strong)UIScrollView *  mainScrollView;

@property(nonatomic,strong)NSString * leiXingStr;
@property(nonatomic,strong)NSArray * leiXingArray;
@property(nonatomic,strong)NSMutableArray * leiXingButtonArray;

@property(nonatomic,strong)UIImagePickerController * imagePickerController;
@property(nonatomic,strong)NSMutableArray * photoArray;
@property(nonatomic,strong)NSMutableArray * photoPathArray;

@property(nonatomic,strong)UIButton * tiJiaoButton;


@end

@implementation HeiDianPingJiaViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    maxImageSelected = 6;
    
    [self yinCangTabbar];

    self.topTitleLale.text = @"评价";
    self.loadingFullScreen = @"yes";

    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.frame.origin.y+self.topNavView.frame.size.height,WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.frame.origin.y+self.topNavView.frame.size.height-49*BiLiWidth))];
    [self.view addSubview:self.mainScrollView];
    
    UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.mainScrollView addGestureRecognizer:viewTap];
    
    UILabel * leiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, 20*BiLiWidth, 200*BiLiWidth, 15*BiLiWidth)];
    leiXingLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    leiXingLable.textColor = RGBFormUIColor(0x333333);
    leiXingLable.text = @"类型";
    [self.mainScrollView addSubview:leiXingLable];

    float originx = 12*BiLiWidth;
    float originy = leiXingLable.top+leiXingLable.height+15*BiLiWidth;
    float xDisTance =  40*BiLiWidth;
    float yDistance = 20*BiLiWidth;

    self.leiXingArray = [[NSArray alloc] initWithObjects:@"虚假信息",@"信息过期",@"其他", nil];
    self.leiXingButtonArray = [NSMutableArray array];
    
    for (int i=0; i<self.leiXingArray.count; i++) {
        
        NSString * leiXingStr = [self.leiXingArray objectAtIndex:i];
        
        CGSize size = [NormalUse setSize:leiXingStr withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:15*BiLiWidth];
        
        if (originx+size.width>WIDTH_PingMu-24*BiLiWidth) {
            
            originx = 12*BiLiWidth;
            originy = originy+40*BiLiWidth+yDistance;
        }
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(originx, originy,size.width+30*BiLiWidth, 40*BiLiWidth)];
        [button setTitle:leiXingStr forState:UIControlStateNormal];
        [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
        button.tag=i;
        button.layer.cornerRadius = 20*BiLiWidth;
        button.backgroundColor = RGBFormUIColor(0xEEEEEE);
        [button addTarget:self action:@selector(leiXingButtonCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainScrollView addSubview:button];
        
        [self.leiXingButtonArray addObject:button];
        originx = originx+button.width+xDisTance;
    }

    UILabel * fuWuLeiXingTip = [[UILabel alloc] initWithFrame:CGRectMake(12*BiLiWidth, originy+40*BiLiWidth+40*BiLiWidth, 200*BiLiWidth, 15*BiLiWidth)];
    fuWuLeiXingTip.font = [UIFont systemFontOfSize:15*BiLiWidth];
    fuWuLeiXingTip.textColor = RGBFormUIColor(0x333333);
    fuWuLeiXingTip.text = @"内容";
    [self.mainScrollView addSubview:fuWuLeiXingTip];

    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(12*BiLiWidth,fuWuLeiXingTip.top+fuWuLeiXingTip.height+15*BiLiWidth, WIDTH_PingMu-24*BiLiWidth, 130*BiLiWidth-30*BiLiWidth)];
    self.textView.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:15*BiLiWidth];
    self.textView.textColor = RGBFormUIColor(0x999999);
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.delegate = self;
    self.textView.layer.cornerRadius = 4*BiLiWidth;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [RGBFormUIColor(0xDDDDDD) CGColor];
    self.textView.placeholder = @"请输入具体原因...";
    self.textView.font = [UIFont systemFontOfSize:12*BiLiWidth];
    [self.mainScrollView addSubview:self.textView];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(12.5*BiLiWidth, self.textView.top+self.textView.height+32.5*BiLiWidth, 200*BiLiWidth, 13*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:11*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0xFF0000);
    [self.mainScrollView addSubview:tipLable];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"照片（请上传评价的证明照片）"];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x333333) range:NSMakeRange(0, 2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13*BiLiWidth] range:NSMakeRange(0, 2)];
    tipLable.attributedText = str;

    
    self.photoArray = [NSMutableArray array];
    self.photoPathArray = [NSMutableArray array];
    self.photoContentView = [[UIView alloc] initWithFrame:CGRectMake(15*BiLiWidth, tipLable.frame.origin.y+tipLable.frame.size.height+20*BiLiWidth, WIDTH_PingMu-30*BiLiWidth, 72*BiLiWidth)];
    [self.mainScrollView addSubview:self.photoContentView];
    [self initphotoContentView];

    
    self.tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-153*BiLiWidth)/2, self.photoContentView.top+self.photoContentView.height+42*BiLiWidth, 153*BiLiWidth, 40*BiLiWidth)];
    [self.tiJiaoButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.tiJiaoButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.tiJiaoButton.bounds;
    gradientLayer.cornerRadius = 20*BiLiWidth;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    [self.tiJiaoButton.layer addSublayer:gradientLayer];
    
    UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tiJiaoButton.width, self.tiJiaoButton.height)];
    tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiJiaoLable.text = @"确认提交";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [self.tiJiaoButton addSubview:tiJiaoLable];

}
-(void)leiXingButtonCLick:(UIButton *)selectButton
{
    self.leiXingStr = [self.leiXingArray objectAtIndex:selectButton.tag];
    
    for (UIButton * button in self.leiXingButtonArray) {
        
        if (selectButton.tag==button.tag) {
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:RGBFormUIColor(0x333333)];
        }
        else
        {
            [button setTitleColor:RGBFormUIColor(0x333333) forState:UIControlStateNormal];
            [button setBackgroundColor:RGBFormUIColor(0xEEEEEE)];

        }
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
    
    self.tiJiaoButton.top =  self.photoContentView.frame.origin.y+self.photoContentView.frame.size.height+42*BiLiWidth;

    self.mainScrollView.contentSize = CGSizeMake(WIDTH_PingMu, self.tiJiaoButton.top+self.tiJiaoButton.height+20*BiLiWidth);

}
-(void)deleteImageButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    [self.photoArray removeObjectAtIndex:button.tag];
    [self initphotoContentView];
}

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
          
        [wself addMediaFromLibaray];
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
-(void)addMediaFromLibaray
{
    TZImagePickerController *imagePickController;
    NSInteger count = 0;
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
-(void)tiJiaoButtonClick
{
    [self.textView resignFirstResponder];
    
    [self.photoPathArray removeAllObjects];
    
    if (![NormalUse isValidString:self.leiXingStr]) {
        
        [NormalUse showToastView:@"请选择评价类型" view:self.view];
        return;
    }
    
    if (self.textView.text.length==0) {
        
        [NormalUse showToastView:@"请填写投诉内容" view:self.view];
        return;
    }
    
    if (self.photoArray.count!=0)
    {
        uploadImageIndex = 0;
        [self xianShiLoadingView:@"提交中..." view:nil];
        [self uploadImage];
    }
    else
    {
        [self xianShiLoadingView:@"提交中..." view:nil];
        [self tiJiaoJvBaoMessage];
    }

    
}
-(void)uploadImage
{
    UIImage *image = [self.photoArray objectAtIndex:uploadImageIndex];
    //png和jpeg的压缩
    NSData *imageData = UIImagePNGRepresentation(image);

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
            [self tiJiaoJvBaoMessage];
        }
        
    }];
    

}

-(void)tiJiaoJvBaoMessage
{
    
    if ([NormalUse isValidArray:self.photoPathArray]&& self.photoPathArray.count>0) {
    
        [HTTPModel saveFile:[[NSDictionary alloc]initWithObjectsAndKeys:[self.photoPathArray objectAtIndex:uploadImageIndex],@"filepath", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            self->uploadImageIndex = self->uploadImageIndex+1;
            
            if (status==1) {
                
                if (![NormalUse isValidString:self.pathId]) {
                    
                    self.pathId = [responseObject objectForKey:@"fileId"];
                }
                else
                {
                    self.pathId = [[self.pathId stringByAppendingString:@"|"] stringByAppendingString:[responseObject objectForKey:@"fileId"]];
                }
            }


            if (self->uploadImageIndex<self.photoArray.count) {

                [self tiJiaoJvBaoMessage];
            }
            else
            {
                [HTTPModel heiDianPingJia:[[NSDictionary alloc]initWithObjectsAndKeys:self.black_id,@"black_id",self.leiXingStr,@"type",self.textView.text,@"content",self.pathId,@"images", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
                   
                    [self yinCangLoadingView];

                    if (status==1) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        [NormalUse showToastView:@"评价成功" view:[NormalUse getCurrentVC].view];
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
-(void)viewTap
{
    [self.textView resignFirstResponder];
}




@end
