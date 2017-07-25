//
//  TDHomeVillAgeModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/17.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDHomeVillAgeModel.h"

@implementation TDHomeVillAgeModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{ @"TDID" : @"id"};
}

- (void)setImagesList:(NSString *)imagesList{
    _imagesList = imagesList;
    self.arrImages = [_imagesList componentsSeparatedByString:@","];
}

@end
