//
//  TDPublicNetWorkTools.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/13.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDPublicNetWorkTools.h"

@implementation TDPublicNetWorkTools

#pragma mark - 用户

+ (void)postSendCodeWithPhone:(NSString *)phone successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    MBProgressHUD *HUD = [self commitWithHUD:@"发送验证码中"];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
                            phoneNumber:phone
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     NSString *errStr = [error.userInfo objectForKey:@"getVerificationCode"];
                                     if (!error){
                                         [TDPublicTools SHOWHUDWITHHUD:HUD test:@"获取验证码成功"];
                                         kHankCallBlock(successBlock,nil);
                                     }else{
                                         [TDPublicTools SHOWHUDWITHHUD:HUD test:errStr];
                                         kHankCallBlock(failure,error);
                                     }
                                 }];
}

#define kTestNumber @"15083518280"

+ (void)postLoginWithPhone:(NSString *)phone code:(NSString *)code successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSDictionary *dic = @{@"phone":phone,
                          @"chanel":@"0",
                          };
    MBProgressHUD *HUD = [self commitWithHUD:@"登录中"];
    NSString *url = [BASEIP stringByAppendingString:LOGINAPI];
    
#ifdef TestVersion
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];
        kHankCallBlock(failure,error);
    }];
#else
    if([phone isEqualToString:kTestNumber]){
        [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
            [HUD hideAnimated:YES];
            kHankCallBlock(successBlock,responseObject);
        } failure:^(id error) {
            [HUD hideAnimated:YES];
            kHankCallBlock(failure,error);
        }];
    }else{
        [SMSSDK commitVerificationCode:code phoneNumber:phone zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
            if (error){
                [TDPublicTools SHOWHUDWITHHUD:HUD test:@"验证失败"];
                return;
            }else{
                //成功登录
                [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
                    [HUD hideAnimated:YES];
                    kHankCallBlock(successBlock,responseObject);
                } failure:^(id error) {
                    [HUD hideAnimated:YES];
                    kHankCallBlock(failure,error);
                }];
            }
        }];
    }
#endif

}

+ (void)postUserInfoWithToken:(NSString *)token successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSDictionary *dic = @{@"token":kHankUnNilStr(token),
                          };
    NSString *url = [BASEIP stringByAppendingString:USERINFO];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kHankCallBlock(failure,error);
    }];
}

+ (void)postUpdateNameWithContent:(NSString *)content type:(TDMyDataCelltype)type successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"token"] = kHankUnNilStr(kCurrentUser.token);
    NSString *url = @"";
    switch (type) {
        case TDMyDataCellNametype:{
            dic[@"userName"] = kHankUnNilStr(content);
            url = [BASEIP stringByAppendingString:UPDATENAME];
        }
            break;
        case TDMyDataCellAddressetype:{
            dic[@"address"] = kHankUnNilStr(content);
            url = [BASEIP stringByAppendingString:UPDATEADDRESS];
        }
            break;
        case TDMyDataCellPhoneetype:{
            dic[@"phone"] = kHankUnNilStr(content);
            url = [BASEIP stringByAppendingString:UPDATEPHONE];
        }
            break;
        default:
            break;
    }
    MBProgressHUD *HUD = [self commitWithHUD:@""];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        kHankCallBlock(successBlock,responseObject);
        [HUD hideAnimated:YES];
    } failure:^(id error) {
        [HUD hideAnimated:YES];
        kHankCallBlock(failure,error);
    }];
}

#pragma mark - 首页

+ (void)postSysTopManagerWithsuccessBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSString *url = [BASEIP stringByAppendingString:TOPMANAGELIST];
    [THTTPManager postWithParameter:@{} strUrl:url success:^(ZLRequestResponse *responseObject) {
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kHankCallBlock(failure,error);
    }];
}

+ (void)postDvillageGetAreasWithsuccessBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSString *url = [BASEIP stringByAppendingString:DVILLAGEGETAREAS];
    [THTTPManager postWithParameter:@{} strUrl:url success:^(ZLRequestResponse *responseObject) {
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kHankCallBlock(failure,error);
    }];
}

+ (void)postVillageDetailsWithId:(NSString *)villageId successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSString *url = [BASEIP stringByAppendingString:VILLAGEDETAIL];
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:@{@"id":kHankUnNilStr(villageId)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [TDPublicTools SHOWHUDWITHHUD:HUD test:@"获取失败"];
        kHankCallBlock(failure,error);
    }];
}

+ (void)postTourDetailsWithId:(NSString *)tourId successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSString *url = [BASEIP stringByAppendingString:ROUTEDETAIL];
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:@{@"id":kHankUnNilStr(tourId)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [TDPublicTools SHOWHUDWITHHUD:HUD test:@"获取失败"];
        kHankCallBlock(failure,error);
    }];
}

+ (void)postProductsDetailsWithId:(NSString *)productsId successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSString *url = [BASEIP stringByAppendingString:PRODUCTDETAIL];
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:@{@"id":kHankUnNilStr(productsId)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [TDPublicTools SHOWHUDWITHHUD:HUD test:@"获取失败"];
        kHankCallBlock(failure,error);
    }];
}

#pragma mark - 农产品

+ (void)postGetByCodeAppWithsuccessBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSString *url = [BASEIP stringByAppendingString:GETBYCODEAPP];
    [THTTPManager postWithParameter:@{} strUrl:url success:^(ZLRequestResponse *responseObject) {
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kHankCallBlock(failure,error);
    }];
}

+ (void)postGetAreasAndVillageWithsuccessBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSString *url = [BASEIP stringByAppendingString:GETAREASANDVILLAGE];
    [THTTPManager postWithParameter:@{} strUrl:url success:^(ZLRequestResponse *responseObject) {
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kHankCallBlock(failure,error);
    }];
}

+ (void)postGetSortWithsuccessBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSString *url = [BASEIP stringByAppendingString:GETSORT];
    [THTTPManager postWithParameter:@{} strUrl:url success:^(ZLRequestResponse *responseObject) {
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        kHankCallBlock(failure,error);
    }];
}

#pragma mark - 资讯

+ (void)postInfoDetailsWithId:(NSString *)infoId successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSString *url = [BASEIP stringByAppendingString:INFODETAIL];
    MBProgressHUD *HUD = [self commitWithHUD:@"获取详情中"];
    [THTTPManager postWithParameter:@{@"id":kHankUnNilStr(infoId)} strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [TDPublicTools SHOWHUDWITHHUD:HUD test:@"获取失败"];
        kHankCallBlock(failure,error);
    }];
}

#pragma mark - 订单和支付

+ (void)postOrderPayWithPayId:(NSString *)payId payNum:(NSString *)payNum successBlock:(RequestResponse)successBlock failure:(kHankObjBlock)failure{
    NSDictionary *dic = @{@"token":kHankUnNilStr(kCurrentUser.token),
                          @"payId":kHankUnNilStr(payId),
                          @"payNum":kHankUnNilStr(payNum)
                          };
    MBProgressHUD *HUD = [self commitWithHUD:@"获取订单中"];
    NSString *url = [BASEIP stringByAppendingString:ORDERPAY];
    [THTTPManager postWithParameter:dic strUrl:url success:^(ZLRequestResponse *responseObject) {
        [HUD hideAnimated:YES];
        kHankCallBlock(successBlock,responseObject);
    } failure:^(id error) {
        [HUD hideAnimated:YES];
        kHankCallBlock(failure,error);
    }];
}

#pragma mark - Help

+ (MBProgressHUD *)commitWithHUD:(NSString *)str{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:kHankCurrentWindow animated:YES];
    HUD.label.text = str;
    HUD.userInteractionEnabled = YES;
    return HUD;
}

@end
