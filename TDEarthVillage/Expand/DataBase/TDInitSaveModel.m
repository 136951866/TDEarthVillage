//
//  TDInitSaveModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/8/4.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDInitSaveModel.h"

@implementation TDInitSaveModel

+ (TDInitSaveModel *)getSaveModel{
    TDInitSaveModel *saveModel = [TDInitSaveModel getObjctForKey:kTDInitSaveModelPath path:TDCodingPathDocument];
    if(!saveModel){
        saveModel = [TDInitSaveModel new];
    }
    return saveModel;
}

+ (void)saveWithDic:(NSDictionary *)dic{
    TDInitSaveModel *saveModel = [TDInitSaveModel mj_objectWithKeyValues:dic];
    [saveModel writeObjectForKey:kTDInitSaveModelPath path:TDCodingPathDocument];
}

@end
