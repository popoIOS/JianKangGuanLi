//
//  HomeViewController.m
//  TheSecondProject
//
//  Created by ydz on 17/2/14.
//  Copyright © 2017年 贾. All rights reserved.
//

#import "HomeViewController.h"
#import "pop.h"
#import <HealthKit/HealthKit.h>
#import "ZSHealthKitManager.h"
#import "AAAAAAAViewController.h"
@interface HomeViewController ()
{
    UIButton *btnPop;
    UIButton *btnDis;
     ZSHealthKitManager *_manager;
}
@property (nonatomic, strong)UIButton *btn1;
@property (nonatomic, strong) HKHealthStore *healthStore;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    btnPop = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPop.frame = CGRectMake(100, 100, 100, 100);
    btnPop.layer.cornerRadius = 50;
    btnPop.layer.masksToBounds = YES;
    btnPop.backgroundColor = [UIColor redColor];
    [btnPop addTarget:self action:@selector(onClickPop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPop];

    btnDis = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDis.frame = CGRectMake(0, SCREEN_HEIGHT-90, 70, 70);
    btnDis.backgroundColor = [UIColor yellowColor];
    [btnDis addTarget:self action:@selector(onClickDis) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDis];
    
    _manager = [ZSHealthKitManager shareInstance];
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeDataTypes = [self dataTypesToWrite];//获取写权限
        NSSet *readDataTypes = [self dataTypesToRead];//获取写权限
        
        self.healthStore = [[HKHealthStore alloc] init];
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"fail");
            }
        }];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


-(void)netIsConnected{
    [super netIsConnected];
}

-(void)onClickPop{

//    POPBasicAnimation *spring = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
//    spring.beginTime = CACurrentMediaTime();
//    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(15, 15)];
//    spring.duration = 5;
//    [btnPop pop_addAnimation:spring forKey:@"btn1"];
//
//    POPSpringAnimation *springSc = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    springSc.beginTime = CACurrentMediaTime();
//    springSc.toValue = [NSValue valueWithCGPoint:CGPointMake(0.6, 0.6)];
//    springSc.springBounciness = 15;
//    springSc.springSpeed = 20;
//    [wind.layer pop_addAnimation:springSc forKey:@"btn1Sc"];
//    btnPop.layer.cornerRadius = [UIScreen mainScreen].bounds.size.height/2;
//修改补数
    [self recordWeight:30900 Distant:49.0];

    
    
    
}

-(void)onClickDis{
    
    [self.navigationController pushViewController:[AAAAAAAViewController new] animated:YES];
    
//    POPBasicAnimation *spring = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
//    spring.beginTime = CACurrentMediaTime();
//    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
//    spring.duration = 5;
//    [btnPop pop_addAnimation:spring forKey:@"btn1"];
    
    POPSpringAnimation *springSc = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    springSc.beginTime = CACurrentMediaTime();
    springSc.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    springSc.springBounciness = 15;
    springSc.springSpeed = 20;
    UIWindow *wind = [UIApplication sharedApplication].keyWindow;
    [wind.layer pop_addAnimation:springSc forKey:@"btn1Sc"];
//
//    
//    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//    spring.beginTime = CACurrentMediaTime();
//    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2 , self.view.center.y)];
//    spring.springBounciness = 15;
//    spring.springSpeed = 20;
//    [wind pop_addAnimation:spring forKey:@"btn1"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

- (NSSet *)dataTypesToWrite {
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    return [NSSet setWithObject:stepType];
}

- (NSSet *)dataTypesToRead {
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    return [NSSet setWithObjects:stepType , nil];
}

-(void)recordWeight:(double)step Distant:(double)distant{
    //  categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    HKQuantityType *distantType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    if ([HKHealthStore isHealthDataAvailable] ) {
        
        //步数
        HKQuantity *stepQuantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:step];
        
        HKQuantitySample *stepSample = [HKQuantitySample quantitySampleWithType:stepType quantity:stepQuantity startDate:[NSDate date] endDate:[NSDate date]];
        
        //公里数
//        HKQuantity *distantQuantity = [HKQuantity quantityWithUnit:[HKUnit unitFromString:@"km"] doubleValue:distant];
//        
//        HKQuantitySample *distantSample = [HKQuantitySample quantitySampleWithType:distantType quantity:distantQuantity startDate:[NSDate date] endDate:[NSDate date]];
        
        
//        __block typeof(self) weakSelf = self;
        [self.healthStore saveObject:stepSample withCompletion:^(BOOL success, NSError *error) {
            if (success) {
//                __block typeof(weakSelf) strongSelf = weakSelf;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"步数已加上" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                    [alert show];
                    
               
                });
                
                NSLog(@"The data has print");
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加步数失败" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                [alert show];
                NSLog(@"The error is %@",error);
            }
        }];
//        [self.healthStore saveObject:distantSample withCompletion:^(BOOL success, NSError *error) {
//            if (success) {
//                //                __block typeof(weakSelf) strongSelf = weakSelf;
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"公里已加上" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
//                    [alert show];
//                    
//                    
//                });
//                
//                NSLog(@"The data has print");
//            }else{
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"公里数失败" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
//                [alert show];
//                NSLog(@"The error is %@",error);
//            }
//        }];
    }
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
