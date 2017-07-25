//
//  TDTickTimer.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TickBlock)(NSTimeInterval);
typedef void (^TickFinishBlock)(void);

@interface TDTickTimer : NSObject

/**
 *  倒计时
 *  @param time        倒计时间（秒为单位）
 *  @param tickBlock   倒计时回调（返回剩余秒数）
 *  @param finishBlock 倒计时结束
 */
-(void)tickTime:(NSTimeInterval)time tickBlock:(TickBlock)tickBlock finishBlock:(TickFinishBlock) finishBlock;
/**
 *  取消倒计时
 */
-(void)stopTick;
@end
