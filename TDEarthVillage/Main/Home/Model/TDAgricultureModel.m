//
//  TDAgricultureModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/18.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDAgricultureModel.h"

@implementation TDAgricultureModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{ @"TDID" : @"id"};
}

- (void)setImagesList:(NSString *)imagesList{
    _imagesList = imagesList;
    self.arrImages = [_imagesList componentsSeparatedByString:@","];
}

@end
