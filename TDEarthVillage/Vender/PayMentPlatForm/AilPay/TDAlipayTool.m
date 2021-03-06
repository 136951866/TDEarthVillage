//
//  TDAlipayTool.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/11.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDAlipayTool.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation TDAlipayTool

+ (void)payAliPayWithOrderId:(NSString *)orderId
                  totalMoney:(NSString *)totalMoney
                    payTitle:(NSString *)payTitle
          productDescription:(NSString *)productDescription
                   notifyURL:(NSString *)notifyURL{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = kAliPartnerID;
    NSString *seller = kAliSellerID;
    NSString *privateKey = kAliPartnerPrivKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderId; //订单ID（由商家自行制定）
    if (payTitle) {
    }else{
        payTitle = @"服务";
    }
    order.productName = payTitle; //商品标题
    order.productDescription = productDescription; //商品描述
    NSLog(@"paymodel.price%@",totalMoney);
    order.amount = totalMoney; //商品价格

    NSString *notifyUrl = kHankUnNilStr([TDInitSaveModel getSaveModel].apliayNotify);
    order.notifyURL = notifyUrl; //回调URL//notifyURL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = kAliPayURLScheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    NSLog(@"%@",order);
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    //HWLog(@"%fdgh@",signedString);
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec,signedString,@"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            if ([[resultDic objectForKey:@"resultStatus"] isEqual:@"9000"]) {
                //支付成功
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_SUCCESSED];
                
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_FAILED];
            }
            
        }];
    }
}
    
@end
