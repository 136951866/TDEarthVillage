//
//  TDOrderModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/20.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDOrderModel.h"

@implementation TDOrderModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{ @"TDID" : @"id"};
}

- (void)setOrderStatus:(NSString *)orderStatus{
    _orderStatus = orderStatus;
    self.status = [_orderStatus intValue];
}

- (void)setProductName:(NSString *)productName{
    _productName = productName;
    self.arrProductName = [_productName componentsSeparatedByString:@","];
}

- (void)setProductNum:(NSString *)productNum{
    _productNum = productNum;
    self.arrProductNum = [_productNum componentsSeparatedByString:@","];
}

- (NSMutableArray *)arrProduct{
    if(!_arrProduct){
        _arrProduct = [[NSMutableArray alloc]init];
        [self.arrProductName enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_arrProduct addObject:[[TDOrderProctModel alloc]initWithName:obj num:self.arrProductNum[idx]]];
        }];
    }
    return _arrProduct;
}

@end

@implementation TDOrderProctModel

- (instancetype)initWithName:(NSString *)name num:(NSString *)num{
    if(self = [super init]){
        self.name = name;
        self.num = num;
    }
    return self;
}

@end
