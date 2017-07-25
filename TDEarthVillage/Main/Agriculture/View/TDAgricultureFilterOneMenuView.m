//
//  TDAgricultureFilterOneMenuView.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/7.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDAgricultureFilterOneMenuView.h"

NSString *const IDENTIFIER1 = @"CELL1";
#define kmargin SCREEN_HEIGHT/2

@interface TDAgricultureFilterOneMenuView()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *_arrData;
    UIView *_bgView;
    UIView *_bgbackView;
    UIView *_superView;
@private
    NSInteger _sel;
}

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation TDAgricultureFilterOneMenuView

#pragma mark - Public Method

- (instancetype)initWithArrData:(NSArray *)arrData superView:(UIView *)superView;{
    if(self = [super init]){
        _arrData = arrData;
        _superView = superView;
        _sel = -1;
        _bgbackView = [[UIView alloc] init];
        _bgbackView.backgroundColor = [UIColor blackColor];
        _bgbackView.userInteractionEnabled = YES;
        _bgbackView.alpha = 0.3;
        _bgbackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [_bgbackView addGestureRecognizer:ges];
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.userInteractionEnabled = YES;
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView addSubview:self.tableView];
        [self addSubview:_bgbackView];
        
    }
    return self;
}

- (void)showAsDrawDownView:(UIView *)view {
    CGRect showFrame = view.frame;
    CGFloat x = 0.f;
    CGFloat y = showFrame.origin.y+showFrame.size.height;
    CGFloat w = _superView.width;;
    CGFloat h = _superView.height-y- kmargin;
    self.frame = CGRectMake(x, y, w, h+ kmargin);
    _bgView.frame = CGRectMake(x, 0, w, h);
    _bgbackView.frame = CGRectMake(x, 0, w, h+kmargin);
    if(!_bgView.superview) {
        [self addSubview:_bgView];
    }
    [self loadSels];
    [self adjustTableViews];
    if(!self.superview) {
        [_superView addSubview:self];
        self.alpha = .0f;
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = 1.0f;
        }];
    }
    [_superView bringSubviewToFront:self];
}


- (void)dismiss{
    kHankCallBlock(_cancelBlock);
    if(self.superview) {
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = .0f;
        } completion:^(BOOL finished) {
            [_bgView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                [obj removeFromSuperview];
            }];
            [self removeFromSuperview];
        }];
    }
}

#pragma mark - Private Method

- (void)loadSels{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_sel inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    [_bgView addSubview:_tableView];
}

- (void)adjustTableViews{
    int w = SCREEN_WIDTH;
    CGRect rect = _tableView.frame;
    rect.size.height = _bgView.frame.size.height ;
    _tableView.frame = rect;
    
    CGRect f = _tableView.frame;
    f.size.width = w;
    f.origin.x = 0;
    _tableView.frame = f;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER1];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.text = _arrData[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _sel = indexPath.row;
    kHankCallBlock(_textBlock,_arrData[indexPath.row]);
    [self dismiss];
}

#pragma mark - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER1 ];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.frame = CGRectMake(0, 0, 0, 0);
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
