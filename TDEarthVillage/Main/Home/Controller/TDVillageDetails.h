//
//  TDVillageDetails.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseVC.h"

@class TDHomeVillAgeModel;
@interface TDVillageDetails : TDBaseVC

- (instancetype)initWithModel:(TDHomeVillAgeModel *)model;
- (instancetype)initWithVillageId:(NSString *)villageId;

@end
