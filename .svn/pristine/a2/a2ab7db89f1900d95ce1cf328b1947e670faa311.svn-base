//
//  TDAgricultureFilterSaveModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/24.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDAgricultureFilterSaveModel.h"

@implementation TDAgricultureFilterSaveModel

+ (TDAgricultureFilterSaveModel *)getSaveModel{
    TDAgricultureFilterSaveModel *saveModel = [TDAgricultureFilterSaveModel getObjctForKey:kTDAgricultureFilterSaveModelPath path:TDCodingPathDocument];
    if(!saveModel){
        saveModel = [TDAgricultureFilterSaveModel new];
    }
    return saveModel;
}

+ (void)saveTypeModel:(NSArray *)arrSelectTypeModel{
    TDAgricultureFilterSaveModel *saveModel = [self getSaveModel];
    saveModel.arrSelectTypeModel = arrSelectTypeModel;
    [saveModel writeObjectForKey:kTDAgricultureFilterSaveModelPath path:TDCodingPathDocument];
}
+ (void)saveFieldModel:(NSArray *)arrSelectFieldModel{
    TDAgricultureFilterSaveModel *saveModel = [self getSaveModel];
    saveModel.arrSelectFieldModel = arrSelectFieldModel;
    [saveModel writeObjectForKey:kTDAgricultureFilterSaveModelPath path:TDCodingPathDocument];
}
+ (void)saveSortModel:(NSArray *)arrSelectSortModel{
    TDAgricultureFilterSaveModel *saveModel = [self getSaveModel];
    saveModel.arrSelectSortModel = arrSelectSortModel;
    [saveModel writeObjectForKey:kTDAgricultureFilterSaveModelPath path:TDCodingPathDocument];
}
+ (void)saveHomeTopManageModel:(NSArray *)arrHomeTopManageModel{
    TDAgricultureFilterSaveModel *saveModel = [self getSaveModel];
    saveModel.arrHomeTopManage = arrHomeTopManageModel;
    [saveModel writeObjectForKey:kTDAgricultureFilterSaveModelPath path:TDCodingPathDocument];
}
+ (void)saveHomeFilterModel:(NSArray *)arrHomeFilterModel{
    TDAgricultureFilterSaveModel *saveModel = [self getSaveModel];
    saveModel.arrHomeFilter = arrHomeFilterModel;
    [saveModel writeObjectForKey:kTDAgricultureFilterSaveModelPath path:TDCodingPathDocument];
}

+ (NSArray *)getTypeModel{
    TDAgricultureFilterSaveModel *saveModel = [self getSaveModel];
    return kHankUnArr(saveModel.arrSelectTypeModel);
}

+ (NSArray *)getFieldModel{
    TDAgricultureFilterSaveModel *saveModel = [self getSaveModel];
    return kHankUnArr(saveModel.arrSelectFieldModel);
}

+ (NSArray *)getSortModel{
    TDAgricultureFilterSaveModel *saveModel = [self getSaveModel];
    return kHankUnArr(saveModel.arrSelectSortModel);
}

+ (NSArray *)getHomeTopManageModel{
    TDAgricultureFilterSaveModel *saveModel = [self getSaveModel];
    return kHankUnArr(saveModel.arrHomeTopManage);
}
+ (NSArray *)getHomeFilterModel{
    TDAgricultureFilterSaveModel *saveModel = [self getSaveModel];
    return kHankUnArr(saveModel.arrHomeFilter);
}
@end
