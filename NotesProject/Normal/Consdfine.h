//
//  Consdfine.h
//  NotesProject
//
//  Created by BoBo on 2019/10/15.
//  Copyright © 2019 BoBo. All rights reserved.
//

#ifndef Consdfine_h
#define Consdfine_h

//是否是正式环境0:测试，1:正式
#define IS_FORMAL_ENVIRONMENT  0
    
#if IS_FORMAL_ENVIRONMENT
#pragma mark 接口 生产

//融云key
#define RYKey @"tdrvipkstyvg5"
#define WYAPPKey @"211a06a77c365aa1d071ead6a86b3412"
#define WYCertificate @"yoyoPushDis"

#define HTTP_REQUESTURL @"http://yzjs.yingheyezi.com/wh/"



#else
#pragma mark 接口 测试
#define RYKey @"k51hidwqke44b"
#define WYAPPKey @"4317b56661cca83a3fdee0ffeed0ffcf"
//网易云信appkey
#define WYCertificate @"YoYoPushDev"
#define HTTP_REQUESTURL @"http://42.194.167.215:8089"
#define HTTP_FileUpload @"http://129.28.198.178:8090"
#endif




//当前设置的宽、高
#define WIDTH_PingMu [UIScreen mainScreen].bounds.size.width
#define HEIGHT_PingMu [UIScreen mainScreen].bounds.size.height


#define TopHeight_PingMu ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 35 : 20)
#define BottomHeight_PingMu ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 64 : 49)


#define BiLiWidth [UIScreen mainScreen].bounds.size.width/360
#define BiLiHeight  [UIScreen mainScreen].bounds.size.height/667



#define RGBFormUIColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#define UserInformation @"UserINFO" //当前用户信息
#define LoginToken @"LoginTokenDefaults" //当前用户token
#define CurrentCity @"CurrentCityDefaults" //当前城市
#define UserRole @"UserRoleDefaults"//当前用户角色
#define JinBiShuoMing @"JinBIShuoMingDefaults"//项目金币说明
/*
 "cny_to_coin":"10",//人民币兑换金币比率 1人民币对应 10金币
 "normal_auth_coin":"1000",//茶小二认证所需金币
 "agent_auth_coin":"500",//经纪人认证所需金币
 "goddess_auth_coin":"1000",//女神认证所需金币
 "peripheral_auth_coin":"1000",//外围女认证所需金币
 "global_auth_coin":"10000",//全球陪玩认证所需金币
 "cash_out_percentage":"30",//提现手续费百分比
 "share_percentage":"300",//分享提成奖励金币
 "unlock_mobile_coin":"200",//联系方式解锁所需金币
 "made_requirement_coin":"300",//定制需求所需金币
 "cash_out_limit":"500",//提现最低额度
 "publish_post_coin":"100",//发布帖子所需金币
 "vip_forever_coin":"1000000",//终身会员金币
 "vip_year_coin":"100000",//年会员金币
 "ticket_buy_coin":"50",//购买彩票码金币
 "vip_funlock_num":"15",//终身会员当天解锁次数
 "vip_fpost_num":"15",//终身会员当天发帖次数
 "vip_ypost_num":"10",//年会员当天发帖次数
 "vip_yunlock_num":"10",//年会员当天解锁次数
 "vip_fpack_coin":"1000",//开通终身会员送的金币
 "vip_ypack_coin":"500",//开通年会员送的金币
 "couple_auth_coin":"10000",//夫妻交友认证金币
 "enabled_post_normal":"1",//茶馆儿是否允许免费发帖
 "enabled_post_agent":"1",//经纪人是否允许免费发帖
 "unlock_post_coin":"100",//解锁普通帖子金币
 "unlock_agent_coin":"600",//解锁经纪人金币
 "unlock_couple_coin":"200",//解锁夫妻交友金币
 "unlock_peripheral_coin":"200",//解锁外围角色金币
 "unlock_global_coin":"200",//解锁全球角色金币
 "unlock_goddess_coin":"200",//解锁女神角色金币
 "unlock_demand_coin":"200",//解锁需求定制金币
 "vip_ticket_nums_day":"1",//VIP每天可以领取的兑奖码
 "ticket_coin_day":"50"//每个好友每天上线后可领取的金币数
 */


#endif /* Consdfine_h */
