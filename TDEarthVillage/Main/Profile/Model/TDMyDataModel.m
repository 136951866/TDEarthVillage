//
//  TDMyDataModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDMyDataModel.h"

@implementation TDMyDataModel

- (instancetype)initWithType:(TDMyDataCelltype)type content:(NSString *)content{
    if(self = [super init]){
        self.type = type;
        self.content = content;
    }
    return self;
}

- (instancetype)initWithType:(TDMyDataCelltype)type content:(NSString *)content image:(UIImage *)image{
    if(self =  [self initWithType:type content:content]){
        self.image = image;
    }
    return self;
}
@end
