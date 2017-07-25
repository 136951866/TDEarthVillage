//
//  TDMyDataVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDMyDataVC.h"
#import "TDMyDataCell.h"
#import "TDMyDataModel.h"
#import "TDModifymyDataVC.h"

@interface TDMyDataVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_arrModel;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TDMyDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSomeThing];
}

#pragma mark - Private Method

- (void)initSomeThing{
    self.title = @"我的资料";
    _tableView.backgroundColor = kBackgroundGray;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDMyDataCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TDMyDataCell class])];
    _arrModel = [NSMutableArray array];
    
    NSMutableArray *arrScetion0 = [NSMutableArray array];
    [arrScetion0 addObject:[[TDMyDataModel alloc]initWithType:TDMyDataCellHeadPortraittype content:kHankUnNilStr(kCurrentUser.logo)]];
      [arrScetion0 addObject:[[TDMyDataModel alloc]initWithType:TDMyDataCellNicktype content:kHankUnNilStr(kCurrentUser.nickName)]];
    [_arrModel addObject:arrScetion0];
    NSMutableArray *arrScetion1 = [NSMutableArray array];
    [arrScetion1 addObject:[[TDMyDataModel alloc]initWithType:TDMyDataCellNametype content:kHankUnNilStr(kCurrentUser.acceptName)]];
    [arrScetion1 addObject:[[TDMyDataModel alloc]initWithType:TDMyDataCellAddressetype content:kHankUnNilStr(kCurrentUser.acceptAddress)]];
    [arrScetion1 addObject:[[TDMyDataModel alloc]initWithType:TDMyDataCellPhoneetype content:kHankUnNilStr(kCurrentUser.acceptPhone)]];
     [_arrModel addObject:arrScetion1];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section){
        return 62;
    }else{
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDMyDataModel *model = _arrModel[indexPath.section][indexPath.row];
    TDMyDataCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDMyDataCell class]) forIndexPath:indexPath];
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TDMyDataModel *model = _arrModel[indexPath.section][indexPath.row];
    return [TDMyDataCell getHeightWithModel:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = _arrModel[section];
    return arr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TDMyDataModel *model = _arrModel[indexPath.section][indexPath.row];
    HANKWEAKSELF
    switch (model.type) {
        case TDMyDataCellHeadPortraittype:{
            [[HKPhotoTool shareTool] showImageViewSelcteWithResultBlock:^(UIImage *data, NSDictionary *info) {
                NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
                NSMutableArray *arrScetion0 = _arrModel[0];
                [arrScetion0 replaceObjectAtIndex:0 withObject:[[TDMyDataModel alloc]initWithType:TDMyDataCellHeadPortraittype content:[url absoluteString] image:data]];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:YES];
            }];
        }
            break;
        case TDMyDataCellNicktype:{
            TDModifymyDataVC *modifyVC = [[TDModifymyDataVC alloc]initWithModel:model finishBlock:^(NSString *str) {
                kCurrentUser.nickName = str;
                [kCurrentUser save];
                HANKSTRONGSELF
                NSMutableArray *arrScetion1 = strongSelf->_arrModel[0];
                [arrScetion1 replaceObjectAtIndex:0 withObject:[[TDMyDataModel alloc]initWithType:TDMyDataCellNicktype content:kHankUnNilStr(str)] ];
                [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:YES];
            }];
            [self.navigationController pushViewController:modifyVC animated:YES];
        }
            break;
        case TDMyDataCellNametype:{
            TDModifymyDataVC *modifyVC = [[TDModifymyDataVC alloc]initWithModel:model finishBlock:^(NSString *str) {
                kCurrentUser.acceptName = str;
                [kCurrentUser save];
                HANKSTRONGSELF
                NSMutableArray *arrScetion1 = strongSelf->_arrModel[1];
                [arrScetion1 replaceObjectAtIndex:0 withObject:[[TDMyDataModel alloc]initWithType:TDMyDataCellNametype content:kHankUnNilStr(str)] ];
                [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:YES];
            }];
            [self.navigationController pushViewController:modifyVC animated:YES];
        }
            break;
        case TDMyDataCellAddressetype:{
            TDModifymyDataVC *modifyVC = [[TDModifymyDataVC alloc]initWithModel:model finishBlock:^(NSString *str) {
                kCurrentUser.acceptAddress = str;
                [kCurrentUser save];
                HANKSTRONGSELF
                NSMutableArray *arrScetion1 = strongSelf->_arrModel[1];
                [arrScetion1 replaceObjectAtIndex:1 withObject:[[TDMyDataModel alloc]initWithType:TDMyDataCellAddressetype content:kHankUnNilStr(str)] ];
                [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:YES];
            }];
            [self.navigationController pushViewController:modifyVC animated:YES];
        }
            break;
        case TDMyDataCellPhoneetype:{
            TDModifymyDataVC *modifyVC = [[TDModifymyDataVC alloc]initWithModel:model finishBlock:^(NSString *str) {
                kCurrentUser.acceptAddress = str;
                [kCurrentUser save];
                HANKSTRONGSELF
                NSMutableArray *arrScetion1 = strongSelf->_arrModel[1];
                [arrScetion1 replaceObjectAtIndex:1 withObject:[[TDMyDataModel alloc]initWithType:TDMyDataCellPhoneetype content:kHankUnNilStr(str)] ];
                [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:YES];
            }];
            [self.navigationController pushViewController:modifyVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section){
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 62)];
        lbl.backgroundColor = kBackgroundGray;
        lbl.textColor = kTitleThemeBlack;
        lbl.text = @"  收货地址";
        lbl.font = kHankFont(22);
        return lbl;
    }else{
        UIView *view = [UIView new];
        view.backgroundColor = kBackgroundGray;
        return view;
    }
}

@end
