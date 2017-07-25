//
//  TDAgricultureFilterSaveModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/24.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseModel.h"

#define kTDAgricultureFilterSaveModelPath @"kTDAgricultureFilterSaveModelPath"

@interface TDAgricultureFilterSaveModel : TDBaseModel

/**
 种类
 */
@property (nonatomic, strong)NSArray *arrSelectTypeModel;

/**
 场地
 */
@property (nonatomic, strong)NSArray *arrSelectFieldModel;

/**
 排序
 */
@property (nonatomic, strong)NSArray *arrSelectSortModel;

/**
 首页轮播
 */
@property (nonatomic, strong)NSArray *arrHomeTopManage;

/**
 首页城镇筛选
 */
@property (nonatomic, strong)NSArray *arrHomeFilter;


+ (TDAgricultureFilterSaveModel *)getSaveModel;
+ (void)saveTypeModel:(NSArray *)arrSelectTypeModel;
+ (void)saveFieldModel:(NSArray *)arrSelectFieldModel;
+ (void)saveSortModel:(NSArray *)arrSelectSortModel;
+ (void)saveHomeTopManageModel:(NSArray *)arrHomeTopManageModel;
+ (void)saveHomeFilterModel:(NSArray *)arrHomeFilterModel;

+ (NSArray *)getTypeModel;
+ (NSArray *)getFieldModel;
+ (NSArray *)getSortModel;
+ (NSArray *)getHomeTopManageModel;
+ (NSArray *)getHomeFilterModel;
@end
