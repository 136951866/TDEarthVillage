//
//  TDOrderPayVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDOrderPayVC.h"
#import "TDOrderPayCell.h"
#import "TDOrderPayStatuesVC.h"
#import "TDOrderPayModel.h"
#import "TDOrderPayStatuesVC.h"
#import "TDOrderModel.h"

@interface TDOrderPayVC ()<UITableViewDelegate,UITableViewDataSource>{
    TDOrderPayModel *_model;
    TDPayType _payType;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;

@end

@implementation TDOrderPayVC

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

HankMustImplementedDataInit()
- (instancetype)initWithModel:(TDOrderPayModel *)model{
    if(self = [super init]){
        _model = model;
        _model.isCanEdit = YES;
        _payType = TDPayWeiChatType;
    }
    return self;
}

- (instancetype)initWithOrderModel:(TDOrderModel *)model{
    if(self = [super init]){
        _model = [TDOrderPayModel new];
        _model.TDID = model.TDID;
        _model.amount = model.totalAmount;
        _model.outTradeNo = model.orderNo;
        _model.subject = model.productName;
        _model.numStr = model.productNum;
        _model.payTime = model.payDate;
        _model.payType = [model.payChannel intValue];
        _model.payIsSucess = model.status !=TDPayStatusWaitPayType;
        _model.status = model.status;
        _model.notifyUrl = model.notifyUrl;
        _model.receiptAddress = model.receiptAddress;
        _model.receiptName = model.receiptName;
        _model.receiptPhone = model.receiptPhone;
        _model.isCanEdit = NO;
        _payType = _model.payType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单";
    [_btnPay setTitle:[NSString stringWithFormat:@"支付(￥%@)",_model.amount] forState:UIControlStateNormal];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDOrderPayCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDOrderPayCell class])];
    kALI_PAY_RESULTWithSelector(alipaySuccess:)
    kWX_PAY_RESULTWithSelector(wechatSuccess:)
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

#pragma mark - NSNotificationCenter

- (void)wechatSuccess:(NSNotification *)noti{
    [self payResultWithNoti:[noti object] result:WXPAY_SUCCESSED];
}

- (void)alipaySuccess:(NSNotification *)noti{
    [self payResultWithNoti:[noti object] result:ALIPAY_SUCCESSED];
}

- (void)payResultWithNoti:(NSString *)noti result:(NSString *)result{
//    if ([noti isEqualToString:result]) {
//        NSLog(@"支付成功");
//    }else{
//        NSLog(@"支付失败");
//    }
//    if ([result isEqualToString:ALIPAY_SUCCESSED]) {
//        NSLog(@"alipay");
//    }else if([result isEqualToString:WXPAY_SUCCESSED]){
//        NSLog(@"wechatpay");
//    }
    _model.payIsSucess = [noti isEqualToString:result];
    _model.payType = _payType;
    _model.payTime = [TDPublicTools dateStringForFormat:@"yyyy.MM.dd HH:mm" timeInterval:[[NSDate date] timeIntervalSince1970] * 1000];
    TDOrderPayStatuesVC *statusVC = [[TDOrderPayStatuesVC alloc]initWithModel:_model];
    [self.navigationController pushViewController:statusVC animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDOrderPayCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDOrderPayCell class]) forIndexPath:indexPath];
    HANKWEAKSELF    
    [cell setUIWithModel:_model payTypeBlock:^(TDPayType index) {
        HANKSTRONGSELF
        strongSelf->_payType = index;
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TDOrderPayCell getCellHeightWithModel:_model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Action

- (IBAction)payAction:(UIButton *)sender {
    if(_payType == TDPayApliType){
        //支付宝
        [TDAlipayTool payAliPayWithOrderId:kHankUnNilStr(_model.outTradeNo) totalMoney:kHankUnNilStr(_model.amount) payTitle:kHankUnNilStr(_model.subject) productDescription:kHankUnNilStr(_model.subject) notifyURL:kHankUnNilStr(_model.notifyUrl)];
    }else{
        //微信
        [LVWxPay WXPayWithbody:kHankUnNilStr(_model.subject) andtrade_no:kHankUnNilStr(_model.outTradeNo) andPrice:[NSString stringWithFormat:@"%ld",(long)([kHankUnNilStr(_model.amount) floatValue] * 100)] notifyURL:kHankUnNilStr(_model.notifyUrl)];
    }
}

@end
