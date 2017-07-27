//
//  TDInitThridPart.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/3.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDInitThridPart.h"
#import "IQKeyboardManager.h"

@implementation TDInitThridPart

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] td_initIQKeyboardManager];
        [[self class] td_registerWeixinPay];
        [[self class] td_registeSMSSDK];
        [[self class] td_registeUmMobClick];
    });
}

+ (void)td_initIQKeyboardManager{
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
    
+ (void)td_registerWeixinPay{
    [WXApi registerApp:UMWXAppId];
}

+ (void)td_registeSMSSDK{
    [SMSSDK registerApp:SMSApp
             withSecret:SMSSecret];
}

+ (void)td_registeUmMobClick{
#pragma mark 友盟统计
    UMConfigInstance.appKey = MobAppkey;
    UMConfigInstance.ePolicy = BATCH;
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
}

@end
