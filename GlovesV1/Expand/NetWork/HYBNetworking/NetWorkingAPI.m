//
//  NetWorkingAPI.m
//  BaseAppStruct
//
//  Created by HaviLee on 2016/10/21.
//  Copyright © 2016年 Havi. All rights reserved.
//

#import "NetWorkingAPI.h"

@implementation NetWorkingAPI
static NetWorkingAPI *_netWorkClient;

+ (instancetype)sharedJSONClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _netWorkClient = [[NetWorkingAPI alloc]init];
//        [_netWorkClient initAllRequestParams];
    });
    return _netWorkClient;
}

//初始化所有参数
- (void)initAllRequestParams
{
    //设置baseUrl
    [HYBNetworking updateBaseUrl:kAppBaseURL];
    //请求取消时间
    [HYBNetworking setTimeout:30];
    //设置没有网络的时候从本地读取数据
    [HYBNetworking obtainDataFromLocalWhenNetworkUnconnected:YES];
    //缓存get请求，
    [HYBNetworking cacheGetRequest:YES shoulCachePost:NO];
    //debug模式。放心使用，使用debug
    [HYBNetworking enableInterfaceDebug:YES];
    //配置请求和接受格式，json
    [HYBNetworking configRequestType:kHYBRequestTypeJSON responseType:kHYBResponseTypeJSON shouldAutoEncodeUrl:NO callbackOnCancelRequest:YES];
    //配置请求头
    [HYBNetworking configCommonHttpHeaders:@{
                                             @"AccessToken" : kAccessTocken,
                                             @"Accept":@"application/json"
                                             }];
}

- (void)updateBaseUrl:(NSString *)baseUrl
{
    [HYBNetworking updateBaseUrl:baseUrl];
}
- (NSString *)baseUrl
{
    return [HYBNetworking baseUrl];
}

- (void)setTimeout:(NSTimeInterval)timeout
{
    [HYBNetworking setTimeout:timeout];
}

- (void)obtainDataFromLocalWhenNetworkUnconnected:(BOOL)shouldObtain
{
    [HYBNetworking obtainDataFromLocalWhenNetworkUnconnected:shouldObtain];
}

- (void)cacheGetRequest:(BOOL)isCacheGet shoulCachePost:(BOOL)shouldCachePost
{
    [HYBNetworking cacheGetRequest:isCacheGet shoulCachePost:shouldCachePost];
}

- (unsigned long long)totalCacheSize
{
   return [HYBNetworking totalCacheSize];
}

- (void)autoToClearCacheWithLimitedToSize:(NSUInteger)mSize
{
    [HYBNetworking autoToClearCacheWithLimitedToSize:mSize];
}

- (void)clearCaches
{
    [HYBNetworking clearCaches];
}

- (void)enableInterfaceDebug:(BOOL)isDebug
{
    [HYBNetworking enableInterfaceDebug:isDebug];
}

- (void)configRequestType:(HYBRequestType)requestType
             responseType:(HYBResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest
{
    [HYBNetworking configRequestType:requestType responseType:responseType shouldAutoEncodeUrl:shouldAutoEncode callbackOnCancelRequest:shouldCallbackOnCancelRequest];
}

- (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders
{
    [HYBNetworking configCommonHttpHeaders:httpHeaders];
}

- (void)cancelAllRequest
{
    [HYBNetworking cancelAllRequest];
}

- (void)cancelRequestWithURL:(NSString *)url
{
    [HYBNetworking cancelRequestWithURL:url];
}

#pragma mark 业务需求

//获取服务器时间
- (void)requestServerTimeWithBlock:(void (^)(ServerTimeModel *serVerTime))success fail:(void (^)(NSError *error))fail
{
    NSString *aPath = @"v1/app/GetServerTime";
    [HYBNetworking getWithUrl:aPath refreshCache:YES success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        ServerTimeModel *serverModel = [ServerTimeModel modelWithDictionary:dic];
        success(serverModel);
    } fail:^(NSError *error) {
        fail(error);
    }];
}

//获取用户信息
- (void)requestUserInfoWithParam:(NSDictionary *)params andBlock:(void (^)(UserInfoDetailModel *userInfo))success fail:(void (^)(NSError *error))fail
{
    NSString *aPath = @"v1/user/UserInfo";
    [HYBNetworking getWithUrl:aPath refreshCache:YES params:params success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        UserInfoDetailModel *userInfoModel = [UserInfoDetailModel modelWithDictionary:dic];
        success(userInfoModel);
    } fail:^(NSError *error) {
        fail(error);
    }];
}

@end
