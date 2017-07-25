//
//  TDBadgeProtocol.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#ifndef TDBadgeProtocol_h
#define TDBadgeProtocol_h

#define kBadgeScaleAniKey       @"scale"

static char badgeLabelKey;
static char badgeBgColorKey;
static char badgeFontKey;
static char badgeTextColorKey;
static char badgeAniTypeKey;
static char badgeFrameKey;
static char badgeCenterOffsetKey;
static char badgeMaximumBadgeNumberKey;

typedef NS_ENUM(NSUInteger, BadgeStyle)
{
    BadgeStyleRedDot = 0,
    BadgeStyleNumber,
    BadgeStyleNew,
};

typedef NS_ENUM(NSUInteger, BadgeAnimType)
{
    BadgeAnimTypeNone = 0,
    BadgeAnimTypeScale,
};


#pragma mark -- protocol definition

@protocol ZLBadgeProtocol <NSObject>

@required

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

@end

#endif /* TDBadgeProtocol_h */
