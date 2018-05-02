//
//  BaseViewController.m
//  TheSecondProject
//
//  Created by ydz on 17/2/14.
//  Copyright © 2017年 贾. All rights reserved.
//

#import "BaseViewController.h"
#import <AFNetworkReachabilityManager.h>



@interface BaseViewController ()

@property (nonatomic, assign) BOOL nowNetState;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavForBaseController];
    
    [self getTheNet];
}

-(void)setNavForBaseController{
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"后退" style:UIBarButtonItemStylePlain target:self action:@selector(onGoBack)];
        self.navigationItem.leftBarButtonItem = item;
        
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = ColorCustom(59, 175, 217, 1);
}

-(void)onGoBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.bottom = [[NSBundle mainBundle] loadNibNamed:@"BottomView" owner:nil options:nil].lastObject;
    self.bottom.frame = self.view.frame;
    self.bottom.backgroundColor = [UIColor yellowColor];
    self.bottom.hidden = YES;
    [self.view addSubview:self.bottom];

    
}


#pragma mark---------获取网络不同状态
-(void)getTheNet{
    self.nowNetState = YES;
    self.netConnecting = YES;
    
    __weak typeof(self) weakSelf = self;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (weakSelf.nowNetState == NO) {
                    weakSelf.netConnecting = YES;
                    weakSelf.nowNetState = YES;
                    [weakSelf showRightWithTitle:@"WIFI已连接" autoCloseTime:2];
                    [weakSelf netIsConnected];
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (weakSelf.nowNetState == NO) {
                    weakSelf.netConnecting = YES;
                    weakSelf.nowNetState = YES;
                    [weakSelf showRightWithTitle:@"手机网络已连接" autoCloseTime:2];
                }
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                if (weakSelf.nowNetState == YES) {
                    weakSelf.netConnecting = NO;
                    weakSelf.nowNetState = NO;
                    [weakSelf showErrorWithTitle:@"网络连接断开" autoCloseTime:2];
                }
                break;
            case AFNetworkReachabilityStatusUnknown:
                if (weakSelf.nowNetState == YES) {
                    [weakSelf showErrorWithTitle:@"当前网络未知" autoCloseTime:2];
                    weakSelf.netConnecting = NO;
                    weakSelf.nowNetState = NO;
                }
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];

}
#pragma mark-----网络重新连接
-(void)netIsConnected{

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
