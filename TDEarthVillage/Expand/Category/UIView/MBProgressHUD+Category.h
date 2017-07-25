//
//  MBProgressHUD+Category.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/11.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Category)
    
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
    
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
    
    
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
    
+ (MBProgressHUD *)showMessage:(NSString *)message;
    
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
    
@end
