//
//  TDModifymyDataVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/7.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDModifymyDataVC.h"
#import "TDMyDataModel.h"

#define kbtnFrame CGRectMake(-20, 0, 60, 25)

@interface TDModifymyDataVC (){
    NSArray             *_arrType;
    TDMyDataModel       *_model;
    kHankTextBlock      _finishBlock;
}

@property (nonatomic, strong) UIButton                  *btnRight;
@property (weak, nonatomic) IBOutlet UILabel            *lblTitle;
@property (weak, nonatomic) IBOutlet UITextField        *tfContent;

@end

@implementation TDModifymyDataVC

- (instancetype)initWithModel:(TDMyDataModel *)model finishBlock:(kHankTextBlock)finishBlock{
    if(self = [super init]){
        _model = model;
        _finishBlock = finishBlock;
        _arrType = @[@"头像",@"昵称",@"姓名",@"地址",@"手机"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改资料";
    self.view.backgroundColor = kBackgroundGray;
    _lblTitle.text =  _arrType[_model.type];
    _tfContent.text = kHankUnNilStr(_model.content);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnRight];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Action

- (void)saveAction:(UIButton *)btn {
    if(!kHankUnNilStr(_tfContent.text).length){
        [TDPublicTools showMessage:@"不能为空" view:kHankCurrentWindow];
        return;
    }
    if(_model.type == TDMyDataCellPhoneetype && ![TDPublicTools isValidPhoneNum:kHankUnNilStr(_tfContent.text)]){
        [TDPublicTools showMessage:@"手机格式不对" view:self.view];
        _tfContent.text = @"";
        return;
    }
    [TDPublicNetWorkTools postUpdateNameWithContent:kHankUnNilStr(_tfContent.text) type:_model.type successBlock:^(ZLRequestResponse *responseObject) {
        kHankCallBlock(_finishBlock,kHankUnNilStr(_tfContent.text));
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(id object) {
        
    }];
}

#pragma mark - Setter

- (UIButton *)btnRight{
    if(!_btnRight){
        _btnRight= [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = kbtnFrame;
        [_btnRight setImage:[UIImage imageNamed:@"me_edit_save"] forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}


@end
