//
//  TDPurchasePopupView.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDPurchasePopupView.h"

const static CGFloat kTDPurchasePopupViewHeight = 241.0f;

@interface TDPurchasePopupView(){
    kHankTextBlock _numBlock;
    UIView *_superView;
}

@property (weak, nonatomic) IBOutlet UILabel        *lblNum;
@property (weak, nonatomic) IBOutlet UIView         *viewForMask;
@property (weak, nonatomic) IBOutlet UIView         *ViewForPurchase;

@end

@implementation TDPurchasePopupView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.height = SCREEN_HEIGHT;
    self.width = SCREEN_WIDTH;
}

#pragma mark - Public Method

- (void)setWithNumBlock:(kHankTextBlock)numBlock superView:(UIView *)superView{
    _numBlock = numBlock;
    _superView = superView;
}

- (void)show{
    _ViewForPurchase.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kTDPurchasePopupViewHeight);
    self.hidden = NO;
    [_superView addSubview:self];
    [_superView addSubview:_ViewForPurchase];
    HANKWEAKSELF
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        HANKSTRONGSELF
        strongSelf.viewForMask.alpha = 0.5;
        strongSelf.ViewForPurchase.frame = CGRectMake(0, SCREEN_HEIGHT  - kTDPurchasePopupViewHeight, SCREEN_WIDTH, kTDPurchasePopupViewHeight);
    } completion:nil];
}

#pragma mark - Private Method

- (void)hide{
    [self hide:nil];
}

- (void)hide:(kHankBasicBlock)block{
    HANKWEAKSELF
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        HANKSTRONGSELF
        strongSelf.viewForMask.alpha = 0;
        strongSelf.ViewForPurchase.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kTDPurchasePopupViewHeight);
    } completion:^(BOOL finished) {
        HANKSTRONGSELF
        strongSelf.hidden = YES;
        kHankCallBlock(block);
    }];
}

#pragma mark - ACTION

- (IBAction)touchBackgroundAction:(UITapGestureRecognizer *)sender {
    [self hide];
}

- (IBAction)comfirmAction:(UIButton *)sender {
    HANKWEAKSELF
    [self hide:^{
        HANKSTRONGSELF
        kHankCallBlock(strongSelf->_numBlock,kHankUnNilStr(strongSelf->_lblNum.text));
    }];
}

- (IBAction)reduceAction:(UIButton *)sender {
    NSInteger count = [_lblNum.text integerValue];
    count--;
    if (count < 1) {
        [TDPublicTools showMessage:@"请输入正确的数量" view:nil];
        return;
    }
    _lblNum.text = [NSString stringWithFormat:@"%@",@(count)];
}

- (IBAction)addAction:(UIButton *)sender {
    NSInteger count = [_lblNum.text integerValue];
    count++;
    if (count >999) {
        [TDPublicTools showMessage:@"请输入正确的数量" view:nil];
        return;
    }
    _lblNum.text = [NSString stringWithFormat:@"%@",@(count)];
}


@end
