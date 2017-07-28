//
//  TDOrderPayStatuesVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDOrderPayStatuesVC.h"
#import "TDOrderPayStatuesCell.h"
#import "TDOrderPayModel.h"
#import "TDOrderDetailsVC.h"

@interface TDOrderPayStatuesVC ()<UITableViewDelegate,UITableViewDataSource>{
    TDOrderPayModel *_model;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnStatus;

@end

@implementation TDOrderPayStatuesVC

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

HankMustImplementedDataInit()
- (instancetype)initWithModel:(TDOrderPayModel *)model{
    if(self = [super init]){
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付状态";
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDOrderPayStatuesCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDOrderPayStatuesCell class])];
    [_btnStatus setTitle:_model.payIsSucess?@"查看订单":@"重新支付" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(popBackAction:) image:@"common_back" highImage:@"common_back"];
    kALI_PAY_RESULTWithSelector(alipaySuccess:)
    kWX_PAY_RESULTWithSelector(wechatSuccess:)
    // Do any additional setup after loading the view from its nib.
    //回 购物车 TDOrderListVC TDTourDetalisVC
}

- (void)popBackAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    kHankCallBlock(_popBlock);
}
#pragma mark - NSNotificationCenter

- (void)wechatSuccess:(NSNotification *)noti{
    [self payResultWithNoti:[noti object] result:WXPAY_SUCCESSED];
}

- (void)alipaySuccess:(NSNotification *)noti{
    [self payResultWithNoti:[noti object] result:ALIPAY_SUCCESSED];
}

- (void)payResultWithNoti:(NSString *)noti result:(NSString *)result{
    _model.payIsSucess = [noti isEqualToString:result];
    _model.payTime = [TDPublicTools dateStringForFormat:@"yyyy.MM.dd HH:mm" timeInterval:[[NSDate date] timeIntervalSince1970]];
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDOrderPayStatuesCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDOrderPayStatuesCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:_model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TDOrderPayStatuesCell getCellHeightWithModel:_model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Action

- (IBAction)payStatusAction:(UIButton *)sender {
    if(_model.payIsSucess){
        //查看订单
        _model.status = TDPayStatusWaitSendType;
        TDOrderDetailsVC *detailsVC = [[TDOrderDetailsVC alloc]initWithModel:_model];
        [self.navigationController pushViewController:detailsVC animated:YES];
    }else{
        //重新支付
        if(_model.payType == TDPayApliType){
            //支付宝
            [TDAlipayTool payAliPayWithOrderId:kHankUnNilStr(_model.outTradeNo) totalMoney:kHankUnNilStr(_model.amount) payTitle:kHankUnNilStr(_model.subject) productDescription:kHankUnNilStr(_model.subject) notifyURL:kHankUnNilStr(_model.notifyUrl)];
        }else{
            //微信
            [LVWxPay WXPayWithbody:kHankUnNilStr(_model.subject) andtrade_no:kHankUnNilStr(_model.outTradeNo) andPrice:[NSString stringWithFormat:@"%ld",(long)([kHankUnNilStr(_model.amount) floatValue] * 100)] notifyURL:kHankUnNilStr(_model.notifyUrl)];
        }
    }
}


@end
