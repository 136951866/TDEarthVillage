//
//  TDShopBottomView.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kTDShopBottomViewHeight = 50;
typedef void (^kTDShopBottomViewBlock)(NSString *strNum,NSString *strCost);

@interface TDShopBottomView : UIView

@property (weak, nonatomic  ) IBOutlet UILabel              *lblNum;
@property (weak, nonatomic  ) IBOutlet UILabel              *lblCost;
@property (strong, nonatomic) kTDShopBottomViewBlock        settlementBlock;

@end
