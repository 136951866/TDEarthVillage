//
//  TDHomeSysTopManagerModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/17.
//  Copyright © 2017年 Hank. All rights reserved.
//  首页轮播model

#import "TDBaseModel.h"
/*
 "id": "1",
 "createDate": "2017.07.17 08:48",
 "topUrl": "http://www.baidu.com",
 "topType": 1, （1：资讯 2：村落 3：旅游线路 4：农产品）
 "topTitle": "资讯",
 "topLog": "1.jpg",
 "contentId": "1"
 */
@interface TDHomeSysTopManagerModel : TDBaseModel

@property (nonatomic, copy) NSString *TDID;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *topUrl;
@property (nonatomic, copy) NSString *topType;
@property (nonatomic, copy) NSString *topTitle;
@property (nonatomic, copy) NSString *topLog;
@property (nonatomic, copy) NSString *contentId;

@property (nonatomic, assign) TDTopManagerType type;

@end
