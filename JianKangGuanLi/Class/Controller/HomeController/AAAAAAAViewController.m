//
//  AAAAAAAViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/4/19.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "AAAAAAAViewController.h"
#import "POP.h"
@interface AAAAAAAViewController ()
{
    UIView *viewbg;
}
@end

@implementation AAAAAAAViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    viewbg = [[UIView alloc]init];
    viewbg.center = self.view.center;
    viewbg.layer.cornerRadius = 50;
    viewbg.layer.masksToBounds = YES;
    viewbg.bounds = CGRectMake(0, 0, 100, 100);
    viewbg.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:viewbg];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
    [viewbg addGestureRecognizer:tap];
    
}


-(void)onTap{

    
    
}


-(void)aa{

    CGFloat centerX = viewbg.bounds.size.width/2;
    CGFloat centerY = viewbg.bounds.size.height/2;
    CGFloat maxY = viewbg.bounds.size.height;
//    CGFloat maxX = viewbg.bounds.size.width;
    CGFloat minY = 0;
//    CGFloat minX = 0;
    
    UIBezierPath *berpath = [UIBezierPath bezierPath];
    [berpath addArcWithCenter:CGPointMake(centerX, centerY) radius:50 startAngle:M_PI/2 endAngle:M_PI*3/2 clockwise:YES];
    [berpath addCurveToPoint:CGPointMake(centerX, centerY) controlPoint1:CGPointMake(centerX, minY) controlPoint2:CGPointMake(centerX/2, centerY/2)];
    [berpath addCurveToPoint:CGPointMake(centerX, maxY) controlPoint1:CGPointMake(centerX, centerY) controlPoint2:CGPointMake(centerX/2+centerX, maxY-centerY/2)];
    [berpath closePath];
//    [berpath moveToPoint:CGPointMake(0, viewbg.bounds.size.height/2)];
//    [berpath addLineToPoint:CGPointMake(viewbg.bounds.size.width, viewbg.bounds.size.height/2)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = berpath.CGPath;
    layer.strokeColor = [UIColor blueColor].CGColor;
    layer.fillColor = [UIColor redColor].CGColor;
    [viewbg.layer addSublayer:layer];
    
    [self creatLeftArc];
    
}

-(void)creatLeftArc{

    POPBasicAnimation *pop = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    pop.beginTime = CACurrentMediaTime();
    pop.duration = 3;
//    pop.toValue = @M_PI;
    pop.fromValue = @(M_PI*2);
    pop.toValue = @(0);
    pop.repeatCount = HUGE_VALF;

    [viewbg.layer pop_addAnimation:pop forKey:@"asd"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
