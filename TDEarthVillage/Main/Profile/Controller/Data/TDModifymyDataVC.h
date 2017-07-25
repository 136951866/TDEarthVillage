//
//  TDModifymyDataVC.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/7.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseVC.h"
#import "TDMyDataModel.h"

@interface TDModifymyDataVC : TDBaseVC

- (instancetype)initWithModel:(TDMyDataModel *)model finishBlock:(kHankTextBlock)finishBlock;

@end
