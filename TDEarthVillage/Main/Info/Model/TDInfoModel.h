//
//  TDInfoModel.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/17.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseModel.h"

/*
 "id": "1",
 "createDate": "2017-07-17",
 "title": "深圳",
 "logo": "1.jpg",
 "context": "43242411111111"
 */

@interface TDInfoModel : TDBaseModel


@property (nonatomic, copy) NSString *TDID;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *context;


@end
