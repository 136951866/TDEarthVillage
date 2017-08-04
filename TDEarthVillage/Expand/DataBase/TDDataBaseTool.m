//
//  TDDataBaseTool.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/12.
//  Copyright © 2017年 Hank. All rights reserved.
//

/***********************
 *td_car  购物车数据表
***********************/

#import "TDDataBaseTool.h"
#import "TDShopModel.h"

@interface TDDataBaseTool (){
    FMDatabase *_database;
}

@end

@implementation TDDataBaseTool

#pragma mark - 数据库相关

- (instancetype)init{
    if (self = [super init]) {
        //初始化数据库对象 并打开
        _database = [FMDatabase databaseWithPath:[TDDataBaseTool getDataBasePath]];
        //如果数据库打开失败返回空值
        if (![_database open]) {
            NSLog(@"数据库打开失败");
            return nil;
        }
    }
    //如果数据库打开成功 创建表
    //创建搜索历史记录表
    NSString *sqlCar = @"create table if not exists td_car(carId integer primary key autoincrement,TDId text,strNum text,price text,title text,log text,userId text,type text)";
    if ([_database executeUpdate:sqlCar]) {
        NSLog(@"创建表成功！");
    }else{
        NSLog(@"创建表失败！");
    }
    return self;
}

+ (TDDataBaseTool *)sharedDataBase{
    static TDDataBaseTool *wydatase = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        wydatase = [[TDDataBaseTool alloc]init];
    });
    
    return wydatase;
}

//返回数据库的路径
+ (NSString *)getDataBasePath{
    return  kHankFilePathAtDocumentWithName(@"TDDataBaseTool.db");
}

//清空数据库
- (BOOL)deleteDatabase{
    NSString *sql = @"delete from td_car";
    if ([_database executeUpdate:sql]) {
        return YES;
    }
    return NO;
}

//关闭数据库
- (void)closeDataBase{
    if (_database) {
        [_database close];
    }
}

#pragma mark - 购物车

//向购物车中添加产品
- (BOOL)insertPdcToCarWithModel:(TDShopModel *)model{
    if ([self isExistInCarWithModel:model]) {
        NSLog(@"-->model 已经存在插入失败");
        return NO;
    }
    NSString *sql = @"insert into td_car(TDId,strNum,price,title,log,userId,type) values (?,?,?,?,?,?,?)";
    BOOL isInsertOK = [_database executeUpdate:sql,model.TDId,model.strNum,model.price,model.title,model.log,model.userId,model.type];
    if (isInsertOK) {
        NSLog(@"%@-->插入成功",model.TDId);
        return YES;
    }
    return NO;
}

//查询购物车中是否包含此产品
- (BOOL)isExistInCarWithModel:(TDShopModel *)model{
    NSString *sql = @"select * from td_car";
    FMResultSet *results = [_database executeQuery:sql];
    
    while (results.next) {
        NSString *TDId = [results stringForColumn:@"TDId"];
        NSString *userId = [results stringForColumn:@"userId"];
        if ([model.TDId isEqualToString:TDId] && [model.userId  isEqualToString:userId]) {
            return YES;
        }
    }
    return NO;
}

//获取购物车列表
- (NSArray*)getAllpdcInCarWithUserId:(NSString *)userId{
    NSString *sql = @"select * from td_car order by carId desc";
    FMResultSet *results = [_database executeQuery:sql];
    NSMutableArray *arr = [NSMutableArray array];
    while (results.next) {
        if([userId isEqualToString:[results stringForColumn:@"userId"]]){
            TDShopModel *model = [[TDShopModel alloc]init];
            model.TDId = [NSString stringWithFormat:@"%@",[results stringForColumn:@"TDId"]];
            model.strNum = [NSString stringWithFormat:@"%d",[results intForColumn:@"strNum"]];
            model.price = [NSString stringWithFormat:@"%.2f",[results doubleForColumn:@"price"]];
            model.title = [NSString stringWithFormat:@"%@",[results stringForColumn:@"title"]];
            model.log = [NSString stringWithFormat:@"%@",[results stringForColumn:@"log"]];
            model.userId = [NSString stringWithFormat:@"%@",[results stringForColumn:@"userId"]];
            model.type = [NSString stringWithFormat:@"%@",[results stringForColumn:@"type"]];
            [arr addObject:model];
        }
    }
    return arr;
}

- (NSInteger)getAllPdcNumIncarWithUserId:(NSString *)userId{
    NSString *sql = @"select * from td_car order by carId desc";
    FMResultSet *results = [_database executeQuery:sql];
    NSInteger num = 0;
    while (results.next) {
        if([userId isEqualToString:[results stringForColumn:@"userId"]]){
            num += [results intForColumn:@"strNum"];
        }
    }
    return num;
}

//修改购物车中产品的数量
- (BOOL)updataCountInCar:(NSString *)newStrNum model:(TDShopModel *)model{
    if(![self isExistInCarWithModel:model]){
        /********如果购物车中没有该产品*********/
        NSLog(@"修改购物车中产品的数量 购物车中没有该产品");
        return NO;
    }
    NSString *sql = @"update td_car set strNum = ? where TDId = ? and userId = ?";
    BOOL isOK = [_database executeUpdate:sql,newStrNum,model.TDId,model.userId];
    if (isOK) {
        NSLog(@"购物车中产品的数量成功");
        return YES;
    }
    NSLog(@"购物车中产品的数量失败");
    return NO;
}

//删除购物车产品
- (BOOL)deletePdcInCarByModel:(TDShopModel *)model{
    if(![self isExistInCarWithModel:model]){
        /********如果购物车中没有该产品*********/
        NSLog(@"修改购物车中产品的数量 购物车中没有该产品");
        return NO;
    }
    NSString *sqll = @"delete from td_car where TDId = ? and userId = ?";
    BOOL isOK = [_database executeUpdate:sqll,model.TDId,model.userId];
    if (isOK) {
        NSLog(@"删除购物车产品成功");
        return YES;
    }
    NSLog(@"删除购物车产品失败");
    return NO;
}

- (TDShopModel *)getNewsModelById:(NSString *)TDId userId:(NSString *)userId{
    NSString *sql = @"select * from td_car where TDId = ? and userId = ?";
    FMResultSet *results = [_database executeQuery:sql,TDId,userId];
    while (results.next) {
        TDShopModel *model = [[TDShopModel alloc]init];
        model.TDId = [NSString stringWithFormat:@"%@",[results stringForColumn:@"TDId"]];
        model.strNum = [NSString stringWithFormat:@"%d",[results intForColumn:@"strNum"]];
        model.price = [NSString stringWithFormat:@"%.2f",[results doubleForColumn:@"price"]];
        model.title = [NSString stringWithFormat:@"%@",[results stringForColumn:@"title"]];
        model.log = [NSString stringWithFormat:@"%@",[results stringForColumn:@"log"]];
        model.userId = [NSString stringWithFormat:@"%@",[results stringForColumn:@"userId"]];
        model.type = [NSString stringWithFormat:@"%@",[results stringForColumn:@"type"]];
        return model;
    }
    return nil;
}

@end
