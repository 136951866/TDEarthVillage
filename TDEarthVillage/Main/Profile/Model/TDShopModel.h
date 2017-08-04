//
//  TDShopModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseModel.h"

@interface TDShopModel : TDBaseModel

@property (nonatomic, strong)NSString   *TDId;
@property (nonatomic, assign)BOOL       isSelect;
@property (nonatomic, strong)NSString   *strNum;
@property (nonatomic, strong)NSString   *price;
@property (nonatomic, strong)NSString   *title;
@property (nonatomic, strong)NSString   *log;
@property (nonatomic, strong)NSString   *userId;
/**
 Agriculture 农产品 Tour 旅游线路 
 */
@property (nonatomic, strong)NSString   *type;

@end
