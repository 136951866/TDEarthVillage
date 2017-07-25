//
//  TDTickTimer.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDTickTimer.h"

@interface TDTickTimer()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation TDTickTimer

- (void)dealloc{
    [self stopTick];
}

-(void)tickTime:(NSTimeInterval)time tickBlock:(TickBlock)tickBlock finishBlock:(TickFinishBlock) finishBlock{
    __block NSTimeInterval timeout = time;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    HANKWEAKSELF
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(weakSelf.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                kHankCallBlock(finishBlock);
                if(finishBlock){
                    finishBlock();
                }
            });
        }else{
            timeout--;
            dispatch_async(dispatch_get_main_queue(), ^{
                kHankCallBlock(tickBlock,timeout);
            });
        }
    });
    dispatch_resume(_timer);
}

-(void)stopTick{
    dispatch_source_cancel(_timer);
}

@end
