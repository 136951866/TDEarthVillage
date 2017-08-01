//
//  TDTourDetalisVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDTourDetalisVC.h"
#import "TDTourDetalsHeaderView.h"
#import "TDPurchasePopupView.h"
#import "TDOrderPayVC.h"
#import "TDShopVC.h"
#import "TDWebViewCell.h"
#import "TDLoginVC.h"
#import "TDAgricultureModel.h"
#import "TDTourModel.h"
#import "TDOrderPayModel.h"

@interface TDTourDetalisVC ()<UITableViewDelegate, UITableViewDataSource>{
    TDDetailsType _type;
    TDAgricultureModel *_agricultureModel;
    TDTourModel *_tourModel;
    BOOL _isPost;
    NSString *_Id;
}

@property (weak, nonatomic) IBOutlet UIButton           *btnShop;
@property (weak, nonatomic) IBOutlet UITableView        *tableView;
@property (strong, nonatomic) TDTourDetalsHeaderView    *headerView;
@property (strong, nonatomic) TDPurchasePopupView       *popupView;
@property (strong, nonatomic) TDWebViewCell             *webCell;

@end

@implementation TDTourDetalisVC

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self.tableView];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

HankMustImplementedDataInit()
- (instancetype)initWithAricultureModel:(TDAgricultureModel *)model{
    if(self = [super init]){
        _isPost = NO;
        _type = TDDetailsAgricultureType;
        _agricultureModel = model;
    }
    return self;
}

- (instancetype)initWithTourModel:(TDTourModel *)model{
    if(self = [super init]){
        _isPost = NO;
        _type = TDDetailsTourType;
        _tourModel = model;
    }
    return self;
}

- (instancetype)initWithTourId:(NSString *)tourId{
    if(self = [super init]){
        _isPost = YES;
        _type = TDDetailsTourType;
        _Id = tourId;
    }
    return self;
}

- (instancetype)initWithProductId:(NSString *)productId{
    if(self = [super init]){
        _isPost = YES;
        _type = TDDetailsAgricultureType;
        _Id = productId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _type == TDDetailsAgricultureType ? @"农产品详情":@"旅游线路详情";
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDWebViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDWebViewCell class])];
    if(_isPost){
        if(_type == TDDetailsTourType){
            [TDPublicNetWorkTools postTourDetailsWithId:_Id successBlock:^(ZLRequestResponse *responseObject) {
                _tourModel = [TDTourModel mj_objectWithKeyValues:responseObject.data];
                [self initSomeThing];
            } failure:^(id object) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if (_type == TDDetailsAgricultureType){
            [TDPublicNetWorkTools postProductsDetailsWithId:_Id successBlock:^(ZLRequestResponse *responseObject) {
                _agricultureModel = [TDAgricultureModel mj_objectWithKeyValues:responseObject.data];
                [self initSomeThing];
            } failure:^(id object) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }else{
        [self initSomeThing];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)initSomeThing{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerView;
    [[NSNotificationCenter defaultCenter]addObserver:self.tableView selector:@selector(reloadData) name:kTDWebViewCellDidFinishLoad object:nil];
    [self.tableView reloadData];
    kUserLoginWithSelector(getShopNum);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getShopNum];
}

#pragma priVate Method

- (void)getShopNum{
    if([TDUserInfoModel isLogin]){
        NSInteger numOfProduct = [TDDataBase getAllPdcNumIncarWithUserId:kHankUnNilStr(kCurrentUser.userId)];
        [TDPublicTools setShopNumberWithShowView:self.btnShop number:@(numOfProduct).description];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!_webCell){
        _webCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDWebViewCell class]) forIndexPath:indexPath];
        [_webCell.webView loadHTMLString:_type == TDDetailsAgricultureType?kHankUnNilStr(_agricultureModel.introduce):kHankUnNilStr(_tourModel.introduce)
 baseURL:nil];
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

- (IBAction)addShopAction:(UIButton *)sender {
    if([TDUserInfoModel isLogin]){
        [self addShop];
    }else{
        HANKWEAKSELF    
        [TDLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            HANKSTRONGSELF
            [strongSelf addShop];
        } failHandler:^(id object) {
            
        }];
    }
}

- (void)addShop{
    [TDPublicTools showMessage:@"已加入购物车" view:self.view];
    TDShopModel *model = [TDShopModel new];
    model.TDId = _type == TDDetailsAgricultureType?_agricultureModel.TDID:_tourModel.TDID;
    model.price = _type == TDDetailsAgricultureType?_agricultureModel.price:_tourModel.price;
    model.title = _type == TDDetailsAgricultureType?_agricultureModel.productName:_tourModel.travelName;
    model.log = _type == TDDetailsAgricultureType?_agricultureModel.log:_tourModel.log;
    if([TDDataBase isExistInCarWithModel:model]){
        TDShopModel *newModel = [TDDataBase getNewsModelById:model.TDId userId:kHankUnNilStr(kCurrentUser.userId)];
        NSInteger conut = [newModel.strNum integerValue] + 1;
        model.strNum = @(conut).description;
        [TDDataBase updataCountInCar:@(conut).description model:model];
    }else{
        model.strNum = @"1";
        [TDDataBase insertPdcToCarWithModel:model];
    }
    NSInteger numOfProduct = [TDDataBase getAllPdcNumIncarWithUserId:kHankUnNilStr(kCurrentUser.userId)];
    [TDPublicTools setShopNumberWithShowView:self.btnShop number:@(numOfProduct).description];
}

- (IBAction)purchaseAction:(UIButton *)sender {
    if([TDUserInfoModel isLogin]){
       [self.popupView show];
    }else{
        HANKWEAKSELF
        [TDLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            HANKSTRONGSELF
             [strongSelf.popupView show];
        } failHandler:^(id object) {
            
        }];
    }
}

- (void)payAction:(NSString *)strNum{
    NSString *strPayId = _type == TDDetailsAgricultureType?_agricultureModel.TDID:_tourModel.TDID;
    NSString *strPayNum = strNum;
    
    TDOrderPayModel *model = [TDOrderPayModel new];
    model.subject = _type == TDDetailsAgricultureType?_agricultureModel.productName:_tourModel.travelName;
    NSString *price = _type == TDDetailsAgricultureType?_agricultureModel.price:_tourModel.price;
    model.amount = @([kHankUnNilStr(price) floatValue] * [strPayNum integerValue]).description;
    model.numStr = strPayNum;
    model.strPayId = strPayId;
    TDOrderPayVC *payVC = [[TDOrderPayVC alloc]initWithModel:model];
    [self.navigationController pushViewController:payVC animated:YES];
}

- (IBAction)toShopVCAction:(UIButton *)sender {
    if([TDUserInfoModel isLogin]){
        TDShopVC *shopVC = [[TDShopVC alloc]init];
        [self.navigationController pushViewController:shopVC animated:YES];
    }else{
        HANKWEAKSELF
        [TDLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            HANKSTRONGSELF
            TDShopVC *shopVC = [[TDShopVC alloc]init];
            [strongSelf.navigationController pushViewController:shopVC animated:YES];
        } failHandler:^(id object) {
            
        }];
    }
}

#pragma mark - Setter

- (TDTourDetalsHeaderView *)headerView{
    if(!_headerView){
        if(_type == TDDetailsAgricultureType){
            _headerView =  [[TDTourDetalsHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTDTourDetalsHeaderViewHeight) agricultureModel:_agricultureModel];
        }else{
            _headerView =  [[TDTourDetalsHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTDTourDetalsHeaderViewHeight) tourModel:_tourModel];
        }
    }
    return _headerView;
}

- (TDPurchasePopupView *)popupView{
    if(!_popupView){
        _popupView = [[[NSBundle mainBundle]loadNibNamed:@"TDPurchasePopupView" owner:nil options:nil] firstObject];
        HANKWEAKSELF    
        [_popupView setWithNumBlock:^(NSString *str) {
            HANKSTRONGSELF
            [strongSelf payAction:str];
        } superView:self.view];
    }
    return _popupView;
}

@end
