//
//  TDMyDataCell.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDMyDataModel;
@interface TDMyDataCell : UITableViewCell

- (void)setUIWithModel:(TDMyDataModel *)model;
+ (CGFloat)getHeightWithModel:(TDMyDataModel *)model;

@end
