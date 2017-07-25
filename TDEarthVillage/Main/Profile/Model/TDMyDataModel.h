//
//  TDMyDataModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseModel.h"

@interface TDMyDataModel : TDBaseModel

- (instancetype)initWithType:(TDMyDataCelltype)type content:(NSString *)content;
- (instancetype)initWithType:(TDMyDataCelltype)type content:(NSString *)content image:(UIImage *)image;

@property (nonatomic, strong) UIImage           *image;
@property (nonatomic, strong) NSString          *content;
@property (nonatomic, assign) TDMyDataCelltype  type;


@end
