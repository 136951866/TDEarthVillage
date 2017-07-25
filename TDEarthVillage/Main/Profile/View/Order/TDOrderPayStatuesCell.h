//
//  TDOrderPayStatuesCell.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDOrderPayModel;
@interface TDOrderPayStatuesCell : UITableViewCell

+ (CGFloat)getCellHeightWithModel:(TDOrderPayModel *)model;
- (void)setUIWithModel:(TDOrderPayModel *)model;

@end
