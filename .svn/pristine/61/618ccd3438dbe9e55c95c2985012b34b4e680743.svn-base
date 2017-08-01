//
//  TDHomeFilterView.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDHomeFilterView.h"
#import "TDHomeFilterTableViewView.h"

#define klblMaxWdith (SCREEN_WIDTH/5)

const static CGFloat KTapTag = 1000;
const static CGFloat KWdithFill = 14;
const static CGFloat KHeightFill = 6;
const static CGFloat KMargin = 14;

const static CGFloat KTapMoreTag = 2000;

@interface TDHomeFilterView(){
    CGFloat _totalHeight;
    //上一次的frame
    CGRect _previousFrame ;
    NSArray *_filterArrModel;
    kHomeDvilllageModelBlock _selectFilterBlock;
    NSMutableArray *_arrLabel;
    
    UILabel *_lblPre;
    UILabel *_lblCurrent;
    
    NSMutableArray *_filterTabArrModel;
}

@property (nonatomic, strong) TDHomeFilterTableViewView *filterTabView;

@end

@implementation TDHomeFilterView

#pragma mark - Public Method

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _arrLabel = [NSMutableArray array];
        _filterTabArrModel = [NSMutableArray array];
    }
    return self;
}

- (void)setUIWithFilterArrModel:(NSArray *)filterArrModel
              selectFilterBlock:(kHomeDvilllageModelBlock)selectFilterBlock{
    _filterArrModel = filterArrModel;
    _selectFilterBlock = selectFilterBlock;
    [self prepare];
    [self setLabel];
}
#pragma mark - Private Method

- (void)prepare{
     _totalHeight = 0;
    [_arrLabel enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    if(_filterTabArrModel.count){
        [self.filterTabView removeFromSuperview];
        self.filterTabView = nil;
    }
}

- (void)setLabel{
    _previousFrame = CGRectMake(0, KMargin, 0, 0);
    __block NSInteger lastindex = 0;
    HANKWEAKSELF
    [_filterArrModel enumerateObjectsUsingBlock:^(TDHomeDvilllageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HANKSTRONGSELF
        UILabel*tagLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        tagLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        tagLabel.textColor = idx?kTitleThemeBlack:[UIColor whiteColor];
        tagLabel.backgroundColor = idx?kThemeGray:kThemeBlue;
        if(!idx){
            _lblPre = tagLabel;
        }
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.font = [UIFont boldSystemFontOfSize:12];
        tagLabel.text = kHankUnNilStr(obj.name);
        tagLabel.tag = KTapTag + idx;
        tagLabel.layer.cornerRadius = 2;
        tagLabel.clipsToBounds=YES;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:12]};
        CGSize Size_str=[kHankUnNilStr(obj.name) sizeWithAttributes:attrs];
        
        Size_str.width += KWdithFill;
        Size_str.width = Size_str.width > klblMaxWdith?klblMaxWdith:Size_str.width;
        Size_str.height += KHeightFill;
        
        if (((_previousFrame.origin.y+ _previousFrame.size.height+(KMargin) + Size_str.height) > ((Size_str.height * 2)+ (KMargin * 3))) && (_previousFrame.origin.x + _previousFrame.size.width + KMargin + Size_str.width>= self.width ) ){
            UILabel *lblPre = [self viewWithTag:KTapTag+ (idx -1)];
            UILabel*tagLabel=[[UILabel alloc]initWithFrame:_previousFrame];
            tagLabel.textAlignment = NSTextAlignmentCenter;
            tagLabel.tag = KTapMoreTag;
            tagLabel.font = [UIFont boldSystemFontOfSize:12];
            tagLabel.textColor = kTitleThemeBlack;
            tagLabel.backgroundColor = kThemeGray;
            tagLabel.text = @"更多 >";
            tagLabel.layer.cornerRadius = 2;
            tagLabel.clipsToBounds=YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction:)];
            tagLabel.userInteractionEnabled = YES;
            [tagLabel addGestureRecognizer:tap];
            [strongSelf addSubview:tagLabel];
             [lblPre removeFromSuperview];
            lastindex = idx -1;
            *stop = YES;
        }else{
             CGRect newRect = CGRectZero;
            if (_previousFrame.origin.x + _previousFrame.size.width + KMargin + Size_str.width>= self.width ){
                newRect.origin = CGPointMake(KMargin, _previousFrame.origin.y + Size_str.height + KMargin);
     
                _totalHeight += Size_str.height + KMargin;
            }else {
                newRect.origin = CGPointMake(_previousFrame.origin.x + _previousFrame.size.width + KMargin, _previousFrame.origin.y);
            }
            newRect.size = Size_str;
            if (_previousFrame.origin.x + _previousFrame.size.width + KMargin*2 + Size_str.width>= self.width ){
                newRect.size.width -= KMargin;
            }
            [tagLabel setFrame:newRect];
            
            [strongSelf setHight:strongSelf andHight:_totalHeight+Size_str.height + KMargin];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction:)];
            tagLabel.userInteractionEnabled = YES;
            [tagLabel addGestureRecognizer:tap];
            _previousFrame=newRect;
            [strongSelf addSubview:tagLabel];
            [_arrLabel addObject:tagLabel];
        }
    }];
    _filterTabArrModel = [NSMutableArray arrayWithArray:[_filterArrModel subarrayWithRange:NSMakeRange(lastindex, _filterArrModel.count - lastindex)]];
}

//设置view的高度
- (void)setHight:(UIView *)view andHight:(CGFloat)hight{
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;
}

#pragma mark - Action

- (void)handleTapAction:(UITapGestureRecognizer *)tap{
    if(![tap.view isKindOfClass:[UILabel class]]){
        return;
    }
    if(tap.view.tag == KTapMoreTag){
        [self.filterTabView show];
    }else{
        [self.filterTabView cleanSelect];
        NSInteger index = tap.view.tag - KTapTag;
        TDHomeDvilllageModel *model = _filterArrModel[index];
        _lblPre.textColor = kTitleThemeBlack;
        _lblPre.backgroundColor = kThemeGray;
        
        _lblCurrent = (UILabel *)(tap.view);
        _lblCurrent.textColor = [UIColor whiteColor];
        _lblCurrent.backgroundColor = kThemeBlue;
        _lblPre = _lblCurrent;
       kHankCallBlock(_selectFilterBlock,model);
    }
}

#pragma mark - Setter

- (TDHomeFilterTableViewView *)filterTabView{
    if(!_filterTabView){
        _filterTabView = [[TDHomeFilterTableViewView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        HANKWEAKSELF    
        [_filterTabView setUIWithModel:_filterTabArrModel selectFilterBlock:^(TDHomeDvilllageModel *model) {
            HANKSTRONGSELF
            strongSelf->_lblPre.textColor = kTitleThemeBlack;
            strongSelf->_lblPre.backgroundColor = kThemeGray;
            
            strongSelf->_lblCurrent = (UILabel *)([self viewWithTag:KTapMoreTag]);
            strongSelf->_lblCurrent.textColor = [UIColor whiteColor];
            strongSelf->_lblCurrent.backgroundColor = kThemeBlue;
            strongSelf->_lblPre = _lblCurrent;
            kHankCallBlock(strongSelf->_selectFilterBlock,model);
        }];
        [_filterTabView setSubView];
    }
    return _filterTabView;
}

+ (CGFloat)getTDHomeFilterViewHeightWithFilterArrModel:(NSArray *)filterArrModel{
    __block CGFloat height = filterArrModel.count?50:0;
    __block CGRect _previousFrame = CGRectMake(0, KMargin, 0, 0);
    [filterArrModel enumerateObjectsUsingBlock:^(TDHomeDvilllageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:12]};
        CGSize Size_str=[kHankUnNilStr(obj.name) sizeWithAttributes:attrs];
        Size_str.width += KWdithFill;
        Size_str.width = Size_str.width > klblMaxWdith?klblMaxWdith:Size_str.width;
        Size_str.height += KHeightFill;
        if (((_previousFrame.origin.y+ _previousFrame.size.height+(KMargin) + Size_str.height) >= ((Size_str.height * 2)+ (KMargin * 3))) && (_previousFrame.origin.x + _previousFrame.size.width + KMargin + Size_str.width>= SCREEN_WIDTH ) ){
            height +=40;
            *stop = YES;
        }else{
            CGRect newRect = CGRectZero;
            if (_previousFrame.origin.x + _previousFrame.size.width + KMargin + Size_str.width>= SCREEN_WIDTH ){
                newRect.origin = CGPointMake(KMargin, _previousFrame.origin.y + Size_str.height + KMargin);
            }else {
                newRect.origin = CGPointMake(_previousFrame.origin.x + _previousFrame.size.width + KMargin, _previousFrame.origin.y);
            }
            newRect.size = Size_str;
            if (_previousFrame.origin.x + _previousFrame.size.width + KMargin*2 + Size_str.width>= SCREEN_WIDTH ){
                newRect.size.width -= KMargin;
            }
            _previousFrame=newRect;
            if (((_previousFrame.origin.y+ _previousFrame.size.height+(KMargin) + Size_str.height) >= ((Size_str.height * 2)+ (KMargin * 3))) && (_previousFrame.origin.x + _previousFrame.size.width + KMargin + Size_str.width>= SCREEN_WIDTH ) ){
                height +=40;
                *stop = YES;
            }
        }
    }];

    return height;
}
@end
