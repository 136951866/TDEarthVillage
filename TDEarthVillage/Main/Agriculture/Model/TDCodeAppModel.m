//
//  TDCodeAppModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/21.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDCodeAppModel.h"

@implementation TDCodeAppModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{ @"TDID" : @"id"
              };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"leafs" : [self class],
              @"regin" : [self class],
             };
}

- (void)setRegin:(NSArray *)regin{
    _regin = regin;
    _leafs = regin;
}

@end
