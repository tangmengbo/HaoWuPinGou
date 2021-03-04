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

+ (void)IPTestGET:(NSString *)URLString
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

//通过url获取ip
+(void)getIPByUrl:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//appi/common/getSiteUrls
//根据Ip获取Url数组
+(void)getUrlListByIp:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//ip是否可用
+(void)IpTestCheck:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//获取上传资源的接口域名
+(void)getResourceSite:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//获取当前城市
+(void)getCurrentCity:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//获取热门城市列表
+(void)getHotCityList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//获取城市列表
+(void)getCityList:(NSDictionary *_Nullable)parameter
          callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//填写邀请码
+(void)tianXieYaoQingMa:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//手机号是否存在
+(void)mobileAlsoExit:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//解绑手机号
+(void)jieBangMobile:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//发送验证码
+(void)getVerifyCode:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//绑定手机号
+(void)bangDingMobile:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//重置密码
+(void)chognZhiMiMa:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//编辑用户信息
+(void)editUserInfo:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//检测账号是否可用 appi/common/getUserStatus

+(void)acountAlsoCanUse:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;


//获取初始化账号
+(void)registerInit:(NSDictionary *_Nullable)parameter
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

//系统公告
+(void)getXiTongGongGao:(NSDictionary *_Nullable)parameter
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

//定制列表
+(void)getDingZhiList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//定制需求
+(void)dingZhiXuQiu:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//定制详情
+(void)getDingZhiDetail:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//项目金币列表
+(void)getAppJinBiList:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//个人角色获取[对应不同的认证权限]
+(void)getUserRole:(NSDictionary *_Nullable)parameter
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
//黑店评价
+(void)heiDianPingJia:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//发布黑店曝光
+(void)faBuHeiDianBaoGuang:(NSDictionary *_Nullable)parameter
                  callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//茶小二&经纪人认证
+(void)jingJiRenRenZheng:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//会员认证
+(void)vipRenRenZheng:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;


//三大认证申请接口  1女神 2外围女 3全球空降
+(void)sanDaRenZheng:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//收藏帖子
+(void)tieZiFollow:(NSDictionary *_Nullable)parameter
          callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//取消收藏帖子
+(void)tieZiUnFollow:(NSDictionary *_Nullable)parameter
          callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//会员认证发布帖子/vipzone/post
+(void)vipRenZhengFaTie:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//发布帖子
+(void)faBuTieZi:(NSDictionary *_Nullable)parameter
        callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//帖子详情
+(void)getTieZiDetail:(NSDictionary *_Nullable)parameter
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

//验车报告 帖子详情页面时传入，post_id在经纪人和茶小二帖子时传入。girl_id在女神、外围、全球详情时传入
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

//经纪人列表 appi/Upscale/agentList
+(void)getJingJiRenList:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//vipzone/index 获取会员专区列表
+(void)getVipZhuanQuList:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//女神/外围/全球列表  type_id 1女神 2外围 3全球 page 下标
+(void)getSanDaGirlList:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//三大角色详情
+(void)getSanDaGirlDetail:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//经纪人创建店铺
+(void)createDianPu:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//经纪人店铺
+(void)getDianPuDetail:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//经纪人删帖(删掉某个旗下小姐)
+(void)jingJiRenShanChuTieZi:(NSDictionary *_Nullable)parameter
                   callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//关注店铺
+(void)dianPuFollow:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//取消关注店铺
+(void)dianPuUnfollow:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//开奖列表 
+(void)getKaiJingList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//开奖详情
+(void)getKaiJingDetail:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;


//领取好友登录金币
+(void)getFriendCoins:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//购买兑奖码
+(void)buyTicket:(NSDictionary *_Nullable)parameter
        callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//获取购买记录
+(void)getBuyList:(NSDictionary *_Nullable)parameter
         callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//解锁  //解锁 type_id  1经纪人 2茶小二 3女神 4外围 5全球陪玩 6定制服务
+(void)unlockMobile:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//预约 type_id: 1会员帖(+经纪人贴) 2仨角色贴 3夫妻交友贴和普通帖子
+(void)yuYueTieZi:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//获取解锁列表(6类)  type_id  默认1。1经纪人 2茶小二 3女神 4外围 5全球陪玩 6定制服务
+(void)getJieUnlockList:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//夫妻交认证
+(void)fuQiJiaoRenZheng:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;


//夫妻交列表
+(void)getFuQiJiaoList:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//夫妻交详情
+(void)getFuQiJiaoDetail:(NSDictionary *_Nullable)parameter
callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//个人信息
+(void)getUserInfo:(NSDictionary *_Nullable)parameter
          callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//我的发布_帖子(信息)
+(void)getMyXinXiList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//我的发布_角色贴 type_id 1女神 2外围女 3全球空降
+(void)getJiaoSeFaTieList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//我的发布_夫妻交发帖
+(void)getFuQiJiaoFaTieList:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//我的发布_黑店曝光
+(void)getMyHeiDianBaoGuangList:(NSDictionary *_Nullable)parameter
                   callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//我的发布_定制服务
+(void)getMyDingZhiFuWuList:(NSDictionary *_Nullable)parameter
                   callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//我的发布_验证
+(void)getMyYanZhengList:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//发布体验报告
//type_id 1经纪人，茶小二帖子 2女神、外围、全球帖子
+(void)faBuTiYanBaoGao:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//我的收藏列表
+(void)getMyShouCangList:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//我的关注列表
+(void)getMyGuanZhuList:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//经纪人查看自己的店铺详情
+(void)jingJiRenGetDianPuDetail:(NSDictionary *_Nullable)parameter
                       callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//   0官方 1审核 2活动 默认官方消息
+(void)getXiaoXiMessageList:(NSDictionary *_Nullable)parameter
                   callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//官方消息详情
+(void)getGuanFangMessageDetail:(NSDictionary *_Nullable)parameter
                       callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//开通会员  vip_type vip_forever永久会员 vip_year年会员
+(void)kaiTongHuiYuan:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//会员描述信息
+(void)huiYuanMiaoShuXinXi:(NSDictionary *_Nullable)parameter
                  callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//金币明细  type_id 1收入 2支出 不填则所有
+(void)getJinBiMingXiList:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//提现申请接口
+(void)tiXianShenQing:(NSDictionary *_Nullable)parameter
             callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//发帖是否免费
+(void)faTieAlsoFree:(NSDictionary *_Nullable)parameter
            callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//根据融云ID获取头像昵称
+(void)getUserInfoByRYID:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//轮询获取最新消息
+(void)getNewMessageCount:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//站点地址列表
+(void)getJSSiteUrls:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//查看支付状态 appi/mlpay/getPaystatus
+(void)checkZFStatus:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//聚合下单 appi/mlpay/ddyOrdering
+(void)jvHeXiaDan:(NSDictionary *_Nullable)parameter
         callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//订单号生成接口 appi/mlpay/getddOrder
+(void)getZFOrderId:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//金币产品列表 /appi/mlpay/ddyProducts
+(void)getZFJinBiList:(NSDictionary *_Nullable)parameter
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//充值明细 appi/user/getRechargeList
+(void)getZFRechargeList:(NSDictionary *_Nullable)parameter
                callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//上传share_code appi/user/getPshareCode
+(void)getShareCode:(NSDictionary *_Nullable)parameter
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
//获取支付渠道链接appi/common/getPayType
+(void)getCommonPayType:(NSDictionary *_Nullable)parameter
               callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
+(void)getDataByUrl:(NSDictionary *_Nullable)parameter
           callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

//获取用户在线状态user/user_status
+(void)getUserOnLineStatus:(NSDictionary *_Nullable)parameter
                  callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;
@end
