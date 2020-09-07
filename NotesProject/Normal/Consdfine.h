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



#else
#pragma mark 接口 测试
#define RYKey @"k51hidwqke44b"
#define WYAPPKey @"4317b56661cca83a3fdee0ffeed0ffcf"
//网易云信appkey
#define WYCertificate @"YoYoPushDev"
#define HTTP_REQUESTURL @"http://42.194.167.215:8089"
#define HTTP_FileUpload @"http://129.28.198.178:8090"
#endif




//当前设置的宽、高
#define WIDTH_PingMu [UIScreen mainScreen].bounds.size.width
#define HEIGHT_PingMu [UIScreen mainScreen].bounds.size.height


#define TopHeight_PingMu ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 35 : 20)
#define BottomHeight_PingMu ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 64 : 49)


#define BiLiWidth [UIScreen mainScreen].bounds.size.width/360
#define BiLiHeight  [UIScreen mainScreen].bounds.size.height/667



#define RGBFormUIColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#define UserInformation @"UserINFO" //当前用户信息
#define LoginToken @"LoginTokenDefaults" //当前用户token
#define CurrentCity @"CurrentCityDefaults" //当前城市
#define UserRole @"UserRoleDefaults"//当前用户角色


#endif /* Consdfine_h */
