//
//  ConnectBlueViewController.h
//  JianKangGuanLi
//
//  Created by ydz on 17/3/27.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConnectBlueViewController : BaseViewController

@property (nonatomic, strong)NSMutableArray *arryDataSource;
@property (nonatomic, assign)BOOL isScuess;

-(void)getCBMangerState;

@end
