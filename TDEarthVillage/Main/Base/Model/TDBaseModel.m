//
//  TDBaseModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/3.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseModel.h"

@implementation TDBaseModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if ([super init] && [dic isKindOfClass:[NSDictionary class]]) {
        self = [[self class] mj_objectWithKeyValues:dic];
    }
    return self;
}

MJCodingImplementation

- (instancetype)copyWithZone:(NSZone *)zone {
    return [[self.class allocWithZone:zone] initWithDic:[self mj_keyValues]];
}

@end
