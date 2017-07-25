//
//  TDProductCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDProductCell.h"
#import "TDAgricultureModel.h"
#import "TDTourModel.h"

@interface TDProductCell()

@property (weak, nonatomic) IBOutlet UILabel        *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lblCost;
@property (weak, nonatomic) IBOutlet UIImageView    *imgPic;

@end

@implementation TDProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setAgricultureUIWithModle:(TDAgricultureModel *)model{
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:kHankUnNilStr(model.log)] placeholderImage:kimgPlaceholder];
    _lblTitle.text = kHankUnNilStr(model.productName);
    _lblCost.text = [NSString stringWithFormat:@"¥%@/%@",kHankUnNilStr(model.price),kHankUnNilStr(model.unit)];
}

- (void)setAgricultureUIWithModle:(TDAgricultureModel *)model searchKey:(NSString *)key{
    [self setAgricultureUIWithModle:model];
    if(kHankUnNilStr(key).length>0){
        _lblTitle.text = nil;
        _lblTitle.attributedText = [kHankUnNilStr(model.productName) attributeWithRangeOfString:key color:kThemeBlue];
    }
}
- (void)setTourUIWithModle:(TDTourModel *)model{
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:kHankUnNilStr(model.log)] placeholderImage:kimgPlaceholder];
    _lblTitle.text = kHankUnNilStr(model.travelName);
    _lblCost.text = [NSString stringWithFormat:@"¥%@",kHankUnNilStr(model.price)];
}

@end
