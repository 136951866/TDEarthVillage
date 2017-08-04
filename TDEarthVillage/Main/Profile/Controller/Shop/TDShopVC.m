//
//  TDShopVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/4.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDShopVC.h"
#import "TDShopCell.h"
#import "TDShopModel.h"
#import "TDShopBottomView.h"
#import "TDOrderPayVC.h"
#import "TDOrderPayModel.h"
#import "TDTourDetalisVC.h"

#define kbtnFrame CGRectMake(-20, 0, 60, 25)

@interface TDShopVC ()<UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate,TDShopCellDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *arrData;
@property (nonatomic, strong)TDShopBottomView *bottomView;
@property (nonatomic, strong)UIButton *btnRight;
@end

@implementation TDShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    _arrData = [NSMutableArray arrayWithArray:[TDDataBase getAllpdcInCarWithUserId:kHankUnNilStr(kCurrentUser.userId)]];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self setBottomData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
    // Do any additional setup after loading the view.
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [_tableView reloadData];
//}

- (void)allSelect:(UIButton *)btn{
    if(!_arrData.count){
        [TDPublicTools showMessage:@"购物车为空" view:self.view];
        return;
    }
    self.btnRight.selected = !self.btnRight.selected;
    [_arrData enumerateObjectsUsingBlock:^(TDShopModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelect = btn.selected;
    }];
    [self.tableView reloadData];
    [self setBottomData];
}

- (void)settlementAction{
    __block NSMutableArray *arrPayId = [NSMutableArray array];
    __block NSMutableArray *arrPayNum = [NSMutableArray array];
    __block NSMutableArray *arrSubject = [NSMutableArray array];
    __block NSMutableArray *arrSelectModel = [NSMutableArray array];
    [_arrData enumerateObjectsUsingBlock:^(TDShopModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.isSelect){
            [arrPayId addObject:obj.TDId];
            [arrPayNum addObject:obj.strNum];
            [arrSubject addObject:obj.title];
            [arrSelectModel addObject:obj];
        }
    }];
    if(!arrSelectModel.count){
        [TDPublicTools showMessage:@"请选择" view:self.view];
        return;
    }

    TDOrderPayModel *model = [TDOrderPayModel new];
    model.subject = [arrSubject componentsJoinedByString:@","];
    model.amount = self.bottomView.lblCost.text;
    model.numStr = [arrPayNum componentsJoinedByString:@","];
    model.strPayId =  [arrPayId componentsJoinedByString:@","];
    TDOrderPayVC *payVC = [[TDOrderPayVC alloc]initWithModel:model];
    HANKWEAKSELF
    payVC.payBlock = ^{
        HANKSTRONGSELF
        [arrSelectModel enumerateObjectsUsingBlock:^(TDShopModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                    [TDDataBase deletePdcInCarByModel:model];
        }];
        strongSelf.bottomView.lblNum.text = @"0";
        strongSelf.bottomView.lblCost.text = @"0.00";
        strongSelf.btnRight.selected = NO;
        strongSelf->_arrData = [NSMutableArray arrayWithArray:[TDDataBase getAllpdcInCarWithUserId:kHankUnNilStr(kCurrentUser.userId)]];
        [strongSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:payVC animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTDShopCellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDShopModel *model = _arrData[indexPath.row];
    TDShopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDShopCell class])];
    if (!cell) {
        cell = [[TDShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TDShopCell class])];
    }
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"删除" backgroundColor:kThemeBlue]];
    cell.delegate = self;
    cell.selectedDelegate = self;
    [cell setUIWithModel:model];
    return cell;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    TDShopModel *model = _arrData[indexPath.row];
//    if(model.isSelect){
//        NSInteger num = [self.bottomView.lblNum.text integerValue] - [model.strNum integerValue];
//        CGFloat cost = [self.bottomView.lblCost.text floatValue] - ([model.price floatValue] *[model.strNum integerValue]);
//        self.bottomView.lblNum.text = @(num).description;
//        self.bottomView.lblCost.text = [NSString stringWithFormat:@"%.2f",cost];
//    }
    [_arrData removeObjectAtIndex:indexPath.row];
    [TDDataBase deletePdcInCarByModel:model];
    [_tableView reloadData];
    [self setBottomData];
    return YES;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    TDShopModel *model = _arrData[indexPath.row];
//    if([model.type isEqualToString:@"Agriculture"]){
//        TDTourDetalisVC *detailsVC = [[TDTourDetalisVC alloc]initWithProductId:kHankUnNilStr(model.TDId)];
//        [self.navigationController pushViewController:detailsVC animated:YES];
//    }else{
//        TDTourDetalisVC *detailsVC = [[TDTourDetalisVC alloc]initWithTourId:kHankUnNilStr(model.TDId)];
//         [self.navigationController pushViewController:detailsVC animated:YES];
//    }
//}

#pragma mark - TDShopCellDelegate

-(void)selectedConfirmCell:(TDShopCell *)cell{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    TDShopModel *model = _arrData[indexPath.row];
    model.isSelect = YES;
    [cell setUIWithModel:model];
    [self setBottomData];
}
-(void)selectedCancelCell:(TDShopCell *)cell{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    TDShopModel *model = _arrData[indexPath.row];
    model.isSelect = NO;
    [cell setUIWithModel:model];
    self.btnRight.selected = NO;
    [self setBottomData];
}

-(void)getNumberWithCell:(TDShopCell *)cell Number:(NSString *)strNum{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    TDShopModel *model = _arrData[indexPath.row];
    model.strNum = strNum;
    [cell setUIWithModel:model];
    [self setBottomData];
}

#pragma mark - Setter

- (void)setBottomData{
    __block NSInteger count = 0;
    __block CGFloat allCost = 0;
    __block NSInteger allCountSelect = 0;
    [_arrData enumerateObjectsUsingBlock:^(TDShopModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.isSelect){
            allCountSelect +=1;
            count += [obj.strNum integerValue];
            allCost += [kHankUnNilStr(obj.price) floatValue] * [obj.strNum integerValue];
        }
    }];
    if(_arrData.count){
        self.btnRight.selected = allCountSelect == _arrData.count;
    }else{
        self.btnRight.selected = NO;
    }
    self.bottomView.lblNum.text = @(count).description;
    self.bottomView.lblCost.text = [NSString stringWithFormat:@"%.2f",allCost];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHankNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kHankNavBarHeight - kTDShopBottomViewHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (TDShopBottomView *)bottomView{
    if(!_bottomView){
        _bottomView = [[[NSBundle mainBundle]loadNibNamed:@"TDShopBottomView" owner:nil options:nil] lastObject];
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT- kTDShopBottomViewHeight, SCREEN_WIDTH, kTDShopBottomViewHeight);
        HANKWEAKSELF
        _bottomView.settlementBlock = ^(NSString *strNum, NSString *strCost) {
            HANKSTRONGSELF
            [strongSelf settlementAction];
        };
    }
    return _bottomView;
}
- (UIButton *)btnRight{
    if(!_btnRight){
        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = kbtnFrame;
        _btnRight.titleLabel.font = kHankFont(15);
        [_btnRight setTitle:@"全选" forState:UIControlStateNormal];
        [_btnRight setTitle:@"全选" forState:UIControlStateSelected];
        [_btnRight setTitleColor:kMainFigure forState:UIControlStateNormal];
        [_btnRight setTitleColor:kMainFigure forState:UIControlStateSelected];
        [_btnRight setImage:[UIImage imageNamed:@"shopcar_choose"] forState:UIControlStateNormal];
        [_btnRight setImage:[UIImage imageNamed:@"shopcar_choose_s"] forState:UIControlStateSelected];
        [_btnRight addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
        _btnRight.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        _btnRight.selected = NO;
    }
    return _btnRight;
}


@end
