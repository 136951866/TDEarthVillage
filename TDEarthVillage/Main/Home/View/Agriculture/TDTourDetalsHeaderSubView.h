//
//  TDTourDetalsHeaderSubView.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDAgricultureModel;
@class TDTourModel;
const static CGFloat kTDTourDetalsHeaderSubViewHeight = 130.0f;

@interface TDTourDetalsHeaderSubView : UIView

- (void)setUIWithAgricultureModel:(TDAgricultureModel *)agricultureModel;
- (void)setUIWithTourModel:(TDTourModel *)tourModel;

@end
