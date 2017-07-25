//
//  TDOrderDetalisCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDOrderDetalisCell.h"
#import "TDOrderSubCell.h"
#import "TDOrderPayModel.h"

//中间视图高度- tableView高度
#define kMideViewOriHeight (10 + 21 + 10 + 0.5 + 10 + 10)

@interface TDOrderDetalisCell()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrData;
    TDOrderPayModel *_model;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consMidViewHeight;

/***********订单************/
@property (weak, nonatomic) IBOutlet UILabel *lblOrderNum;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderCost;
@property (weak, nonatomic) IBOutlet UILabel *lblPayType;
@property (weak, nonatomic) IBOutlet UILabel *lblPayTime;
/***********收货地址************/

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblTel;

/******************************/
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;


@end

@implementation TDOrderDetalisCell

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
    _consMidViewHeight.constant = kMideViewOriHeight +(kTDOrderSubCellHeight * model.arrSubject.count);
    _lblOrderNum.text = kHankUnNilStr(_model.outTradeNo);
    _lblOrderCost.text = [NSString stringWithFormat:@"￥%@",kHankUnNilStr(_model.amount)];
    _lblPayType.text = model.payType == TDPayApliType?@"支付宝支付":@"微信支付";
    _lblPayTime.text = kHankUnNilStr(model.payTime);
    
    [_tableView reloadData];
    
    _lblName.text = kHankUnNilStr(model.receiptAddress).length?kHankUnNilStr(model.receiptAddress):kHankUnNilStr(kCurrentUser.acceptAddress);
    _lblAddress.text =  kHankUnNilStr(model.receiptName).length?kHankUnNilStr(model.receiptName):kHankUnNilStr(kCurrentUser.acceptName);
    _lblTel.text = kHankUnNilStr(model.receiptPhone).length?kHankUnNilStr(model.receiptPhone):kHankUnNilStr(kCurrentUser.acceptPhone);
    [self layoutIfNeeded];
    
    _lblStatus.text = kHankUnNilStr(@"未知");
}

+ (CGFloat)getCellHeightWithModel:(TDOrderPayModel *)model{
    //除了中间的view高度
    CGFloat height = 120 +  170 + 30;
    height +=  kMideViewOriHeight +(kTDOrderSubCellHeight * model.arrSubject.count);
    return height;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDOrderSubCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDOrderSubCell class]) forIndexPath:indexPath];
    TDOrderPayProctModel *model = _model.arrProduct[indexPath.row];
    cell.lblTitle.text = kHankUnNilStr(model.name);
    cell.lblNum.text= [NSString stringWithFormat:@"X%@",kHankUnNilStr(model.num)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTDOrderSubCellHeight;
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
