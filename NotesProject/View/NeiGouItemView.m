//
//  ChongZhiItemView.m
//  ChengZi
//
//  Created by tangMeng on 2019/7/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "InApppurchaseItemView.h"

@implementation InApppurchaseItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.appPurchaseTool =  [InApppurchaseTool getInstance];
        
        self.appPurchaseTool.delegate = self;
        
        self.interFace = [InterfaceTool getInstance];
        self.kkInterFace = [KKInterfaceTool getInstance];
        
        self.frame = CGRectMake(0, HEIGHT_PingMu, WIDTH_PingMu, HEIGHT_PingMu);

        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        self.productsList = [defaults objectForKey:@"ChongZhi_productList"];

        if ([NormalUse isValidArray:self.productsList]) {
            
            [self initChongZhiItemView];
            [self.interFace getWalletMes:[NormalUse getNowUserID]
                                     apiId:@"8005"
                                  delegate:self
                                  selector:@selector(getUserInformationSuccess:)
                             errorSelector:@selector(getUserInformationError:)];

        }
        else
        {
            [self.kkInterFace getChongZhiList:@"2004"
                                   bsCode:@"3"
                              retPayssionPmId:nil
                                     currency:@"USD"
                                     delegate:self
                                     selector:@selector(getChongZhiListSuccess:)
                                errorSelector:@selector(getChongZhiListError:)];
                  
        }
       
        
        
    
    }
    return self;
}
-(void)getChongZhiListSuccess:(NSDictionary *)info
{
          
    self.productsList = [info objectForKey:@"productsList"];
    [self initChongZhiItemView];
    [self.interFace getWalletMes:[NormalUse getNowUserID]
                             apiId:@"8005"
                          delegate:self
                          selector:@selector(getUserInformationSuccess:)
                     errorSelector:@selector(getUserInformationError:)];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.productsList forKey:@"ChongZhi_productList"];
    [defaults synchronize];


}
-(void)getChongZhiListError:(NSDictionary *)info
{
    
}
//获取到余额更新余额
-(void)getUserInformationSuccess:(NSDictionary *)info
{
    NSString * gold_number = [info objectForKey:@"gold_number"];
    float goldNum = gold_number.floatValue/100;
    if (goldNum <= 0) {
            
           [NormalUse showToastView:@"Insufficient balance, please recharge" view:self];
      
    }
    
    NSString * str = [NSString stringWithFormat:@"Account: %.1f",goldNum];
    CGSize  yuESize = [NormalUse setSize:str withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:13*BiLiWidth];
    
    self.yuELable.frame = CGRectMake(self.yuELable.frame.origin.x, self.yuELable.frame.origin.y, yuESize.width, self.yuELable.frame.size.height);
    
    self.yuELable.text = str;
    
    self.danWeiImageView.frame = CGRectMake(self.yuELable.frame.origin.x+self.yuELable.frame.size.width+5*BiLiWidth, self.yuELable.frame.origin.y-1*BiLiWidth, 15*BiLiWidth, 15*BiLiWidth);
    
}


-(void)getUserInformationError:(NSDictionary *)info
{
    
}
- (void)initChongZhiItemView
{
    UIButton * bottomAlphaButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    bottomAlphaButton.backgroundColor = [UIColor clearColor];
    bottomAlphaButton.alpha = 0.4;
    [bottomAlphaButton addTarget:self action:@selector(bottomAlphaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bottomAlphaButton];
    
    UIView * whiteContentView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_PingMu-309*BiLiWidth, WIDTH_PingMu, 309*BiLiWidth)];
    whiteContentView.backgroundColor = RGBFormUIColor(0xFAFAFA);
    [self addSubview:whiteContentView];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, 44.5*BiLiWidth)];
    titleLable.textColor = RGBFormUIColor(0x999999);
    titleLable.text = @"Recharge";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:15*BiLiWidth];
    [whiteContentView addSubview:titleLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5*BiLiWidth, WIDTH_PingMu, 1)];
    lineView.backgroundColor = RGBFormUIColor(0xF0F0F0);
    [whiteContentView addSubview:lineView];
    
    NSString * str = [NSString stringWithFormat:@"Account: %@",@"0"];
    CGSize  yuESize = [NormalUse setSize:str withCGSize:CGSizeMake(WIDTH_PingMu, WIDTH_PingMu) withFontSize:13*BiLiWidth];

    self.yuELable = [[UILabel alloc] initWithFrame:CGRectMake(22*BiLiWidth, lineView.frame.origin.y+lineView.frame.size.height+16*BiLiWidth, yuESize.width, 15*BiLiWidth)];
    self.yuELable.textColor = RGBFormUIColor(0xFDBB15);
    self.yuELable.font = [UIFont systemFontOfSize:13*BiLiWidth];
    [whiteContentView addSubview:self.yuELable];
    
    self.yuELable.text = str;
    
    self.danWeiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.yuELable.frame.origin.x+self.yuELable.frame.size.width+5*BiLiWidth, self.yuELable.frame.origin.y-1*BiLiWidth, 15*BiLiWidth, 15*BiLiWidth)];
    self.danWeiImageView.image = [UIImage imageNamed:@"bangDan_zuanShi"];
    [whiteContentView addSubview:self.danWeiImageView];
    
    NSUserDefaults * productInfoDefaults = [NSUserDefaults standardUserDefaults];
    NSArray * productInfoArray = [productInfoDefaults objectForKey:@"productInfoDefaultsKey"];

    
    for (int i=0; i<self.productsList.count; i++) {
        
        NSDictionary * info = [self.productsList objectAtIndex:i];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(22.5*BiLiWidth+i%3*115*BiLiWidth, self.yuELable.frame.origin.y+self.yuELable.frame.size.height+15*BiLiWidth+i/3*75*BiLiWidth, 100*BiLiWidth, 60*BiLiWidth)];
        [button addTarget:self action:@selector(checkChongZhiItem:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = 4*BiLiWidth;
        button.tag = i;
        [whiteContentView addSubview:button];
        
        UILabel * jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 13*BiLiWidth, 50*BiLiWidth, 18*BiLiWidth)];
        jinBiLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*BiLiWidth];
        jinBiLable.textAlignment = NSTextAlignmentRight;
        jinBiLable.textColor = [UIColor blackColor];
        jinBiLable.text = [info objectForKey:@"totalProduct"];
        [button addSubview:jinBiLable];
        
        UIImageView * danWeiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(jinBiLable.frame.origin.x+jinBiLable.frame.size.width+3*BiLiWidth, jinBiLable.frame.origin.y+1.5*BiLiWidth, 15*BiLiWidth, 15*BiLiWidth)];
        danWeiImageView.image = [UIImage imageNamed:@"KB"];
        [whiteContentView addSubview:danWeiImageView];
        [button addSubview:danWeiImageView];
        
        UILabel * moneyLablev= [[UILabel alloc] initWithFrame:CGRectMake(0, jinBiLable.frame.origin.y+jinBiLable.frame.size.height+7*BiLiWidth, button.frame.size.width, 10*BiLiWidth)];
        moneyLablev.textAlignment = NSTextAlignmentCenter;
        moneyLablev.font = [UIFont systemFontOfSize:10*BiLiWidth];
        moneyLablev.textColor = RGBFormUIColor(0x999999);
        [button addSubview:moneyLablev];
        
        for (NSDictionary * identifyInfo in productInfoArray) {
            
            if ([[identifyInfo objectForKey:@"productIdentifier"] isEqualToString:[info objectForKey:@"appleCode"]]) {
                moneyLablev.text = [identifyInfo objectForKey:@"finalPrice"];
                break;
            }
        }

        [button addSubview:moneyLablev];


        whiteContentView.frame = CGRectMake(whiteContentView.frame.origin.x, HEIGHT_PingMu-(button.frame.origin.y+button.frame.size.height+15*BiLiWidth+45*BiLiWidth+15*BiLiWidth), whiteContentView.frame.size.width, button.frame.origin.y+button.frame.size.height+15*BiLiWidth+45*BiLiWidth+15*BiLiWidth);
        
    }
    self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22.5*BiLiWidth+1%3*115*BiLiWidth, self.yuELable.frame.origin.y+self.yuELable.frame.size.height+15*BiLiWidth+1/3*75*BiLiWidth, 100*BiLiWidth, 60*BiLiWidth)];
    self.selectImageView.tag = 1;
    self.selectImageView.image = [UIImage imageNamed:@"TC_chongzhi_xuanzhong_pic"];
    [whiteContentView addSubview:self.selectImageView];
    
    UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(22.5*BiLiWidth, whiteContentView.frame.size.height-65*BiLiWidth, WIDTH_PingMu-45*BiLiWidth, 45*BiLiWidth)];
    chongZhiButton.backgroundColor = RGBFormUIColor(0x15BAFD);
    chongZhiButton.layer.cornerRadius = 45*BiLiWidth/2;
    [chongZhiButton setTitle:@"Recharge" forState:UIControlStateNormal];
    [chongZhiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chongZhiButton addTarget:self action:@selector(chongZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    chongZhiButton.titleLabel.font = [UIFont systemFontOfSize:15*BiLiWidth];
    [whiteContentView addSubview:chongZhiButton];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu);
    } completion:^(BOOL finished) {
        self.backgroundColor = RGBFormUIColorA(0x000000, 0.3);
    }];
}
-(void)checkChongZhiItem:(UIButton *)button
{
    self.selectImageView.frame = button.frame;
    self.selectImageView.tag = button.tag;
}
-(void)bottomAlphaButtonClick
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(0, HEIGHT_PingMu, WIDTH_PingMu, HEIGHT_PingMu);
    } completion:^(BOOL finished) {
        
        self.successfulChongZhi(2);
         [self removeFromSuperview];
    }];
   
}
-(void)chongZhiButtonClick
{
    self.backgroundColor = [UIColor clearColor];
    [self removeFromSuperview];
    
    [NormalUse showMessageLoadView:@"Processing..." vc:[NormalUse getCurrentVC]];
    NSDictionary * info = [self.productsList objectAtIndex:self.selectImageView.tag];
    [self.kkInterFace neiGouPayCharge:@"2007"
                             currency:@"USD"
                            productId:[info objectForKey:@"id"]
                            eventType:self.eventType
                             delegate:self
                             selector:@selector(getChargeSuccess:)
                        errorSelector:@selector(getChargeError:)];

    
}
-(void)getChargeSuccess:(NSDictionary *)info
{
    NSDictionary * productInfo = [self.productsList objectAtIndex:self.selectImageView.tag];
    [self.appPurchaseTool startPurchase:[productInfo objectForKey:@"appleCode"] out_trade_no:[info objectForKey:@"orderNo"]];

}

-(void)getChargeError:(NSDictionary *)info
{
    self.successfulChongZhi(0);
    [NormalUse removeMessageLoadingView:[NormalUse getCurrentVC]];
    [NormalUse showToastView:[info objectForKey:@"message"] view:[NormalUse getCurrentVC].view];
}
-(void)purchaseSuccess:(NSString *)base64Str out_trade_no:(nonnull NSString *)out_trade_no
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
       NSArray * neiGouBase64Array = [defaults objectForKey:@"NeiGouBase64Key"];//存储苹果支付返回的base64的数组
       NSMutableArray * base64Array;
       if ([neiGouBase64Array isKindOfClass:[NSArray class]]&&neiGouBase64Array.count>0)
       {
           base64Array = [[NSMutableArray alloc] initWithArray:neiGouBase64Array];
       }
       else
       {
           base64Array = [NSMutableArray array];
       }
       NSDictionary * info = [[NSDictionary alloc] initWithObjectsAndKeys:base64Str,@"payload",[NormalUse getobjectForKey:out_trade_no],@"orderNo",[NormalUse getobjectForKey:[NSString stringWithFormat:@"%d",(int)self.selectImageView.tag]],@"neiGouIndex", nil];
       [base64Array addObject:info];
       neiGouBase64Array = [[NSArray alloc] initWithArray:base64Array];
       NSSet * set = [NSSet setWithArray:neiGouBase64Array];
       neiGouBase64Array = [set allObjects];
       [defaults setObject:neiGouBase64Array forKey:@"NeiGouBase64Key"];
       [defaults synchronize];

       
       [NormalUse removeMessageLoadingView:[NormalUse getCurrentVC]];
       
       [NormalUse showMessageLoadView:@"Verification..." vc:[NormalUse getCurrentVC]];
       
       [self.kkInterFace neiGouRuZhang:@"2008"
                                 payload:base64Str
                                 orderNo:out_trade_no
                                delegate:self
                                selector:@selector(getResultSuccess:)
                           errorSelector:@selector(getResultError:)];
}
-(void)purchaseError:(NSString *)errorStr
{
    self.successfulChongZhi(0);
    [NormalUse removeMessageLoadingView:[NormalUse getCurrentVC]];
    
}


-(void)getResultSuccess:(NSDictionary *)info
{
    
    self.successfulChongZhi(1);
    [NormalUse removeMessageLoadingView:[NormalUse getCurrentVC]];
    [NormalUse showToastView:@"Recharge Success" view:[NormalUse getCurrentVC].view];
    
   NSDictionary * result = [info objectForKey:@"result"];
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   NSArray * benDiBase64Array = [defaults objectForKey:@"NeiGouBase64Key"];//存储苹果支付返回的base64的数组
   NSMutableArray * base64Array = [[NSMutableArray alloc] initWithArray:benDiBase64Array];
   
   for (int i=0;i<base64Array.count;i++) {
       NSDictionary * cunChuInfo = [base64Array objectAtIndex:i];
       
       if ([[cunChuInfo objectForKey:@"payload"] isEqualToString:[result objectForKey:@"payload"]])
       {
           [base64Array removeObjectAtIndex:i];
       }
   }
   benDiBase64Array = [[NSArray alloc] initWithArray:base64Array];
   [defaults setObject:benDiBase64Array forKey:@"NeiGouBase64Key"];
   [defaults synchronize];
    
    
    
        NSUserDefaults * productInfoDefaults = [NSUserDefaults standardUserDefaults];
        NSArray * productInfoArray = [productInfoDefaults objectForKey:@"productInfoDefaultsKey"];

        NSDictionary * identifyInfo1 ;
        NSDictionary * productInfo = [self.productsList objectAtIndex:self.selectImageView.tag];
        
        for (NSDictionary * identifyInfo in productInfoArray) {
            
            if ([[identifyInfo objectForKey:@"productIdentifier"] isEqualToString:[productInfo objectForKey:@"appleCode"]]) {
                
                identifyInfo1 = identifyInfo;
                break;
            }
        }
        
        NSDecimalNumber *price = [identifyInfo1 objectForKey:@"price"];
        NSString * danWeiStr = [identifyInfo1 objectForKey:@"currencyCode"];
        NSLog(@"%f %@",price.floatValue,danWeiStr);
        ADJEvent *event = [ADJEvent eventWithEventToken:@"8t3f15"];
        [event setRevenue:price.doubleValue currency:danWeiStr];
        [Adjust trackEvent:event];

}
-(void)getResultError:(NSDictionary *)info
{
    if ([@"-999" isEqualToString:[info objectForKey:@"code"]]) {
        self.successfulChongZhi(0);
        

    }
    else
    {
        self.successfulChongZhi(0);
        NSDictionary * result = [info objectForKey:@"result"];
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSArray * benDiBase64Array = [defaults objectForKey:@"NeiGouBase64Key"];//存储苹果支付返回的base64的数组
        NSMutableArray * base64Array = [[NSMutableArray alloc] initWithArray:benDiBase64Array];
        
        for (int i=0;i<base64Array.count;i++) {
            NSDictionary * cunChuInfo = [base64Array objectAtIndex:i];
            
            if ([[cunChuInfo objectForKey:@"payload"] isEqualToString:[result objectForKey:@"payload"]])
            {
                [base64Array removeObjectAtIndex:i];
            }
        }
        benDiBase64Array = [[NSArray alloc] initWithArray:base64Array];
        [defaults setObject:benDiBase64Array forKey:@"NeiGouBase64Key"];
        [defaults synchronize];

    }
    
    [NormalUse removeMessageLoadingView:[NormalUse getCurrentVC]];
    [NormalUse showToastView:[info objectForKey:@"message"] view:[NormalUse getCurrentVC].view];
    
}


@end
