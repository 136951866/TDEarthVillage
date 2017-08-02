//
//  TDVillageDetails.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDVillageDetails.h"
#import "TDAgricultureVC.h"
#import "TDTourVC.h"
#import "TDWebViewCell.h"
#import "TDVillageDetailHeaderView.h"
#import "TDHomeVillAgeModel.h"

@interface TDVillageDetails ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    TDHomeVillAgeModel *_model;
    BOOL _isPost;
    NSString *_villageId;
}
    
@property (nonatomic, strong)TDVillageDetailHeaderView      *headerView;
@property (weak, nonatomic) IBOutlet UITableView            *tableView;
@property (strong, nonatomic)TDWebViewCell                  *webCell;
    
@end

@implementation TDVillageDetails

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self.tableView];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

HankMustImplementedDataInit()
- (instancetype)initWithModel:(TDHomeVillAgeModel *)model{
    if(self = [super init]){
        _isPost = NO;
        _model = model;
    }
    return self;
}

- (instancetype)initWithVillageId:(NSString *)villageId{
    if(self = [super init]){
        _isPost = YES;
        _villageId = villageId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"村落详情";
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDWebViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDWebViewCell class])];
    if(_isPost){
        [TDPublicNetWorkTools postVillageDetailsWithId:_villageId successBlock:^(ZLRequestResponse *responseObject) {
            _model = [TDHomeVillAgeModel mj_objectWithKeyValues:responseObject.data];
            [self initSomeThing];
        } failure:^(id object) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        [self initSomeThing];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)initSomeThing{
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[NSNotificationCenter defaultCenter]addObserver:self.tableView selector:@selector(reloadData) name:kTDWebViewCellDidFinishLoad object:nil];
}

#pragma mark - tableView deleagte and sourcedata
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!_webCell){
        _webCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDWebViewCell class]) forIndexPath:indexPath];
        [_webCell.webView loadHTMLString:kHankUnNilStr(_model.introduce) baseURL:nil];
    }
    return _webCell;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!_webCell){
        return 0;
    }else{
        return [[self.webCell.webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] intValue];
    }
}

#pragma mark - Action

- (IBAction)agricultureAction:(UIButton *)sender {
    TDAgricultureVC *agricultureVC = [[TDAgricultureVC alloc]initWithVillageId:kHankUnNilStr(_model.TDID)];
    [self.navigationController pushViewController:agricultureVC animated:YES];
}

- (IBAction)tourAction:(UIButton *)sender {
    TDTourVC *tourVC = [[TDTourVC alloc]initWithVillageId:kHankUnNilStr(_model.TDID)];
    [self.navigationController pushViewController:tourVC animated:YES];
}

#pragma mark - Setter

- (TDVillageDetailHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[TDVillageDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTDVillageDetailHeaderViewHeight) model:_model];
    }
    return _headerView;
}
@end
