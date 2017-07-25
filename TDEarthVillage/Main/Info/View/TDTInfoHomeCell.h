//
//  TDTInfoHomeCell.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDInfoModel;
const static CGFloat kTDTInfoHomeCellHeight = 115.0f;

@interface TDTInfoHomeCell : UITableViewCell

- (void)setUIWithModle:(TDInfoModel *)model;

@end
