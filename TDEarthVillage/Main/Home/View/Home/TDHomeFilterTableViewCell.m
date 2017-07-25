//
//  TDHomeFilterTableViewCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDHomeFilterTableViewCell.h"
#import "TDHomeDvilllageModel.h"

const static CGFloat kMargin = 14;
#define kFontOfTitle [UIFont systemFontOfSize:15]
#define kWidthOflblContent (kTDHomeFilterTableViewCellWdith - kMargin*2)

@interface TDHomeFilterTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel                *lblTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *consHeight;

@end

@implementation TDHomeFilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUIWithModel:(TDHomeDvilllageModel *)model{
    _consHeight.constant = [NSAttributedString heightForAtsWithStr:kHankUnNilStr(model.name) font:kFontOfTitle width:kWidthOflblContent lineH:0 maxLine:0];
    [_lblTitle setAtsWithStr:kHankUnNilStr(model.name) lineGap:0];
    [self layoutIfNeeded];
}

+ (CGFloat)getHeightWithModel:(TDHomeDvilllageModel *)model{
     CGFloat height = kMargin *2;
    if(kHankUnNilStr(model.name).length){
        height += [NSAttributedString heightForAtsWithStr:kHankUnNilStr(model.name) font:kFontOfTitle width:kWidthOflblContent lineH:0 maxLine:0];
    }
    return height;
}
@end
