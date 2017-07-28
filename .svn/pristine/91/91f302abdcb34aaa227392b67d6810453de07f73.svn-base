//
//  TDOrderPayCell.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDOrderPayCell.h"
#import "TDOrderSubCell.h"
#import "TDOrderPayVC.h"
#import "TDMyDataVC.h"
#import "TDOrderPayModel.h"

#define kGoodsViewOriHeight (10 + 21 + 10 + 0.5 + 10 + 10)

@interface TDOrderPayCell()<UITableViewDelegate,UITableViewDataSource>{
    TDPayType _selectTYpe;
    TDOrderPayModel *_model;
    kTDPayTypeBlock _payTypeBlock;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnEditBac;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consGoodViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnWeiXin;
@property (weak, nonatomic) IBOutlet UIButton *btnAli;


//@property (weak, nonatomic) IBOutlet UILabel *lblOrderNum;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblTel;
@end

@implementation TDOrderPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDOrderSubCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDOrderSubCell class])];
    _selectTYpe = TDPayWeiChatType;
    // Initialization code
}

#pragma mark - Public Method

- (void)setUIWithModel:(TDOrderPayModel *)model payTypeBlock:(kTDPayTypeBlock)payTypeBlock{
    _model = model;
    _consGoodViewHeight.constant = kGoodsViewOriHeight +(kTDOrderSubCellHeight * model.arrProduct.count);
    _btnEditBac.hidden = _btnEdit.hidden = !model.isCanEdit;
    _payTypeBlock = payTypeBlock;
//    _lblOrderNum.text = kHankUnNilStr(_model.outTradeNo);
    [_tableView reloadData];
    _lblName.text = kHankUnNilStr(model.receiptAddress).length?kHankUnNilStr(model.receiptAddress):kHankUnNilStr(kCurrentUser.acceptAddress);
    _lblAddress.text =  kHankUnNilStr(model.receiptName).length?kHankUnNilStr(model.receiptName):kHankUnNilStr(kCurrentUser.acceptName);
    _lblTel.text = kHankUnNilStr(model.receiptPhone).length?kHankUnNilStr(model.receiptPhone):kHankUnNilStr(kCurrentUser.acceptPhone);
    if( _model.isCanEdit == NO){
        _selectTYpe = _model.payType;
        _btnAli.selected = _model.payType == TDPayApliType;
        _btnWeiXin.selected = _model.payType != TDPayApliType;
    }
    [self layoutIfNeeded];
}

+ (CGFloat)getCellHeightWithModel:(TDOrderPayModel *)model{
    //除了Goods的view高度
    CGFloat height = 135 + 157 + 40;
    height +=  kGoodsViewOriHeight +(kTDOrderSubCellHeight * model.arrProduct.count);
    return height;
}

#pragma mark Action

- (IBAction)editAction:(UIButton *)sender {
    TDOrderPayVC *vc = [TDPublicTools getVCWithClass:[TDOrderPayVC class] targetResponder:self];
    if(vc){
        TDMyDataVC *profileVc = [[TDMyDataVC alloc]init];
        [vc.navigationController pushViewController:profileVc animated:YES];
    }
}

- (IBAction)weiXinPayAction:(UIButton *)sender {
    _btnWeiXin.selected = YES;
    _btnAli.selected = NO;
    _selectTYpe = TDPayWeiChatType;
    kHankCallBlock(_payTypeBlock,_selectTYpe);
}

- (IBAction)aliPayAction:(UIButton *)sender {
    _btnWeiXin.selected = NO;
    _btnAli.selected = YES;
    _selectTYpe = TDPayApliType;
    kHankCallBlock(_payTypeBlock,_selectTYpe);
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
