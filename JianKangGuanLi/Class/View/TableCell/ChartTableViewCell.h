//
//  ChartTableViewCell.h
//  TheSecondProject
//
//  Created by ydz on 17/2/15.
//  Copyright © 2017年 贾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartTableViewCell : UITableViewCell

@property (nonatomic, strong) JHColumnChart *column;
@property (nonatomic, strong) JHLineChart *lineChart;

-(void)getDataFromTable:(NSIndexPath *)indexPath dataSourceY:(NSArray *)arrSourcey dataSourceX:(NSArray *)arrSourcex;
@end
