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
#define kAliPartnerID         @"2088721560527861"

/**
 *  账户
 */
//收款支付宝账号
#define kAliSellerID          @"qyf@dvillage.cn"

/**
 *  私钥
 */
//商户私钥，自助生成（这个私钥需要自己手动生成，具体生成方法可以看支付宝的官方文档，下面给出大体格式）
#define kAliPartnerPrivKey   @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKt/oSMe6IEXm1yCm8w2zbb+OEpGg/AwqiH6l7nLfph8ANHhGNsLU7QlfCHXGwg8lQGNGUy4GC+z1i7hOTRPgvhUSMOzx9cC0HJGDM+gzC29a0X6g3Fybx7VkI3JTyFfUDminUsvXyUuc32Ld7yQpB1NtBoL91GGXoEC7b4/4RqXAgMBAAECgYEAgWDSjm1F2AWYJi0+HcyGWvPkQVx7Mptz7hhfmEHFaoG6GJupJa6g4fmZcOoXMZqKitYIbRFA5dPU1B8DCcymLzELo7S3yYtg6Uh3cjogn8WYlXHtXE1w/U5MfZf2Z+KoSweA7sZ/iloYeQb/t8jppy5g72lu5e3e1OcoLMiPIYkCQQD/QF15PyS7V+7Ma9wTZLrOAIV8JhcC+IKFOetAHswgX8E+GbL1Cziwh+JEoEkIjb8ptX844JYvZxKinyxN662VAkEArABin3wWPh38MMGqt5rLHmOTPcwiDJmygTf/dgvQaso6X3iRyMkTBb4Q/luPokexGxKLwUfKWK/TylbdidzkewJBALlaHgZ7icrZEbkz4b3beaM50bTTXAZ2OyFPa7tGIeioYAUeWEuE+IeIRRCcbCxf8h7xgw7kV2rYqDma6Gs05vkCQHDz99BATuMQEfN62z+j2cvlHGayzZF0xbLyMUM2UvIuR9M2fJZc5a8ZuFMxkcvCRN5AeaK+IHXJUc5I6UeF1k0CQFzG+bAuDkiGVXF0FOlNCll5jLgDo2TmHsARYIw5Hn13akKIpapTbiojfxFPAa4QxdGIUKIh8cAQKlpK/4ndJnc="
/**
 *  后台接口地址
 */
//后台给的接口网址
#define kAliNotifyURL          @"http://www.getoffer.cn/ls/api/client/order/alipay/notify"   //这里填写的后台给你的支付接口网址
#define kAliPayURLScheme       @"alipay2017080107986946"  //AliPayURLScheme
                                       

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
