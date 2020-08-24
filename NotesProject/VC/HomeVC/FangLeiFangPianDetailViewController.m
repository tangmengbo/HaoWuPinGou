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
    
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.topNavView.top+self.topNavView.height, WIDTH_PingMu, HEIGHT_PingMu-(self.topNavView.top+self.topNavView.height))];
    self.contentTextView.font = [UIFont systemFontOfSize:15*BiLiWidth];
    self.contentTextView.textColor = RGBFormUIColor(0x868686);
    [self.view addSubview:self.contentTextView];
    
    [HTTPModel getArticleDetail:[[NSDictionary alloc]initWithObjectsAndKeys:self.idStr,@"id", nil] callback:^(NSInteger status, id  _Nullable responseObject, NSString * _Nullable msg) {
        
        NSDictionary * info = responseObject;
        NSString * contentStr = [info objectForKey:@"content"];
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        self.contentTextView.attributedText = attrStr;
        [self.contentTextView sizeToFit];

    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
