//
//  JiaoSeWeiRenZhengFaTieKouFeiVC.h
//  JianZhi
//
//  Created by 唐蒙波 on 2020/10/21.
//  Copyright © 2020 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JiaoSeWeiRenZhengFaTieKouFeiVC : MainBaseViewController

@property(nonatomic,strong)NSDictionary * info;
@property(nonatomic,strong)NSString * renZhengType;//1女神 2外围女 3全球空降
@property(nonatomic,assign)int  renZhengStatus;

@end

NS_ASSUME_NONNULL_END
