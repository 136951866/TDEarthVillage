//
//  TDPublicTools.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDPublicTools.h"
#import "TDNavigationVC.h"
#import "UIView+TDBadge.h"

@implementation TDPublicTools

+ (UIImage*) createImageWithColor:(UIColor*) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (void)showMessage:(NSString *)text view:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (text.length > 10) {
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = text;
        hud.detailsLabel.font = hud.label.font;
    }else{
        hud.label.text = text;
    }
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
}

+ (void)SHOWHUDWITHHUD:(MBProgressHUD *)HUD test:(NSString *)text{
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.userInteractionEnabled = YES;
    if ([text isKindOfClass:[NSString class]]) {
        HUD.label.text = text;
    }
    HUD.removeFromSuperViewOnHide = YES;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1.0];
}

+ (void)showWithTellPhone:(NSString *)Number inView:(UIView *)view{
    UIWebView *callWebview = [[UIWebView alloc] init];
    NSString *strPhone = [NSString stringWithFormat:@"tel:%@",Number];
    NSURL *telURL =[NSURL URLWithString:[strPhone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [view addSubview:callWebview];
}

+ (id)getVCWithClass:(Class)targetClass targetResponder:(UIResponder *)targetResponder{
    do{
        if([targetResponder isKindOfClass:targetClass]){
            return targetResponder;
        }
        targetResponder = [targetResponder nextResponder];
    }while (targetResponder!=nil);
    return nil;
}

+ (UIViewController *)getClass:(Class)aClass target:(UIViewController *)target{
    NSArray *array=target.navigationController.viewControllers;
    for (UIViewController *vc in array){
        if([vc isKindOfClass:aClass]){
            return vc;
        }
    }
    return nil;
}

+ (NSString *)stringDeleteString:(NSString *)str{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if (c == '\n') {
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    TDNavigationVC *nav = [[TDNavigationVC alloc]initWithRootViewController:viewControllerToPresent];
    UIViewController *rootVc  = [kHankCurrentWindow rootViewController];
    while (rootVc.presentedViewController) {
        rootVc = rootVc.presentedViewController;
    }
    [rootVc presentViewController:nav animated:flag completion:completion];
}

+ (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion{
    UIViewController *rootVc = [kHankCurrentWindow rootViewController];
    while (rootVc.presentedViewController) {
        rootVc = rootVc.presentedViewController;
    }
    [rootVc dismissViewControllerAnimated:flag completion:completion];
}

+ (NSString *)getNowTitleWithFormat:(NSString *)format{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

#pragma mark - About Verify

+ (BOOL)isValidPhoneNum:(NSString *)strPhoneNum{
    NSString *Regex = @"^(13[0-9]|14[57]|15[012356789]|17[0678]|18[0-9])[0-9]{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:strPhoneNum];
}

+ (BOOL)isvalidEmail:(NSString *)email{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:email];
}

+ (BOOL)isCorrect:(NSString *)IDNumber
{
    NSMutableArray *IDArray = [NSMutableArray array];
    if (IDNumber.length < 18) return NO;
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    // 余数数组
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [IDNumber substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    if ([str isEqualToString:string]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - deal with

+ (NSString *)floatChangeStr:(CGFloat)num{
    BOOL isZear = num == (long)num;
    if(isZear){
        return [NSString stringWithFormat:@"%ld",(long)num];
    }else{
        return [NSString stringWithFormat:@"%.2f",num];
    }
}

+ (NSString *)dateStringForFormat:(NSString *)format timeInterval:(double)interval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval/1000];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [fmt setDateFormat:format];
    return [fmt stringFromDate:date];
}

+ (void)setShopNumberWithShowView:(UIView *)view number:(NSString*)number{
    if([number integerValue]){
        [view showBadgeWithStyle:BadgeStyleNumber value:[number integerValue] animationType:BadgeAnimTypeNone];
    }else{
        [view clearBadge];
    }
}

+ (NSString *)MD5:(NSString *)mdStr{
    //32位 小写
    const char *original_str = [mdStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

@end
