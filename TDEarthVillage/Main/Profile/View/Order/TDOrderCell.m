//
//  TDOrderCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDOrderCell.h"
#import "TDOrderSubCell.h"
#import "TDOrderModel.h"

@interface TDOrderCell()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_arrData;
    TDOrderModel *_model;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTabViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderNum;
@property (weak, nonatomic) IBOutlet UILabel *lblCreateTime;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@end

@implementation TDOrderCell

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

- (void)setUIWithModel:(TDOrderModel *)model{
    _model = model;
//    _consTabViewHeight.constant = model.arrProduct.count * kTDOrderSubCellHeight;
    __block CGFloat subCellHeight = 0;
    
    [model.arrProduct enumerateObjectsUsingBlock:^(TDOrderProctModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        subCellHeight +=[TDOrderSubCell getCellHeightWithModel:kHankUnNilStr(model.name)];
    }];
    _consTabViewHeight.constant = subCellHeight;
    
    _lblOrderNum.text = kHankUnNilStr(model.orderNo);
    _lblCreateTime.text = kHankUnNilStr(model.createDate);
    
    switch (model.status) {
        case TDPayStatusWaitPayType:{
            _lblStatus.text = @"待付款";
            _lblStatus.textColor = [UIColor redColor];
        }
            break;
        case TDPayStatusSucessPayType:{
            _lblStatus.text = @"已付款";
            _lblStatus.textColor = kThemeBlue;
        }
            break;
//        case TDPayStatusSendType:{
//            _lblStatus.text = @"已发货";
//            _lblStatus.textColor = [UIColor colorWithHexString:@"858687"];
//        }
            break;
        default:{
            _lblStatus.text = @"待付款";
            _lblStatus.textColor = [UIColor redColor];
        }
            break;
    }
    [_tableView reloadData];
    [self layoutIfNeeded];
}

+ (CGFloat)getCellHeightWithModel:(TDOrderModel *)model{
    //cell的高度 - tableview的高度
    CGFloat height = 172 - 33.5;
//    height +=kTDOrderSubCellHeight * model.arrProduct.count;
    __block CGFloat subCellHeight = 0;
    
    [model.arrProduct enumerateObjectsUsingBlock:^(TDOrderProctModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        subCellHeight +=[TDOrderSubCell getCellHeightWithModel:kHankUnNilStr(model.name)];
    }];
    height += subCellHeight;
    return height;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   TDOrderSubCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDOrderSubCell class]) forIndexPath:indexPath];
    TDOrderProctModel *model = _model.arrProduct[indexPath.row];
//    cell.lblTitle.text = kHankUnNilStr(model.name);
    [cell setWithTitle:kHankUnNilStr(model.name)];
    cell.lblNum.text= [NSString stringWithFormat:@"X%@",kHankUnNilStr(model.num)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return kTDOrderSubCellHeight;
    TDOrderProctModel *model = _model.arrProduct[indexPath.row];
    return [TDOrderSubCell getCellHeightWithModel:kHankUnNilStr(model.name)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _model.arrProduct.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


@end
