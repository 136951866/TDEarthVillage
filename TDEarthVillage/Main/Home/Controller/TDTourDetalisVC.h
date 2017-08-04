//
//  TDTourDetalisVC.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseVC.h"

@class TDAgricultureModel;
@class TDTourModel;

@interface TDTourDetalisVC : TDBaseVC

//农产品详情
- (instancetype)initWithAricultureModel:(TDAgricultureModel *)model;
//旅游线路详情
- (instancetype)initWithTourModel:(TDTourModel *)model;
//初始化
- (instancetype)initWithTourId:(NSString *)tourId;
- (instancetype)initWithProductId:(NSString *)productId;

@end
