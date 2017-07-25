//
//  TDShopCell.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/4.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <MGSwipeTableCell/MGSwipeTableCell.h>
#import "TDShopModel.h"

@class TDShopCell;
static const CGFloat kTDShopCellHeight = 100;

@protocol TDShopCellDelegate <NSObject>

-(void)selectedConfirmCell:(TDShopCell *)cell;
-(void)selectedCancelCell:(TDShopCell *)cell;
-(void)getNumberWithCell:(TDShopCell *)cell Number:(NSString *)strNum;

@end

@interface TDShopCell : MGSwipeTableCell

@property (nonatomic, weak)id<TDShopCellDelegate> selectedDelegate;

- (void)setUIWithModel:(TDShopModel *)model;

@end
