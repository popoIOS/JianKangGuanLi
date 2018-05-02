//
//  Circle.m
//  CLNetWorking
//
//  Created by hezhijingwei on 16/7/5.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLCircle.h"

@interface CLCircle ()

@property (nonatomic ,strong) UIBezierPath *bezierPath;
//外圈
@property (nonatomic,strong)CAGradientLayer *gradientLayer;


@end


@implementation CLCircle

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;

}

-(void)drawRect:(CGRect)rect{

    if (!_gradientLayer) {
        
        CAShapeLayer *arc = [CAShapeLayer layer];
        arc.path = [UIBezierPath bezierPathWithArcCenter:self.center radius:(self.frame.size.height-30)/2 startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
        arc.fillColor = [UIColor clearColor].CGColor;
        arc.strokeColor = [UIColor purpleColor].CGColor;
        arc.lineWidth = 15;
        [arc setLineDashPattern:[NSArray arrayWithObjects:@2,@2,nil]];
        
        self.gradientLayer = [CAGradientLayer layer];
        CGRect rect = self.frame;
        rect.origin.y = 0;

        self.gradientLayer.frame = CGRectMake(rect.origin.x, -30, rect.size.width, rect.size.height+30);
        self.gradientLayer.colors = @[(id)[[UIColor redColor] CGColor],(id)[[UIColor yellowColor] CGColor],(id)[[UIColor blueColor] CGColor]];
        [self.gradientLayer setLocations: @[@0.25, @0.5, @0.75  ]];
        self.gradientLayer.startPoint = CGPointMake(0,0.5);
        self.gradientLayer.endPoint = CGPointMake(1,0.5);
        self.gradientLayer.mask = arc;
        
        [self.layer addSublayer:self.gradientLayer];

    }
    
    CAShapeLayer *centerArc = [CAShapeLayer layer];

    centerArc.frame = CGRectMake(self.frame.origin.x, -30, self.frame.size.width, self.frame.size.height+30);
    
    centerArc.path = [UIBezierPath bezierPathWithArcCenter:self.center radius:(self.frame.size.height-30-30)/2 startAngle:3 * M_PI / 2 endAngle:3 * M_PI / 2 + 2 * M_PI * 0.75 clockwise:1].CGPath;
    centerArc.fillColor = [UIColor clearColor].CGColor;
    centerArc.strokeColor = [UIColor greenColor].CGColor;
    centerArc.lineWidth = 4;
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 5.0;
    drawAnimation.repeatCount         = 1.0;
    drawAnimation.removedOnCompletion = NO;
    drawAnimation.fromValue = [NSNumber numberWithInt:0];
    drawAnimation.toValue = [NSNumber numberWithInt:10];
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [centerArc addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
//    CAGradientLayer *changeLayer = [CAGradientLayer layer];
//    changeLayer.frame = self.frame;
//    changeLayer.colors = self.colors;
//    changeLayer.startPoint = CGPointMake(0,0.5);
//    changeLayer.endPoint = CGPointMake(1,0.5);
//    changeLayer.mask = centerArc;
    //  3/2  * 0.0;
    //   0   * 1/4;
    //  1/2  * 2/4
    //   1   * 3/4
    [self.layer addSublayer:centerArc];
//    self.layer.transform = CATransform3DMakeRotation(0.78, 1.0, 1.0, 0.0);
    NSString *text = [NSString stringWithFormat:@"%.2f",0.75];
    
//    self.transform = CGAffineTransformMakeRotation(-90*M_PI/180);
//    self.layer.transform = CATransform3DMakeRotation(-90*M_PI/180, 1, 1, 0);
    
    [text drawAtPoint:CGPointMake(self.frame.size.width/2-20, self.frame.size.height/2-10) withAttributes:@{          NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0],
                                                                                                                   NSForegroundColorAttributeName:[UIColor blackColor]}];

}


@end
