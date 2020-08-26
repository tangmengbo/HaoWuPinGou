//
//  HTTPModel.h
//  FindingMe
//
//  Created by pfjhetg on 2016/12/13.
//  Copyright © 2016年 3VOnline Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFAppDotNetAPIClient.h"
//重连次数
#define maxCont 10
//请求错误
#define NET_ERROR_MSG @"网络不给力"

//Singleton
// .h
#define singleton_interface(className) + (instancetype)shared##className;


@interface HTTPModel : NSObject

singleton_interface(HTTPModel)

//POST
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
    progress:(void (^)(NSProgress *))progress
     success:( void (^)(NSURLSessionDataTask *task, id  responseObject))success
     failure:( void (^)(NSURLSessionDataTask *  task, NSError *error))failure;

//GET
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *))progress
    success:( void (^)(NSURLSessionDataTask *task, id  responseObject))success
    failure:( void (^)(NSURLSessionDataTask *  task, NSError *error))failure;

//GET单次（链接失败不重新链接)
+ (void)SINGERGET:(NSString *)URLString
      parameters:(id)parameters
        progress:(void (^)(NSProgress *))progress
         success:(void (^)(NSURLSessionDataTask *, id))success
         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

//取消所有请求
+ (void)clearAllRequt;


//获取当前城市
+(void)getCurrentCity:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//获取热门城市列表
+(void)getHotCityList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//获取城市列表
+(void)getCityList:(NSDictionary *_Nullable)parameter
          callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//发送验证码
+(void)getVerifyCode:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

+(void)login:(NSDictionary *_Nullable)parameter
    callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

+(void)uploadImageVideo:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
+(void)getBannerList:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//防雷防骗列表
+(void)getArticleList:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//防雷防骗详情
+(void)getArticleDetail:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//活动首页 
+(void)getHuoDongHomeInfo:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//开奖列表 
+(void)getKaiJingList:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//开奖详情
+(void)getKaiJingDetail:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//购买兑奖码
+(void)buyTicket:(NSDictionary *_Nullable)parameter
        callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//获取购买记录
+(void)getBuyList:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

@end
