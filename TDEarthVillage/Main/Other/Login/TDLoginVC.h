//
//  TDLoginVC.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseVC.h"

@interface TDLoginVC : TDBaseVC

/**
 模态弹出类方法
 */
+ (void)presentLoginVCWithSuccessHandler:(kHankObjBlock)blockSuccess failHandler:(kHankObjBlock)blockFail;
/**
 成功返回
 */
@property (strong, nonatomic) kHankObjBlock         blockSuccess;

/**
 失败返回
 */
@property (strong, nonatomic) kHankObjBlock         blockFail;

@end
