//
//  TDProfileHomeCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDProfileHomeCell.h"

@interface TDProfileHomeCell (){
    NSArray *_arrImg;
    NSArray *_arrTitle;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblExit;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;

@end

@implementation TDProfileHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _arrImg = @[@"me_shopcar",@"me_order",@"me_dearth"];
    _arrTitle = @[@"购物车",@"我的订单",@"关于D球村"];
    // Initialization code
}

#pragma mark - Public Method

- (void)setUIWIthType:(TDProfileHomeCelltype)type{
    _lblExit.hidden = type != TDProfileHomeCellExittype;
    _imgIcon.hidden = _lblTitle.hidden = _imgArrow.hidden = type == TDProfileHomeCellExittype;
    if(type != TDProfileHomeCellExittype){
        _imgIcon.image = kHankGetAssetImage(_arrImg[type]);
        _lblTitle.text = _arrTitle[type];
    }
}


@end
