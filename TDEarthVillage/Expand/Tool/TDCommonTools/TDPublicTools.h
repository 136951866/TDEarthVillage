//
//  TDPublicTools.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDPublicTools : NSObject

/**
 *  颜色转UIIimage
 *
 *  @param color UIColor
 *
 *  @return UIImage
 */
+(UIImage*) createImageWithColor:(UIColor*) color;

/**
 *  拿指定VC
 */
+ (id)getVCWithClass:(Class)targetClass targetResponder:(UIResponder *)targetResponder;
+ (UIViewController *)getClass:(Class)aClass target:(UIViewController *)target;

/**
 *  模态相关
 */
+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
+ (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion;

+ (void)showMessage:(NSString *)text view:(UIView *)view;
+ (void)SHOWHUDWITHHUD:(MBProgressHUD *)HUD test:(NSString *)text;

/**
 *  删除特殊字符
 */
+ (NSString *) stringDeleteString:(NSString *)str;

/**
 *  校验手机号码
 */
+ (BOOL)isValidPhoneNum:(NSString *)strPhoneNum;
/**
 *  校验email
 */
+ (BOOL)isvalidEmail:(NSString *)email;
/**
 *  校验身份证号码
 */
+ (BOOL)isCorrect:(NSString *)IDNumber;
/**
 *  打电话
 */
+ (void)showWithTellPhone:(NSString *)Number inView:(UIView *)view;

+ (NSString *)floatChangeStr:(CGFloat)num;
+ (NSString *)getNowTitleWithFormat:(NSString *)format;
+ (NSString *)dateStringForFormat:(NSString *)format timeInterval:(double)interval;


+ (void)setShopNumberWithShowView:(UIView *)view number:(NSString*)number;
@end
