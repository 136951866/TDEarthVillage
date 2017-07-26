//
//  TDHomeFilterView.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDHomeDvilllageModel.h"

@interface TDHomeFilterView : UIView

//- (instancetype)initWithFrame:(CGRect)frame arrModel:(NSArray *)arrMode lblTitleBlock:(kHankTextBlock)lblTitleBlock;

- (void)setUIWithFilterArrModel:(NSArray *)filterArrModel
              selectFilterBlock:(kHomeDvilllageModelBlock)selectFilterBlock;

+ (CGFloat)getTDHomeFilterViewHeightWithFilterArrModel:(NSArray *)filterArrModel;
@end
