//
//  TDUserInfoModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/11.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseModel.h"

#define kCurrentUser [TDUserInfoModel shareUser]

@interface TDUserInfoModel : TDBaseModel

+ (TDUserInfoModel *)shareUser;

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *acceptName;
@property (nonatomic, copy) NSString *acceptAddress;
@property (nonatomic, copy) NSString *acceptPhone;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *phone;
//退出
+ (void)logout;
//归档
- (void)save;
//是否已经登录
+ (BOOL)isLogin;
- (void)setterWithDict:(NSDictionary *)dict;
//删除本地数据不发通知
- (void)removeFromLocalData;

@end
