//
//  ZLRequestResponse.h
//  我要留学
//
//  Created by Hank on 10/13/16.
//  Copyright © 2016 深圳市智联天下国际教育有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDBaseModel.h"
/*
 json={
 success = 1,
 objects = {
 id = 0,
 circleComment = 0,
 momentComment = 0,
 solutionComment = 0,
 userId = 18370995023
 },
 error = <null>,
 time = 1476321757814
 }
 */

@interface ZLRequestResponse : TDBaseModel

@property (nonatomic,assign) BOOL success;         //版本号
@property (nonatomic,assign) NSUInteger time;       //操作的控制器名称
@property (nonatomic,strong) id error;
@property (nonatomic,strong) id objects;
@property (nonatomic,strong) id object;
@property (nonatomic,assign) NSUInteger totalCount;


//下发后的调用结果，不等于200时，此值会返回错误的信息
@property (nonatomic,copy) NSString *message;
//200时为成功，其它都为失败
@property (nonatomic,copy) NSString *code;
//数据
@property (nonatomic,strong) id data;

@end
