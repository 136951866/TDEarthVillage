//
//  TDPayNeedMacros.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#ifndef TDPayNeedMacros_h
#define TDPayNeedMacros_h

/**************************** 支付宝支付 *****************************/
/**
 *  商户ID
 */
//合作身份者id，以2088开头的16位纯数字（客户给）
#define kAliPartnerID         @"2088021280217179"

/**
 *  账户
 */
//收款支付宝账号
#define kAliSellerID          @"zhiliantianxia@163.com"

/**
 *  私钥
 */
//商户私钥，自助生成（这个私钥需要自己手动生成，具体生成方法可以看支付宝的官方文档，下面给出大体格式）
#define kAliPartnerPrivKey   @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALqDaS78z/c/Hp0TIYO6uogtFL420j4zZxGlvZGSSmDIe82NTV1b2WjIjaHmOfNDoIDISD9zxu2eRIrNh9T2leGpjgg1VbVzU9KWKuijyCeDwbdLjYyleamshK4aSs1B5dh/IKGWEnQMY4BWLjF8MbQHZQUhYDVJSjJX8RwR/jO7AgMBAAECgYEAkT3iPAf9fyF1GoaaU7WmqoLIo3OXd36Z5cE2hVTxfLrCxggiVfA/tnxu5sOdHxXruD2/HUJwh/v2jkyNWUcI4VJDXMoipp5kIY5EYuqIJSIAUy2isolVwWrRcKceIXffXnQ9iGKantv8LnF88IIMFMPs1UvZs7TRUPY9dZoj7IECQQD287AgxL8WcQJM6cI+9c71M/wt6taKOpFkPPH0f385PUzd/kgY7RMjMDFhMdXDVh1KklhStMFHAYPbhLIU1kh7AkEAwVjVKnwUz41AzojHp2frbKbvriwIdOdolAew8uGUI8WFrV0Yg4bLkQ5glJaUj3JFNbbsq3DzrDiw76cZU3D9wQJAFvphvwrPhPUK88Ekc9tHYIVvx438XGxKrvsEwG1Elzze9CD+8GLOzw1i6tpKO5y9qPyo/zkWatb3P+u+7jVqFQJAUJryM4YLPwQKcpA/fCEs2t01qw0ccXBP/va95GP62HbuZfob0CmQEGdICGpGgQ8In34laMvsKm5wBVlKi6jdgQJBAMd0SGDzx93aqdfvpsaxugK/UC4EPF/k6iWw/auBLdMXgJF9NT2g2MdD7I/PiAUj9cSThmCl698D6tz5Y5Zy05c="
/**
 *  后台接口地址
 */
//后台给的接口网址
#define kAliNotifyURL          @"http://www.getoffer.cn/ls/api/client/order/alipay/notify"   //这里填写的后台给你的支付接口网址
#define kAliPayURLScheme       @"alipay2016111602864559"  //AliPayURLScheme
                                       

//通知的名字及参数
#define ALI_PAY_RESULT         @"Ali_pay_result_isSuccessed"
#define ALIPAY_SUCCESSED       @"Ali_pay_isSuccessed"
#define ALIPAY_FAILED          @"Ali_pay_isFailed"
#define kALI_PAY_RESULTWithSelector(sel) [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sel) name:ALI_PAY_RESULT object:nil];

/**************************** 微信支付 *****************************/

//微信支付
#define  UMWXAppId @"wx4b0bc4fecc3e1748"
#define  UMWXAppSecret @"ecf87bac5d395be608c3040367aae098"


//通知的名字及参数
#define WX_PAY_RESULT          @"weixin_pay_result"
#define WXPAY_SUCCESSED        @"wechat_pay_isSuccessed"
#define WXPAY_FAILED           @"wechat_pay_isFailed"

#define kWX_PAY_RESULTWithSelector(sel) [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sel) name:WX_PAY_RESULT object:nil];

//商户号，填写商户对应参数（客户给）
#define kWXPAY_MCH_ID          @"1407017702"
//商户API密钥，填写相应参数（客户给）
#define kWXPAY_PARTNER_ID      @"zhiliantianxiawoyaoliuxue1304000"
//支付结果回调页面（后台会给你）

#define kWXPAY_NOTIFY_URL      @"http://www.getoffer.cn/ls/api/client/order/wechatpay/notify" 
//获取服务器端支付数据地址（商户自定义）
#define kWXPAY_SP_URL          @"https://api.mch.weixin.qq.com/pay/unifiedorder"

#endif /* TDPayNeedMacros_h */
