//
//  TDTourDetalsHeaderSubView.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDTourDetalsHeaderSubView.h"
#import "TDAgricultureModel.h"
#import "TDTourModel.h"

@interface TDTourDetalsHeaderSubView ()

@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@property (weak, nonatomic) IBOutlet UILabel *lblCategroy;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblFiely;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchant;
@property (weak, nonatomic) IBOutlet UILabel *lblFielyName;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantName;

@end

@implementation TDTourDetalsHeaderSubView

- (void)setUIWithAgricultureModel:(TDAgricultureModel *)agricultureModel{
    _lbltitle.text = kHankUnNilStr(agricultureModel.productName);
    _lblPrice.text = [NSString stringWithFormat:@"%@/%@",kHankUnNilStr(agricultureModel.price),kHankUnNilStr(agricultureModel.unit)];
    _lblCategroy.text = kHankUnNilStr(agricultureModel.productTypeName);
    _lblFiely.text = kHankUnNilStr(agricultureModel.villageName);
    _lblMerchant.text = kHankUnNilStr(agricultureModel.merchantName);
}

- (void)setUIWithTourModel:(TDTourModel *)tourModel{
    _lbltitle.text = kHankUnNilStr(tourModel.travelName);
    _lblPrice.text = kHankUnNilStr(tourModel.price);
    _lblCategroy.text = kHankUnNilStr(tourModel.productTypeName);
    _lblMerchantName.hidden = _lblMerchant.hidden = YES;
    _lblFielyName.text = @"商户:";
    _lblFiely.text = kHankUnNilStr(tourModel.merchantName);
}

@end
