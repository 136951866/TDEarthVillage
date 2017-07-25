//
//  TDInfoDetailVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/17.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDInfoDetailVC.h"
#import "TDInfoModel.h"

@interface TDInfoDetailVC ()<UIWebViewDelegate>{
    NSString *_title;
    NSString *_content;
    BOOL _isPost;
    NSString *_infoId;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TDInfoDetailVC

HankMustImplementedDataInit()
- (instancetype)initWithInfoId:(NSString *)infoId{
    if(self = [super init]){
        _isPost = YES;
        _infoId = infoId;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content{
    if(self = [super init]){
        _isPost = NO;
        _title = title;
        _content = content;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(_isPost){
        [TDPublicNetWorkTools postInfoDetailsWithId:_infoId successBlock:^(ZLRequestResponse *responseObject) {
            TDInfoModel *model = [TDInfoModel mj_objectWithKeyValues:responseObject.data];
            self.title = model.title;
            [_webView loadHTMLString:model.context baseURL:nil];
        } failure:^(id object) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        self.title = _title;
        [_webView loadHTMLString:_content baseURL:nil];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:_webView animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:_webView];
}

@end
