//
//  TDOrderSubCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDOrderSubCell.h"

#define kFontOfTitle [UIFont systemFontOfSize:17]
#define kWidthOflblContent (SCREEN_WIDTH - 72)
@interface TDOrderSubCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTitleHeightMargin;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation TDOrderSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    _lblTitle.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setWithTitle:(NSString *)title{
    _consTitleHeightMargin.constant = [NSAttributedString heightForAtsWithStr:kHankUnNilStr(title) font:kFontOfTitle width:kWidthOflblContent lineH:0 maxLine:0];
    [_lblTitle setAtsWithStr:kHankUnNilStr(title) lineGap:0];
}

+ (CGFloat)getCellHeightWithModel:(NSString *)title{
    CGFloat height = 4;
    if(title.length >0){
        height += [NSAttributedString heightForAtsWithStr:kHankUnNilStr(title) font:kFontOfTitle width:kWidthOflblContent lineH:0 maxLine:0];
    }
    return height;
}

@end
