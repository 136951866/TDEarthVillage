//
//  TDUserInfoModel.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/11.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDUserInfoModel.h"

static NSString *kUserInfoKey = @"kUserInfo";
static TDUserInfoModel *shareUser;

@implementation TDUserInfoModel

#pragma mark - Public Methos

+ (TDUserInfoModel *)shareUser{
    if (!shareUser) {
        shareUser = [TDUserInfoModel getObjctForKey:kUserInfoKey];
        if (!shareUser) {
            shareUser = [[TDUserInfoModel alloc]init];
        }
    }
    return shareUser;
}

+ (void)logout{
    kNoticeUserLogout
    [TDUserInfoModel removeCodingForKey:kUserInfoKey];
    shareUser = nil;
}
    
- (void)removeFromLocalData{
    [TDUserInfoModel removeCodingForKey:kUserInfoKey];
    shareUser = nil;
}
    
- (void)setterWithDict:(NSDictionary *)dict{
    if ([dict isKindOfClass:[NSDictionary class]]) {
        [self mj_setKeyValues:dict];
    }
}
    
- (void)save{
    [self writeObjectForKey:kUserInfoKey];
}
    
+ (BOOL)isLogin{
    if(kCurrentUser == nil){
        return FALSE;
    }else{
        if(kCurrentUser.token.length <=0 || kCurrentUser.token == nil){
            return FALSE;
        }else{
            return TRUE;
        }
    }
}

@end
