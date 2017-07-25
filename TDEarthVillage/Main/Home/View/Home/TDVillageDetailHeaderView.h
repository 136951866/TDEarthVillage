//
//  TDVillageDetailHeaderView.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/18.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDHomeVillAgeModel;
#define kTDVillageDetailHeaderViewHeight (85 + ((SCREEN_WIDTH*3)/5))

@interface TDVillageDetailHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame model:(TDHomeVillAgeModel *)model;

@end
