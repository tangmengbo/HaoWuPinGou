//
//  TiXianViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/22.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "TiXianViewController.h"

@interface TiXianViewController ()

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UITextField * jinBiTF;

@property(nonatomic,strong)UILabel * yueLable;
@property(nonatomic,strong)UILabel * tipLable;//展示金币和人民币的比例 以及输入金币后对应的人民币数量

@property(nonatomic,strong)UITextField * yinHangKaHaoTF;
@property(nonatomic,strong)UITextField * shouKuanRenXingMingTF;

@property(nonatomic,strong)UIView * tipKuangView;

@end

@implementation TiXianViewController

-(UIView *)tipKuangView
{
    if (!_tipKuangView) {
        
        _tipKuangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
        _tipKuangView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self.view addSubview:_tipKuangView];
        
        UIImageView * kuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-287*BiLiWidth)/2, (HEIGHT_PingMu-253*BiLiWidth)/2, 287*BiLiWidth, 253*BiLiWidth)];
        kuangImageView.image = [UIImage imageNamed:@"zhangHu_tipKuang"];
        kuangImageView.userInteractionEnabled = YES;
        [_tipKuangView addSubview:kuangImageView];
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kuangImageView.left+kuangImageView.width-33*BiLiWidth/2*1.5, kuangImageView.top-33*BiLiWidth/3, 33*BiLiWidth, 33*BiLiWidth)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"zhangHu_closeKuang"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeTipKuangView) forControlEvents:UIControlEventTouchUpInside];
        [_tipKuangView addSubview:closeButton];
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 38*BiLiWidth, kuangImageView.width, 17*BiLiWidth)];
        tipLable1.font = [UIFont systemFontOfSize:17*BiLiWidth];
        tipLable1.textColor = RGBFormUIColor(0x343434);
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.text = @"提示";
        [kuangImageView addSubview:tipLable1];
        
        UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable1.top+tipLable1.height+25*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 40*BiLiWidth)];
        tipLable2.font = [UIFont systemFontOfSize:14*BiLiWidth];
        tipLable2.textColor = RGBFormUIColor(0x343434);
        tipLable2.numberOfLines = 2;
        tipLable2.text = @"您的提现申请已提交，稍后可在消息中心查看提交结果。";
        [kuangImageView addSubview:tipLable2];
        
        UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake(37*BiLiWidth, tipLable2.top+tipLable2.height+43*BiLiWidth, kuangImageView.width-37*BiLiWidth*2, 40*BiLiWidth)];
        [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [kuangImageView addSubview:sureButton];
        //渐变设置
        UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
        UIColor *colorTwo = RGBFormUIColor(0xFF0876);
        CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = sureButton.bounds;
        gradientLayer1.cornerRadius = 20*BiLiWidth;
        gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        gradientLayer1.locations = @[@0,@1];
        [sureButton.layer addSublayer:gradientLayer1];
        
        UILabel * sureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sureButton.width, sureButton.height)];
        sureLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
        sureLable.text = @"确定";
        sureLable.textAlignment = NSTextAlignmentCenter;
        sureLable.textColor = [UIColor whiteColor];
        [sureButton addSubview:sureLable];
        

        

    }
    return _tipKuangView;
}
-(void)closeTipKuangView
{
    self.tipKuangView.hidden = YES;
}
-(void)sureButtonClick
{
    self.tipKuangView.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = @"金币提现";
    
    self.view.backgroundColor = RGBFormUIColor(0xF7F7F7);
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    
    UIView * whiteContentView = [[UIView alloc] initWithFrame:CGRectMake(16*BiLiWidth, 16*BiLiWidth, WIDTH_PingMu-32*BiLiWidth, 381*BiLiWidth)];
    whiteContentView.backgroundColor = [UIColor whiteColor];
    whiteContentView.layer.cornerRadius = 4*BiLiWidth;
    whiteContentView.layer.masksToBounds = YES;
    [self.mainScrollView addSubview:whiteContentView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTap)];
    [whiteContentView addGestureRecognizer:tap];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(32*BiLiWidth, 25*BiLiWidth, 100*BiLiWidth, 14*BiLiWidth)];
    tipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    tipLable.textColor = RGBFormUIColor(0x343434);
    tipLable.text = @"金币提现";
    [whiteContentView addSubview:tipLable];
    
    UIImageView * jinBiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(tipLable.left, tipLable.top+tipLable.height+24.5*BiLiWidth, 32*BiLiWidth, 32*BiLiWidth)];
    jinBiImageView.image = [UIImage imageNamed:@"zhangHu_jinBiIcon"];
    [whiteContentView addSubview:jinBiImageView];
    
    
    
    self.jinBiTF = [[UITextField alloc] initWithFrame:CGRectMake(jinBiImageView.left+jinBiImageView.width+13*BiLiWidth, jinBiImageView.top, whiteContentView.width-(jinBiImageView.left+jinBiImageView.width+13*BiLiWidth+30*BiLiWidth), jinBiImageView.height)];
    self.jinBiTF.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.jinBiTF.placeholder = [NSString stringWithFormat:@"请输入要提现的金币数且大于%@",[NormalUse getJinBiStr:@"cash_out_limit"]];
    self.jinBiTF.textColor = RGBFormUIColor(0x343434);
    self.jinBiTF.adjustsFontSizeToFitWidth = YES;
    self.jinBiTF.keyboardType = UIKeyboardTypeNumberPad;
    [whiteContentView addSubview:self.jinBiTF];
    [self.jinBiTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];

    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(jinBiImageView.left, jinBiImageView.top+jinBiImageView.height+9.5*BiLiWidth, whiteContentView.width-jinBiImageView.left*2, 1)];
    lineView.backgroundColor = RGBFormUIColor(0xEEEEEE);
    [whiteContentView addSubview:lineView];
    
    self.yueLable = [[UILabel alloc] initWithFrame:CGRectMake(jinBiImageView.left, lineView.top+lineView.height+11*BiLiWidth, 200*BiLiWidth, 18*BiLiWidth)];
    self.yueLable.font = [UIFont systemFontOfSize:18*BiLiWidth];
    self.yueLable.textColor = RGBFormUIColor(0xFED062);
    self.yueLable.adjustsFontSizeToFitWidth = YES;
    [whiteContentView addSubview:self.yueLable];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"金币余额 %@",self.yuEStr]];
    [str addAttribute:NSForegroundColorAttributeName value:RGBFormUIColor(0x9A9A9A) range:NSMakeRange(0, 4)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*BiLiWidth] range:NSMakeRange(0, 4)];
    self.yueLable.attributedText = str;

    
    self.tipLable = [[UILabel alloc] initWithFrame:CGRectMake(whiteContentView.width-30*BiLiWidth-150*BiLiWidth, self.yueLable.top, 150*BiLiWidth, 18*BiLiWidth)];
    self.tipLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.tipLable.textColor = RGBFormUIColor(0x9A9A9A);
    self.tipLable.textAlignment = NSTextAlignmentRight;
    self.tipLable.adjustsFontSizeToFitWidth = YES;
    NSString * jinBiRmbBiLi = [NormalUse getJinBiStr:@"cny_to_coin"];
    self.tipLable.text = [NSString stringWithFormat:@"1金币=%.2f人民币",1/jinBiRmbBiLi.floatValue];
    [whiteContentView addSubview:self.tipLable];
    
    UILabel * shouKuanRenLable = [[UILabel alloc] initWithFrame:CGRectMake(jinBiImageView.left, self.yueLable.top+self.yueLable.height+34*BiLiWidth, 200*BiLiWidth, 14*BiLiWidth)];
    shouKuanRenLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    shouKuanRenLable.textColor = RGBFormUIColor(0x343434);
    shouKuanRenLable.text = @"填写收款人信息";
    [whiteContentView addSubview:shouKuanRenLable];
    
    UIView * yinHangKaTFKuang = [[UIView alloc] initWithFrame:CGRectMake(jinBiImageView.left, shouKuanRenLable.top+shouKuanRenLable.height+16.5*BiLiWidth, whiteContentView.width-jinBiImageView.left*2,34.5*BiLiWidth)];
    yinHangKaTFKuang.layer.borderColor = [RGBFormUIColor(0xDEDEDE) CGColor];
    yinHangKaTFKuang.layer.borderWidth = 1;
    [whiteContentView addSubview:yinHangKaTFKuang];


    self.yinHangKaHaoTF = [[UITextField alloc] initWithFrame:CGRectMake(jinBiImageView.left+7*BiLiWidth, shouKuanRenLable.top+shouKuanRenLable.height+16.5*BiLiWidth, whiteContentView.width-jinBiImageView.left*2-7*BiLiWidth,34.5*BiLiWidth)];
    self.yinHangKaHaoTF.textColor = RGBFormUIColor(0x343434);
    self.yinHangKaHaoTF.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.yinHangKaHaoTF.placeholder = @"请输入银行卡号";
    [whiteContentView addSubview:self.yinHangKaHaoTF];
    
    UIView * shouKuanRenTFKuang = [[UIView alloc] initWithFrame:CGRectMake(jinBiImageView.left, self.yinHangKaHaoTF.top+self.yinHangKaHaoTF.height+15.5*BiLiWidth, whiteContentView.width-jinBiImageView.left*2,34.5*BiLiWidth)];
    shouKuanRenTFKuang.layer.borderColor = [RGBFormUIColor(0xDEDEDE) CGColor];
    shouKuanRenTFKuang.layer.borderWidth = 1;
    [whiteContentView addSubview:shouKuanRenTFKuang];

    
    self.shouKuanRenXingMingTF = [[UITextField alloc] initWithFrame:CGRectMake(jinBiImageView.left+7*BiLiWidth, self.yinHangKaHaoTF.top+self.yinHangKaHaoTF.height+15.5*BiLiWidth, whiteContentView.width-jinBiImageView.left*2-7*BiLiWidth,34.5*BiLiWidth)];
    self.shouKuanRenXingMingTF.textColor = RGBFormUIColor(0x343434);
    self.shouKuanRenXingMingTF.font = [UIFont systemFontOfSize:14*BiLiWidth];
    self.shouKuanRenXingMingTF.placeholder = @"请输入收款人姓名";
    [whiteContentView addSubview:self.shouKuanRenXingMingTF];


    UIButton * tiXianButton = [[UIButton alloc] initWithFrame:CGRectMake(jinBiImageView.left, self.shouKuanRenXingMingTF.top+self.shouKuanRenXingMingTF.height+38.5*BiLiWidth, whiteContentView.width-jinBiImageView.left*2, 40*BiLiWidth)];
    [tiXianButton addTarget:self action:@selector(tiXianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteContentView addSubview:tiXianButton];
    //渐变设置
    UIColor *colorOne = RGBFormUIColor(0xFF6C6C);
    UIColor *colorTwo = RGBFormUIColor(0xFF0876);
    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = tiXianButton.bounds;
    gradientLayer1.cornerRadius = 20*BiLiWidth;
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(0, 1);
    gradientLayer1.locations = @[@0,@1];
    [tiXianButton.layer addSublayer:gradientLayer1];
    
    UILabel * tiJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tiXianButton.width, tiXianButton.height)];
    tiJiaoLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    tiJiaoLable.text = @"提现";
    tiJiaoLable.textAlignment = NSTextAlignmentCenter;
    tiJiaoLable.textColor = [UIColor whiteColor];
    [tiXianButton addSubview:tiJiaoLable];
    
    UILabel * guiZeTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(whiteContentView.left, whiteContentView.top+whiteContentView.height+19.5*BiLiWidth, 200*BiLiWidth, 14*BiLiWidth)];
    guiZeTitleLable.font = [UIFont systemFontOfSize:14*BiLiWidth];
    guiZeTitleLable.text = @"*提现规则";
    guiZeTitleLable.textColor = RGBFormUIColor(0x343434);
    [self.mainScrollView addSubview:guiZeTitleLable];
    
    UILabel * tiXianMessageLable = [[UILabel alloc] initWithFrame:CGRectMake(whiteContentView.left, guiZeTitleLable.top+guiZeTitleLable.height+13.5*BiLiWidth, whiteContentView.width, 0)];
    tiXianMessageLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    tiXianMessageLable.textColor = RGBFormUIColor(0x9A9A9A);
    tiXianMessageLable.numberOfLines = 0;
    [self.mainScrollView addSubview:tiXianMessageLable];
   
    NSString * cash_out_percentage = [NormalUse getJinBiStr:@"cash_out_percentage"];
    NSString * neiRongStr = [NSString stringWithFormat:@"1、每次提现最低为%@金币\n2、提现收取%@%@BiLiWidth手续费，如提1000金币，则实际到账%d金币\n3、仅支持银行卡提现，收款账户卡号和姓名必须一致，到账时间为24小时内",[NormalUse getJinBiStr:@"cash_out_limit"],cash_out_percentage,@"%",1000-(1000*cash_out_percentage.intValue/100)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:neiRongStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [neiRongStr length])];
    tiXianMessageLable.attributedText = attributedString;
    //设置自适应
    [tiXianMessageLable  sizeToFit];

    [self.mainScrollView setContentSize:CGSizeMake(WIDTH_PingMu, tiXianMessageLable.top+tiXianMessageLable.height+40*BiLiWidth)];

}
-(void)contentViewTap
{
    [self.jinBiTF resignFirstResponder];
    [self.yinHangKaHaoTF resignFirstResponder];
    [self.shouKuanRenXingMingTF resignFirstResponder];
}
-(void)tiXianButtonClick
{
    //tiXianShenQing
    if (![NormalUse isValidString:self.jinBiTF.text]) {
        
        [NormalUse showToastView:@"请填写提现金额" view:self.view];
        return;
    }
    NSString * cash_out_limit = [NormalUse getJinBiStr:@"cash_out_limit"];
    if(self.jinBiTF.text.intValue<cash_out_limit.intValue)
    {
        [NormalUse showToastView:[NSString stringWithFormat:@"提现金额不能少于%@",cash_out_limit] view:self.view];
        return;
    }
    if (![NormalUse isValidString:self.yinHangKaHaoTF.text]) {
        
        [NormalUse showToastView:@"请填写银行卡号" view:self.view];
        return;
    }

    if (![NormalUse isValidString:self.shouKuanRenXingMingTF.text]) {
        
        [NormalUse showToastView:@"请填写收款人姓名" view:self.view];
        return;
    }
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.jinBiTF.text forKey:@"coin"];
    [dic setObject:self.yinHangKaHaoTF.text forKey:@"bank_card"];
    [dic setObject:self.shouKuanRenXingMingTF.text forKey:@"username"];
    [NormalUse showMessageLoadView:@"处理中..." vc:self];
    [HTTPModel tiXianShenQing:dic callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
       
        [NormalUse removeMessageLoadingView:self];
        if (status==1) {
            
            self.tipKuangView.hidden = NO;

        }
        else
        {
            [NormalUse showToastView:msg view:self.view];
        }
    }];
}
#pragma mark--金币输入框监听

-(void)textFieldChanged:(UITextField*)textField{

    NSString * str = textField.text;
    NSString * jinBiRmbBiLi = [NormalUse getJinBiStr:@"cny_to_coin"];

    if([NormalUse isValidString:str])
    {
        self.tipLable.text = [NSString stringWithFormat:@"合计:%.2f元",str.intValue/jinBiRmbBiLi.floatValue];
    }
    else
    {
        self.tipLable.text = [NSString stringWithFormat:@"1金币=%.2f人民币",1/jinBiRmbBiLi.floatValue];

    }
    
}
@end
