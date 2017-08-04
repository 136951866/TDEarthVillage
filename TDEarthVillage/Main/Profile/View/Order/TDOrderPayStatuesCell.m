//
//  TDOrderPayStatuesCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDOrderPayStatuesCell.h"
#import "TDOrderSubCell.h"
#import "TDOrderPayModel.h"

#define kGoodsViewOriHeight (10 + 21 + 10 + 0.5 + 10 + 10)

@interface TDOrderPayStatuesCell ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrData;
    TDOrderPayModel *_model;
}
@property (weak, nonatomic) IBOutlet UILabel *lblPayStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consGoodViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/***********订单************/
@property (weak, nonatomic) IBOutlet UILabel *lblOrderNum;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderCost;
@property (weak, nonatomic) IBOutlet UILabel *lblPayType;
@property (weak, nonatomic) IBOutlet UILabel *lblPayTime;

/***********收货地址************/

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblTel;
@end

@implementation TDOrderPayStatuesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDOrderSubCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDOrderSubCell class])];
    
    // Initialization code
}

#pragma mark - Public Method

- (void)setUIWithModel:(TDOrderPayModel *)model{
    _model = model;
    
    __block CGFloat subCellHeight = kGoodsViewOriHeight;
    
    [model.arrProduct enumerateObjectsUsingBlock:^(TDOrderPayProctModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        subCellHeight +=[TDOrderSubCell getCellHeightWithModel:kHankUnNilStr(model.name)];
    }];
    _consGoodViewHeight.constant = subCellHeight;//= kGoodsViewOriHeight +(kTDOrderSubCellHeight * model.arrSubject.count);
    _lblPayStatus.text = model.payIsSucess?@"支付成功":@"支付失败";
    _lblPayStatus.textColor = model.payIsSucess?kThemeBlue:[UIColor redColor];
    _lblOrderNum.text = kHankUnNilStr(_model.outTradeNo);
    _lblOrderCost.text = [NSString stringWithFormat:@"￥%@",kHankUnNilStr(_model.amount)];
    _lblPayType.text = model.payType == TDPayApliType?@"支付宝支付":@"微信支付";
    _lblPayTime.text = kHankUnNilStr(model.payTime);
    
    [_tableView reloadData];
    
    _lblName.text = kHankUnNilStr(kCurrentUser.acceptName);
    _lblAddress.text = kHankUnNilStr(kCurrentUser.acceptAddress);
    _lblTel.text = kHankUnNilStr(kCurrentUser.acceptPhone);
    [self layoutIfNeeded];
}

+ (CGFloat)getCellHeightWithModel:(TDOrderPayModel *)model{
    //除了Goods的view高度
    CGFloat height = 60 +  120 + 145 + 40;
    //height +=   kGoodsViewOriHeight +(kTDOrderSubCellHeight * model.arrSubject.count);
    __block CGFloat subCellHeight = kGoodsViewOriHeight;
    
    [model.arrProduct enumerateObjectsUsingBlock:^(TDOrderPayProctModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        subCellHeight +=[TDOrderSubCell getCellHeightWithModel:kHankUnNilStr(model.name)];
    }];
    height += subCellHeight;
    return height;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDOrderSubCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDOrderSubCell class]) forIndexPath:indexPath];
    TDOrderPayProctModel *model = _model.arrProduct[indexPath.row];
//    cell.lblTitle.text = kHankUnNilStr(model.name);
    [cell setWithTitle:kHankUnNilStr(model.name)];
    cell.lblNum.text= [NSString stringWithFormat:@"X%@",kHankUnNilStr(model.num)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDOrderPayProctModel *model = _model.arrProduct[indexPath.row];
    return [TDOrderSubCell getCellHeightWithModel:kHankUnNilStr(model.name)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.arrProduct.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}



@end
