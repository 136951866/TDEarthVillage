//
//  TDTourVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDTourVC.h"
#import "TDProductCell.h"
#import "TDTourDetalisVC.h"
#import "TDTourModel.h"

@interface TDTourVC ()<UITableViewDelegate,UITableViewDataSource,RefreshToolDelegate>{
    NSString *_villageId;
}

@property (strong, nonatomic) ZLRefreshTool         *refresh;
@property (weak, nonatomic) IBOutlet UITableView    *tableView;

@end

@implementation TDTourVC

HankMustImplementedDataInit()
- (instancetype)initWithVillageId:(NSString *)villageId{
    if(self = [super init]){
        _villageId = villageId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本村旅游线路";
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDProductCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDProductCell class])];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - RefreshToolDelegate

//数据链接地址
- (NSDictionary *)requestParameter{
    return @{@"villageId":kHankUnNilStr(_villageId)};
}
//返回响应数据
- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[TDTourModel mj_objectArrayWithKeyValuesArray:data]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDTourModel *model = self.refresh.arrData[indexPath.row];
    TDProductCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDProductCell class]) forIndexPath:indexPath];
    [cell setTourUIWithModle:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTDProductCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TDTourModel *model = self.refresh.arrData[indexPath.row];
    TDTourDetalisVC *detailsVc = [[TDTourDetalisVC alloc]initWithTourModel:model];
    [self.navigationController pushViewController:detailsVc animated:YES];
}

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        NSString *url = [BASEIP stringByAppendingString:ROUTELIST];
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:url];
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.lblOfNodata.text = @"没有旅游线路";
        }];
    }
    return _refresh;
}

@end
