//
//  TDHomeVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/4.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDHomeVC.h"
#import "TDHomeHeaderView.h"
#import "TDHomeCell.h"
#import "TDVillageDetails.h"
#import "TDHomeVillAgeModel.h"
#import "TDHomeSysTopManagerModel.h"
#import "TDHomeDvilllageModel.h"
#import "TDAgricultureFilterSaveModel.h"

@interface TDHomeVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSMutableArray *_arrTopManage;
    NSMutableArray *_arrFilter;
    TDHomeDvilllageModel *_model;
}

@property (nonatomic, strong)UITableView        *tableView;
@property (strong, nonatomic)ZLRefreshTool      *refresh;
@property (nonatomic, strong)TDHomeHeaderView   *headerView;

@end

@implementation TDHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    _arrTopManage = [NSMutableArray array];
    _arrFilter = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view.
}

- (void)requestNetWork{
    HANKWEAKSELF
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [_arrTopManage removeAllObjects];
    [TDPublicNetWorkTools postSysTopManagerWithsuccessBlock:^(ZLRequestResponse *responseObject) {
        [_arrTopManage addObjectsFromArray:[TDHomeSysTopManagerModel mj_objectArrayWithKeyValuesArray:responseObject.data]];
        [TDAgricultureFilterSaveModel saveHomeTopManageModel:_arrTopManage];
        dispatch_semaphore_signal(semaphore);
    } failure:^(id object) {
        _arrTopManage = [NSMutableArray arrayWithArray:[TDAgricultureFilterSaveModel getHomeTopManageModel]];
        dispatch_semaphore_signal(semaphore);
    }];
    
    [TDPublicNetWorkTools postDvillageGetAreasWithsuccessBlock:^(ZLRequestResponse *responseObject) {
        TDHomeDvilllageModel *model = [TDHomeDvilllageModel new];
        model.name = @"全部";
        [_arrFilter addObject:model];
        for (int i = 0; i<14; i++) {
            TDHomeDvilllageModel *model = [TDHomeDvilllageModel new];
            model.name = [NSString stringWithFormat:@"test%@",@(i).description];
            [_arrFilter addObject:model];
        }

        [_arrFilter addObjectsFromArray:[TDHomeDvilllageModel mj_objectArrayWithKeyValuesArray:responseObject.data]];
        [TDAgricultureFilterSaveModel saveHomeFilterModel:_arrFilter];
        dispatch_semaphore_signal(semaphore);
    } failure:^(id object) {
        _arrFilter = [NSMutableArray arrayWithArray:[TDAgricultureFilterSaveModel getHomeFilterModel]];
       dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            HANKSTRONGSELF
            [strongSelf.headerView setUIWithTopManArrModel:_arrTopManage filterArrModel:_arrFilter selectFilterBlock:^(TDHomeDvilllageModel *model) {
                _model = model;
                [_refresh reload];
            }];
        });
    });
}

//数据链接地址
- (NSDictionary *)requestParameter{
    if(self.refresh.pageIndex == 1){
        if(!_arrTopManage.count || !_arrFilter.count){
            [self requestNetWork];
        }
    }
    return @{@"areaId":kHankUnNilStr(_model.code)};
}
//返回响应数据
- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[TDHomeVillAgeModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDHomeVillAgeModel *model = self.refresh.arrData[indexPath.row];
    TDHomeCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDHomeCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTDHomeCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TDHomeVillAgeModel *model = self.refresh.arrData[indexPath.row];
    TDVillageDetails *detail = [[TDVillageDetails alloc]initWithModel:model];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - Setter 

- (TDHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[TDHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTDHomeHeaderViewHeight)];
    }
    return _headerView;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kHankTabBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDHomeCell class])];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [UIView new];;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        NSString *url = [BASEIP stringByAppendingString:DVILLAGELIST];
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:url];
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.lblOfNodata.text = @"没有村落";
        }];
    }
    return _refresh;
}

@end
