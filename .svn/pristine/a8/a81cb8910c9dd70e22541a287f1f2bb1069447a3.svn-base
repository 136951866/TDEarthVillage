//
//  TDOrderPayModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/19.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDOrderPayModel.h"

@implementation TDOrderPayModel

- (void)setSubject:(NSString *)subject{
    _subject = subject;
    self.arrSubject = [_subject componentsSeparatedByString:@","];
}

- (void)setNumStr:(NSString *)numStr{
    _numStr = numStr;
    self.arrNum = [_numStr componentsSeparatedByString:@","];
}

- (NSMutableArray *)arrProduct{
    if(!_arrProduct){
        _arrProduct = [[NSMutableArray alloc]init];
        [self.arrSubject enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_arrProduct addObject:[[TDOrderPayProctModel alloc]initWithName:obj num:self.arrNum[idx]]];
        }];
    }
    return _arrProduct;
}


@end

@implementation TDOrderPayProctModel

- (instancetype)initWithName:(NSString *)name num:(NSString *)num{
    if(self = [super init]){
        self.name = name;
        self.num = num;
    }
    return self;
}

@end


