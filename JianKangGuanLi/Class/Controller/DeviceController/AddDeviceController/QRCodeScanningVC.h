//
//  QRCodeScanningVC.h
//  SGQRCodeExample
//
//  Created by apple on 17/3/21.
//  Copyright © 2017年 JP_lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGQRCode.h"

@protocol ScaningCodeDelegate <NSObject>

-(void)scaningCodeReturnString:(NSString *)string;

@end

@interface QRCodeScanningVC : SGQRCodeScanningVC

@property (nonatomic, assign) id<ScaningCodeDelegate> delegate;

@end
