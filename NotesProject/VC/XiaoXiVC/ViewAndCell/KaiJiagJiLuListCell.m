//
//  KaiJiagJiLuListCell.m
//  JianZhi
//
//  Created by 唐蒙波 on 2020/9/18.
//  Copyright © 2020 Meng. All rights reserved.
//

#import "KaiJiagJiLuListCell.h"

@implementation KaiJiagJiLuListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectedBackgroundView = [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];//RGBFormUIColor(0xF4F4F4);

        self.backgroundColor = RGBFormUIColor(0xF9F9F9);


    }
    return self;
}
-(void)initData:(NSDictionary *)info
{
    [self.contentView removeAllSubviews];
    
    NSDictionary *  draw_detail = [info objectForKey:@"draw_detail"];
    
    if ([NormalUse isValidDictionary:draw_detail]) {
        
        NSArray * firstArray = [draw_detail objectForKey:@"first"];
        NSArray * secondArray = [draw_detail objectForKey:@"second"];
        NSArray * threeArray = [draw_detail objectForKey:@"three"];
        
        float originY = 19*BiLiWidth;
        
        for (int i=0; i<firstArray.count; i++) {
            
            if (i==0) {
                
                UIImageView * biaoShiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50.5*BiLiWidth, originY, 17.5*BiLiWidth, 21*BiLiWidth)];
                biaoShiImageView.image = [UIImage imageNamed:@"kaiJiang_1"];
                [self.contentView addSubview:biaoShiImageView];
                
            }
            NSDictionary * info = [firstArray objectAtIndex:i];
            
            UILabel * haoMaLable = [[UILabel alloc] initWithFrame:CGRectMake(78.5*BiLiWidth, originY, 110*BiLiWidth, 21*BiLiWidth)];
            haoMaLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
            haoMaLable.textColor = RGBFormUIColor(0x666666);
            NSNumber * ticket_code = [info objectForKey:@"ticket_code"];
            haoMaLable.text = [NSString stringWithFormat:@"中奖号码 %d",ticket_code.intValue];
            [self.contentView addSubview:haoMaLable];
            
            UILabel * jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(haoMaLable.left+haoMaLable.width+50*BiLiWidth, originY, 150*BiLiWidth, 21*BiLiWidth)];
            jinBiLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
            jinBiLable.textColor = RGBFormUIColor(0x666666);
            NSNumber * obtain_coin = [info objectForKey:@"obtain_coin"];
            jinBiLable.text = [NSString stringWithFormat:@"%d个金币",obtain_coin.intValue];
            [self.contentView addSubview:jinBiLable];

            
            originY = originY+38*BiLiWidth;
        }
        
        for (int i=0; i<secondArray.count; i++) {
            
            if (i==0) {
                
                UIImageView * biaoShiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50.5*BiLiWidth, originY, 17.5*BiLiWidth, 21*BiLiWidth)];
                biaoShiImageView.image = [UIImage imageNamed:@"kaiJiang_2"];
                [self.contentView addSubview:biaoShiImageView];
                
            }
            
            NSDictionary * info = [secondArray objectAtIndex:i];
            
            UILabel * haoMaLable = [[UILabel alloc] initWithFrame:CGRectMake(78.5*BiLiWidth, originY, 110*BiLiWidth, 21*BiLiWidth)];
            haoMaLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
            haoMaLable.textColor = RGBFormUIColor(0x666666);
            NSNumber * ticket_code = [info objectForKey:@"ticket_code"];
            haoMaLable.text = [NSString stringWithFormat:@"中奖号码 %d",ticket_code.intValue];
            [self.contentView addSubview:haoMaLable];
            
            UILabel * jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(haoMaLable.left+haoMaLable.width+50*BiLiWidth, originY, 150*BiLiWidth, 21*BiLiWidth)];
            jinBiLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
            jinBiLable.textColor = RGBFormUIColor(0x666666);
            NSNumber * obtain_coin = [info objectForKey:@"obtain_coin"];
            jinBiLable.text = [NSString stringWithFormat:@"%d个金币",obtain_coin.intValue];
            [self.contentView addSubview:jinBiLable];

            
            originY = originY+38*BiLiWidth;
        }

        
        for (int i=0; i<threeArray.count; i++) {
            
            if (i==0) {
                
                UIImageView * biaoShiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50.5*BiLiWidth, originY, 17.5*BiLiWidth, 21*BiLiWidth)];
                biaoShiImageView.image = [UIImage imageNamed:@"kaiJiang_3"];
                [self.contentView addSubview:biaoShiImageView];
                
            }
            
            NSDictionary * info = [threeArray objectAtIndex:i];
            
            UILabel * haoMaLable = [[UILabel alloc] initWithFrame:CGRectMake(78.5*BiLiWidth, originY, 110*BiLiWidth, 21*BiLiWidth)];
            haoMaLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
            haoMaLable.textColor = RGBFormUIColor(0x666666);
            NSNumber * ticket_code = [info objectForKey:@"ticket_code"];
            haoMaLable.text = [NSString stringWithFormat:@"中奖号码 %d",ticket_code.intValue];
            [self.contentView addSubview:haoMaLable];
            
            UILabel * jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(haoMaLable.left+haoMaLable.width+50*BiLiWidth, originY, 150*BiLiWidth, 21*BiLiWidth)];
            jinBiLable.font = [UIFont systemFontOfSize:13*BiLiWidth];
            jinBiLable.textColor = RGBFormUIColor(0x666666);
            NSNumber * obtain_coin = [info objectForKey:@"obtain_coin"];
            jinBiLable.text = [NSString stringWithFormat:@"%d个金币",obtain_coin.intValue];
            [self.contentView addSubview:jinBiLable];

            
            originY = originY+38*BiLiWidth;
        }

    }

    
}
+(float)getCellHeight:(NSDictionary *)info
{
    float originY = 19*BiLiWidth;
    
    NSDictionary *  draw_detail = [info objectForKey:@"draw_detail"];
    if([NormalUse isValidDictionary:draw_detail])
    {
        NSArray * firstArray = [draw_detail objectForKey:@"first"];
        NSArray * secondArray = [draw_detail objectForKey:@"second"];
        NSArray * threeArray = [draw_detail objectForKey:@"three"];
        
        if ([NormalUse isValidArray:firstArray]) {
            
            originY = originY+firstArray.count*38*BiLiWidth;
        }
        if ([NormalUse isValidArray:secondArray]) {
            
            originY = originY+secondArray.count*38*BiLiWidth;
        }
        if ([NormalUse isValidArray:threeArray]) {
            
            originY = originY+threeArray.count*38*BiLiWidth;
        }
        return originY;

    }
    else
    {
        return 0;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
