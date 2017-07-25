//
//  UIView+TDBadge.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDBadgeProtocol.h"

@interface UIView (TDBadge)

@property (nonatomic, strong) UILabel *badge;
@property (nonatomic, strong) UIFont *badgeFont;
@property (nonatomic, strong) UIColor *badgeBgColor;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, assign) CGRect badgeFrame;

@property (nonatomic, assign) CGPoint  badgeCenterOffset;
@property (nonatomic, assign) BadgeAnimType aniType;
@property (nonatomic, assign) NSInteger badgeMaximumBadgeNumber;

- (void)showBadge;
- (void)showBadgeWithStyle:(BadgeStyle)style
                     value:(NSInteger)value
             animationType:(BadgeAnimType)aniType;
- (void)clearBadge;
- (void)resumeBadge;

@end
