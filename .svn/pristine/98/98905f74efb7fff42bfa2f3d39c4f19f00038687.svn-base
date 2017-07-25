//
//  TDTourDetalsHeaderView.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDTourDetalsHeaderView.h"
#import "TDAgricultureModel.h"
#import "TDTourModel.h"

@interface TDTourDetalsHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong)TDTourDetalsHeaderSubView *subView;

@end

@implementation TDTourDetalsHeaderView

- (instancetype)initWithFrame:(CGRect)frame agricultureModel:(TDAgricultureModel *)agricultureModel{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.cycleScrollView];
        [self addSubview:self.subView];
        _cycleScrollView.imageURLStringsGroup = kHankUnArr(agricultureModel.arrImages);
        [_subView setUIWithAgricultureModel:agricultureModel];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame tourModel:(TDTourModel *)tourModel{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.cycleScrollView];
        [self addSubview:self.subView];
        _cycleScrollView.imageURLStringsGroup = kHankUnArr(tourModel.arrImages);
        [_subView setUIWithTourModel:tourModel];
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
    }
    return _cycleScrollView;
}

- (TDTourDetalsHeaderSubView *)subView{
    if(!_subView){
        _subView = [[[NSBundle mainBundle]loadNibNamed:@"TDTourDetalsHeaderSubView" owner:nil options:nil] firstObject];
        _subView.frame = CGRectMake(0, (SCREEN_WIDTH*3)/5, SCREEN_WIDTH, kTDTourDetalsHeaderSubViewHeight);
    }
    return _subView;
}


@end
