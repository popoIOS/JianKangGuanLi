//
//  BlueThoothPackViewController.h
//  TheSecondProject
//
//  Created by ydz on 17/3/7.
//  Copyright © 2017年 贾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectBlueViewController.h"

@interface BlueThoothPackViewController : ConnectBlueViewController

// 1血压  2心率
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong)NSDate *selectedDate;
@end
