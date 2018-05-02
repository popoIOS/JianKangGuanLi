//
//  RequestManger.m
//  TheSecondProject
//
//  Created by ydz on 17/3/9.
//  Copyright © 2017年 贾. All rights reserved.
//

#import "RequestManger.h"
#import "AFNetworking.h"


@implementation RequestManger

+(void)getWithUrl:(NSString *)url Header:(id)header Param:(id)para ShowProgress:(UIViewController *)vc Tip:(NSString *)successTip Success:(void(^)(id responsed))success Fail:(void(^)(NSError *error))fail{

    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manger.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    [manger GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+(void)postWithUrl:(NSString *)url Header:(id)header Param:(id)para ShowProgress:(UIViewController *)vc Tip:(NSString *)successTip Success:(void(^)(id responsed))success Fail:(void(^)(NSError *error))fail{

    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manger.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    NSDictionary *headerDic = (NSDictionary *)header;
    for (NSString *key in headerDic.allKeys) {
        [manger.requestSerializer setValue:headerDic[key] forHTTPHeaderField:key];
    }
    __weak typeof(vc) weakVc = vc;
    [vc showRoundProgressWithTitle:DATAFROMPROGRESS];
    [manger POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSInteger code = [dic[@"code"] integerValue];
        switch (code) {
            case 10000:
                if (successTip) {
                    [weakVc showRightWithTitle:successTip autoCloseTime:1];
                }else{
                    [weakVc hideBubble];
                }
                success(dic[@"value"]);
                break;
            case -10000:
                success(nil);
                [weakVc showErrorWithTitle:dic[@"message"] autoCloseTime:2];
                break;
            case -10004:
                [weakVc showErrorWithTitle:OUTTIMELOGIN autoCloseTime:2];
                LOGIN_OUTTIME_FORLOGIN(weakVc)
                break;
            default:
                break;
        }
                
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakVc showErrorWithTitle:FAILFROMDATA autoCloseTime:2];
        NSLog(@"%@",error);
    }];
}


@end
