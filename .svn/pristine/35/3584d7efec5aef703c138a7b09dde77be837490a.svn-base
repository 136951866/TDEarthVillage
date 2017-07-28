//
//  TDHomeHeaderView.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDHomeHeaderView.h"
#import "TDHomeFilterView.h"
#import "TDHomeSysTopManagerModel.h"
#import "TDHomeVC.h"
#import "TDInfoDetailVC.h"
#import "TDVillageDetails.h"
#import "TDTourDetalisVC.h"

@interface TDHomeHeaderView ()<SDCycleScrollViewDelegate>{
    kHomeDvilllageModelBlock _selectFilterBlock;
    NSArray *_topManArrModel;
    NSArray *_filterArrModel;
}

@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong)UIView *viewLine;
@property (nonatomic, strong)TDHomeFilterView *filterView;

@end

@implementation TDHomeHeaderView

#pragma mark - Private Method

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.cycleScrollView];
        [self addSubview:self.filterView];
        [self addSubview:self.viewLine];
    }
    return self;
}

- (void)setUIWithTopManArrModel:(NSArray *)topManArrModel
                 filterArrModel:(NSArray *)filterArrModel
              selectFilterBlock:(kHomeDvilllageModelBlock)selectFilterBlock{
    _selectFilterBlock = selectFilterBlock;
    _topManArrModel = topManArrModel;
    _filterArrModel = filterArrModel;
    __block NSMutableArray *arrImg = [NSMutableArray array];
    [_topManArrModel enumerateObjectsUsingBlock:^(TDHomeSysTopManagerModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrImg addObject:obj.topLog];
    }];
    self.cycleScrollView.imageURLStringsGroup = arrImg;
    [self.filterView setUIWithFilterArrModel:filterArrModel selectFilterBlock:selectFilterBlock];
    self.viewLine.backgroundColor = topManArrModel.count?kBackgroundGray:[UIColor whiteColor];
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    TDHomeSysTopManagerModel *model = _topManArrModel[index];
    TDHomeVC *vc = [TDPublicTools getVCWithClass:[TDHomeVC class] targetResponder:self];
    switch (model.type) {
        case TDTopManagerInfoType:{
            //资讯
            if(vc){
                TDInfoDetailVC *detailsVC = [[TDInfoDetailVC alloc]initWithInfoId:kHankUnNilStr(model.contentId)];
                [vc.navigationController pushViewController:detailsVC animated:YES];
            }
        }
            break;
        case TDTopManagerVillageType:{
            //村落
            if(vc){
                TDVillageDetails *detailsVC = [[TDVillageDetails alloc]initWithVillageId:kHankUnNilStr(model.contentId)];
                [vc.navigationController pushViewController:detailsVC animated:YES];
            }
        }
            break;
        case TDTopManagerTourType:{
            //旅游线路
            if(vc){
                TDTourDetalisVC *detailsVC = [[TDTourDetalisVC alloc]initWithTourId:kHankUnNilStr(model.contentId)];
                [vc.navigationController pushViewController:detailsVC animated:YES];
            }
        }
            break;
        case TDTopManagerAgricultureType:{
            //农产品
            if(vc){
                TDTourDetalisVC *detailsVC = [[TDTourDetalisVC alloc]initWithProductId:kHankUnNilStr(model.contentId)];
                [vc.navigationController pushViewController:detailsVC animated:YES];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - Setter And Getter

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

- (UIView *)viewLine{
    if(!_viewLine){
        _viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 2, SCREEN_WIDTH, 2)];
        _viewLine.backgroundColor = [UIColor whiteColor];
    }
    return _viewLine;
}

- (TDHomeFilterView *)filterView{
    if(!_filterView){
        _filterView = [[TDHomeFilterView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH *3/5, SCREEN_WIDTH, 90)];
    }
    return _filterView;
}

+ (CGFloat)getTDHomeHeaderViewHeightWithFilterArrModel:(NSArray *)filterArrModel{
    CGFloat height = ((SCREEN_WIDTH*3)/5);
    height +=[TDHomeFilterView getTDHomeFilterViewHeightWithFilterArrModel:filterArrModel];
    return height;
}
@end
