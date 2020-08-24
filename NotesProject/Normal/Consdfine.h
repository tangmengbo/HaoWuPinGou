//
//  Consdfine.h
//  NotesProject
//
//  Created by BoBo on 2019/10/15.
//  Copyright © 2019 BoBo. All rights reserved.
//

#ifndef Consdfine_h
#define Consdfine_h

//是否是正式环境0:测试，1:正式
#define IS_FORMAL_ENVIRONMENT  0
    
#if IS_FORMAL_ENVIRONMENT
#pragma mark 接口 生产

//融云key
#define RYKey @"tdrvipkstyvg5"
#define WYAPPKey @"211a06a77c365aa1d071ead6a86b3412"
#define WYCertificate @"yoyoPushDis"

#define HTTP_REQUESTURL @"http://yzjs.yingheyezi.com/wh/"
#define Image_URL @"http://42.194.167.215:8089/"

//

#else
#pragma mark 接口 测试
#define RYKey @"k51hidwqke44b"
#define WYAPPKey @"4317b56661cca83a3fdee0ffeed0ffcf"
//网易云信appkey
#define WYCertificate @"YoYoPushDev"
#define HTTP_REQUESTURL @"http://42.194.167.215:8089/appi"
#define Image_URL @"http://42.194.167.215:8089"
#endif




//测试账号 2139455   123456
//bundleid     com.livevideo.chat.yoyo
//沙盒测试账号 yotestus@cock.li  密码：ZhiHua123@
//1515718610  appStoreId

#define gaodBiLi   100
#define USERCC 640/750/2
//当前设置的宽、高
#define WIDTH_PingMu [UIScreen mainScreen].bounds.size.width
#define HEIGHT_PingMu [UIScreen mainScreen].bounds.size.height


#define TopHeight_PingMu ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 35 : 20)
#define BottomHeight_PingMu ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 64 : 49)


#define BiLiWidth [UIScreen mainScreen].bounds.size.width/360
#define BiLiHeight  [UIScreen mainScreen].bounds.size.height/667

#define LeftDistance (([UIScreen mainScreen].bounds.size.width == 812.0 ||[UIScreen mainScreen].bounds.size.width == 896.0 )? 30 : 0.0)

#define HP_WidthBL  ([UIScreen mainScreen].bounds.size.width-LeftDistance)/667
#define HP_HeightBL [UIScreen mainScreen].bounds.size.height/375


#define RGBFormUIColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define LoginStatus @"LoginStatus"
#define IntroduceStatus   @"IntroduceStatus"
#define FiveMinutesDefaultsKey @"fiveMinutesDefaultsKey"


#define YongHuINFO @"YongHuINFO"
#define APPKEY @"mImPJVmkkAjM1lYOvdInFw=="
#define APPNAME @"kkchat"

//详细信息
#define user_detail_info @"18006"

//存储渠道号
#define CHANNEL @"CHANNEL"
#define UNIQUEID @"UNIQUEID"


//接口前缀
#define portsUser @"user"
#define portsRooms @"rooms"
#define portsSystem @"system"
#define portsWallet @"wallet"
#define portsTrans @"trade"


#define YaoJiangViewTimeLength [NormalUse yaoJiangViewTimeLength]
#define BlackVipViewTimeLength [NormalUse blackVipViewTimeLength]
#define VipGetFreecountTimeLength [NormalUse vipGetFreecountTimeLength]


#endif /* Consdfine_h */
