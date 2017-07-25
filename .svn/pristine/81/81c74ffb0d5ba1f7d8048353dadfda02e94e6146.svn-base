//
//  TDInfoHomeVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDInfoHomeVC.h"
#import "TDTInfoHomeCell.h"
#import "TDInfoDetailVC.h"
#import "TDInfoModel.h"

@interface TDInfoHomeVC ()<UITableViewDataSource,UITableViewDelegate,RefreshToolDelegate>

@property (strong, nonatomic) ZLRefreshTool         *refresh;
@property (weak, nonatomic) IBOutlet UITableView    *tableView;


@end

@implementation TDInfoHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯";
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDTInfoHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDTInfoHomeCell class])];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.refresh addRefreshView];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - RefreshToolDelegate

//数据链接地址
- (NSDictionary *)requestParameter{
    return @{};
}
//返回响应数据
- (void)handleResponse:(id)data{
    if(![data isKindOfClass:[NSArray class]]){
        return;
    }
    [self.refresh.arrData addObjectsFromArray:[TDInfoModel mj_objectArrayWithKeyValuesArray:data]];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDInfoModel *model = self.refresh.arrData[indexPath.row];
    TDTInfoHomeCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDTInfoHomeCell class]) forIndexPath:indexPath];
    [cell setUIWithModle:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTDTInfoHomeCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.refresh.arrData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TDInfoModel *model = self.refresh.arrData[indexPath.row];
    TDInfoDetailVC *detail = [[TDInfoDetailVC alloc]initWithTitle:kHankUnNilStr(model.title) content:kHankUnNilStr(model.context)];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - Setter

- (ZLRefreshTool *)refresh{
    if(!_refresh){
        NSString *url = [BASEIP stringByAppendingString:INFOLIST];
        _refresh = [[ZLRefreshTool alloc]initWithContentView:self.tableView url:url];
        _refresh.delegate = self;
        [_refresh setBlockEditFailVIew:^(ZLFailLoadView *failView) {
            failView.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
            failView.lblOfNodata.text = @"没有资讯";
        }];
    }
    return _refresh;
}
@end
