//
//  TDAgricultureHomeVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDAgricultureHomeVC.h"
#import "TDProductCell.h"
#import "TDAgricultureSearchVC.h"
//#import "TDAgricultureFilterMenuView.h"
#import <HKMultistageFilterMenuView.h>
//#import "TDAgricultureFilterOneMenuView.h"
#import "TDCodeAppModel.h"
#import "TDAgricultureModel.h"
#import "TDTourDetalisVC.h"
#import "TDAgricultureFilterSaveModel.h"

#define kbtnFrame CGRectMake(-20, 0, 30, 25)
#define kMenuTag 1000
#define kMenuViewTag 2000

@interface TDAgricultureHomeVC ()<HKMultistageFilterMenuViewDelegate,UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSMutableArray *_arrSelectTypeModel;
    NSMutableArray *_arrSelectFieldModel;
    NSMutableArray *_arrSelectSortModel;
    
    TDCodeAppModel *_typeModel;
    TDCodeAppModel *_fieldModel;
    TDCodeAppModel *_sortModel;
}


@property (nonatomic, weak) IBOutlet UIView                     *viewFilter;
@property (nonatomic, weak) IBOutlet UITableView                *tableView;
@property (nonatomic, strong) UIButton                          *btnRight;
@property (nonatomic, strong) ZLRefreshTool                     *refresh;
@property (nonatomic, strong) HKMultistageFilterMenuView        *typeMenum;
@property (nonatomic, strong) HKMultistageFilterMenuView        *fieldMenum;
@property (nonatomic, strong) HKMultistageFilterMenuView        *sortMenum;

@end

@implementation TDAgricultureHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrSelectTypeModel = [NSMutableArray array];
    _arrSelectFieldModel = [NSMutableArray array];
    _arrSelectSortModel = [NSMutableArray array];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDProductCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDProductCell class])];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
    [self requestHeaderData];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view from its nib.
}

- (void)requestHeaderData{
    if(!_arrSelectTypeModel.count){
        [TDPublicNetWorkTools postGetByCodeAppWithsuccessBlock:^(ZLRequestResponse *responseObject) {
            if(![responseObject.data isKindOfClass:[NSArray class]]){
                return;
            }
            [_arrSelectTypeModel removeAllObjects];
            [_arrSelectTypeModel addObjectsFromArray:[TDCodeAppModel mj_objectArrayWithKeyValuesArray:responseObject.data]];
            [TDAgricultureFilterSaveModel saveTypeModel:_arrSelectTypeModel];
        } failure:^(id object) {
            [_arrSelectTypeModel removeAllObjects];
            _arrSelectTypeModel = [NSMutableArray arrayWithArray:[TDAgricultureFilterSaveModel getTypeModel]];
        }];
    }
    if(!_arrSelectFieldModel.count){
        [TDPublicNetWorkTools postGetAreasAndVillageWithsuccessBlock:^(ZLRequestResponse *responseObject) {
            if(![responseObject.data isKindOfClass:[NSArray class]]){
                return;
            }
            [_arrSelectFieldModel removeAllObjects];
            [_arrSelectFieldModel addObjectsFromArray:[TDCodeAppModel mj_objectArrayWithKeyValuesArray:responseObject.data]];
            [TDAgricultureFilterSaveModel saveFieldModel:_arrSelectFieldModel];
        } failure:^(id object) {
            [_arrSelectFieldModel removeAllObjects];
            _arrSelectFieldModel = [NSMutableArray arrayWithArray:[TDAgricultureFilterSaveModel getFieldModel]];
        }];
    }
    if(!_arrSelectSortModel.count){
        [TDPublicNetWorkTools postGetSortWithsuccessBlock:^(ZLRequestResponse *responseObject) {
            if(![responseObject.data isKindOfClass:[NSArray class]]){
                return;
            }
            [_arrSelectSortModel removeAllObjects];
            [_arrSelectSortModel addObjectsFromArray:[TDCodeAppModel mj_objectArrayWithKeyValuesArray:responseObject.data]];
            [TDAgricultureFilterSaveModel saveSortModel:_arrSelectSortModel];
        } failure:^(id object) {
            [_arrSelectSortModel removeAllObjects];
            _arrSelectSortModel = [NSMutableArray arrayWithArray:[TDAgricultureFilterSaveModel getSortModel]];
        }];
    }
}

#pragma mark - RefreshToolDelegate

//数据链接地址
- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        [self requestHeaderData];
    }
    return @{@"sort":kHankUnNilStr(_sortModel.code),
             @"productType":kHankUnNilStr(_typeModel.TDId),
             @"villageId":kHankUnNilStr(_fieldModel.code)
             };
}

//返回响应数据
- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[TDAgricultureModel mj_objectArrayWithKeyValuesArray:data]];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDAgricultureModel *model = self.refresh.arrData[indexPath.row];
    TDProductCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDProductCell class]) forIndexPath:indexPath];
    [cell setAgricultureUIWithModle:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTDProductCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TDAgricultureModel *model = self.refresh.arrData[indexPath.row];
    TDTourDetalisVC *detailsVc = [[TDTourDetalisVC alloc]initWithAricultureModel:model];
    [self.navigationController pushViewController:detailsVc animated:YES];
}

#pragma mark - TDAgricultureFilterMenuViewDelegate

- (NSInteger)assciationMenuView:(HKMultistageFilterMenuView*)asView countForClass:(NSInteger)idx{
    return [self getArrModelWithTag:asView].count;
}

- (NSInteger)assciationMenuView:(HKMultistageFilterMenuView*)asView countForClass:(NSInteger)idx  class_1:(NSInteger)idx_1{
    if(idx_1 == -1){
        return 0;
    }
    TDCodeAppModel *model = [self getArrModelWithTag:asView][idx_1];
    return model.leafs.count;
}

- (NSInteger)assciationMenuView:(HKMultistageFilterMenuView*)asView countForClass:(NSInteger)idx  class_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2{
    if(idx_1 == -1 || idx_2 == -1){
        return 0;
    }
    TDCodeAppModel *model1 = [self getArrModelWithTag:asView][idx_1];
    TDCodeAppModel *model2 = model1.leafs[idx_2];
    return model2.leafs.count;
}

- (NSInteger)assciationMenuView:(HKMultistageFilterMenuView*)asView countForClass:(NSInteger)idx  class_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3{
    if(idx_1 == -1 || idx_2 == -1 || idx_3 == -1){
        return 0;
    }
    TDCodeAppModel *model1 = [self getArrModelWithTag:asView][idx_1];
    TDCodeAppModel *model2 = model1.leafs[idx_2];
    TDCodeAppModel *model3 = model2.leafs[idx_3];
    return model3.leafs.count;
}

//一级点击 idx_1位遍历
- (NSString*)assciationMenuView:(HKMultistageFilterMenuView*)asView titleForClass_1:(NSInteger)idx_1 {
    TDCodeAppModel *model = [self getArrModelWithTag:asView][idx_1];
    return model.name;
}
//二级
- (NSString*)assciationMenuView:(HKMultistageFilterMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 {
    TDCodeAppModel *model1 = [self getArrModelWithTag:asView][idx_1];
    TDCodeAppModel *model2 = model1.leafs[idx_2];
    return model2.name;
}

- (NSString*)assciationMenuView:(HKMultistageFilterMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3 {
    TDCodeAppModel *model1 = [self getArrModelWithTag:asView][idx_1];
    TDCodeAppModel *model2 = model1.leafs[idx_2];
    TDCodeAppModel *model3 = model2.leafs[idx_3];
    return model3.name;
}

- (NSString*)assciationMenuView:(HKMultistageFilterMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3  class_4:(NSInteger)idx_4{
    TDCodeAppModel *model1 = [self getArrModelWithTag:asView][idx_1];
    TDCodeAppModel *model2 = model1.leafs[idx_2];
    TDCodeAppModel *model3 = model2.leafs[idx_3];
    TDCodeAppModel *model4 = model3.leafs[idx_4];
    return model4.name;
}

- (void)assciationMenuViewCancel:(HKMultistageFilterMenuView*)asView {
    UIButton *btn = [self.view viewWithTag:asView.tag-kMenuTag];
    btn.selected = NO;
}

- (BOOL)assciationMenuView:(HKMultistageFilterMenuView*)asView idxChooseInClass1:(NSInteger)idx_1{
    if(idx_1 == -1){
        return NO;
    }
    TDCodeAppModel *model = [self getArrModelWithTag:asView][idx_1];
    return kHankUnArr(model.leafs).count;
}

- (BOOL)assciationMenuView:(HKMultistageFilterMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2{
    if(idx_1 == -1 || idx_2 == -1){
        return NO;
    }
    TDCodeAppModel *model1 = [self getArrModelWithTag:asView][idx_1];
    TDCodeAppModel *model2 = model1.leafs[idx_2];
    return kHankUnArr(model2.leafs).count;
}
- (BOOL)assciationMenuView:(HKMultistageFilterMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3{
    if(idx_1 == -1 || idx_2 == -1 || idx_3 == -1){
        return NO;
    }
    TDCodeAppModel *model1 = [self getArrModelWithTag:asView][idx_1];
    TDCodeAppModel *model2 = model1.leafs[idx_2];
    TDCodeAppModel *model3 = model2.leafs[idx_3];
    return kHankUnArr(model3.leafs).count;
}

- (BOOL)assciationMenuView:(HKMultistageFilterMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3 class4:(NSInteger)idx_4{
    return YES;
}

- (void)getMenuViewSelectSel:(HKMultistageFilterMenuView*)asView sels:(NSInteger *)sels{
    UIButton *btn = [self.view viewWithTag:asView.tag-kMenuTag];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    NSString *title = [self getSelectTitleWithSel:sels asView:asView];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateSelected];
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.titleLabel.mj_textWith, 0, -btn.titleLabel.mj_textWith);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 12);
    [_refresh reload];
}

#pragma mark - Action

- (IBAction)typeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self cancelBtnSelectWithOut:sender];
    [self.typeMenum removeFromSuperview];
    [self.fieldMenum removeFromSuperview];
    [self.sortMenum removeFromSuperview];
    if(sender.selected){
        [self.typeMenum showAsDrawDownView:_viewFilter];
    }
}

- (IBAction)fieldAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self cancelBtnSelectWithOut:sender];
    [self.fieldMenum removeFromSuperview];
    [self.typeMenum removeFromSuperview];
    [self.sortMenum removeFromSuperview];
    if(sender.selected){
        [self.fieldMenum showAsDrawDownView:_viewFilter];
    }
}

- (IBAction)sortAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self cancelBtnSelectWithOut:sender];
    [self.sortMenum removeFromSuperview];
    [self.typeMenum removeFromSuperview];
    [self.fieldMenum removeFromSuperview];
    if(sender.selected){
        [self.sortMenum showAsDrawDownView:_viewFilter];
    }
}

- (void)searchAction:(UIButton *)btn{
    TDAgricultureSearchVC *serach = [[TDAgricultureSearchVC alloc]init];
    [self.navigationController pushViewController:serach animated:YES];
}

#pragma mark - Deal Data

- (NSString *)getSelectTitleWithSel:(NSInteger *)sels asView:(HKMultistageFilterMenuView *)asView{
    NSInteger idx_1 = sels[0];
    NSInteger idx_2 = sels[1];
    NSInteger idx_3 = sels[2];
    NSInteger idx_4 = sels[3];
    if(idx_1 != -1 && idx_2 != -1 && idx_3 != -1 &&idx_4 != -1){
        TDCodeAppModel *model1 = [self getArrModelWithTag:asView][idx_1];
        TDCodeAppModel *model2 = model1.leafs[idx_2];
        TDCodeAppModel *model3 = model2.leafs[idx_3];
        TDCodeAppModel *model4 = model3.leafs[idx_4];
        [self getSelectModelWithModel:model4 asView:asView];
        return [model4.name isEqualToString:@"全部"]?model3.name:model4.name;
    }
    if(idx_1 != -1 && idx_2 != -1 && idx_3 != -1 && idx_4 == -1){
        TDCodeAppModel *model1 = [self getArrModelWithTag:asView][idx_1];
        TDCodeAppModel *model2 = model1.leafs[idx_2];
        TDCodeAppModel *model3 = model2.leafs[idx_3];
        [self getSelectModelWithModel:model3 asView:asView];
        return [model3.name isEqualToString:@"全部"]?model2.name:model3.name;
    }
    if(idx_1 != -1 && idx_2 != -1 && idx_3 == -1 && idx_4 == -1){
        TDCodeAppModel *model1 = [self getArrModelWithTag:asView][idx_1];
        TDCodeAppModel *model2 = model1.leafs[idx_2];
        [self getSelectModelWithModel:model2 asView:asView];
        return [model2.name isEqualToString:@"全部"]?model1.name:model2.name;
    }
    if(idx_1 != -1 && idx_2 == -1 && idx_3 == -1 && idx_4 == -1){
        TDCodeAppModel *model1 = [self getArrModelWithTag:asView][idx_1];
        [self getSelectModelWithModel:model1 asView:asView];
        return [model1.name isEqualToString:@"全部"]?(asView.tag == kMenuViewTag?@"种类":@"产地"):model1.name;;
    }
    return @"";
}

- (void)cancelBtnSelectWithOut:(UIButton *)btn{
    UIButton *btn1 = [self.view viewWithTag:kMenuTag];
    btn1.selected = btn == btn1?btn.selected:NO;
    UIButton *btn2 = [self.view viewWithTag:kMenuTag+1];
    btn2.selected = btn == btn2?btn.selected:NO;
    UIButton *btn3 = [self.view viewWithTag:kMenuTag+2];
    btn3.selected = btn == btn3?btn.selected:NO;
}

//根据asView的tag 拿到数组
- (NSMutableArray *)getArrModelWithTag:(HKMultistageFilterMenuView *)asView{
    if(asView.tag == kMenuViewTag){
        return kHankUnArr(_arrSelectTypeModel);
    }else if(asView.tag == kMenuViewTag + 1){
        return kHankUnArr(_arrSelectFieldModel);
    }else{
        return kHankUnArr(_arrSelectSortModel);
    }
}

//根据asView的tag 设置model
- (void)getSelectModelWithModel:(TDCodeAppModel *)model asView:(HKMultistageFilterMenuView *)asView{
    if(asView.tag == kMenuViewTag){
        //种类
        _typeModel = model;
    }else if(asView.tag == kMenuViewTag + 1){
        //产地
        _fieldModel = model;
    }else{
        //排序
        _sortModel = model;
    }
}

#pragma mark - Getter

- (UIButton *)btnRight{
    if(!_btnRight){
        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = kbtnFrame;
        [_btnRight setImage:[UIImage imageNamed:@"shop_search"] forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}

- (HKMultistageFilterMenuView *)typeMenum{
    if(!_typeMenum){
        _typeMenum = [[HKMultistageFilterMenuView alloc]initWithSuperView:self.view];
        _typeMenum.delegate = self;
        _typeMenum.tag = kMenuViewTag;
    }
    return _typeMenum;
}

- (HKMultistageFilterMenuView *)fieldMenum{
    if(!_fieldMenum){
        _fieldMenum = [[HKMultistageFilterMenuView alloc]initWithSuperView:self.view];
        _fieldMenum.delegate = self;
        _fieldMenum.tag = kMenuViewTag + 1;
    }
    return _fieldMenum;
}

- (HKMultistageFilterMenuView *)sortMenum{
    if(!_sortMenum){
        _sortMenum = [[HKMultistageFilterMenuView alloc]initWithSuperView:self.view];
        _sortMenum.delegate = self;
        _sortMenum.tag = kMenuViewTag + 2;
    }
    return _sortMenum;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        NSString *url = [BASEIP stringByAppendingString:PRODUCTSLIST];
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:url];
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.lblOfNodata.text = @"没有农产品";
        }];
        _refresh.delegate = self;
    }
    return _refresh;
}

@end
