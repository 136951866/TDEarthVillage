//
//  TDTInfoHomeCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDTInfoHomeCell.h"
#import "TDInfoModel.h"

@interface TDTInfoHomeCell ()

@property (weak, nonatomic) IBOutlet UILabel        *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView    *imgPic;

@end

@implementation TDTInfoHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setUIWithModle:(TDInfoModel *)model{
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:kHankUnNilStr(model.logo)] placeholderImage:kimgPlaceholder];
    _lblTitle.text = kHankUnNilStr(model.title);
//    _lblTime.text = [TDPublicTools dateStringForFormat:@"yyyy-MM-dd HH:mm" timeInterval:[kHankUnNilStr(model.createDate) longLongValue]];
    _lblTime.text = kHankUnNilStr(model.createDate);
}

@end
