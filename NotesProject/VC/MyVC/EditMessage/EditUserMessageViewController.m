//
//  EditMessageViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/23.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "EditUserMessageViewController.h"
#import "BangDingMobileViewController.h"
#import "GengHuanMobileViewController.h"

@interface EditUserMessageViewController ()<BangDingMobileViewControllerDelegate,GengHuanMobileViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIImagePickerController * imagePickerController;
@property(nonatomic,strong)UIImage * headerImage;
@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)NSString * headerImageID;

@property(nonatomic,strong)UITextField * nickTF;

@property(nonatomic,strong)UIButton * mobileButton;
@property(nonatomic,strong)UIButton * editMobileButton;

@property(nonatomic,strong)UIButton * cityButton;

@property(nonatomic,strong)UIButton * fenXiangMaButton;


@end

@implementation EditUserMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yinCangTabbar];
    
    self.loadingFullScreen = @"yes";
    
    self.topTitleLale.text = @"编辑资料";
    
    UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:viewTap];

    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-72*BiLiWidth)/2, self.topNavView.top+self.topNavView.height+10*BiLiWidth, 72*BiLiWidth, 72*BiLiWidth)];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
    self.headerImageView.clipsToBounds = YES;
    self.headerImageView.layer.cornerRadius = 72*BiLiWidth/2;
    self.headerImageView.userInteractionEnabled = YES;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[self.userInfo objectForKey:@"avatar"]]];
    [self.view addSubview:self.headerImageView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPhoto)];
    [self.headerImageView addGestureRecognizer:tap];
    

    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headerImageView.top+self.headerImageView.height+9.5*BiLiWidth, WIDTH_PingMu, 14*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.textColor = RGBFormUIColor(0x999999);
    tipLable.text = @"点击更换头像";
    [self.view addSubview:tipLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, tipLable.top+tipLable.height+21*BiLiWidth, WIDTH_PingMu, 10*BiLiWidth)];
    lineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.view addSubview:lineView];
    
    UILabel * nickLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BiLiWidth, lineView.top+lineView.height, 70*BiLiWidth, 55*BiLiWidth)];
    nickLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    nickLable.textColor = RGBFormUIColor(0x333333);
    nickLable.text = @"昵称";
    [self.view addSubview:nickLable];
    
    self.nickTF = [[UITextField alloc] initWithFrame:CGRectMake(nickLable.left+nickLable.width, nickLable.top, WIDTH_PingMu-(nickLable.left+nickLable.width+10*BiLiWidth), nickLable.height)];
    self.nickTF.placeholder = @"输入昵称";
    self.nickTF.text = [self.userInfo objectForKey:@"nickname"];
    self.nickTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.nickTF.textColor = RGBFormUIColor(0x999999);
    [self.view addSubview:self.nickTF];
    
    UIView * nickLineView = [[UIView alloc] initWithFrame:CGRectMake(0, nickLable.top+nickLable.height, WIDTH_PingMu, 1)];
    nickLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.view addSubview:nickLineView];
    
    UILabel * mobileLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BiLiWidth, nickLineView.top+nickLineView.height, 70*BiLiWidth, 55*BiLiWidth)];
    mobileLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    mobileLable.textColor = RGBFormUIColor(0x333333);
    mobileLable.text = @"手机号";
    [self.view addSubview:mobileLable];
    
    self.mobileButton = [[UIButton alloc] initWithFrame:CGRectMake(nickLable.left+nickLable.width, mobileLable.top, WIDTH_PingMu-(nickLable.left+nickLable.width+10*BiLiWidth), nickLable.height)];
    self.mobileButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.mobileButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
    self.mobileButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
//    [self.mobileButton addTarget:self action:@selector(bangDingMobileButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mobileButton];
    
//    self.editMobileButton = [[UIButton alloc] initWithFrame:CGRectMake(nickLable.left+nickLable.width+110*BiLiWidth, mobileLable.top, 30*BiLiWidth, self.mobileButton.height)];
//    [self.editMobileButton setTitleColor:RGBFormUIColor(0x00AEFF) forState:UIControlStateNormal];
//    self.editMobileButton.titleLabel.font = [UIFont systemFontOfSize:12*BiLiWidth];
//    [self.editMobileButton addTarget:self action:@selector(editMobileButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.editMobileButton setTitle:@"更换" forState:UIControlStateNormal];
//    [self.view addSubview:self.editMobileButton];
    
    if ([NormalUse isValidString:[self.userInfo objectForKey:@"mobile"]]) {
        
        [self.mobileButton setTitle:[self.userInfo objectForKey:@"mobile"] forState:UIControlStateNormal];
        self.mobileButton.enabled = NO;
    }
    else
    {
        [self.mobileButton setTitle:@"暂未绑定" forState:UIControlStateNormal];
        self.editMobileButton.hidden = YES;

    }


    
    UIView * mobileLineView = [[UIView alloc] initWithFrame:CGRectMake(0, mobileLable.top+mobileLable.height, WIDTH_PingMu, 1)];
    mobileLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.view addSubview:mobileLineView];
    
    
    UILabel * cityLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BiLiWidth, mobileLineView.top+mobileLineView.height, 70*BiLiWidth, 55*BiLiWidth)];
    cityLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    cityLable.textColor = RGBFormUIColor(0x333333);
    cityLable.text = @"城市";
    [self.view addSubview:cityLable];
    
    self.cityButton = [[UIButton alloc] initWithFrame:CGRectMake(nickLable.left+nickLable.width, cityLable.top, WIDTH_PingMu-(nickLable.left+nickLable.width+10*BiLiWidth), nickLable.height)];
    self.cityButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.cityButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
    self.cityButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
    NSDictionary * cityInfo = [NormalUse defaultsGetObjectKey:CurrentCity];
    [self.cityButton setTitle:[cityInfo objectForKey:@"cityName"] forState:UIControlStateNormal];
    [self.view addSubview:self.cityButton];
    
    UIView * cityLineView = [[UIView alloc] initWithFrame:CGRectMake(0, cityLable.top+cityLable.height, WIDTH_PingMu, 1)];
    cityLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.view addSubview:cityLineView];


    UILabel * fanXiangMaLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BiLiWidth, cityLineView.top+cityLineView.height, 70*BiLiWidth, 55*BiLiWidth)];
    fanXiangMaLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    fanXiangMaLable.textColor = RGBFormUIColor(0x333333);
    fanXiangMaLable.text = @"分享码";
    [self.view addSubview:fanXiangMaLable];
    
    self.fenXiangMaButton = [[UIButton alloc] initWithFrame:CGRectMake(nickLable.left+nickLable.width, fanXiangMaLable.top, WIDTH_PingMu-(nickLable.left+nickLable.width+10*BiLiWidth), nickLable.height)];
    [self.fenXiangMaButton setTitle:[self.userInfo objectForKey:@"share_code"] forState:UIControlStateNormal];
    self.fenXiangMaButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.fenXiangMaButton setTitleColor:RGBFormUIColor(0x999999) forState:UIControlStateNormal];
    self.fenXiangMaButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
    [self.view addSubview:self.fenXiangMaButton];
    
    UIView * fenXiangMaLineView = [[UIView alloc] initWithFrame:CGRectMake(0, fanXiangMaLable.top+fanXiangMaLable.height, WIDTH_PingMu, 1)];
    fenXiangMaLineView.backgroundColor = RGBFormUIColor(0xF7F7F7);
    [self.view addSubview:fenXiangMaLineView];

    
    UIButton * saveButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_PingMu-269*BiLiWidth)/2, fenXiangMaLineView.top+fenXiangMaLineView.height+40*BiLiWidth, 269*BiLiWidth, 40*BiLiWidth)];
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = saveButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [saveButton.layer addSublayer:gradientLayer1];
    
    UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, saveButton.width, saveButton.height)];
    tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiJiaoLable.text = @"保存";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [saveButton addSubview:tiJiaoLable];

    
}
-(void)viewTap
{
    [self.nickTF resignFirstResponder];
}
-(void)editPhoto
{
    [self viewTap];
    
    __weak typeof(self)wself = self;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [wself showImagePicker:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction * libraryAction = [UIAlertAction actionWithTitle:@"查看相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          
        [wself showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
      }];
    [alert addAction:cancleAction];
    [alert addAction:photoAction];
    [alert addAction:libraryAction];
    [self presentViewController:alert animated:YES completion:nil];

}
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        self.imagePickerController = [[UIImagePickerController alloc] init] ;
        self.imagePickerController.delegate = self;
        self.imagePickerController.sourceType = sourceType;
        self.imagePickerController.allowsEditing = YES;
        self.imagePickerController.modalPresentationStyle = 0;
        [self presentViewController:self.imagePickerController animated:YES completion:^{
            
        }];
    } else {
        
        [NormalUse showToastView:@"你的设备不支持" view:self.view];
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{   //判断是否设置头像
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    self.headerImage = image;
    self.headerImageView.image = image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)saveButtonClick
{
    if(![NormalUse isValidString:self.nickTF.text])
    {
        [NormalUse showToastView:@"昵称不能为空" view:self.view];
        return;
    }
    [self xianShiLoadingView:@"修改中..." view:self.view];
    
    if (self.headerImage!=nil) {
        
        UIImage * uploadImage = [NormalUse scaleToSize:self.headerImage size:CGSizeMake(400, 400*(self.headerImage.size.height/self.headerImage.size.width))];
        //png和jpeg的压缩
        NSData *imageData = UIImagePNGRepresentation(uploadImage);
        
        unsigned long long size = imageData.length;
        NSString * videoFileSize = [NSString stringWithFormat:@"%.2f", size / pow(10, 6)];
        NSLog(@"%@",videoFileSize);

        [HTTPModel uploadImageVideo:[[NSDictionary alloc] initWithObjectsAndKeys:imageData,@"file",@"&%&*HDSdahjd.dasiH23",@"upload_key",@"img",@"file_type", nil]
                           callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
            
            if (status==1) {
                
                [self getImagePathId:[responseObject objectForKey:@"filename"]];
            }
            else
            {
                [self yinCangLoadingView];

                [NormalUse showToastView:msg view:self.view];
            }
            
        }];

    }
    else
    {
        [self tiJiaoXiuGai:nil];
    }
    
}
-(void)getImagePathId:(NSString * )filepath
{
    [HTTPModel saveFile:[[NSDictionary alloc]initWithObjectsAndKeys:filepath,@"filepath", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        

        if (status==1) {
            
            [self tiJiaoXiuGai:[responseObject objectForKey:@"fileId"]];
        }
        else
        {
            [self yinCangLoadingView];

            [NormalUse showToastView:msg view:self.view];
        }

    }];


}
-(void)tiJiaoXiuGai:(NSString *)headerImageID
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.nickTF.text forKey:@"nickname"];
    if (headerImageID!=nil) {
        
        [dic setObject:headerImageID forKey:@"avatar"];
    }
    [HTTPModel editUserInfo:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        [self yinCangLoadingView];
        if (status==1) {
            
            [NormalUse showToastView:@"修改成功" view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }

    }];

}
-(void)editMobileButtonClick
{
    GengHuanMobileViewController * vc = [[GengHuanMobileViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma GengHuanMobileViewControllerDelegate

-(void)gengHuanMobileSuccess:(NSString *)mobileStr
{
    [self.mobileButton setTitle:mobileStr forState:UIControlStateNormal];
    self.mobileButton.enabled = NO;
    self.editMobileButton.hidden = NO;
}

-(void)bangDingMobileButtonClick
{
    BangDingMobileViewController * vc = [[BangDingMobileViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma BangDingMobileViewControllerDelehate

-(void)bangDingMobileSuccess:(NSString *)mobileStr
{
    [self.mobileButton setTitle:mobileStr forState:UIControlStateNormal];
    self.mobileButton.enabled = NO;
    self.editMobileButton.hidden = NO;
}
@end
