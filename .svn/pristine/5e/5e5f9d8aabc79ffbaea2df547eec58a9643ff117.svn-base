//
//  TDAgricultureSearchVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDAgricultureSearchVC.h"
#import "TDProductCell.h"
#import "TDAgricultureModel.h"
#import "TDTourDetalisVC.h"

@interface TDAgricultureSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,RefreshToolDelegate>

@property (strong , nonatomic) ZLRefreshTool            *refresh;
@property (weak, nonatomic) IBOutlet UITableView        *tableView;
@property (weak, nonatomic) IBOutlet UITextField        *tfSearch;

@end

@implementation TDAgricultureSearchVC

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSomeThing];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - RefreshToolDelegate

//数据链接地址
- (NSDictionary *)requestParameter{
    return @{@"productName":kHankUnNilStr(_tfSearch.text)};
}
//返回响应数据
- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[TDAgricultureModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma MARK - Private Methods

- (void)initSomeThing{
    self.title = @"搜索";
    _tfSearch.delegate = self;
    _tableView.rowHeight = kTDProductCellHeight;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDProductCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDProductCell class])];
    self.refresh.delegate = self;
}


#pragma mark - ACTION

- (IBAction)searchAction:(UIButton *)sender {
    if(_tfSearch.text.length){
        [self.view endEditing:YES];
        [self.refresh reload];
    }
}

#pragma mark - UITextViewDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [self.refresh reload];
    return YES;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDAgricultureModel *model = self.refresh.arrData[indexPath.row];
    TDProductCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDProductCell class]) forIndexPath:indexPath];
    [cell setAgricultureUIWithModle:model searchKey:kHankUnNilStr(_tfSearch.text)];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TDAgricultureModel *model = self.refresh.arrData[indexPath.row];
    TDTourDetalisVC *detailsVc = [[TDTourDetalisVC alloc]initWithAricultureModel:model];
    [self.navigationController pushViewController:detailsVc animated:YES];
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        NSString *url = [BASEIP stringByAppendingString:PRODUCTSLIST];
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:url];
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.lblOfNodata.text = @"未搜索到您需要的农产品";
        }];
       [_refresh addRefreshView];
    }
    return _refresh;
}

@end
