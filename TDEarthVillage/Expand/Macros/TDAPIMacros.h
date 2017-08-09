//
//  TDAPIMacros.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/17.
//  Copyright © 2017年 Hank. All rights reserved.
//

#ifndef TDAPIMacros_h
#define TDAPIMacros_h

#define TestVersion

//域名
#ifdef TestVersion
//#define BASEIP @"http://120.25.0.202:8088/"
#define BASEIP @"http://120.25.0.202:8088/"
#else
#define BASEIP @""
#endif

/********************
 全局参数
 *******************/
#define COMMONINIT @"web/app/common/init"

/********************
 用户
 *******************/

//验证码
#define SENDCODEAPI @"web/app/duserValidata/sendCode"
//登陆
#define LOGINAPI @"web/app/login"
//我的个人资料
#define USERINFO @"web/app/user/get"
//修改收货人信息姓名
#define UPDATENAME @"web/app/duserAddress/updateName"
//修改收货地址
#define UPDATEADDRESS @"web/app/duserAddress/updateAddress"
//修改收货地址
#define UPDATEPHONE @"web/app/duserAddress/updatePhone"
//修改用户的昵称
#define UPDATENICKNAME @"web/app/updateNickName"
//修改用户头像
#define UPLOADLOGO @"web/app/uploadLogo"
//关于地球村
#define ABOUT @"web/app/common/about"

/********************
 资讯
 *******************/

//资讯列表
#define INFOLIST @"web/app/dinformation/list"


/********************
 首页
 *******************/

//首页村落列表
#define DVILLAGELIST @"web/app/dvillage/list"
//首页轮播
#define TOPMANAGELIST @"web/app/sysTopManager/list"
//农产品列表查询
#define PRODUCTSLIST @"web/app/dtravelProducts/list"
//旅游线路列表
#define ROUTELIST @"web/app/dtravelRoute/list"
//首页获取乡镇接口
#define DVILLAGEGETAREAS @"web/app/dvillage/getAreas"
//村落详情
#define VILLAGEDETAIL @"web/app/dvillage/detail"
//农产品详情
#define PRODUCTDETAIL @"web/app/dtravelProducts/detail"
//旅游线路详情
#define ROUTEDETAIL @"web/app/dtravelRoute/detail"

/********************
 农产品
 *******************/
//获取所有农产品
#define GETBYCODEAPP @"web/app/sysProductsType/getByCodeApp"
//产地和村二级
#define GETAREASANDVILLAGE @"web/app/dvillage/getAreasAndVillage"
//默认排序数据
#define GETSORT @"web/app/common/sort"

/********************
 订单和支付
 *******************/

//支付下单接口
#define ORDERPAY @"web/app/order/pay"
//支付定单列表
#define ORDERLIST @"web/app/order/list"
//首页获取乡镇接口

/********************
 资讯
 *******************/

//资讯详情
#define INFODETAIL @"web/app/dinformation/detail"

#endif /* TDAPIMacros_h */
