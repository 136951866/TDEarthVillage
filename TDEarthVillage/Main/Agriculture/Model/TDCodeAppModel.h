//
//  TDCodeAppModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/21.
//  Copyright © 2017年 Hank. All rights reserved.
//
/*
 id	string	ID
 name	string	姓名
 pId	string	父ID
 level	string	级别
 leafs	string	子节点
 */
#import "TDBaseModel.h"

@interface TDCodeAppModel : TDBaseModel

@property (nonatomic, copy) NSString *TDId;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pId;
@property (nonatomic, strong) NSArray *leafs;
@property (nonatomic, strong) NSArray *regin;

@end
