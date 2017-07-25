//
//  TDOrderModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/20.
//  Copyright © 2017年 Hank. All rights reserved.
//
/*
 id	string	资讯id
 createDate	string	创建时间
 orderNo	string	订单号
 orderStatus	string	订单状态,0:待付款,1:付款成功(待发货) 2:已发货
 payChannel	string	支付渠道, 0:支付宝,1:微信
 productName	string	购买产品名称,多个以逗号拼接
 productNum	string	购买产品数量,多个以逗号拼接
 payDate	string	支付时间
 totalAmount	string	总付款金额
 */
#import "TDBaseModel.h"

@interface TDOrderModel : TDBaseModel


@property (nonatomic, copy) NSString * createDate;
@property (nonatomic, copy) NSString * TDID;
@property (nonatomic, copy) NSString * orderNo;
@property (nonatomic, copy) NSString * orderStatus;
@property (nonatomic, copy) NSString * payChannel;
@property (nonatomic, copy) NSString * payDate;
@property (nonatomic, copy) NSString * productName;
@property (nonatomic, strong) NSArray * arrProductName;
@property (nonatomic, copy) NSString * productNum;
@property (nonatomic, strong) NSArray * arrProductNum;
@property (nonatomic, copy) NSString * totalAmount;
@property (nonatomic, copy) NSString * receiptAddress;
@property (nonatomic, copy) NSString * receiptName;
@property (nonatomic, copy) NSString * receiptPhone;
@property (nonatomic, copy) NSString * notifyUrl;

@property (nonatomic, assign)TDPayStatusType status;
@property (nonatomic, strong) NSMutableArray *arrProduct;
@end


@interface TDOrderProctModel : TDBaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *num;

- (instancetype)initWithName:(NSString *)name num:(NSString *)num;

@end
