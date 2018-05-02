//
//  CeShiViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/4/7.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "CeShiViewController.h"
#import "pop.h"

@interface CeShiViewController ()<POPAnimationDelegate>
{
    CAShapeLayer *toplayer;
    CAShapeLayer *bottomlayer;
}
@property (weak, nonatomic) IBOutlet UILabel *lblCeShi;

@end

@implementation CeShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblCeShi.alpha = 0;
    [self huaUp];
    [self huaDown];
    [self stat];
}

-(void)huaUp{
    UIBezierPath *bezier = [[UIBezierPath alloc]init];
    [bezier moveToPoint:CGPointMake(0, 0)];
    [bezier addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];
    [bezier addLineToPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2.0)];

    [bezier addCurveToPoint:CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0) controlPoint1: CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2) controlPoint2: CGPointMake(SCREEN_WIDTH/4*3, SCREEN_HEIGHT/2+60)];
    [bezier addCurveToPoint:CGPointMake(0, SCREEN_HEIGHT/2) controlPoint1: CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0) controlPoint2: CGPointMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/2-60)];

    [bezier closePath];

    //创建一个CAShapeLayer，将绘制的贝斯尔曲线的path给CAShapeLayer
    toplayer = [CAShapeLayer layer];
    toplayer.path = bezier.CGPath;
    //给topLayer设置contents为启动图
    toplayer.fillColor = [[UIColor yellowColor]CGColor];

    toplayer.contents = [UIImage imageNamed:@"d2_h"];
    toplayer.frame = self.view.frame;
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:toplayer];
    //将绘制后的CAShapeLayer做为topLayer的mask
}

-(void)huaDown{
    UIBezierPath *bezier = [[UIBezierPath alloc]init];
    [bezier moveToPoint:CGPointMake(0,SCREEN_HEIGHT/2)];
    [bezier addCurveToPoint:CGPointMake(SCREEN_WIDTH/2.0,SCREEN_HEIGHT/2.0) controlPoint1: CGPointMake(0,SCREEN_HEIGHT/2)  controlPoint2: CGPointMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/2-60)];
    [bezier addCurveToPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2)  controlPoint1: CGPointMake(SCREEN_WIDTH/2.0,SCREEN_HEIGHT/2.0)  controlPoint2: CGPointMake(SCREEN_WIDTH/4*3, SCREEN_HEIGHT/2+60)];
    [bezier addLineToPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    [bezier addLineToPoint:CGPointMake(0, SCREEN_HEIGHT)];

    [bezier closePath];
    
    //创建一个CAShapeLayer，将绘制的贝斯尔曲线的path给CAShapeLayer
    bottomlayer = [CAShapeLayer layer];
    bottomlayer.path = bezier.CGPath;
    bottomlayer.fillColor = [[UIColor redColor]CGColor];
    //给topLayer设置contents为启动图
    bottomlayer.contents = [UIImage imageNamed:@"d2_h"];
    bottomlayer.frame = self.view.frame;
    
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:bottomlayer];
    //将绘制后的CAShapeLayer做为topLayer的mas
}

-(void)stat{
    POPBasicAnimation *anTop = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anTop.beginTime = CACurrentMediaTime();
    anTop.toValue = @(-120);
    anTop.duration = 3;
    anTop.delegate = self;
    [toplayer pop_addAnimation:anTop forKey:@"an"];
    
    POPBasicAnimation *anBottom = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anBottom.beginTime = CACurrentMediaTime();
    anBottom.toValue = @(SCREEN_HEIGHT);
    anBottom.duration = 3;
    [bottomlayer pop_addAnimation:anBottom forKey:@"asdfn"];

    POPBasicAnimation *anAlp = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anAlp.beginTime = CACurrentMediaTime();
    anAlp.toValue = @(1);
    anAlp.duration = 3;
    [self.lblCeShi pop_addAnimation:anAlp forKey:@"asd"];
}

-(void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished{
    if (finished == YES) {
        [bottomlayer removeFromSuperlayer];
        [toplayer removeFromSuperlayer];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(void)dealloc{}

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
