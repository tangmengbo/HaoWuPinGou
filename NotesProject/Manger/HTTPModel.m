//
//  HTTPModel.m
//  FindingMe
//
//  Created by pfjhetg on 2016/12/13.
//  Copyright © 2016年 3VOnline Inc. All rights reserved.
//

#import "HTTPModel.h"
#import "AppDelegate.h"
#import "NSData+Additions.h"
#import <AdSupport/AdSupport.h>



#define WEAKSELF __weak typeof(self) weakSelf = self;


// 最后一句不要斜线
#define singleton_implementation(className) \
static className *_instace; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
\
return _instace; \
} \
\
+ (instancetype)shared##className \
{ \
if (_instace == nil) { \
_instace = [[className alloc] init]; \
} \
\
return _instace; \
}



@implementation HTTPModel
singleton_implementation(HTTPModel)

# pragma - mark 封装请求

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
    progress:(void (^)(NSProgress *))progress
     success:(void (^)(NSURLSessionDataTask *, id))success
     failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    WEAKSELF
    
    
    AFAppDotNetAPIClient * apiClient =   [AFAppDotNetAPIClient sharedClient];
    
    //    [apiClient.requestSerializer setValue:@"appstore" forHTTPHeaderField:@"channel"];
    
    
    [apiClient POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (maxCont == 1) {
            if (failure) {
                failure(task, error);
                // [Common showMessageView:NET_ERROR_MSG];
            }
        } else if (error.code == -1001 || re.statusCode == 504) {
            dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                [weakSelf REPLYPOST:URLString  errerCount:1 parameters:parameters progress:progress success:success failure:failure];
            });
        } else {
            if (failure) {
                failure(task, error);
                // [Common showMessageView:NET_ERROR_MSG];
                // [Common showMessageView:NET_ERROR_MSG view:self.view];
            }
        }
    }];
}


+ (void)REPLYPOST:(NSString *)URLString
       errerCount:(int)errerCount
       parameters:(id)parameters
         progress:(void (^)(NSProgress *))progress
          success:(void (^)(NSURLSessionDataTask *, id))success
          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    WEAKSELF
    [[AFAppDotNetAPIClient sharedClient] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (error.code == -1001 || re.statusCode == 504) {
            int er = errerCount +1;
            if (er>=maxCont) {
                if (failure) {
                    failure(task, error);
                    // [Common showMessageView:NET_ERROR_MSG];
                }
            } else {
                dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                    [weakSelf REPLYPOST:URLString errerCount:er parameters:parameters progress:progress success:success failure:failure];
                });
            }
        } else {
            if (failure) {
                failure(task, error);
                //[Common showMessageView:NET_ERROR_MSG];
            }
        }
    }];
}


+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *))progress
    success:(void (^)(NSURLSessionDataTask *, id))success
    failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    WEAKSELF
    [[AFAppDotNetAPIClient sharedClient] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (maxCont == 1) {
            if (failure) {
                failure(task, error);
                // [Common showMessageView:NET_ERROR_MSG];
            }
        } else if (error.code == -1001 || re.statusCode == 504) {
            dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                [weakSelf REPLYGET:URLString  errerCount:1 parameters:parameters progress:progress success:success failure:failure];
            });
        } else {
            if (failure) {
                failure(task, error);
                // [Common showMessageView:NET_ERROR_MSG];
            }
        }
    }];
}


+ (void)REPLYGET:(NSString *)URLString  errerCount:(int)errerCount parameters:(id)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    __weak typeof(self) _weekSelf = self;
    [[AFAppDotNetAPIClient sharedClient] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (error.code == -1001 || re.statusCode == 504) {
            int er = errerCount + 1;
            if (er >= maxCont) {
                if (failure) {
                    failure(task, error);
                    // [Common showMessageView:NET_ERROR_MSG];
                }
            } else {
                dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                    [_weekSelf REPLYGET:URLString  errerCount:er parameters:parameters progress:progress success:success failure:failure];
                });
            }
        } else {
            if (failure) {
                failure(task, error);
                // [Common showMessageView:NET_ERROR_MSG];
            }
        }
    }];
}


+ (void)SINGERGET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    [[AFAppDotNetAPIClient sharedClient] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
            // [Common showMessageView:NET_ERROR_MSG];
        }
    }];
}


+ (void)clearAllRequt{
    [AFAppDotNetAPIClient clearAllRequest];
}


# pragma - mark http请求接口

+(void)getCurrentCity:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/common/curCity",HTTP_REQUESTURL];
    
    [HTTPModel GET:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSNumber * code = [dict objectForKey:@"code"];
        if (code.intValue==1) {
            
            if ([dict valueForKey:@"data"]) {
                
                callback([[dict valueForKey:@"code"] integerValue], [dict valueForKey:@"data"], [dict objectForKey:@"info"]);
            }
            
        }
        else
        {
            callback(code.intValue, nil, [dict objectForKey:@"info"]);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        callback(-1, nil, NET_ERROR_MSG);
        
        
    }];
    
}
+(void)getHotCityList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url =  [NSString stringWithFormat:@"%@/common/getHotCity",HTTP_REQUESTURL];
    
    [HTTPModel GET:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSNumber * code = [dict objectForKey:@"code"];
        if (code.intValue==1) {
            
            if ([dict valueForKey:@"data"]) {
                
                callback([[dict valueForKey:@"code"] integerValue], [dict valueForKey:@"data"], [dict objectForKey:@"info"]);
            }
        }
        else
        {
            callback(code.intValue, nil, [dict objectForKey:@"info"]);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

+(void)getCityList:(NSDictionary *_Nullable)parameter
          callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url =  [NSString stringWithFormat:@"%@/common/getCityList",HTTP_REQUESTURL];
    
    [HTTPModel GET:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSNumber * code = [dict objectForKey:@"code"];
        if (code.intValue==1) {
            
            if ([dict valueForKey:@"data"]) {
                
                callback([[dict valueForKey:@"code"] integerValue], [dict valueForKey:@"data"], [dict objectForKey:@"info"]);
            }
            
        }
        else
        {
            callback(code.intValue, nil, [dict objectForKey:@"info"]);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        callback(error.code, nil, error.domain);
        
    }];
}
+(void)getVerifyCode:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/common/sendSmsCode",HTTP_REQUESTURL];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSNumber * code = [dict objectForKey:@"code"];
        if (code.intValue==1) {
            
            if ([dict valueForKey:@"data"]) {
                
                callback([[dict valueForKey:@"code"] integerValue], [dict valueForKey:@"data"], [dict objectForKey:@"info"]);
            }
            
        }
        else
        {
            callback(code.intValue, nil, [dict objectForKey:@"info"]);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        callback(-1, nil, NET_ERROR_MSG);
    }];
    
}
+(void)login:(NSDictionary *_Nullable)parameter
    callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url = [NSString stringWithFormat:@"%@/login/index",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSNumber * code = [dict objectForKey:@"code"];
        if (code.intValue==1) {
            
            if ([dict valueForKey:@"data"]) {
                
                callback([[dict valueForKey:@"code"] integerValue], [dict valueForKey:@"data"], [dict objectForKey:@"info"]);
            }
            
        }
        else
        {
            callback(code.intValue, nil, [dict objectForKey:@"info"]);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        callback(-1, nil, NET_ERROR_MSG);
    }];
    
}
+(void)uploadImageVideo:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url = [NSString stringWithFormat:@"http://129.28.198.178:8090/api/upload/img_upload"];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSNumber * code = [dict objectForKey:@"code"];
        if (code.intValue==1) {
            
            if ([dict valueForKey:@"data"]) {
                
                callback([[dict valueForKey:@"code"] integerValue], [dict valueForKey:@"data"], [dict objectForKey:@"info"]);
            }
            
        }
        else
        {
            callback(code.intValue, nil, [dict objectForKey:@"info"]);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        callback(-1, nil, NET_ERROR_MSG);
    }];
    
}
+(void)getBannerList:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url = [NSString stringWithFormat:@"%@/common/bannerList",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSNumber * code = [dict objectForKey:@"code"];
        if (code.intValue==1) {
            
            if ([dict valueForKey:@"data"]) {
                
                callback([[dict valueForKey:@"code"] integerValue], [dict valueForKey:@"data"], [dict objectForKey:@"info"]);
            }
            
        }
        else
        {
            callback(code.intValue, nil, [dict objectForKey:@"info"]);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        callback(-1, nil, NET_ERROR_MSG);
    }];
    
}
//防雷防骗列表
+(void)getArticleList:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/common/getArticleList",HTTP_REQUESTURL];
    
    [HTTPModel GET:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSNumber * code = [dict objectForKey:@"code"];
        if (code.intValue==1) {
            
            if ([dict valueForKey:@"data"]) {
                
                callback([[dict valueForKey:@"code"] integerValue], [dict valueForKey:@"data"], [dict objectForKey:@"info"]);
            }
            
        }
        else
        {
            callback(code.intValue, nil, [dict objectForKey:@"info"]);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        callback(error.code, nil, error.domain);
        
    }];

}
//防雷防骗详情
+(void)getArticleDetail:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/common/getArticleDetail",HTTP_REQUESTURL];
    
    [HTTPModel GET:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSNumber * code = [dict objectForKey:@"code"];
        if (code.intValue==1) {
            
            if ([dict valueForKey:@"data"]) {
                
                callback([[dict valueForKey:@"code"] integerValue], [dict valueForKey:@"data"], [dict objectForKey:@"info"]);
            }
            
        }
        else
        {
            callback(code.intValue, nil, [dict objectForKey:@"info"]);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        callback(error.code, nil, error.domain);
        
    }];

}




@end
















