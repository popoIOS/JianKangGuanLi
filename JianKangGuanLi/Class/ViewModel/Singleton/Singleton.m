//
//  Singleton.m
//  TheSecondProject
//
//  Created by ydz on 17/3/9.
//  Copyright © 2017年 贾. All rights reserved.
//

#import "Singleton.h"


static NSDateFormatter *formatter = nil;

@implementation Singleton

+(NSDateFormatter *)shareDateFormatter{
    static dispatch_once_t tt;
    dispatch_once(&tt, ^{
       
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
    });
    return formatter;
}


+(void)handleDataFromBloodAddHeartRate:(NSArray *)arry IsBooldAndHearRate:(BlueThoothDataType)dataType Sucess:(void(^)(NSMutableArray *aryX,NSMutableArray *arryY))scuess{

    NSMutableArray *arryX = [NSMutableArray array];
    NSMutableArray *arryY = [NSMutableArray array];
    NSMutableArray *arrySystolic = [NSMutableArray array];
    NSMutableArray *arryDiastolic = [NSMutableArray array];
    NSMutableArray *arryHeartRate = [NSMutableArray array];
    
    for (NSDictionary *dic in arry) {
        if (dic[SYSTOLICHEIGHT] && dic[DIASTOLICLOW]) {
            [arrySystolic addObject:dic[SYSTOLICHEIGHT]];
            [arryDiastolic addObject:dic[DIASTOLICLOW]];
        }
        if (dic[HEARTRATE]) {
            [arryHeartRate addObject:dic[HEARTRATE]];
        }
        [arryX addObject:[Singleton getHoureAndMinFromCreatDate:dic[@"createDate"]]];
    }
    switch (dataType) {
        case BloodPresure:
            arryY = [NSMutableArray arrayWithArray:@[arrySystolic,arryDiastolic]];
            break;
        case HearRate:
            arryY = [NSMutableArray arrayWithArray:@[arryHeartRate]];
            break;
        case BloodPresureAndHearRate:
            arryY = [NSMutableArray arrayWithArray:@[arryHeartRate,arrySystolic,arryDiastolic]];
            break;
        default:
            break;
    }

    for (NSInteger i =0; i<7; i++) {
        if (arryX.count <= i) {
            [arryX addObject:@""];
        }
    }
    scuess(arryX,arryY);
}

+(NSString *)getHoureAndMinFromCreatDate:(NSString *)creatDate{

    NSString *str = @"";
    NSArray *arryFornbsp = [creatDate componentsSeparatedByString:@" "];
    if (arryFornbsp.count == 2) {
        NSArray *arryForHour = [arryFornbsp[1] componentsSeparatedByString:@":"];
        if (arryForHour.count==3) {
            str = [NSString stringWithFormat:@"%@:%@",arryForHour[0],arryForHour[1]];
        }
    }
    return str;
}

+(NSArray *)arryForLineColor:(NSInteger)count Color:(UIColor *)color{
    NSMutableArray *arryColor = [NSMutableArray array];
    for (NSInteger i= 0; i < count; i++) {
        [arryColor addObject:color];
    }
    return arryColor;
}
@end

