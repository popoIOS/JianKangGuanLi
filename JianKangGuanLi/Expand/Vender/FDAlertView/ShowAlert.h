//
//  ShowAlert.h
//  FDAlertViewDemo
//
//  Created by ydz on 17/4/13.
//  Copyright © 2017年 fergusding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ShowAlert : NSObject

/*
 定义地的弹出框
 */
+(void)showAlertWithMessage:(NSString *)title Message:(NSString *)msg Buttons:(NSArray *)btnArray Sure:(void(^)())sure;

/*
 定义的弹出视图
 点击按钮隐藏时   使用： 
 FDAlertView *alert = (FDAlertView *)self.superview;
 [alert hide];
 */
+(void)showAlertWithCustom:(UIView *)custom;

@end
