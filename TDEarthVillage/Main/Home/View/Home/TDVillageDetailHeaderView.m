//
//  TDVillageDetailHeaderView.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/18.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDVillageDetailHeaderView.h"
#import "TDHomeVillAgeModel.h"

@interface TDVillageDetailHeaderView ()<SDCycleScrollViewDelegate>{
    TDHomeVillAgeModel *_model;
}
@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong)UILabel *lblVillageName;
@property (nonatomic, strong)UILabel *lblAreaName;
@end

@implementation TDVillageDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame model:(TDHomeVillAgeModel *)model{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        _model = model;
        [self addSubview:self.cycleScrollView];
        [self addSubview:self.lblVillageName];
        [self addSubview:self.lblAreaName];
    }
    return self;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

#pragma mark - Setter 

- (SDCycleScrollView *)cycleScrollView{
    if(!_cycleScrollView){
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH*3)/5) imageURLStringsGroup:nil];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.pageControlStyle =SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.currentPageDotColor = kThemeBlue;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
        _cycleScrollView.autoScrollTimeInterval = 4;
        _cycleScrollView.delegate =self;
        _cycleScrollView.backgroundColor = [UIColor clearColor];
        _cycleScrollView.placeholderImage = kimgPlaceholder;
        _cycleScrollView.imageURLStringsGroup = _model.arrImages;
    }
    return _cycleScrollView;
}

- (UILabel *)lblAreaName{
    if(!_lblAreaName){
        _lblAreaName = [[UILabel alloc]initWithFrame:CGRectMake(0,  (SCREEN_WIDTH*3)/5 + kCommonMargin*2, self.width, 21)];
        _lblAreaName.textAlignment = NSTextAlignmentCenter;
        _lblAreaName.textColor = kTitleThemeBlack;
        _lblAreaName.font = kHankFont(20);
        _lblAreaName.text = kHankUnNilStr(_model.villageName);
    }
    return _lblAreaName;
}

- (UILabel *)lblVillageName{
    if(!_lblVillageName){
        _lblVillageName = [[UILabel alloc]initWithFrame:CGRectMake(0,  self.lblAreaName.bottom + kCommonMargin, self.width, 18)];
        _lblVillageName.textAlignment = NSTextAlignmentCenter;
        _lblVillageName.textColor = kTitleColorGray2;
        _lblVillageName.font = kHankFont(17);
        _lblVillageName.text = [NSString stringWithFormat:@"%@,%@",kHankUnNilStr(_model.cityName),kHankUnNilStr(_model.areaName)];
    }
    return _lblVillageName;
}

@end
