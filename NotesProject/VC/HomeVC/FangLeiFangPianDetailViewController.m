//
//  FangLeiFangPianDetailViewController.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/8/24.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "FangLeiFangPianDetailViewController.h"

@interface FangLeiFangPianDetailViewController ()



@end

@implementation FangLeiFangPianDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topTitleLale.text = [self.info objectForKey:@"title"];
    


    
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    self.contentTextView.font = [UIFont systemFontOfSize:12*BiLiWidth];
    self.contentTextView.textColor = RGBFormUIColor(0x868686);
    [self.view addSubview:self.contentTextView];
    
    NSString * content = [self.info objectForKey:@"content"];
    content = [self replaceImageHtml:content];
    
    NSAttributedString * attributedString = [self setAttributedString:content font:[UIFont systemFontOfSize:16] lineSpacing:2];
    //CGFloat textHeight = [self getHTMLHeightByStr:content font:[UIFont systemFontOfSize:16] lineSpacing:2 width:WIDTH_PingMu];

//    NSData *data = [content dataUsingEncoding:NSUnicodeStringEncoding];
//    self.contentTextView.attributedText = [[NSAttributedString alloc] initWithData:data options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    self.contentTextView.attributedText = attributedString;


}
/**
 html 富文本设置

 @param str html 未处理的字符串
 @param font 设置字体
 @param lineSpacing 设置行高
 @return 默认不将 \n替换<br/> 返回处理好的富文本
 */
-(NSMutableAttributedString *)setAttributedString:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing
{
    //如果有换行，把\n替换成<br/>
    //如果有需要把换行加上
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    //设置HTML图片的宽度
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    //设置富文本字的大小
//    [htmlString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:lineSpacing];
//    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [htmlString length])];
    
    return htmlString;

}
/**
 计算html字符串高度

 @param str html 未处理的字符串
 @param font 字体设置
 @param lineSpacing 行高设置
 @param width 容器宽度设置
 @return 富文本高度
 */
-(CGFloat )getHTMLHeightByStr:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width
{
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    [htmlString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpacing];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [htmlString length])];
    
    CGSize contextSize = [htmlString boundingRectWithSize:(CGSize){width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return contextSize.height ;
    

}
//用正则表达式匹配文字中的链接 并且替换成 域名+链接
-(NSString *)zhengZeTiHuan:(NSString *)content
{
    NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:@"/upload/.{30,40}[(jpg)|(png)|(gif)|(jpeg)]" options:NSRegularExpressionCaseInsensitive error:nil];

    NSString* result = [expression stringByReplacingMatchesInString:content options:0 range:NSMakeRange(0, content.length) withTemplate:@""];
    
    return result;
}
- (NSString *)replaceImageHtml:(NSString *)oldHtml {
    
    NSMutableArray * array = [NSMutableArray array];
    NSString *regex = @"/upload/.{30,40}[(jpg)|(png)|(gif)|(jpeg)]";
    NSRange r;
    NSMutableString *newHtml = [NSMutableString stringWithString:oldHtml];
    
    BOOL flag = false;
    
    while (flag == false) {
        
        r = [newHtml rangeOfString:regex options:NSRegularExpressionSearch];
        
        
        if (r.location != NSNotFound) {
            
            NSString * replaceStr = [newHtml substringWithRange:r];
            
            [array addObject:replaceStr];

            [newHtml replaceCharactersInRange:r withString:@"1000000001"];
            
        } else {
            flag = true;
        }
        
    };
    
    regex = @"1000000001";
    
    flag = false;
    
    int i=0;

    while (flag == false) {
        
        r = [newHtml rangeOfString:regex options:NSRegularExpressionSearch];
        
        if (r.location != NSNotFound) {
            
            NSString * replaceStr = [array objectAtIndex:i];

            [newHtml replaceCharactersInRange:r withString:[NSString stringWithFormat:@"%@%@",HTTP_REQUESTURL,replaceStr]];
            i++;
            
        } else {
            flag = true;
        }
        
    };

    
    return newHtml;
}


@end
