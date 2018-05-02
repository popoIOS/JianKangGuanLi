//
//  ShowAlert.m
//  FDAlertViewDemo
//
//  Created by ydz on 17/4/13.
//  Copyright © 2017年 fergusding. All rights reserved.
//

#import "ShowAlert.h"
#import "FDAlertView.h"

@implementation ShowAlert

+(void)showAlertWithMessage:(NSString *)title Message:(NSString *)msg Buttons:(NSArray *)btnArray Sure:(void(^)())sure{

    FDAlertView *alert1 = [[FDAlertView alloc] initWithTitle:title icon:[UIImage imageNamed:@"exclamation-icon"] message:msg buttonTitles:btnArray];
    [alert1 show];
    alert1.sureBlock = ^(){
        
        sure();
        
    };
    
}

+(void)showAlertWithCustom:(UIView *)custom{
    FDAlertView *alert = [[FDAlertView alloc] init];
    alert.contentView = custom;
    [alert show];
}

@end
