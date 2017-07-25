//
//  TDHomeFilterTableViewView.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDHomeDvilllageModel.h"

@interface TDHomeFilterTableViewView : UIView

- (void)show;
- (void)setSubView;
- (void)hide:(kHankBasicBlock)finishBlock;
- (void)setUIWithModel:(NSArray *)filterArrModel
     selectFilterBlock:(kHomeDvilllageModelBlock)selectFilterBlock;

@end
