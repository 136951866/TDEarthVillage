//
//  TDOrderDetailsVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDOrderDetailsVC.h"
#import "TDOrderDetalisCell.h"
#import "TDOrderPayModel.h"
#import "TDOrderModel.h"

@interface TDOrderDetailsVC ()<UITableViewDataSource,UITableViewDelegate>{
    TDOrderPayModel *_model;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TDOrderDetailsVC

HankMustImplementedDataInit()
- (instancetype)initWithModel:(TDOrderPayModel *)model{
    if(self = [super init]){
        _model = model;
    }
    return self;
}

- (instancetype)initWithOrderModel:(TDOrderModel *)model{
    if(self = [super init]){
        _model = [TDOrderPayModel new];
        _model.amount = model.totalAmount;
        _model.outTradeNo = model.orderNo;
        _model.subject = model.productName;
        _model.numStr = model.productNum;
        _model.payTime = model.payDate;
        _model.payType = [model.payChannel intValue];
        _model.payIsSucess = model.status !=TDPayStatusWaitPayType;
        _model.notifyUrl = model.notifyUrl;
        _model.status = model.status;
        
        _model.receiptAddress = model.receiptAddress;
        _model.receiptName = model.receiptName;
        _model.receiptPhone = model.receiptPhone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDOrderDetalisCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDOrderDetalisCell class])];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDOrderDetalisCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDOrderDetalisCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:_model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TDOrderDetalisCell getCellHeightWithModel:_model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
