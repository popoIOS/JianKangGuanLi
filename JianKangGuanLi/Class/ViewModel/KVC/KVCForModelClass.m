//
//  KVCForModelClass.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/30.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "KVCForModelClass.h"
#import "FamliyMemberModel.h"

@implementation KVCForModelClass


#pragma mark------- KVC为家庭成员赋值
+(NSMutableArray *)KVCForFamilyMemberModel:(NSArray *)arry{

    NSMutableArray *arryMemberFamily = [NSMutableArray array];
    for (NSDictionary *dic in arry) {
        FamliyMemberModel *family = [[FamliyMemberModel alloc]init];
        for (NSString *key in [dic allKeys]) {
            [family setValue:[dic objectForKey:key] forKey:key];
        }
        [arryMemberFamily addObject:family];
    }
    return arryMemberFamily;
}

@end
