//
//  Circle.h
//  CLNetWorking
//
//  Created by hezhijingwei on 16/7/5.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CLCircleStyle) {
    
    CLCircleStyleDefault = 0, //默认是空心圆
    CLCircleStyleFill // 饼状图
};


@interface CLCircle : UIView

/**
                 ^ M_PI*3/2
                 ^
 *  开始点的坐标   |
                 |
                 |
    M_PI         |
    ---------------------------> 0 (M_PI*2)
                 |
                 |
                 |
                 |
                 |
                 |M_PI/2
 
 */
@property (nonatomic ,strong) NSArray *StartPointList;


/**
 *  对应的颜色
 */

@property (nonatomic ,strong) NSArray *colorList;

/**
 *  设置是饼状图还是空心圆
 */
@property (nonatomic, assign) CLCircleStyle style;


/**
 *  当为空心形状的图形时  设置linewidth的宽度  linewidth默认是35；
 */
@property (nonatomic, assign) CGFloat lineWidth;

@end
