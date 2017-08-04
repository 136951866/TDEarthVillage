//
//  TDOtherMacros.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#ifndef TDOtherMacros_h
#define TDOtherMacros_h

#define kimgPlaceholder  [UIImage imageNamed:@"placeholderImage"]

#pragma mark - enum

//我的首页cell类型
typedef enum : NSUInteger {
    TDProfileHomeCellShoptype = 0,
    TDProfileHomeCellOrdertype = 1,
    TDProfileHomeCellAbouttype = 2,
    TDProfileHomeCellExittype = 3
} TDProfileHomeCelltype;

//个人资料cell类型
typedef enum : NSUInteger {
    TDMyDataCellHeadPortraittype = 0,
    TDMyDataCellNicktype = 1,
    TDMyDataCellNametype = 2,
    TDMyDataCellAddressetype = 3,
    TDMyDataCellPhoneetype = 4
} TDMyDataCelltype;

//支付类型
typedef enum : NSUInteger {
    TDPayApliType = 0,
    TDPayWeiChatType = 1
} TDPayType;
typedef void (^kTDPayTypeBlock)(TDPayType index);

//用户数据缓存枚举
typedef enum{
    TDCodingPathDocument  = 0,//Document目录，不会清掉缓存
    TDCodingPathCach          = 1
}TDCodingPath;

//首页轮播类型
typedef enum{
    TDTopManagerInfoType  = 1,
    TDTopManagerVillageType  = 2,
    TDTopManagerTourType  = 3,
    TDTopManagerAgricultureType  = 4
}TDTopManagerType;

//详情类型
typedef enum{
    TDDetailsAgricultureType  = 0,
    TDDetailsTourType  = 1,
}TDDetailsType;

//详情类型
typedef enum{
    TDPayStatusWaitPayType  = 0,//待付款
    TDPayStatusSucessPayType  = 1
//    TDPayStatusWaitSendType  = 1,//付款成功(待发货)
//    TDPayStatusSendType = 2//已发货
}TDPayStatusType;


#pragma mark - Login

//通知用户退出
#define kUserLogout @"kUserLogout"
#define kNoticeUserLogout [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogout object:nil];
//通知用户登录
#define kUserLogin @"kUserLogin"
#define kNoticeUserLogin [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogin object:nil];
//用户登录通知监听
#define kUserLoginWithSelector(sel) [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sel) name:kUserLogin object:nil];
//用户退出通知监听
#define kUserLogoutWithSelector(sel) [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sel) name:kUserLogout object:nil];



#pragma mark - 第三方macros

//短信
#define  SMSApp @"1780c400ba1ec"
#define  SMSSecret @"adf7c6f8d11897665289995fb58c0720"

//友盟统计
#define  MobAppkey @"597951301061d26430001090"

#endif /* TDOtherMacros_h */
