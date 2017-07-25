//
//  TDHomeFilterTableViewView.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDHomeFilterTableViewView.h"
#import "TDHomeFilterTableViewCell.h"

#define kTDHomeFilterTableViewHeight (332 * kHankFrameScaleY())

@interface TDHomeFilterTableViewView()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_filterArrModel;
    CGFloat _allHeight;
    kHomeDvilllageModelBlock _selectFilterBlock;
}

@property (strong, nonatomic)  UIView           *viewBack;
@property (strong, nonatomic)  UITableView      *tableView;
@end

@implementation TDHomeFilterTableViewView

#pragma mark - Public Method

- (void)show{
    self.hidden = NO;
    [kHankCurrentWindow addSubview:self];
    _allHeight = self.tableView.contentSize.height;
    _allHeight = _allHeight>kTDHomeFilterTableViewHeight?kTDHomeFilterTableViewHeight:_allHeight;
    self.tableView.frame = CGRectMake((SCREEN_WIDTH - kTDHomeFilterTableViewCellWdith)/2, 0, kTDHomeFilterTableViewCellWdith, _allHeight);
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGFloat y = (SCREEN_HEIGHT - _allHeight)/2;
        self.viewBack.alpha = 0.5;
        self.tableView.frame = CGRectMake( (SCREEN_WIDTH - kTDHomeFilterTableViewCellWdith)/2, y, kTDHomeFilterTableViewCellWdith, _allHeight);
    } completion:nil];
}

- (void)hide:(kHankBasicBlock)finishBlock{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.maskView.alpha = 0;
        self.tableView.frame = CGRectMake((SCREEN_WIDTH - kTDHomeFilterTableViewCellWdith)/2, SCREEN_HEIGHT, kTDHomeFilterTableViewCellWdith,_allHeight);
    } completion:^(BOOL finished) {
        kHankCallBlock(finishBlock);
        [self removeFromSuperview];
    }];
}

- (void)hide{
    [self hide:nil];
}

- (void)setUIWithModel:(NSArray *)filterArrModel
     selectFilterBlock:(kHomeDvilllageModelBlock)selectFilterBlock{
    _filterArrModel = filterArrModel;
    _selectFilterBlock = selectFilterBlock;
    [self.tableView reloadData];
}

- (void)setSubView{
    [kHankCurrentWindow addSubview:self];
    [self setMaskView];
    [self addSubview:self.viewBack];
    [self addSubview:self.tableView];
    [self.tableView reloadData];
    _allHeight = self.tableView.contentSize.height;
    _allHeight = _allHeight>kTDHomeFilterTableViewHeight?kTDHomeFilterTableViewHeight:_allHeight;
    self.tableView.frame = CGRectMake( (SCREEN_WIDTH - kTDHomeFilterTableViewCellWdith)/2, -_allHeight, kTDHomeFilterTableViewCellWdith, _allHeight);
    self.hidden = YES;
}

#pragma mark - Private Method

- (void)setMaskView{
    self.viewBack.alpha = 0.0;
    self.viewBack.frame = self.bounds;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _filterArrModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDHomeFilterTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDHomeFilterTableViewCell class]) forIndexPath:indexPath];
    TDHomeDvilllageModel *model = _filterArrModel[indexPath.row];
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDHomeDvilllageModel *model = _filterArrModel[indexPath.row];
    return [TDHomeFilterTableViewCell getHeightWithModel:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TDHomeDvilllageModel *model = _filterArrModel[indexPath.row];
    HANKWEAKSELF    
    [self hide:^{
        HANKSTRONGSELF
        kHankCallBlock(strongSelf->_selectFilterBlock,model);
    }];
}

#pragma mark - Setter

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _viewBack.backgroundColor = [UIColor blackColor];
        _viewBack.alpha = 0.3;
        _viewBack.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        _viewBack.userInteractionEnabled = YES;
        [_viewBack addGestureRecognizer:tap];
        
    }
    return _viewBack;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake( (SCREEN_WIDTH - kTDHomeFilterTableViewCellWdith)/2, 0, kTDHomeFilterTableViewCellWdith, kTDHomeFilterTableViewHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDHomeFilterTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDHomeFilterTableViewCell class])];
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
