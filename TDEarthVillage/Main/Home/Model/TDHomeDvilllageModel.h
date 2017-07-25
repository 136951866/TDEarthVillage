//
//  TDHomeDvilllageModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/21.
//  Copyright © 2017年 Hank. All rights reserved.
//
/*
 code	string	乡镇的编码
 name	string	名称
 */
#import "TDBaseModel.h"

@class TDHomeDvilllageModel;
typedef void (^kHomeDvilllageModelBlock)(TDHomeDvilllageModel *model);

@interface TDHomeDvilllageModel : TDBaseModel

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;

@end
