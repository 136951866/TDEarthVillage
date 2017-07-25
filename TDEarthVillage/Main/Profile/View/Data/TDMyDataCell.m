//
//  TDMyDataCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDMyDataCell.h"
#import "TDMyDataModel.h"

#define kFontOfTitle [UIFont systemFontOfSize:17]
#define kWidthOflblContent (SCREEN_WIDTH - 14 - 40 - 14 - 14 - 12 - 14)
@interface TDMyDataCell(){
    NSArray *_arrType;
}

@property (weak, nonatomic) IBOutlet UILabel            *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel            *lblSubTitle;
@property (weak, nonatomic) IBOutlet UIImageView        *imgPic;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consSubTitleHeight;
@end

@implementation TDMyDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _arrType = @[@"头像",@"昵称",@"姓名",@"地址",@"手机"];
    // Initialization code
}

#pragma mark - Public Method

- (void)setUIWithModel:(TDMyDataModel *)model{
    _lblSubTitle.hidden = model.type == TDMyDataCellHeadPortraittype;
    _imgPic.hidden = !_lblSubTitle.hidden;
    _lblTitle.text = _arrType[model.type];
    if(model.type == TDMyDataCellHeadPortraittype){
        if(model.image){
            _imgPic.image =model.image;
        }else{
            [_imgPic sd_setImageWithURL:[NSURL URLWithString:kHankUnNilStr(model.content)] placeholderImage:[UIImage imageNamed:@"me_edit_portrait"]];
        }
    }else{
        _consSubTitleHeight.constant = [NSAttributedString heightForAtsWithStr:kHankUnNilStr(model.content) font:kFontOfTitle width:kWidthOflblContent lineH:0 maxLine:0];
        [_lblSubTitle setAtsWithStr:kHankUnNilStr(model.content) lineGap:0];
    }
    _lblSubTitle.textAlignment = NSTextAlignmentRight;
}

+ (CGFloat)getHeightWithModel:(TDMyDataModel *)model{
    CGFloat height = 21 + 21;
    height += [NSAttributedString heightForAtsWithStr:kHankUnNilStr(model.content) font:kFontOfTitle width:kWidthOflblContent lineH:0 maxLine:0];
    if(model.type == TDMyDataCellHeadPortraittype || !kHankUnNilStr(model.content).length){
        height = 60;
    }
    return height;
}
@end
