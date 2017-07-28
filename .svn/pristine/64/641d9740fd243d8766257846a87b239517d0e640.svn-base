//
//  TDOrderPayModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/19.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseModel.h"

/*
 "outTradeNo": "T6TQZ720170719134800",
 "subject": "苹果,第一条线路",
 "amount": "210.0",
 "notifyUrl": ""
 numStr	string	商品拼接后的数量
 */

@interface TDOrderPayModel : TDBaseModel

@property (nonatomic, copy) NSString * amount;
@property (nonatomic, copy) NSString * notifyUrl;
@property (nonatomic, copy) NSString * outTradeNo;
@property (nonatomic, copy) NSString * subject;
@property (nonatomic, strong) NSArray * arrSubject;
@property (nonatomic, copy) NSString * numStr;
@property (nonatomic, strong) NSArray * arrNum;
@property (nonatomic, copy) NSString * receiptAddress;
@property (nonatomic, copy) NSString * receiptName;
@property (nonatomic, copy) NSString * receiptPhone;

@property (nonatomic, strong) NSMutableArray *arrProduct;

@property (nonatomic, copy) NSString * strPayId;
//支付类型
@property (nonatomic, assign)TDPayType payType;
@property (nonatomic, assign)BOOL payIsSucess;
@property (nonatomic, strong) NSString *payTime;
@property (nonatomic, assign)TDPayStatusType status;
//是否隐藏编辑按钮 订单列表进去的隐藏 其他进去的不隐藏
@property (nonatomic, assign)BOOL isCanEdit;
@property (nonatomic, copy) NSString * TDID;


@end

@interface TDOrderPayProctModel : TDBaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *num;

- (instancetype)initWithName:(NSString *)name num:(NSString *)num;

@end
