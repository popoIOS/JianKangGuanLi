//
//  NSString+CategoryString.m
//  TheSecondProject
//
//  Created by ydz on 17/3/9.
//  Copyright © 2017年 贾. All rights reserved.
//

#import "NSString+CategoryString.h"

@implementation NSString (CategoryString)

#pragma mark---- 字符串判空
+(NSString *)stringIsNSULL:(NSString *)string{

    if ([string isEqualToString:@""] || string == nil) {
        return @"";
    }else{
        return string;
    }
}

#pragma mark---- 字符串分割
+(NSString *)handleDateString:(NSString *)string{

    NSArray *arry = [string componentsSeparatedByString:@" "];
    NSArray *arry1 = [arry[1] componentsSeparatedByString:@":"];
    return [NSString stringWithFormat:@"%@:%@",arry1[0],arry1[1]];
    
}

@end
