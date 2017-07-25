//
//  TDHomeCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDHomeCell.h"
#import "TDHomeVillAgeModel.h"

@interface TDHomeCell()

@property (weak, nonatomic) IBOutlet UILabel        *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView    *imgPic;

@end

@implementation TDHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setUIWithModel:(TDHomeVillAgeModel *)model{
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:kHankUnNilStr(model.log)] placeholderImage:kimgPlaceholder];
    _lblTitle.text = kHankUnNilStr(model.villageName);
    
}



@end
