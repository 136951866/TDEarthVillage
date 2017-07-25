//
//  TDShopModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDShopModel.h"

@implementation TDShopModel

- (instancetype)init{
    if(self = [super init]){
        self.userId = kHankUnNilStr(kCurrentUser.userId);
    }
    return self;
}

@end
