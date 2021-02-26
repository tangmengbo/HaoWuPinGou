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
    
    if ([NormalUse isValidString:[NormalUse defaultsGetObjectKey:LoginToken]]) {
        
        [apiClient.requestSerializer setValue:[NormalUse defaultsGetObjectKey:LoginToken] forHTTPHeaderField:@"logintoken"];
        
    }
    NSDictionary * cityInfo = [NormalUse defaultsGetObjectKey:@"CityInfoDefaults"];
    if ([NormalUse isValidDictionary:cityInfo]) {
        
        NSNumber * cityCode = [cityInfo objectForKey:@"cityCode"];
        [apiClient.requestSerializer setValue:[NSString stringWithFormat:@"%d",cityCode.intValue] forHTTPHeaderField:@"citycode"];

    }
    else
    {
        [apiClient.requestSerializer setValue:@"" forHTTPHeaderField:@"citycode"];

    }


    
    //上传文件
    if([URLString containsString:@"upload/img_upload"])
    {
        [apiClient.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        
        NSDictionary * postInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[parameters objectForKey:@"upload_key"],@"upload_key", nil];
        
        [apiClient POST:URLString parameters:postInfo constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString * dateStr= [formatter stringFromDate:[NSDate date]];
            NSString * imageType = [NormalUse contentTypeForImageData:[parameters objectForKey:@"file"]];
            if([@"img" isEqualToString:[parameters objectForKey:@"file_type"]])
            {
                NSString *fileName=[NSString stringWithFormat:@"%@.%@",dateStr,imageType];
                [formData appendPartWithFileData:[parameters objectForKey:@"file"] name:@"file" fileName:fileName mimeType:@"image/jpeg"];
                
            }
            else
            {
                NSString *fileName=[NSString stringWithFormat:@"%@.%@",dateStr,@"MOV"];
                [formData appendPartWithFileData:[parameters objectForKey:@"file"] name:@"file" fileName:fileName mimeType:@"video/quicktime"];
                
            }
            
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
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
    else
    {
        //普通数据请求
        [apiClient.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        [apiClient.requestSerializer setValue:@"1233434" forHTTPHeaderField:@"user-agent"];
        [apiClient POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                if ([NormalUse isValidDictionary:dict]) {

                    NSNumber * code = [dict objectForKey:@"code"];

                    if (code.intValue==11403)
                    {
                        [NormalUse defaultsSetObject:nil forKey:LoginToken];
                        [NormalUse showToastView:[dict objectForKey:@"info"] view:[NormalUse getCurrentVC].view];
                    }
                }

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
    
    AFAppDotNetAPIClient * apiClient =   [AFAppDotNetAPIClient sharedClient];
    
    if ([NormalUse isValidString:[NormalUse defaultsGetObjectKey:LoginToken]]) {
        
        NSLog(@"%@",[NormalUse defaultsGetObjectKey:LoginToken]);
        [apiClient.requestSerializer setValue:[NormalUse defaultsGetObjectKey:LoginToken] forHTTPHeaderField:@"logintoken"];
    }
    
    NSDictionary * cityInfo = [NormalUse defaultsGetObjectKey:@"CityInfoDefaults"];
    if ([NormalUse isValidDictionary:cityInfo]) {
        
        NSNumber * cityCode = [cityInfo objectForKey:@"cityCode"];
        [apiClient.requestSerializer setValue:[NSString stringWithFormat:@"%d",cityCode.intValue] forHTTPHeaderField:@"citycode"];

    }
    else
    {
        [apiClient.requestSerializer setValue:@"" forHTTPHeaderField:@"citycode"];

    }
    
    [apiClient GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if ([NormalUse isValidDictionary:dict]) {
                
                NSNumber * code = [dict objectForKey:@"code"];
                if (code.intValue==11403) {
                    
                   [NormalUse defaultsSetObject:nil forKey:LoginToken];
                    
                    [NormalUse showToastView:[dict objectForKey:@"info"] view:[NormalUse getCurrentVC].view];
                }
                
            }
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
+ (void)IPByUrlGET:(NSString *)URLString
       parameters:(id)parameters
         progress:(void (^)(NSProgress *))progress
          success:(void (^)(NSURLSessionDataTask *, id))success
          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    
//    URLString = @"http://42.194.167.215:8089/appi/common/curCity";
    AFAppDotNetAPIClient * apiClient =   [AFAppDotNetAPIClient sharedClient];

    apiClient.requestSerializer.timeoutInterval = 5.f;
    
    [apiClient GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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
        }
    }];
}

+ (void)IPTestGET:(NSString *)URLString
       parameters:(id)parameters
         progress:(void (^)(NSProgress *))progress
          success:(void (^)(NSURLSessionDataTask *, id))success
          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    
    AFAppDotNetAPIClient * apiClient =   [AFAppDotNetAPIClient sharedClient];
    apiClient.requestSerializer.timeoutInterval = 5.f;
    
    [apiClient GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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

//通过url获取ip
+(void)getIPByUrl:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@",[parameter objectForKey:@"testUrl"]];

    //url = @"http://42.194.167.215:8089/appi/common/curCity";
    [HTTPModel IPByUrlGET:url parameters:nil progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *bodyString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

        if([NormalUse isValidString:bodyString])
        {
            NSArray * ipArray = [bodyString componentsSeparatedByString:@";"];

            if ([NormalUse isValidArray:ipArray]) {
                
                callback(1, ipArray, nil);

            }
            else
            {
                callback(-1, nil, nil);

            }

        }
        else
        {
            callback(-1, nil, nil);

        }

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        callback(-1, nil, NET_ERROR_MSG);
        
        
    }];

}
//根据Ip获取Url数组
+(void)getUrlListByIp:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"http://%@:8089/appi/common/getSiteUrls",[parameter objectForKey:@"uri"]];
    
    [HTTPModel IPByUrlGET:url parameters:parameter progress:^(NSProgress * progress) {
        
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

//ip是否可用
+(void)IpTestCheck:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@",[parameter objectForKey:@"testIp"]];
    
    [HTTPModel IPTestGET:url parameters:nil progress:^(NSProgress * progress) {
        
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
        
        if ([@"NSURLErrorDomain" isEqualToString:error.domain]) {//无效IP
            
            callback(-1, nil, @"无效IP");

        }
        else
        {
            callback(-2, nil, NET_ERROR_MSG);
        }
        
        
    }];

}
# pragma - mark http请求接口

+(void)getCurrentCity:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/common/curCity",HTTP_REQUESTURL];
    
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
    
    NSString *url =  [NSString stringWithFormat:@"%@/appi/common/getHotCity",HTTP_REQUESTURL];
    
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
    
    NSString *url =  [NSString stringWithFormat:@"%@/appi/common/getCityList",HTTP_REQUESTURL];
    
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
//填写邀请码

+(void)tianXieYaoQingMa:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/save_shcode",HTTP_REQUESTURL];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
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
//手机号是否存在
+(void)mobileAlsoExit:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/mobile_exist",HTTP_REQUESTURL];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
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

+(void)jieBangMobile:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/unbind_mobile",HTTP_REQUESTURL];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
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
+(void)getVerifyCode:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/common/sendSmsCode",HTTP_REQUESTURL];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
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
//绑定手机号
+(void)bangDingMobile:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/bind_mobile",HTTP_REQUESTURL];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
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

//重置密码

+(void)chognZhiMiMa:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/forget_password",HTTP_REQUESTURL];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
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
//编辑用户信息
+(void)editUserInfo:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/save",HTTP_REQUESTURL];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
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
//检测账号是否可用

+(void)acountAlsoCanUse:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/common/getUserStatus",HTTP_REQUESTURL];;
    
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

//获取初始化账号
+(void)registerInit:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/register/getInitName",HTTP_REQUESTURL];;
    
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
//phone_ucode 手机唯一码 【该参数存在即表示初始化登录，不存在正常手机号密码登录】
+(void)login:(NSDictionary *_Nullable)parameter
    callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url = [NSString stringWithFormat:@"%@/appi/login/index",HTTP_REQUESTURL];;
    
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


+(void)loginOut:(NSDictionary *_Nullable)parameter
       callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/login/layout",HTTP_REQUESTURL];;
    
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

//设置手势密码
+(void)setShouShiMiMa:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/setGesture",HTTP_REQUESTURL];;
    
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

//是否需要手势密码
+(void)alsoNeesShouShiMiMa:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/getGesture",HTTP_REQUESTURL];;
    
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

//验证手势密码
+(void)checkShouShiMiMa:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/checkGesture",HTTP_REQUESTURL];;
    
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
    
    NSString *url = [NSString stringWithFormat:@"%@/api/upload/img_upload",HTTP_FileUpload];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
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
+(void)saveFile:(NSDictionary *_Nullable)parameter
       callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/common/saveInfo",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
+(void)tieZiTouSu:(NSDictionary *_Nullable)parameter
         callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url = [NSString stringWithFormat:@"%@/appi/home/complaint",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//系统公告
+(void)getXiTongGongGao:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/home/system_report",HTTP_REQUESTURL];;
    
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
//获取信息类型
+(void)getXinXiLeiXing:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/common/getMessageType",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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


//获取服务类型
+(void)getFuWuLeiXing:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/common/getServiceType",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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

//获取小姐类型
+(void)getXiaoJieLeiXing:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/common/getGirlType",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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

//定制列表
+(void)getDingZhiList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/home/made_list",HTTP_REQUESTURL];
    
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

//定制需求 Upscale/made
+(void)dingZhiXuQiu:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Upscale/made",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//定制详情
+(void)getDingZhiDetail:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/home/made_detail",HTTP_REQUESTURL];
    
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
//项目金币列表
+(void)getAppJinBiList:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/common/getCoinItem",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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

//个人角色获取[对应不同的认证权限]
+(void)getUserRole:(NSDictionary *_Nullable)parameter
          callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/getRole",HTTP_REQUESTURL];
    
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
//参数 type 0 闪屏页 1 首页 2高端 3夫妻交 4活动 5我的

+(void)getBannerList:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url = [NSString stringWithFormat:@"%@/appi/common/bannerList",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//体验报告列表
+(void)getTiYanBaoGaoList:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/Report/index",HTTP_REQUESTURL];
    
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
//防雷防骗列表
+(void)getArticleList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/common/getArticleList",HTTP_REQUESTURL];
    
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
//黑店列表 /appi/home/black_shops
+(void)getHeiDianList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/home/black_shops",HTTP_REQUESTURL];
    
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
//黑店详情
+(void)getHeiDianDetail:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/home/blackshop_detail",HTTP_REQUESTURL];
    
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
//黑店评价
+(void)heiDianPingJia:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/home/black_comment",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//发布黑店曝光

+(void)faBuHeiDianBaoGuang:(NSDictionary *_Nullable)parameter
                  callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/home/black_publish",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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

//茶小二&经纪人认证
+(void)jingJiRenRenZheng:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Upscale/auth_arole",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//会员认证
+(void)vipRenRenZheng:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/vipzone/auth_role",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//三大认证申请接口
+(void)sanDaRenZheng:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Upscale/auth_srole",HTTP_REQUESTURL];;
       
       [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
           
       } success:^(NSURLSessionDataTask *task, id responseObject) {
           
           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
           
           NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
           
           NSLog(@"%@",jsonStr);
           
           
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
//收藏帖子 type_id  1帖子 2三大角色 3夫妻交友
+(void)tieZiFollow:(NSDictionary *_Nullable)parameter
          callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Upscale/favorites",HTTP_REQUESTURL];;
       
       [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
           
       } success:^(NSURLSessionDataTask *task, id responseObject) {
           
           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
           
           NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
           
           NSLog(@"%@",jsonStr);
           
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

//取消收藏帖子
+(void)tieZiUnFollow:(NSDictionary *_Nullable)parameter
          callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Upscale/unfavorites",HTTP_REQUESTURL];;
       
       [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
           
       } success:^(NSURLSessionDataTask *task, id responseObject) {
           
           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
           
           NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
           
           NSLog(@"%@",jsonStr);
           
           
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
+(void)vipRenZhengFaTie:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/vipzone/post",HTTP_REQUESTURL];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//发布帖子
+(void)faBuTieZi:(NSDictionary *_Nullable)parameter
        callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/home/post",HTTP_REQUESTURL];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//帖子详情
+(void)getTieZiDetail:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/home/post_detail",HTTP_REQUESTURL];
    
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
//帖子列表
+(void)getTieZiList:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/home/index",HTTP_REQUESTURL];
    
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
//红榜推荐
+(void)getRedList:(NSDictionary *_Nullable)parameter
         callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/home/red_list",HTTP_REQUESTURL];
    
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
//验证榜单
+(void)getYanZhengList:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/home/report_post",HTTP_REQUESTURL];
    
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

//验车报告
+(void)getYanCheBaoGaoList:(NSDictionary *_Nullable)parameter
                  callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/home/report_list",HTTP_REQUESTURL];
    
    [HTTPModel GET:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
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
    NSString *url =  [NSString stringWithFormat:@"%@/appi/common/getArticleDetail",HTTP_REQUESTURL];
    
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

//活动首页
+(void)getHuoDongHomeInfo:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url =  [NSString stringWithFormat:@"%@/appi/Ticket/index",HTTP_REQUESTURL];
    
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
//官方推荐店铺
+(void)getGuanFangTuiJianDianPu:(NSDictionary *_Nullable)parameter
                       callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/Upscale/supportShop",HTTP_REQUESTURL];
    
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
//经纪人列表
+(void)getJingJiRenList:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Upscale/agentList",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//vipzone/index 获取会员专区列表
+(void)getVipZhuanQuList:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/vipzone/index",HTTP_REQUESTURL];
    
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
//女神/外围/全球列表
+(void)getSanDaGirlList:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/Upscale/girlList",HTTP_REQUESTURL];
    
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
//三大角色详情
+(void)getSanDaGirlDetail:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/Upscale/girlDetail",HTTP_REQUESTURL];
    
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


//经纪人创建店铺
+(void)createDianPu:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Upscale/editShop",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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

//经纪人店铺详情
+(void)getDianPuDetail:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Upscale/agentShopDetail",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//经纪人删帖(删掉某个旗下小姐)
+(void)jingJiRenShanChuTieZi:(NSDictionary *_Nullable)parameter
                   callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url =  [NSString stringWithFormat:@"%@/appi/Upscale/delPost",HTTP_REQUESTURL];
    
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
//关注店铺
+(void)dianPuFollow:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Upscale/follow",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//取消关注店铺
+(void)dianPuUnfollow:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Upscale/unfollow",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//开奖列表
+(void)getKaiJingList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url =  [NSString stringWithFormat:@"%@/appi/Ticket/ticketList",HTTP_REQUESTURL];
    
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
//开奖详情
+(void)getKaiJingDetail:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    
    NSString *url =  [NSString stringWithFormat:@"%@/appi/Ticket/ticketDetail",HTTP_REQUESTURL];
    
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
//领取好友登录金币getFriendCoins
+(void)getFriendCoins:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/ticket/getCoin",HTTP_REQUESTURL];
    
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
//购买兑奖码  vip_ticket_flag 该参数表示VIP免费领取兑奖码 传1，此时购买数量随便传个数字
+(void)buyTicket:(NSDictionary *_Nullable)parameter
        callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Ticket/buyTicket",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//获取购买记录
+(void)getBuyList:(NSDictionary *_Nullable)parameter
         callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Ticket/buyList",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//解锁 type_id  1经纪人 2茶小二 3女神 4外围 5全球陪玩 6定制服务 7夫妻交友
//related_id 对应的信息ID
+(void)unlockMobile:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/Upscale/unlockMobile",HTTP_REQUESTURL];

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
//预约 Upscale/interview
+(void)yuYueTieZi:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/Upscale/interview",HTTP_REQUESTURL];
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


//解锁列表(6类)  type_id  默认1。1经纪人 2茶小二 3女神 4外围 5全球陪玩 6定制服务 7夫妻交
+(void)getJieUnlockList:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/unlock_list",HTTP_REQUESTURL];

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
//夫妻交认证
+(void)fuQiJiaoRenZheng:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/couple/auth_couple",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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

//夫妻交列表
+(void)getFuQiJiaoList:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/couple/list",HTTP_REQUESTURL];

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

//夫妻交详情
+(void)getFuQiJiaoDetail:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/couple/detail",HTTP_REQUESTURL];

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
//个人信息
+(void)getUserInfo:(NSDictionary *_Nullable)parameter
          callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/info",HTTP_REQUESTURL];

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

//我的发布_帖子(信息)
+(void)getMyXinXiList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/publish_post",HTTP_REQUESTURL];

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
//我的发布_角色贴 type_id 1女神 2外围女 3全球空降
+(void)getJiaoSeFaTieList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/publish_authinfo",HTTP_REQUESTURL];

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
//我的发布_夫妻交发帖
+(void)getFuQiJiaoFaTieList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/publish_couple",HTTP_REQUESTURL];

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
//我的发布_黑店曝光
+(void)getMyHeiDianBaoGuangList:(NSDictionary *_Nullable)parameter
                   callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/publish_black",HTTP_REQUESTURL];

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

//我的发布_定制服务
+(void)getMyDingZhiFuWuList:(NSDictionary *_Nullable)parameter
                   callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/publish_made",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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


//我的发布_验证
+(void)getMyYanZhengList:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/publish_report",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//发布体验报告 
//type_id 1经纪人，茶小二帖子 2女神、外围、全球帖子
+(void)faBuTiYanBaoGao:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/Report/publish",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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
//我的收藏列表
+(void)getMyShouCangList:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/favorites_list",HTTP_REQUESTURL];

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

//我的关注列表
+(void)getMyGuanZhuList:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/follow_list",HTTP_REQUESTURL];

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

//appi/Upscale/shopDetail
//经纪人查看自己的店铺详情
+(void)jingJiRenGetDianPuDetail:(NSDictionary *_Nullable)parameter
                       callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/Upscale/shopDetail",HTTP_REQUESTURL];

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

//   0官方 1审核 2活动 默认官方消息
+(void)getXiaoXiMessageList:(NSDictionary *_Nullable)parameter
                   callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/MessageList",HTTP_REQUESTURL];

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
//官方消息详情
+(void)getGuanFangMessageDetail:(NSDictionary *_Nullable)parameter
                       callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/messageDetail",HTTP_REQUESTURL];

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
//开通会员  vip_type vip_forever永久会员 vip_year年会员
+(void)kaiTongHuiYuan:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/buyVip",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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

//会员描述信息
+(void)huiYuanMiaoShuXinXi:(NSDictionary *_Nullable)parameter
                  callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/vipInfoList",HTTP_REQUESTURL];

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
//金币明细  type_id 1收入 2支出 不填则所有

+(void)getJinBiMingXiList:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/coin_detail_list",HTTP_REQUESTURL];

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
//提现申请接口
+(void)tiXianShenQing:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@/appi/user/cashOut",HTTP_REQUESTURL];;
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonStr);
        
        
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

//发帖是否免费 如果是经纪人发帖的传该参数 1    
+(void)faTieAlsoFree:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/postingFree",HTTP_REQUESTURL];

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
//根据融云ID获取头像昵称
+(void)getUserInfoByRYID:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/getInfoByRyuid",HTTP_REQUESTURL];

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
//轮询获取最新消息
+(void)getNewMessageCount:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/getNewMessage",HTTP_REQUESTURL];

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
//站点地址列表
+(void)getJSSiteUrls:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/common/getJcSites",HTTP_REQUESTURL];

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
//查看支付状态 appi/mlpay/getPaystatus
+(void)checkZFStatus:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/mlpay/getPaystatus",HTTP_REQUESTURL];

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
//聚合下单 appi/mlpay/ddyOrdering
+(void)jvHeXiaDan:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/mlpay/ddyOrdering",HTTP_REQUESTURL];

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

//订单号生成接口 appi/mlpay/getddOrder
+(void)getZFOrderId:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/mlpay/getddOrder",HTTP_REQUESTURL];

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

//金币产品列表 appi/mlpay/ddyProducts
+(void)getZFJinBiList:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/mlpay/ddyProducts",HTTP_REQUESTURL];

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
//充值明细 appi/user/getRechargeList
+(void)getZFRechargeList:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/getRechargeList",HTTP_REQUESTURL];

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
//上传share_code appi/user/getPshareCode
+(void)getShareCode:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/user/getPshareCode",HTTP_REQUESTURL];

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
//获取支付渠道链接appi/common/getPayType
+(void)getCommonPayType:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  [NSString stringWithFormat:@"%@/appi/common/getPayType",HTTP_REQUESTURL];

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
+(void)getDataByUrl:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url =  @"https://xcypzp.com/upload/202101201455/110000/32821/test.jpg";

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
















