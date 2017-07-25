//
//  TDTourModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/18.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDTourModel.h"

@implementation TDTourModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{ @"TDID" : @"id"};
}

- (void)setImagesList:(NSString *)imagesList{
    _imagesList = imagesList;
    self.arrImages = [_imagesList componentsSeparatedByString:@","];
}

@end
