//
//  TDDataBaseTool.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/12.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TDShopModel;
@class TDDataBaseTool;
#define TDDataBase [TDDataBaseTool sharedDataBase]

@interface TDDataBaseTool : NSObject

//获取数据库管理对象单例的方法
+ (TDDataBaseTool *)sharedDataBase;
//返回数据的路径
+ (NSString *)getDataBasePath;
//关闭数据库
- (void)closeDataBase;
//清空数据库
- (BOOL)deleteDatabase;


/***********
 *购物车模块
 **************/
//向购物车中添加信息
- (BOOL)insertPdcToCarWithModel:(TDShopModel *)model;
//获取购物车列表
- (NSArray*)getAllpdcInCarWithUserId:(NSString *)userId;
//获取购物车列表的数量 = 获取购物车列表.count * 数量
- (NSInteger)getAllPdcNumIncarWithUserId:(NSString *)userId;
//购物车是否存在商品
- (BOOL)isExistInCarWithModel:(TDShopModel *)model;
//修改购物车中产品的数量
- (BOOL)updataCountInCar:(NSString *)newStrNum model:(TDShopModel *)model;
//删除购物车产品
- (BOOL)deletePdcInCarByModel:(TDShopModel *)model;
//根据TDId拿到产品
- (TDShopModel *)getNewsModelById:(NSString *)TDId userId:(NSString *)userId;
@end
