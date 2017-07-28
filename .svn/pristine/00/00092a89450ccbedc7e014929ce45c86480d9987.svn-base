//
//  THTTPRequestOperationManager.m
//  我要留学
//
//  Created by Hank on 10/13/16.
//  Copyright © 2016 深圳市智联天下国际教育有限公司. All rights reserved.
//

#import "THTTPRequestOperationManager.h"
#import "ZLRequestResponse.h"

NSString *const kServerFailure = @"网络存在异常...";
NSString *const kServerError = @"服务器无法连接";

@implementation THTTPRequestOperationManager

+ (void)showNetErrorMessage{
    MBProgressHUD *hud = [MBProgressHUD showMessage:kServerFailure toView:nil];
    [hud hideAnimated:YES afterDelay:1.0f];
}

// 检测网络连接状态
+ (BOOL)reachability{
    __block BOOL _isError = NO;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    HANKWEAKSELF
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        HANKSTRONGSELF
        switch (status){
             case AFNetworkReachabilityStatusUnknown:
                _isError = YES;
                [strongSelf showNetErrorMessage];
                break;
             case AFNetworkReachabilityStatusNotReachable:
                [strongSelf showNetErrorMessage];
                _isError = YES;
                break;
             case AFNetworkReachabilityStatusReachableViaWWAN:
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 break;
             default:
                 break;
         }
     }];
    return _isError;
}

- (instancetype)init{
    if([super init]){
        _isAddCommonParameter = NO;
    }
    return self;
}

#pragma mark - POST

#pragma mark -POST请求

- (void)postWithParameter:(NSDictionary *)parameter strUrl:(NSString *)strUrl success:(RequestResponse)success
                              failure:(kHankObjBlock)failure{
    [self postWithUrlStr:strUrl parameter:parameter success:success failure:failure];
}

- (void)postWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
               success:(RequestResponse)success failure:(kHankObjBlock)failure{
    [self postWithUrlStr:urlStr parameter:parameter hudAddedToView:nil success:success failure:failure];
}

#pragma mark- 所有POST请求最终调此函数

- (void)postWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
        hudAddedToView:(UIView *)view success:(RequestResponse)success
               failure:(kHankObjBlock)failure
{
    if([THTTPRequestOperationManager reachability]){
        return;
    }
    if(view) [MBProgressHUD showHUDAddedTo:view animated:YES];
    NSDictionary *dicParameter = [self dicParameterWithDic:parameter];
    NSLog(@"dicParameter = %@",dicParameter);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self customProcessingForManager:manager];//设置相应内容类型
    [manager POST:urlStr parameters:dicParameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if(view) [MBProgressHUD hideHUDForView:view animated:YES];
        [self requestResponse:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(view) [MBProgressHUD hideHUDForView:view animated:YES];
        kHankCallBlock(failure,error);
    }];
}

- (void)postWithUrlStr:(NSString *)urlStr
             parameter:(NSDictionary *)parameter
              data:(NSData *)data
      showProgressView:(UIView *)view
               success:(RequestResponse)success
               failure:(kHankObjBlock)failure{
    if([THTTPRequestOperationManager reachability]){
        return;
    }
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progress.dimBackground = YES;
    progress.mode = MBProgressHUDModeAnnularDeterminate;
    NSLog(@"dicParameter = %@",parameter);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 8;
    [manager POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"headPicFile" mimeType:@"image/png"];
    }progress:^(NSProgress *uploadProgress){
        NSLog(@"进度= %f",uploadProgress.fractionCompleted);
        progress.progress = uploadProgress.fractionCompleted;
    }success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"responseObject = %@",dic);
        [self requestResponse:dic success:^(ZLRequestResponse *responseObject) {
            progress.label.text = @"上传成功";
            [progress hideAnimated:YES];
            kHankCallBlock(success,responseObject);
        } failure:^(id object) {
            progress.label.text = @"上传失败";
            [progress hideAnimated:YES];
            kHankCallBlock(failure,object);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        progress.label.text = @"上传失败";
        [progress hideAnimated:YES];
        kHankCallBlock(failure,error);
    }];
}

#pragma mark - GET

#pragma mark- 所有Get请求最终调此函数


- (void)getWithParameter:(NSDictionary *)parameter strUrl:(NSString *)strUrl success:(RequestResponse)success
                             failure:(kHankObjBlock)failure{
    [self getWithUrlStr:strUrl parameter:parameter success:success failure:failure];
}

- (void)getWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
              success:(RequestResponse)success failure:(kHankObjBlock)failure{
    [self getWithUrlStr:urlStr parameter:parameter hudAddedToView:nil success:success failure:failure];
}

- (void)getWithUrlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter
       hudAddedToView:(UIView *)view success:(RequestResponse)success
              failure:(kHankObjBlock)failure{
    if(view) [MBProgressHUD showHUDAddedTo:view animated:YES];
    NSDictionary *dicParmeter = [self dicParameterWithDic:parameter];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self customProcessingForManager:manager];//设置相应内容类型
    [manager GET:urlStr parameters:dicParmeter progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if(view) [MBProgressHUD hideHUDForView:view animated:YES];
        [self requestResponse:responseObject success:success failure:failure];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if(view)  [MBProgressHUD hideHUDForView:view animated:YES];
        [THTTPRequestOperationManager showNetErrorMessage];
        kHankCallBlock(failure,error);
    }];
}

#pragma mark - Help

- (void)requestResponse:(id)responseObject success:(RequestResponse)success failure:(kHankObjBlock)failure{
    ZLRequestResponse *response = [[ZLRequestResponse alloc] initWithDic:responseObject];
    if([response.code isEqualToString:@"200"]){
        NSLog(@"网络请求成功");
        kHankCallBlock(success,response);
    }else{
        NSLog(@"网络请求错误 code = %@ message = %@",response.code,response.message);
        [TDPublicTools showMessage:response.message view:kHankCurrentWindow];
        kHankCallBlock(failure,response);
    }
}

//对请求进行自定义处理
- (void)customProcessingForManager:(AFHTTPSessionManager *)manager{
    
    NSMutableSet *types = [NSMutableSet setWithObjects:@"text/html",@"text/plain", nil];
    [types unionSet:manager.responseSerializer.acceptableContentTypes];
    manager.responseSerializer.acceptableContentTypes = types;
    
   
}

- (NSDictionary *)dicParameterWithDic:(NSDictionary *)parameter{
    if (!_isAddCommonParameter) {
        return kHankUnDic(parameter);
    }
    NSMutableDictionary *dicParameter = [[NSMutableDictionary alloc] initWithDictionary:kHankUnDic(parameter)];
    return dicParameter;
}



@end
