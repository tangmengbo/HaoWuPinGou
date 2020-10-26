//
//  Common.h
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-10.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
/*获取手机ip*/
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
#import "SimulateIDFA.h"

/*获取手机ip*/

@interface NormalUse : NSObject

//获取当前sh状态
+(NSString *)getUpdateStatusStr;
//获取当前用户id
+(NSString *)getNowUserID;

+(NSString *)getCurrentaccessid;

+(NSString *)getCurrentUserName;

+(NSString *)getCurrentUserSex;

+(NSString *)getCurrentUserAnchorType;

+(NSString *)getCurrentAvatarpath;

+(NSString *)getVIPStatus;

+(NSString *)getRoleStatus;


+ (BOOL)strNilOrEmpty:(NSString *)string;

//将指定日期转换成格式化日期字符串
+ (NSString*)getDateStringByFormateString:(NSString*)formateString date:(NSDate*)date;

//获取当前时间戳
+(NSString *)getTimestamp:(NSDate *)date;

//图片缩放到指定大小尺寸
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

+ (BOOL) isValidString:(id)input;

+ (BOOL) isValidDictionary:(id)input;

+ (BOOL) isValidArray:(id)input;

+ (BOOL)validateUserName:(NSString*)number;

//根据字体大小获取字符串的size
+(CGSize)setSize:(NSString *)message withCGSize:(CGSize)cgsize  withFontSize:(float)fontSize;


+(NSString *)getobjectForKey:(id)object;

//时间转为几分钟前 ,几秒前
+(NSString *)getReadableDateFromTimestamp:(NSString *)timestamp;

+(NSString *)getSiLiaoReadableDateFromTimestamp:(NSTimeInterval )createdAt;

+ (NSString *)weekdayStringWithDate:(NSDate *)date;

//获取 昨天 今天 周几 消息列表
+(NSString *)getMessageReadableDateFromTimestamp:(NSString *)stamp;

//获取 昨天 今天 周几 动态列表
+(NSString *)getMessageReadableDateFromTimestampTrend:(NSString *)stamp;

+(NSString*)uuid;

+(UILabel * )showToastView:(NSString *)message view:(UIView *)view;

+ (NSString *)intervalSinceNow: (NSDate *) theDate;
//获取设备型号
+ (NSString*)getDeviceType;


//获取图片格式
+(NSString *)contentTypeForImageData:(NSData *)data ;
//抖动效果
+(void)shakeAnimationForView:(UIView *) view;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


//dictionary转json字符串
+(NSString *)convertToJsonData:(NSDictionary *)dict;

//判断字符串是否为空或全是空格
+ (BOOL) isEmpty:(NSString *) str;

//获取视频第一帧图片
+ (UIImage*) getVideoPreViewImage:(NSURL *)path;

//判断时间间隔是否大于3天
+(NSString *)shiJianDistanceAlsoDaYu3Days:(NSString *)timestamp distance:(int)timeDistance;

//判断时间间隔是否大于5分钟
+(NSString *)shiJianDistanceAlsoDaYu5Minutes:(NSString *)timestamp distance:(int)timeDistance;

//获取ip和地理位置信息以及国家名
+(NSDictionary *)getWANIP;

+(NSDictionary *)deviceWANIPAdress;

+(void)xianShiGifLoadingView:(UIViewController *)vc;

+(void)quXiaoGifLoadingView:(UIViewController *)vc;

+(void)removeMessageLoadingView:(UIViewController *)vc;

+(void)showMessageLoadView:(NSString *)message vc:(UIViewController *)vc;


+ (NSMutableArray *)removeNullFromArray:(NSArray *)arr;
+ (NSMutableDictionary *)removeNullFromDictionary:(NSDictionary *)dic;
+ (NSString *)getCurrentSex;

//截取当前屏幕
+ (UIImage *)imageWithScreenshot;
+ (NSData *)dataWithScreenshotInPNGFormat;

//图片合成
+ (UIImage *)composeImg :(UIImage *)bottomImage topImage:(UIImage *)topImage hcImageWidth:(float)hcImageWidth  hcImageHeight:(float)hcImageHeight hcFrame:(CGRect)hcFrame;

//生成二维码
+(UIImage * )erweima :(NSString *)dingDanHao;

//对图片本身进行旋转
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

+ (NSString *)getCurrentDeviceModel;
+ (UIViewController *)getCurrentVC;//获取当前的vc
+(BOOL)getVideoLimit;
+(BOOL)getRadioLimit;


+(void)setTextFieldPlaceholder:(NSString *)textStr placeHoldColor:(UIColor *)color textField:(UITextField *)textField;


//当前配置的多语言环境是否支持当前的系统语言
+(BOOL)alsoSystemLanguageSupport;

+ (UIImage *)countryCodeImage:(NSString *)countryCode;
+ (NSString *)firstCharactorWithString:(NSString *)string;//获取字符串首字母

+(NSString *)getUserJobStatusImageName:(NSString *)jobStatus onLineStatus:(NSString *)onLineStatus;//获取在线状态对应的图片
//100000->100,000 字符串隔三位加逗号
+(NSString *)hanleNums:(NSString *)numbers;

+(void)anHeiShiPei:(id)view lightColor:(UIColor *)lightColor  darkColor:(UIColor *)darkColor;

//是否设置了代理
+(BOOL)getProxyStatus;

+(void)setImageViewMoHu:(UIImageView *)imageView;

+(void)setImageViewMoHu:(UIImageView *)imageView alphaValue:(float)alphaValue;

+(void)removeImageViewMoHu:(UIImageView *)imageView;


+(NSString *)getSheBeiBianMa;


+(void)defaultsSetObject:(id)value forKey:(NSString *)key;

+(id)defaultsGetObjectKey:(NSString *)key;

+(id)getJinBiStr:(NSString *)key;

+(BOOL)alsoShowTabbar;

+(UIImage *)shengChengErWeiMa:(NSString *)pathStr;

+(NSString *)netWorkState;


@end
