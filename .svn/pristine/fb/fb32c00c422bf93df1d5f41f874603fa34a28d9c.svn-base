//
//  TDBaseModel+Coding.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/11.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseModel.h"

@interface TDBaseModel (Coding)
/**
*  将模型的二进制数据写入Document目录
*
*  @param key 通过key来查找模型
*/
- (void)writeObjectForKey:(NSString *)key;
    
/**
*  将模型的二进制数据写入指定路径
*
*  @param key  通过key来查找模型
*  @param path 路径类型
*/
- (void)writeObjectForKey:(NSString *)key path:(TDCodingPath)path;
    
/**
*  读取模型，注意要用读取的模型类调用
*
*  @param key 通过key来查找模型
*
*  @return 返回该模型实例
*/
+ (id)getObjctForKey:(NSString *)key;
    
/**
*  读取模型，注意要用读取的模型类调用
*
*  @param key  通过key来查找模型
*  @param path 路径类型
*
*  @return 返回该模型实例
*/
+ (id)getObjctForKey:(NSString *)key path:(TDCodingPath)path;
    
/**
*  删除归档模型
*
*  @param key 通过key来删除归档的模型，默认删除Document目录
*/
+ (void)removeCodingForKey:(NSString *)key;
    
/**
*  删除归档模型
*
*  @param key  通过key来删除归档的模型
*  @param path 路径类型
*/
+ (void)removeCodingForKey:(NSString *)key path:(TDCodingPath)path;
@end
