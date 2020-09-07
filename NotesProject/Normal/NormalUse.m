//
//  Common.m
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-10.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import "NormalUse.h"
#import <sys/utsname.h>
#import <Security/Security.h>
//获取idfa
#import <AdSupport/ASIdentifierManager.h>
#import <CFNetwork/CFNetwork.h>



@implementation NormalUse


+ (BOOL)strNilOrEmpty:(NSString *)string
{
    if ([string isKindOfClass:[NSString class]])
    {
        if (string.length > 0)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}

+ (NSString*)getDateStringByFormateString:(NSString*)formateString date:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formateString];
    NSString *strDate = [formatter stringFromDate:date];
    return strDate;
}

+(NSString *)getTimestamp:(NSDate *)date
{
    NSString *timeString = @"";
    if([date isKindOfClass:[NSDate class]])
    {
      timeString = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    }
    return timeString;
}

//图片缩放到指定大小尺寸
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    CGSize imgsize =size;
    
    UIGraphicsBeginImageContext(imgsize);
    [img drawInRect:CGRectMake(0, 0, imgsize.width, imgsize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
+ (BOOL) isValidString:(id)input
{
    if (!input) {
        return NO;
    }
    if(input==nil)
    {
        return NO;
    }
    if([input isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    if ((NSNull *)input == [NSNull null]) {
        return NO;
    }
    if (![input isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([input isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

+ (BOOL) isValidDictionary:(id)input
{
    if (!input) {
        return NO;
    }
    if ((NSNull *)input == [NSNull null]) {
        return NO;
    }
    if (![input isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    if ([input count] <= 0) {
        return NO;
    }
    return YES;
}

+ (BOOL) isValidArray:(id)input
{
    if (!input) {
        return NO;
    }
    if ((NSNull *)input == [NSNull null]) {
        return NO;
    }
    if (![input isKindOfClass:[NSArray class]]) {
        return NO;
    }
    if ([input count] <= 0) {
        return NO;
    }
    return YES;
}



+(NSString *)getCurrentUserName {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:UserInformation];
    return [userInfo objectForKey:@"nickname"];
}
+(NSString *)getCurrentAvatarpath {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:UserInformation];
    return [userInfo objectForKey:@"avatar"];
}
+(NSString *)getUpdateStatusStr
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * status = [defaults objectForKey:@"AnchorOrUser"];
    return status;
}

+(NSString *)getNowUserID {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:UserInformation];
    return [userInfo objectForKey:@"userId"];
}

+(NSString *)getCurrentUserSex
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:UserInformation];
    return [userInfo objectForKey:@"sex"];

}
+(NSString *)getCurrentUserAnchorType
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * info = [userDefaults objectForKey:UserInformation];
    NSNumber * numberType = [info objectForKey:@"accountType"];
    NSString * typeStr = [NSString stringWithFormat:@"%d",numberType.intValue];
    return typeStr;
}

+(NSString *)getVIPStatus{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:UserInformation];
    return [userInfo objectForKey:@"isVip"];

}
+(NSString *)getRoleStatus
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:UserInformation];
    return [userInfo objectForKey:@"role"];

}

//较验用户名
+ (BOOL)validateUserName:(NSString*)number {
    BOOL res = YES;
    if(![NormalUse isValidString:number])
        return NO;
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+(CGSize)setSize:(NSString *)message withCGSize:(CGSize)cgsize  withFontSize:(float)fontSize
{

    
    CGSize  size = [message boundingRectWithSize:cgsize  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size;
}



//+(UIImage *)generateImageForGalleryWithImage:(UIImage *)image
//{
//    UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:image];
//    tmpImageView.frame                  = CGRectMake(0.0f, 0.0f, image.size.width, image.size.width);
//    tmpImageView.layer.borderColor      = [UIColor whiteColor].CGColor;
//    tmpImageView.layer.borderWidth      = 0.0;
//    tmpImageView.layer.shouldRasterize  = YES;
//    
//    UIImage *tmpImage   = [UIImage imageFromView:tmpImageView];
//    
//    return [tmpImage transparentBorderImage:1.0f];
//}

+(NSString *)getobjectForKey:(id)object
{
    NSString *temp = @"";
    if(object  && ![object isEqual:[NSNull class]] &&![object isEqual:[NSNull null]])
    {
        temp = object;
    }
    return temp;
}

+(NSString *)getReadableDateFromTimestamp:(NSString *)stamp
{
    NSString *_timestamp;
    
    NSTimeInterval createdAt = [stamp doubleValue];
    
    // Calculate distance time string
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);  // createdAt
    if (distance < 0) distance = 0;
    
    if (distance < 30) {
        _timestamp = @"Just now";
    }
    else if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"Seconds ago" : @"Seconds ago"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"Minutes ago" : @"Minutes ago"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"Hours ago" : @"Hours ago"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = ((distance / 60 / 60 / 24) + ((distance % (60 * 60 * 24))>0?1:0));
        if (distance == 1) {
            _timestamp =@"Yesterday" ;
        } else if (distance == 2) {
            _timestamp = @"1 day ago";
        } else {
            _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"Days ago" : @"Days ago"];
        }
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"Weeks ago" : @"Weeks ago"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yy-MM-dd"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    
    return _timestamp;
}
+(NSString *)getSiLiaoReadableDateFromTimestamp:(NSTimeInterval)createdAt
{
    NSString *_timestamp;
    
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);  // createdAt
    
    if (distance < 0) distance = 0;
    


    if(distance<60 * 60 * 24)
    {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];

    }
    else
    {
        distance = ((distance / 60 / 60 / 24) + ((distance % (60 * 60 * 24))>0?1:0));
        if (distance == 1) {
            
            static NSDateFormatter *dateFormatter = nil;
            if (dateFormatter == nil) {
                [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm"];
            }
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
            _timestamp = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:date]];
        } else if (distance == 2) {
            
            static NSDateFormatter *dateFormatter = nil;
            if (dateFormatter == nil) {
                [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm"];
            }
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
            _timestamp = [NSString stringWithFormat:@"前天 %@",[dateFormatter stringFromDate:date]];

        } else {

            static NSDateFormatter *dateFormatter = nil;
            if (dateFormatter == nil) {
                [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            }
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
            _timestamp = [dateFormatter stringFromDate:date];

        }
    }
    return _timestamp;
}
+ (NSString *)weekdayStringWithDate:(NSDate *)date {
    //获取星期几
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [componets weekday];//1代表星期日，2代表星期一，后面依次
    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    //NSArray *weekArray = @[@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"];
    NSString *weekStr = weekArray[weekday-1];
    return weekStr;

   
}
+(NSString *)getMessageReadableDateFromTimestamp:(NSString *)stamp
{
    NSString *_timestamp;
    
    NSTimeInterval createdAt = [stamp doubleValue];
    time_t now;
    time(&now);
    int distance = (int)difftime(now, createdAt);  // createdAt
    if (distance < 0) distance = 0;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
    
    NSLog(@"%@",[NormalUse weekdayStringWithDate:date]);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if ([calendar isDateInToday:date]) {
        
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
        }
        _timestamp = [dateFormatter stringFromDate:date];

    }
    else if ([calendar isDateInYesterday:date])
    {
        _timestamp = [NSString stringWithFormat:@"%@",@"Yesterday" ];

    }
    else if (distance < 60 * 60 * 24 * 7)
    {
        

        _timestamp = [NormalUse weekdayStringWithDate:date];
    }
    else
    {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yy-MM-dd"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];

    }
    return _timestamp;
        
   
}
//获取 昨天 今天 周几 动态列表
+(NSString *)getMessageReadableDateFromTimestampTrend:(NSString *)stamp
{
    NSString *_timestamp;
    
    NSTimeInterval createdAt = [stamp doubleValue];
    time_t now;
    time(&now);
    int distance = (int)difftime(now, createdAt);  // createdAt
    if (distance < 0) distance = 0;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
    
    NSLog(@"%@",[NormalUse weekdayStringWithDate:date]);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if ([calendar isDateInToday:date]) {
        
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
        }
        _timestamp = [dateFormatter stringFromDate:date];

    }
    else if ([calendar isDateInYesterday:date])
    {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [NSString stringWithFormat:@"%@ %@",@"Yesterday",[dateFormatter stringFromDate:date] ];

    }
    else if (distance < 60 * 60 * 24 * 7)
    {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
        }

        _timestamp = [NSString stringWithFormat:@"%@ %@",[NormalUse weekdayStringWithDate:date],[dateFormatter stringFromDate:date]];
    }
    else
    {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yy-MM-dd  HH:mm"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        _timestamp = [dateFormatter stringFromDate:date];

    }
    return _timestamp;

}
+(NSString*)uuid
{
    NSString *chars=@"abcdefghijklmnopgrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    assert(chars.length==62);
    int len=chars.length;
    NSMutableString* result=[[NSMutableString alloc] init];
    for(int i=0;i<24;i++){
        int p=arc4random_uniform(len);
        NSRange range=NSMakeRange(p, 1);
        [result appendString:[chars substringWithRange:range]];
    }
    return result;
}

#pragma mark - time

+(UILabel * )showToastView:(NSString *)message view:(UIView *)view;
{
    
    UIView * bottomAlphaView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomAlphaView.alpha = 0.8;
    bottomAlphaView.backgroundColor = [UIColor blackColor];
    [view addSubview:bottomAlphaView];
    
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectZero];
    tipLable.textColor = [UIColor whiteColor];
    tipLable.font = [UIFont systemFontOfSize:12];
    tipLable.layer.masksToBounds = YES;
    tipLable.numberOfLines = 0;
    [view addSubview:tipLable];
    
    CGSize oneLineSize = [NormalUse setSize:message withCGSize:CGSizeMake(WIDTH_PingMu, HEIGHT_PingMu) withFontSize:12];
    
    float duration;
    if (oneLineSize.width>WIDTH_PingMu-80) {
        
        tipLable.frame = CGRectMake((WIDTH_PingMu-(WIDTH_PingMu-80))/2, 0, WIDTH_PingMu-80*BiLiWidth, 0);
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:message];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [message length])];
        tipLable.attributedText = attributedString;
        //设置自适应
        [tipLable  sizeToFit];
        
        if (tipLable.frame.size.height<40) {
            
            bottomAlphaView.frame = CGRectMake((WIDTH_PingMu-(tipLable.frame.size.width+20))/2, (HEIGHT_PingMu-40)/2, tipLable.frame.size.width+20, 40);
            
            tipLable.frame = CGRectMake((WIDTH_PingMu-tipLable.frame.size.width)/2, (HEIGHT_PingMu-40)/2, tipLable.frame.size.width, 40);
            
            duration = 5;
        }
        else
        {
            
            bottomAlphaView.frame = CGRectMake((WIDTH_PingMu-(tipLable.frame.size.width+30))/2, (HEIGHT_PingMu-tipLable.frame.size.height-20)/2, tipLable.frame.size.width+30, tipLable.frame.size.height+20);
            
            tipLable.frame = CGRectMake((WIDTH_PingMu-tipLable.frame.size.width)/2, (HEIGHT_PingMu-tipLable.frame.size.height)/2, tipLable.frame.size.width, tipLable.frame.size.height);
            
            duration = 8;

        }

        
    }
    else
    {
        bottomAlphaView.frame = CGRectMake((WIDTH_PingMu-(oneLineSize.width+20))/2, (HEIGHT_PingMu-40)/2, oneLineSize.width+20, 40);
        
        tipLable.frame = CGRectMake((WIDTH_PingMu-(oneLineSize.width))/2, (HEIGHT_PingMu-40)/2, oneLineSize.width, 40);
        tipLable.text = message;
        
        duration = 3;
    }
    
    bottomAlphaView.layer.cornerRadius = bottomAlphaView.frame.size.height/2;
    tipLable.textAlignment = NSTextAlignmentCenter;

    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{

        tipLable.alpha = 0;
        bottomAlphaView.alpha = 0;

    } completion:^(BOOL finished) {

        [tipLable removeFromSuperview];
        [bottomAlphaView removeAllSubviews];
    }];
    
    return tipLable;
}

//发布时间与当前时间的间隔
+ (NSString *)intervalSinceNow: (NSDate *) theDate
{
    
    NSTimeInterval late=[theDate timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"NO";
    
    NSTimeInterval cha=now-late;
    if (cha/60>2)
    {
    
        timeString=@"YES";
        
    }
    return timeString;
}

+ (NSString*)getDeviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *device = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return device;
}

//获取图片格式
+(NSString *)contentTypeForImageData:(NSData *)data {
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpeg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"tiff";
            
        case 0x52:
            
            if ([data length] < 12) {
                
                return nil;
                
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            
            if(testString!=nil && ![testString isKindOfClass:[NSNull class]])
            {
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                
                return @"webp";
                
            }
            }
            
            return nil;
            
    }
    
    return nil;
    
}
+(void)shakeAnimationForView:(UIView *) view
{
    // 获取到当前的View
    
    CALayer *viewLayer = view.layer;
    
    // 获取当前View的位置
    
    CGPoint position = viewLayer.position;
    
    // 移动的两个终点位置
    
    CGPoint x = CGPointMake(position.x + 15, position.y);
    
    CGPoint y = CGPointMake(position.x - 15, position.y);
    
    // 设置动画
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 设置运动形式
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    // 设置开始位置
    
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    
    // 设置结束位置
    
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    // 设置自动反转
    
    [animation setAutoreverses:YES];
    
    // 设置时间
    
    [animation setDuration:.06];
    
    // 设置次数
    
    [animation setRepeatCount:5];
    
    // 添加上动画
    
    [viewLayer addAnimation:animation forKey:nil];
    
    
    
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
//    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSMutableString *responseString = [NSMutableString stringWithString:jsonString];
//    NSString *character = nil;
//    for (int i = 0; i < responseString.length; i ++) {
//        character = [responseString substringWithRange:NSMakeRange(i, 1)];
//        NSLog(@"%@",character);
//        if ([character isEqualToString:@"\\"])
//        {
//            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
//        }
//    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
//    if(err)
//    {
////        NSLog(@"json解析失败：%@",err);
//        return nil;
//    }
    return dic;
}


+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
//判断字符串是否为空或全是空格
+ (BOOL) isEmpty:(NSString *) str {
    
    if(!str) {
        
        return true;
        
    }else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        
        if([trimedString length] == 0) {
            
            return true;
            
            
        }else {
            
            
            return false;
            
            
        }
        
    }
    
    
}
//获取视频的第一帧
+ (UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}
+(NSString *)shiJianDistanceAlsoDaYu3Days:(NSString *)timestamp distance:(int)timeDistance;
{
    
    NSTimeInterval createdAt = [timestamp doubleValue];
    
    // Calculate distance time string
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);  // createdAt
   if (distance >= 60 * 60 * 24 * timeDistance)
   {
       return @"大于3天";
   }
    else
    {
        return @"小于3天";
    }
}
+(NSString *)shiJianDistanceAlsoDaYu5Minutes:(NSString *)timestamp distance:(int)timeDistance;
{
    
    NSTimeInterval createdAt = [timestamp doubleValue];
    
    // Calculate distance time string
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);  // createdAt
    if (distance >= 60 * timeDistance)
    {
        return @"大于5分钟";
    }
    else
    {
        return @"小于5分钟";
    }
}
//获取ip和地理位置信息以及国家名
+(NSDictionary *)getWANIP

{
 
        //通过淘宝的服务来定位WAN的IP，否则获取路由IP没什么用
        NSUserDefaults * getIpParameterDefaults = [NSUserDefaults standardUserDefaults];
        NSString * ipPathStr = [getIpParameterDefaults objectForKey:@"getIpParameterDefaultsKey"];
        
        NSURL *ipURL =  [NSURL URLWithString:ipPathStr];
        NSData *data = [NSData dataWithContentsOfURL:ipURL];
        NSDictionary *ipDic;
        if(data)
        {
            ipDic  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        
        NSDictionary * dic = [ipDic objectForKey:@"data"];
        
        return dic;
    
    
}
+(NSDictionary *)deviceWANIPAdress{
    

        NSError *error;
        
        NSUserDefaults * getIpParameterDefaults = [NSUserDefaults standardUserDefaults];
        NSString * ipPathStr = [getIpParameterDefaults objectForKey:@"getIpParameterDefaultsKey"];
        
        NSURL *ipURL = [NSURL URLWithString:ipPathStr]; //  http://pv.sohu.com/cityjson?ie=utf-8
        
        NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
        
        //判断返回字符串是否为所需数据
        
        if ([ip hasPrefix:@"var returnCitySN = "]) {
            
            //对字符串进行处理，然后进行json解析
            //删除字符串多余字符串
            
            NSRange range = NSMakeRange(0, 19);
            
            [ip deleteCharactersInRange:range];
            
            NSString * nowIp =[ip substringToIndex:ip.length-1];
            
            //将字符串转换成二进制进行Json解析
            
            NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            return dict;
            
        }
    
        return nil;
    
}
+(void)xianShiGifLoadingView:(UIViewController *)vc
{
    UIView * loadingBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, TopHeight_PingMu+44, WIDTH_PingMu, HEIGHT_PingMu)];
    loadingBottomView.backgroundColor = [UIColor clearColor];
    loadingBottomView.tag = -12121212;
    [vc.view addSubview:loadingBottomView];
    
    NSString  *name = @"loading.gif";
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    
    UIImageView * loadingImageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH_PingMu-60)/2,(HEIGHT_PingMu-60)/2, 60, 60)];
    loadingImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    [loadingBottomView addSubview:loadingImageView];
}

+(void)quXiaoGifLoadingView:(UIViewController *)vc
{
    for (UIView * loadingView in [vc.view subviews]) {
        
        if (loadingView.tag==-12121212) {
            
            [loadingView removeAllSubviews];
            [loadingView removeFromSuperview];
            
            break;
        }
    }
}

+(void)showMessageLoadView:(NSString *)message vc:(UIViewController *)vc
{
    UIView * loadingBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    loadingBottomView.backgroundColor = [UIColor clearColor];
    loadingBottomView.tag = -1332569;
    [vc.view addSubview:loadingBottomView];
    
    UIView * loadingBottomAlphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PingMu, HEIGHT_PingMu)];
    loadingBottomAlphaView.backgroundColor = [UIColor blackColor];
    loadingBottomAlphaView.alpha = 0.5;
    [loadingBottomView addSubview:loadingBottomAlphaView];
    
    UIView * loadingView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_PingMu-200)/2, (HEIGHT_PingMu-60-80)/2, 200, 70)];
    loadingView.backgroundColor = [UIColor blackColor];
    loadingView.layer.cornerRadius = 10;
    loadingView.alpha = 0.8;
    [loadingBottomView addSubview:loadingView];
    
    UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityView startAnimating];
    activityView.frame = CGRectMake(20, 25, 20, 20);
    [loadingView addSubview:activityView];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 300, 70)];
    tipLable.text = [NSString stringWithFormat:@"%@",message];
    tipLable.textColor = [UIColor whiteColor];
    tipLable.font = [UIFont systemFontOfSize:15];
    [loadingView addSubview:tipLable];
}
+(void)removeMessageLoadingView:(UIViewController *)vc
{
    for (UIView * loadingView in [vc.view subviews]) {
        
        if (loadingView.tag==-1332569) {
            
            [loadingView removeAllSubviews];
            [loadingView removeFromSuperview];
            
            break;
        }
    }
}

// 删除NSArray中的NSNull
+ (NSMutableArray *)removeNullFromArray:(NSArray *)arr
{
    NSMutableArray *marr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSValue *value = arr[i];
        // 删除NSDictionary中的NSNull，再添加进数组
        if ([value isKindOfClass:NSDictionary.class]) {
            [marr addObject:[NormalUse removeNullFromDictionary:(NSDictionary *)value]];
        }
        // 删除NSArray中的NSNull，再添加进数组
        else if ([value isKindOfClass:NSArray.class]) {
            [marr addObject:[self removeNullFromArray:(NSArray *)value]];
        }
        // 剩余的非NSNull类型的数据添加进数组
        else if (![value isKindOfClass:NSNull.class]) {
            [marr addObject:value];
        }
    }
    return marr;
    
}
// 删除Dictionary中的NSNull
+ (NSMutableDictionary *)removeNullFromDictionary:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *strKey in dic.allKeys) {
        NSValue *value = dic[strKey];
        // 删除NSDictionary中的NSNull，再保存进字典
        if ([value isKindOfClass:NSDictionary.class]) {
            mdic[strKey] = [self removeNullFromDictionary:(NSDictionary *)value];
        }
        // 删除NSArray中的NSNull，再保存进字典
        else if ([value isKindOfClass:NSArray.class]) {
            mdic[strKey] = [NormalUse removeNullFromArray:(NSArray *)value];
        }
        // 剩余的非NSNull类型的数据保存进字典
        else if (![value isKindOfClass:NSNull.class]) {
            mdic[strKey] = dic[strKey];
        }
    }
    return mdic;
}
+(NSString *)getCurrentSex
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:UserInformation];
    NSNumber * sexNumber = [userInfo objectForKey:@"sex"];
    return [NSString stringWithFormat:@"%d",sexNumber.intValue];
    
}
/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
+ (UIImage *)imageWithScreenshot
{
    NSData *imageData = [NormalUse dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}
//截取当前屏幕内容 将以下代码粘贴复制 直接调用imageWithScreenshot方法
/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
+ (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}
//图片合成
+ (UIImage *)composeImg :(UIImage *)bottomImage topImage:(UIImage *)topImage hcImageWidth:(float)hcImageWidth  hcImageHeight:(float)hcImageHeight hcFrame:(CGRect)hcFrame{
    
    //以1.png的图大小为画布创建上下文
    UIGraphicsBeginImageContext(CGSizeMake(hcImageWidth*4, hcImageHeight*4)); //*4是为了保持清晰度
    [bottomImage drawInRect:CGRectMake(0, 0, hcImageWidth*4, hcImageHeight*4)];//先把1.png 画到上下文中
    [topImage drawInRect:hcFrame];//再把小图放在上下文中
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文
    return resultImg;
}
//生成二维码
+(UIImage * )erweima :(NSString *)dingDanHao
{
    
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[dingDanHao dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    return [NormalUse createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    
}
//改变二维码大小

+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}
+(int)getEnvironment
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([@"1" isEqualToString:[defaults objectForKey:@"environmentKey"]]) {
        
        return 1;
    }
    else
    {
        return 0;
    }
    
}

+ (UIViewController *)getCurrentVC {
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowVC = [self recursiveFindCurrentShowViewControllerFromViewController:rootVC];
    
    return currentShowVC;
}
+ (UIViewController *)recursiveFindCurrentShowViewControllerFromViewController:(UIViewController *)fromVC
{
    
    if ([fromVC isKindOfClass:[UINavigationController class]]) {
        
        return [self recursiveFindCurrentShowViewControllerFromViewController:[((UINavigationController *)fromVC) visibleViewController]];
        
    } else if ([fromVC isKindOfClass:[UITabBarController class]]) {
        
        return [self recursiveFindCurrentShowViewControllerFromViewController:[((UITabBarController *)fromVC) selectedViewController]];
        
    } else {
        
        if (fromVC.presentedViewController) {
            
            return [self recursiveFindCurrentShowViewControllerFromViewController:fromVC.presentedViewController];
            
        } else {
            
            return fromVC;
            
        }
        
    }
    
}
+ (NSString *)getCurrentDeviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([deviceModel isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([deviceModel isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([deviceModel isEqualToString:@"iPhone12,8"])   return @"iPhone SE2";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}

+(BOOL)getVideoLimit
{
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Limited camera rights, unable to view and record videos" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction* addBalckAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }];
        
        [alert addAction:cancleAction];
        [alert addAction:addBalckAction];
        [[NormalUse getCurrentVC] presentViewController:alert animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}
+(BOOL)getRadioLimit
{
    NSString *mediaType = AVMediaTypeAudio;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Microphone access is limited and video recording is not possible" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction* addBalckAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }];
        
        [alert addAction:cancleAction];
        [alert addAction:addBalckAction];
        [[NormalUse getCurrentVC] presentViewController:alert animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}

//去除字符串中的emoji
+ (NSString *)filterEmoji:(NSString *)str {
    
    //@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]"
    NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:@"[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString* result = [expression stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:@""];
    
    return result;
}

+(void)setTextFieldPlaceholder:(NSString *)textStr placeHoldColor:(UIColor *)color textField:(UITextField *)textField
{
    NSMutableAttributedString * placeholderString = [[NSMutableAttributedString alloc] initWithString:textStr attributes:@{NSForegroundColorAttributeName :color}];
    textField.attributedPlaceholder = placeholderString;
}
//当前配置的多语言环境是否支持当前的系统语言
+(BOOL)alsoSystemLanguageSupport
{
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    if (![languageName hasPrefix:@"en"] &&![languageName containsString:@"ar"] && ![languageName containsString:@"hi"]&& ![languageName containsString:@"id"]) {
        
        return NO;
    }
    else
    {
        return YES;
    }
}
+ (UIImage *)countryCodeImage:(NSString *)countryCode{
    
    NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"XYCountryCode"ofType:@"bundle"];
    
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *filename = [NSString stringWithFormat:@"Images/%@",countryCode];
    NSString *path = [resourceBundle pathForResource:filename ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}

+ (NSString *)firstCharactorWithString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return [pinYin substringToIndex:1];
}
//获取在线状态对应的图片
+(NSString *)getUserJobStatusImageName:(NSString *)jobStatus onLineStatus:(NSString *)onLineStatus
{
    NSString * jobImageName;
    if(![NormalUse isValidString:jobStatus]){
        
      if ([@"1" isEqualToString:onLineStatus]) {
            
             jobImageName  = @"online_image";
        }
        else
        {
             jobImageName = @"offline_image";
        }
    }else {
        if (jobStatus.intValue >= 4) {
            
            jobImageName  = @"online_image";
            
        } else if(jobStatus.intValue >= 3){
            
            jobImageName  = @"reliao_image";
            
        }else {
            
            jobImageName  = @"offline_image";
        }
    }
    return jobImageName;
}
//100000->100,000 字符串隔三位加逗号
+(NSString *)hanleNums:(NSString *)numbers{
    NSString *str = [numbers substringWithRange:NSMakeRange(numbers.length%3, numbers.length-numbers.length%3)];
    NSString *strs = [numbers substringWithRange:NSMakeRange(0, numbers.length%3)];
    for (int  i =0; i < str.length; i =i+3) {
        NSString *sss = [str substringWithRange:NSMakeRange(i, 3)];
        strs = [strs stringByAppendingString:[NSString stringWithFormat:@",%@",sss]];
    }
    if ([[strs substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
        strs = [strs substringWithRange:NSMakeRange(1, strs.length-1)];
    }
    return strs;
}
+(void)anHeiShiPei:(id)view lightColor:(UIColor *)lightColor  darkColor:(UIColor *)darkColor
{
    if (@available(iOS 13.0, *)) {
        UIColor * rightColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) { //浅色模式
                return RGBFormUIColor(0x333333);
            } else { //深色模式
                return [UIColor whiteColor];
            }
        }];
        
        if ([view isKindOfClass:[UILabel class]]) {
            
            UILabel * lable = (UILabel *)view;
            lable.textColor = rightColor; //根据当前模式(光明\暗黑)-展示相应颜色 关键是这一句
        }
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton * button = (UIButton *)view;
            [button setTitleColor:rightColor forState:UIControlStateNormal]; //根据当前模式(光明\暗黑)-展示相应颜色 关键是这一句
        }
    }

}
//是否设置了代理
+ (BOOL)getProxyStatus {
    
    NSDictionary *proxySettings = NSMakeCollectable([(NSDictionary *)CFNetworkCopySystemProxySettings() autorelease]);
    NSArray *proxies = NSMakeCollectable([(NSArray *)CFNetworkCopyProxiesForURL((CFURLRef)[NSURL URLWithString:@"https://api-global.hala.icu"], (CFDictionaryRef)proxySettings) autorelease]);
    NSDictionary *settings = [proxies objectAtIndex:0];
    
    NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
    {
        //没有设置代理
        return NO;
    }
    else
    {
        //设置代理了
        return YES;
    }
    
}
+(void)setImageViewMoHu:(UIImageView *)imageView
{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
    effectview.alpha = .8f;
    [imageView addSubview:effectview];


}
+(void)setImageViewMoHu:(UIImageView *)imageView alphaValue:(float)alphaValue
{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
    effectview.alpha = alphaValue;
    effectview.tag = -1001;
    [imageView addSubview:effectview];
    
}
+(void)removeImageViewMoHu:(UIImageView *)imageView
{
    for (UIView * view in imageView.subviews) {
        
        if(view.tag==-1001)
        {
            [view removeFromSuperview];
        }
            
    }

}
+(NSString *)getSheBeiBianMa
{
    NSString * sheBeiBianMa;
    if ( [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        
        sheBeiBianMa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    else
    {
        sheBeiBianMa = [SimulateIDFA createSimulateIDFA];

    }
    return sheBeiBianMa;
}
+(void)defaultsSetObject:(id)value forKey:(NSString *)key
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

+(id)defaultsGetObjectKey:(NSString *)key
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}
+(BOOL)alsoShowTabbar
{
    return YES;
}


@end
