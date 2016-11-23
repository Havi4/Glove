//
//  MineService.m
//  ZZHTabStruct
//
//  Created by HaviLee on 2016/10/25.
//  Copyright © 2016年 Havi. All rights reserved.
//

#import "MineService.h"
#import "UserInfoDetailModel.h"

@implementation MineService

- (void)requestWithParameters:(NSDictionary *)parameters success:(MIRequestSuccessBlock)success fail:(MIRequestFailBlock)fail
{
    NetWorkingAPI *client = [NetWorkingAPI sharedJSONClient];
    
    [client requestUserInfoWithParam:parameters andBlock:^(UserInfoDetailModel *userInfo) {
        success(userInfo);
    } fail:^(NSError *error) {
        fail(nil,error);
    }];
}

- (void)dealloc {
    DeBugLog(@"%s", __FUNCTION__);
}

@end
