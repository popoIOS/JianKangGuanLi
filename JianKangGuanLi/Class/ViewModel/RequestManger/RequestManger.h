//
//  RequestManger.h
//  TheSecondProject
//
//  Created by ydz on 17/3/9.
//  Copyright © 2017年 贾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManger : NSObject


+(void)getWithUrl:(NSString *)url Header:(id)header Param:(id)para ShowProgress:(UIViewController *)vc Tip:(NSString *)successTip Success:(void(^)(id responsed))success Fail:(void(^)(NSError *error))fail;

+(void)postWithUrl:(NSString *)url Header:(id)header Param:(id)para ShowProgress:(UIViewController *)vc Tip:(NSString *)successTip Success:(void(^)(id responsed))success Fail:(void(^)(NSError *error))fail;

@end
