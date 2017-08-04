//
//  TDTourModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/18.
//  Copyright © 2017年 Hank. All rights reserved.
//  旅游线路model

/*
 "id": "535435",
 "createDate": "2017.07.17 08:09",
 "travelName": "第一条线路",
 "log": "1.jpg",
 "introduce": "ffsdf",
 "imagesList": "1.jpg,2.jpg,3.jpg",
 "villageId": "1001",
 "price": 100
 "merchantName": "4324",
 "villageName": "测试村"
 */
#import "TDBaseModel.h"

@interface TDTourModel : TDBaseModel

@property (nonatomic, copy) NSString *TDID;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *travelName;
@property (nonatomic, copy) NSString *log;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *imagesList;
@property (nonatomic, copy) NSString *villageId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *productTypeName;
@property (nonatomic, copy) NSString *merchantName;
@property (nonatomic, copy) NSString *villageName;
@property (nonatomic, strong) NSArray *arrImages;

@end
