//
//  TDAgricultureModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/18.
//  Copyright © 2017年 Hank. All rights reserved.
//  农产品model

#import "TDBaseModel.h"
/*
 "id": "12312",
 "createDate": "2017.07.17 07:29",
 "productName": "苹果",
 "log": "1.jpg",
 "introduce": "测试",
 "villageId": "1001",
 "merchantName": "测试商户",
 "price": 10,
 "unit": "箱",
 "villageName": "测试村",
 "productTypeName": "四级产品"
 */
@interface TDAgricultureModel : TDBaseModel

@property (nonatomic, copy) NSString *TDID;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *log;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *imagesList;
@property (nonatomic, copy) NSString *villageId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *villageName;
@property (nonatomic, copy) NSString *productTypeName;
@property (nonatomic, copy) NSString *merchantName;
@property (nonatomic, strong) NSArray *arrImages;

@end
