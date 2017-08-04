//
//  TDInitSaveModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/8/4.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseModel.h"

#define kTDInitSaveModelPath @"kTDInitSaveModelPath"

@interface TDInitSaveModel : TDBaseModel

/**
 微信支付回调地址
 */
@property (nonatomic, strong)NSString *wechatNotify;

/**
 支付宝回调地址
 */
@property (nonatomic, strong)NSString *apliayNotify;

+ (TDInitSaveModel *)getSaveModel;
+ (void)saveWithDic:(NSDictionary *)dic;

@end
