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
                NSString *fileName=[NSString stringWithFormat:@"%@.%@",dateStr,@"MP4"];
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
        
        [apiClient.requestSerializer setValue:[NormalUse defaultsGetObjectKey:LoginToken] forHTTPHeaderField:@"logintoken"];
    }
    
    [apiClient GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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
//帖子列表home/index
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
//购买兑奖码
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

@end
















