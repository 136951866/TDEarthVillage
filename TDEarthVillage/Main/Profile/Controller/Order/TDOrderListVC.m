//
//  TDOrderListVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDOrderListVC.h"
#import "TDOrderCell.h"
#import "TDOrderDetailsVC.h"
#import "TDOrderModel.h"
#import "TDOrderPayVC.h"
#import "TDOrderPayModel.h"

@interface TDOrderListVC ()<UITableViewDataSource,UITableViewDelegate,RefreshToolDelegate>

@property (strong, nonatomic) ZLRefreshTool             *refresh;
@property (weak, nonatomic) IBOutlet UITableView        *tableView;

@end

@implementation TDOrderListVC

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"EFF0F1"];
    _tableView.tableFooterView = view;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDOrderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDOrderCell class])];
     [self.refresh addRefreshView];
    kALI_PAY_RESULTWithSelector(alipaySuccess:)
    kWX_PAY_RESULTWithSelector(wechatSuccess:)
    // Do any additional setup after loading the view from its nib.
}

- (void)wechatSuccess:(NSNotification *)noti{
    [self.refresh reload];
}

- (void)alipaySuccess:(NSNotification *)noti{
   [self.refresh reload];
}

#pragma mark - RefreshToolDelegate

//数据链接地址
- (NSDictionary *)requestParameter{
    return @{@"token":kHankUnNilStr(kCurrentUser.token)};
}
//返回响应数据
- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[TDOrderModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDOrderModel *model = self.refresh.arrData[indexPath.row];
    TDOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDOrderCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDOrderModel *model = self.refresh.arrData[indexPath.row];
    return [TDOrderCell getCellHeightWithModel:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TDOrderModel *model = self.refresh.arrData[indexPath.row];
    if(model.status == TDPayStatusWaitPayType){
        TDOrderPayVC *payVC = [[TDOrderPayVC alloc]initWithOrderModel:model];
        [self.navigationController pushViewController:payVC animated:YES];
    }else{
        TDOrderDetailsVC *detailsVC = [[TDOrderDetailsVC alloc]initWithOrderModel:model];
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
}

#pragma mark - Setter

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        NSString *url = [BASEIP stringByAppendingString:ORDERLIST];
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:url];
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
            failView.lblOfNodata.text = @"没有订单";
        }];
    }
    return _refresh;
}

@end
