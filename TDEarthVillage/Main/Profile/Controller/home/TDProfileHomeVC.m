//
//  TDProfileHomeVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDProfileHomeVC.h"
#import "TDProfileHomeHeaderView.h"
#import "TDProfileHomeCell.h"
#import "TDShopVC.h"
#import "TDLoginVC.h"
#import "TDAboutVC.h"
#import "TDMyDataVC.h"
#import "TDOrderListVC.h"

@interface TDProfileHomeVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    NSArray *_arrType;
}

@property (nonatomic, strong)TDLoginVC                  *loginVC;
@property (nonatomic, strong)UITableView                *tableView;
@property (nonatomic, strong)TDProfileHomeHeaderView    *headerView;
@end

@implementation TDProfileHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHidden = YES;
    _arrType = @[@[@(TDProfileHomeCellShoptype),@(TDProfileHomeCellOrdertype)],@[@(TDProfileHomeCellAbouttype)],@[@(TDProfileHomeCellExittype)]];
    [self.view addSubview:self.tableView];
    if(![TDUserInfoModel isLogin]){
        [self.view addSubview:self.loginVC.view];
    }else{
        [self setUserInfo];
    }
    kUserLoginWithSelector(userLogin)
    kUserLogoutWithSelector(userLogout)
    // Do any additional setup after loading the view.
}
    
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUserInfo];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = kBackgroundGray;
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrType.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = _arrType[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDProfileHomeCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDProfileHomeCell class]) forIndexPath:indexPath];
    NSArray *arr = _arrType[indexPath.section];
    TDProfileHomeCelltype type = [arr[indexPath.row] integerValue];
    [cell setUIWIthType:type];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTDProfileHomeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = _arrType[indexPath.section];
    TDProfileHomeCelltype type = [arr[indexPath.row] integerValue];
    switch (type) {
        case TDProfileHomeCellShoptype:{
            TDShopVC *shopVC = [[TDShopVC alloc]init];
            [self.navigationController pushViewController:shopVC animated:YES];
        }
            break;
        case TDProfileHomeCellOrdertype:{
            TDOrderListVC *orderVC = [[TDOrderListVC alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
        }
            break;
        case TDProfileHomeCellAbouttype:{
            TDAboutVC *aboutVC = [[TDAboutVC alloc]init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        case TDProfileHomeCellExittype:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认退出" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Action

- (void)userLogout{
    [kCurrentUser removeFromLocalData];
    [self.view addSubview:self.loginVC.view];
    [self.headerView setUserInfo];
}

- (void)userLogin{
    [self setUserInfo];
    [self.loginVC.view removeFromSuperview];
    self.loginVC = nil;
}

- (void)setUserInfo{
    [self.headerView setUserInfo];
    [self.view layoutIfNeeded];
}
    
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (!buttonIndex){
        [self userLogout];
    }
}
    
#pragma mark - Setter

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kHankTabBarHeight) style:UITableViewStyleGrouped];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDProfileHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDProfileHomeCell class])];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (TDProfileHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"TDProfileHomeHeaderView" owner:nil options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTDProfileHomeHeaderViewHeight);
        HANKWEAKSELF
        _headerView.editBlock = ^{
            HANKSTRONGSELF
            TDMyDataVC *dataVC = [[TDMyDataVC alloc]init];
            [strongSelf.navigationController pushViewController:dataVC animated:YES];
        };
        [_headerView setUserInfo];
    }
    return _headerView;
}

- (TDLoginVC *)loginVC{
    if(!_loginVC){
        _loginVC = [[TDLoginVC alloc]init];
        _loginVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _loginVC.view.frame = self.view.bounds;
        HANKWEAKSELF
        _loginVC.blockSuccess = ^(id object){
            HANKSTRONGSELF
            [strongSelf userLogin];
        };
        [self addChildViewController:_loginVC];
    }
    return _loginVC;
}

@end
