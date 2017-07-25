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

@end
