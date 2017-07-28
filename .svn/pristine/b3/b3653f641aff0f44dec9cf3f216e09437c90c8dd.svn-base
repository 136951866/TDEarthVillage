//
//  TDShopBottomView.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDShopBottomView.h"

@interface TDShopBottomView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consMargin;

@end

@implementation TDShopBottomView

- (void)awakeFromNib{
    [super awakeFromNib];
    _lblCost.adjustsFontSizeToFitWidth = YES;
    _consMargin.constant = kHankFrameScaleX()<1?0:30;
}

- (IBAction)settlementAction:(UIButton *)sender {
    kHankCallBlock(_settlementBlock,_lblNum.text,_lblCost.text);
}

@end
