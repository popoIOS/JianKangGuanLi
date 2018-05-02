//
//  Singleton.h
//  TheSecondProject
//
//  Created by ydz on 17/3/9.
//  Copyright © 2017年 贾. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BlueThoothDataType) {
    BloodPresure = 1,                         // no button type
    HearRate,
    BloodPresureAndHearRate,
};

@interface Singleton : NSObject

/*
 创建DateFormatter
 */
+(NSDateFormatter *)shareDateFormatter;


/*
 处理血压和心率数据
 */
+(void)handleDataFromBloodAddHeartRate:(NSArray *)arry IsBooldAndHearRate:(BlueThoothDataType)dataType Sucess:(void(^)(NSMutableArray *aryX,NSMutableArray *arryY))scuess;
/*
 图表线颜色
 */
+(NSArray *)arryForLineColor:(NSInteger)count Color:(UIColor *)color;
@end
