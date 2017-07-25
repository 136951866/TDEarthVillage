//
//  TDLoginVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDLoginVC.h"
#import "TDTickTimer.h"
#import "ZLRequestResponse.h"

const static NSUInteger     kLimitVerficationNum = 3;
const static CGFloat        kValidTime = 60.0f;
#define kImgTopMargin       (130.0 * kHankFrameScaleY())
#define kImgBottomMargin    (27.0 * kHankFrameScaleY())
#define kbtnBottomMargin    (20.0 * kHankFrameScaleY())

@interface TDLoginVC ()<UITextFieldDelegate>{
    TDTickTimer *_timer;
    NSString *_strCaptcha;
}

@property (weak, nonatomic) IBOutlet UIView             *viewForNumber;
@property (weak, nonatomic) IBOutlet UIView             *viewForCaptcha;

@property (weak, nonatomic) IBOutlet UITextField        *tfNnumber;
@property (weak, nonatomic) IBOutlet UITextField        *tfCaptcha;
@property (assign,nonatomic) BOOL                      isModelPush;
@property (weak, nonatomic) IBOutlet UIButton           *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton           *btnCaptcha;
@property (weak, nonatomic) IBOutlet UIButton           *btnLogin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImgTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImgBottomMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBtnTopMargin;


@end

@implementation TDLoginVC

#pragma mark - Public Method

+ (void)presentLoginVCWithSuccessHandler:(kHankObjBlock)blockSuccess failHandler:(kHankObjBlock)blockFail{
    TDLoginVC *loginvc = [[TDLoginVC alloc]init];
    loginvc.blockSuccess = blockSuccess;
    loginvc.blockFail = blockFail;
    loginvc.isModelPush = YES;
    [TDPublicTools presentViewController:loginvc animated:YES completion:nil];
}

#pragma mark - 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSomeThing];
}

#pragma mark - private Method

- (void)initSomeThing{
    [self setLayout];
    self.navBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [_btnCaptcha setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_tfCaptcha addTarget:self action:@selector(tfCodeTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_tfCaptcha addTarget:self action:@selector(tfVerficationTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    _tfCaptcha.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    if(self.isModelPush){
        _btnCancel.hidden = NO;
    }
}

- (void)setLayout{
    _consImgTopMargin.constant = kImgTopMargin;
    if(kHankFrameScaleY()<1){
        _consImgTopMargin.constant = 64;
    }
    _consImgBottomMargin.constant = kImgBottomMargin;
    _consBtnTopMargin.constant = kbtnBottomMargin;
    [self.view layoutIfNeeded];
}

-(void)loginSuccess{
    kNoticeUserLogin
    if(self.isModelPush){
        HANKWEAKSELF
        [TDPublicTools dismissViewControllerAnimated:YES completion:^{
            HANKSTRONGSELF
            kHankCallBlock(strongSelf.blockSuccess,nil);
        }];
    }else{
        kHankCallBlock(self.blockSuccess,nil);
    }
}

-(void)loginFail{
    [kCurrentUser removeFromLocalData];
    if(self.isModelPush){
        HANKWEAKSELF
        [TDPublicTools dismissViewControllerAnimated:YES completion:^{
            HANKSTRONGSELF
            kHankCallBlock(strongSelf.blockFail,nil);
        }];
    }else{
        kHankCallBlock(self.blockFail,nil);
    }
}

#pragma mark - UITextField Action

- (void)tfCodeTextDidChange:(UITextField *)textField{
    if(textField.text.length> kLimitVerficationNum){
        _btnLogin.enabled = YES;
        textField.text = [textField.text substringWithRange:NSMakeRange(0,kLimitVerficationNum + 1)];
    }else{
        _btnLogin.enabled = NO;
    }
    _strCaptcha = textField.text;
}

- (void)tfVerficationTextDidChange:(UITextField *)textField{
    if(textField.text.length > kLimitVerficationNum){
        [_btnLogin setBackgroundColor:kThemeBlue];
        _btnLogin.enabled = YES;
    }else{
        [_btnLogin setBackgroundColor:[UIColor colorWithHexString:@"bbbbbb"]];
        _btnLogin.enabled = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - Action

- (IBAction)loginAction:(UIButton *)sender {
    HANKWEAKSELF    
    [TDPublicNetWorkTools postLoginWithPhone:kHankUnNilStr(_tfNnumber.text) code:kHankUnNilStr(_tfCaptcha.text) successBlock:^(ZLRequestResponse *responseObject) {
        HANKSTRONGSELF
        [strongSelf dealWithUserInfoWithrespon:responseObject];
    } failure:^(id object) {
        HANKSTRONGSELF
        [strongSelf loginFail];
    }];
}

    
- (void)dealWithUserInfoWithrespon:(ZLRequestResponse *)responseObject{
    if(![responseObject.data isKindOfClass:[NSDictionary class]]){
        [TDPublicTools showMessage:@"数据错误" view:self.view];
    }
    [kCurrentUser setterWithDict:responseObject.data];
    [kCurrentUser save];
    NSString *token = kCurrentUser.token;
    HANKWEAKSELF
    [TDPublicNetWorkTools postUserInfoWithToken:token successBlock:^(ZLRequestResponse *responseObject) {
        [kCurrentUser setterWithDict:responseObject.data];
        kCurrentUser.token = token;
        [kCurrentUser save];
        [self loginSuccess];
    } failure:^(id object) {
        HANKSTRONGSELF
        [strongSelf loginFail];
    }];
    
}
    

- (IBAction)cancelAction:(UIButton *)sender {
    [self loginFail];
}

- (IBAction)captchaAction:(UIButton *)sender{
    if(![TDPublicTools isValidPhoneNum:kHankUnNilStr(_tfNnumber.text)]){
        [TDPublicTools showMessage:@"手机格式不对" view:self.view];
        _tfNnumber.text = @"";
        return;
    }
    HANKWEAKSELF
    [TDPublicNetWorkTools postSendCodeWithPhone:kHankUnNilStr(_tfNnumber.text) successBlock:^(ZLRequestResponse *responseObject) {
        HANKSTRONGSELF
        [strongSelf timerTick];
    } failure:^(id object) {
        
    }];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

#pragma mark - Setter

-(void)timerTick{
    HANKWEAKSELF
    if (!_timer) {
        _timer = [[TDTickTimer alloc] init];
    }
    self.btnCaptcha.enabled = NO;
    [_timer tickTime:kValidTime tickBlock:^(NSTimeInterval tick) {
        HANKSTRONGSELF
        NSString *title = [NSString stringWithFormat:@"%.0fs",tick];
        [strongSelf.btnCaptcha setTitle:title forState:strongSelf.btnCaptcha.state];
    } finishBlock:^{
        HANKSTRONGSELF
        strongSelf.btnCaptcha.enabled = YES;
        [strongSelf.btnCaptcha setTitle:@"获取验证码" forState:strongSelf.btnCaptcha.state];
    }];
}


@end
