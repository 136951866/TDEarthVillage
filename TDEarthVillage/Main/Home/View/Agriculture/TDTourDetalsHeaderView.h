//
//  TDTourDetalsHeaderView.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDTourDetalsHeaderSubView.h"

@class TDAgricultureModel;
@class TDTourModel;
#define kTDTourDetalsHeaderViewHeight (kTDTourDetalsHeaderSubViewHeight + ((SCREEN_WIDTH*3)/5))

@interface TDTourDetalsHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame agricultureModel:(TDAgricultureModel *)agricultureModel;
- (instancetype)initWithFrame:(CGRect)frame tourModel:(TDTourModel *)tourModel;

@end
