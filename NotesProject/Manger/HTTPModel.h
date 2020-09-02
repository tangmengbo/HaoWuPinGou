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

//设置手势密码
+(void)setShouShiMiMa:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//是否需要手势密码
+(void)alsoNeesShouShiMiMa:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//验证手势密码
+(void)checkShouShiMiMa:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;


+(void)loginOut:(NSDictionary *_Nullable)parameter
       callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//上传文件
+(void)uploadImageVideo:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//用文件路径获取对应id
+(void)saveFile:(NSDictionary *_Nullable)parameter
       callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//投诉帖子
+(void)tieZiTouSu:(NSDictionary *_Nullable)parameter
         callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//获取信息类型
+(void)getXinXiLeiXing:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//获取服务类型
+(void)getFuWuLeiXing:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//获取小姐类型
+(void)getXiaoJieLeiXing:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//定制需求 Upscale/made
+(void)dingZhiXuQiu:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//项目金币列表
+(void)getAppJinBiList:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//参数 type 0 闪屏页 1 首页 2高端 3夫妻交 4活动 5我的    
+(void)getBannerList:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//体验报告列表
+(void)getTiYanBaoGaoList:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;


//防雷防骗列表
+(void)getArticleList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//黑店列表 /appi/home/black_shops
+(void)getHeiDianList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//黑店详情
+(void)getHeiDianDetail:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//茶小二&经纪人认证
+(void)jingJiRenRenZheng:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//三大认证申请接口  1女神 2外围女 3全球空降
+(void)sanDaRenZheng:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//帖子列表
+(void)getTieZiList:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//红榜推荐 home/red_list
+(void)getRedList:(NSDictionary *_Nullable)parameter
         callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//验证榜单
+(void)getYanZhengList:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//验车报告
+(void)getYanCheBaoGaoList:(NSDictionary *_Nullable)parameter
                  callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//防雷防骗详情
+(void)getArticleDetail:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//活动首页 
+(void)getHuoDongHomeInfo:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//官方推荐店铺
+(void)getGuanFangTuiJianDianPu:(NSDictionary *_Nullable)parameter
                       callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//经纪人店铺详情
+(void)getDianPuDetail:(NSDictionary *_Nullable)parameter
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
