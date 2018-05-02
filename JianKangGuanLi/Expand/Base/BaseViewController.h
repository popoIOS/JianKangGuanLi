//
//  BaseViewController.h
//  TheSecondProject
//
//  Created by ydz on 17/2/14.
//  Copyright © 2017年 贾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomView.h"
@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL netConnecting;
@property (nonatomic, strong) BottomView *bottom;

-(void)netIsConnected;

@end
