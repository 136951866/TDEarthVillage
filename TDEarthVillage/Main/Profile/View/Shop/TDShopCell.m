//
//  TDShopCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/4.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDShopCell.h"

@interface TDShopCell(){
    BOOL _select;
    TDShopModel *_model;
}

@property (nonatomic, strong)UIButton           *btnSelect;
@property (nonatomic, strong)UIView             *viewLine;
@property (nonatomic, strong)UIImageView        *imgPic;
@property (nonatomic, strong)UILabel            *lblTitle;
@property (nonatomic, strong)UILabel            *lblCost;

@property (nonatomic, strong)UIButton           *btnReduce;
@property (nonatomic, strong)UIButton           *btnAdd;
@property (nonatomic, strong)UILabel            *lblNumber;

@end

@implementation TDShopCell

#pragma mark - Private Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.btnSelect];
        [self.contentView addSubview:self.viewLine];
        [self.contentView addSubview:self.imgPic];
        [self.contentView addSubview:self.lblTitle];
        [self.contentView addSubview:self.lblCost];
        [self.contentView addSubview:self.btnReduce];
        [self.contentView addSubview:self.lblNumber];
        [self.contentView addSubview:self.btnAdd];
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints{
    [self.btnSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
        make.centerY.equalTo(self);
    }];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
    [self.imgPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnSelect.mas_right).offset(7);
        make.bottom.equalTo(self).offset(-14);
        make.top.equalTo(self).offset(14);
        make.width.equalTo(@(120));
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgPic.mas_right).offset(7);
        make.right.equalTo(self).offset(-7);
        make.top.equalTo(self.imgPic.mas_top);
    }];
    
    [self.lblCost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lblTitle.mas_right);
        make.bottom.equalTo(self.imgPic.mas_bottom);
    }];
   
    [self.btnReduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblTitle.mas_left);
        make.bottom.equalTo(self.imgPic.mas_bottom);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    
    [self.lblNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnReduce.mas_right);
        make.width.equalTo(@(50));
        make.centerY.equalTo(self.btnReduce.mas_centerY);
    }];
    
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblNumber.mas_right);
        make.centerY.equalTo(self.lblNumber.mas_centerY);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];

}

#pragma mark - Public Method

- (void)setUIWithModel:(TDShopModel *)model{
    _model = model;
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:kHankUnNilStr(model.log)] placeholderImage:kimgPlaceholder];
    _lblTitle.text = kHankUnNilStr(model.title);
    _lblNumber.text = kHankUnNilStr(model.strNum);
    _select = model.isSelect;
    _lblCost.text = [NSString stringWithFormat:@"¥ %@",kHankUnNilStr(model.price)];
    _btnSelect.selected = model.isSelect;
}

#pragma mark - Action

- (void)selectedAction:(UIButton *)btn{
    if (_select) {
        if ([_selectedDelegate respondsToSelector:@selector(selectedCancelCell:)]) {
            [_selectedDelegate selectedCancelCell:self];
        }
    }else{
        if ([_selectedDelegate respondsToSelector:@selector(selectedConfirmCell:)]) {
            [_selectedDelegate selectedConfirmCell:self];
        }
    }
}

- (void)reduceAction:(UIButton *)sender {
    NSInteger count = [_lblNumber.text integerValue];
    count--;
    if (count < 1) {
        [TDPublicTools showMessage:@"请输入正确的数量" view:nil];
        return;
    }
    _lblNumber.text = [NSString stringWithFormat:@"%@",@(count)];
    if ([_selectedDelegate respondsToSelector:@selector(getNumberWithCell:Number:)]) {
        [_selectedDelegate getNumberWithCell:self Number:_lblNumber.text];
    }
    [TDDataBase updataCountInCar:_lblNumber.text model:_model];
}

- (void)addAction:(UIButton *)sender {
    NSInteger count = [_lblNumber.text integerValue];
    count++;
    if (count >999) {
        [TDPublicTools showMessage:@"请输入正确的数量" view:nil];
        return;
    }
    _lblNumber.text = [NSString stringWithFormat:@"%@",@(count)];
    if ([_selectedDelegate respondsToSelector:@selector(getNumberWithCell:Number:)]) {
        [_selectedDelegate getNumberWithCell:self Number:_lblNumber.text];
    }
    [TDDataBase updataCountInCar:_lblNumber.text model:_model];
}

#pragma mark - Setter

- (UIButton *)btnSelect{
    if(!_btnSelect){
        _btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSelect setImage:[UIImage imageNamed:@"shopcar_choose"] forState:UIControlStateNormal];
        [_btnSelect setImage:[UIImage imageNamed:@"shopcar_choose_s"] forState:UIControlStateSelected];
        [_btnSelect addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSelect;
}

- (UIView *)viewLine{
    if(!_viewLine){
        _viewLine = [UIView new];
        _viewLine.backgroundColor = kBackgroundGray;
    }
    return _viewLine;
}

- (UIImageView *)imgPic{
    if(!_imgPic){
        _imgPic = [UIImageView new];
        _imgPic.contentMode = UIViewContentModeScaleAspectFill;
        _imgPic.clipsToBounds = YES;
    }
    return _imgPic;
}

- (UILabel *)lblTitle{
    if(!_lblTitle){
        _lblTitle = [UILabel new];
        _lblTitle.textColor = kTitleThemeBlack;
        _lblTitle.textAlignment  = NSTextAlignmentLeft;
        _lblTitle.numberOfLines = 2;
        _lblTitle.font = kHankFont(15);
    }
    return _lblTitle;
}

- (UILabel *)lblCost{
    if(!_lblCost){
        _lblCost = [UILabel new];
        _lblCost.textColor = kThemeBlue;
        _lblCost.textAlignment  = NSTextAlignmentRight;
        _lblCost.font = kHankFont(17);
    }
    return _lblCost;
}

- (UIButton *)btnReduce{
    if(!_btnReduce){
        _btnReduce = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnReduce setImage:[UIImage imageNamed:@"shopcar_reduce"] forState:UIControlStateNormal];
        [_btnReduce addTarget:self action:@selector(reduceAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnReduce;
}

- (UIButton *)btnAdd{
    if(!_btnAdd){
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAdd setImage:[UIImage imageNamed:@"shopcar_plus"] forState:UIControlStateNormal];
        [_btnAdd addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAdd;
}

- (UILabel *)lblNumber{
    if(!_lblNumber){
        _lblNumber = [UILabel new];
        _lblNumber.backgroundColor = [UIColor clearColor];
        _lblNumber.textColor = kThemeBlue;
        _lblNumber.textAlignment  = NSTextAlignmentCenter;
        _lblNumber.font = kHankFont(15);
    }
    return _lblNumber;
}

@end
