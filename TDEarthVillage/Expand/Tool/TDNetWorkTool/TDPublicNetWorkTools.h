//
//  TDPublicNetWorkTools.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/13.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TDPublicNetWorkTools : NSObject

/********************
 全局参数
 *******************/
+ (void)postInit;


/********************
 用户
 *******************/

/**
 验证码
 
 @param phone 手机号
 */
+ (void)postSendCodeWithPhone:(NSString *)phone successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;

/**
 登录

 @param phone 手机号
 @param code 短信验证码
 */
+ (void)postLoginWithPhone:(NSString *)phone code:(NSString *)code successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;


/**
 我的个人资料接口

 @param token tonken
 */
+ (void)postUserInfoWithToken:(NSString *)token successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;


/**
 修改收货人信息

 @param content 修改内容
 @param type 修改类型
 */
+ (void)postUpdateNameWithContent:(NSString *)content type:(TDMyDataCelltype)type successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;

/**
 修改用户头像

 @param data 文件对象
 @param view 显示进度的view
 */
+ (void)postUploadLogoWithData:(NSData *)data showProgressView:(UIView *)view successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;

/********************
 首页
 *******************/


/**
 首页轮播
 */
+ (void)postSysTopManagerWithsuccessBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;

/**
 首页获取乡镇接口
 */
+ (void)postDvillageGetAreasWithsuccessBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;

/**
 旅游线路详情
 */
+ (void)postTourDetailsWithId:(NSString *)tourId successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;

/**
 农产品详情
 */
+ (void)postProductsDetailsWithId:(NSString *)productsId successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;

/**
 村落详情
 */
+ (void)postVillageDetailsWithId:(NSString *)villageId successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;

/********************
 农产品
 *******************/

/**
 获取所有农产品
 */
+ (void)postGetByCodeAppWithsuccessBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;
/**
 产地和村二级数据
 */
+ (void)postGetAreasAndVillageWithsuccessBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;
/**
 默认排序数据
 */
+ (void)postGetSortWithsuccessBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;

/********************
 订单和支付
 *******************/


/**
 支付下单接口

 @param payId 购买商品的id,购买多个不同的商品时id以逗号拼接传入
 @param payNum 买数量,多个商品的数量以逗号拼接传入,和payId对应
 @param paymentType	支付方式, 0:支付宝 1:微信
 */
+ (void)postOrderPayWithPayId:(NSString *)payId payNum:(NSString *)payNum paymentType:(TDPayType)paymentType successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;

/********************
 资讯
 *******************/

/**
 资讯详情
 */
+ (void)postInfoDetailsWithId:(NSString *)infoId successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure;

@end
