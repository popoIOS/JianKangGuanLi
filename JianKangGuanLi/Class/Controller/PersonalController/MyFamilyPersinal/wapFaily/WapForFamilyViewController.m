//
//  WapForFamilyViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/28.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "WapForFamilyViewController.h"
#import "WapSuppmentViewController.h"

@interface WapForFamilyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFiledForIdentifyNum;
@end

@implementation WapForFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"绑定家庭成员";
    
}
- (IBAction)btnWapFamily:(id)sender {
    
    [self.view endEditing:YES];
    if ([self.textFiledForIdentifyNum.text isEqualToString:@""]) {
//        SHOWALERTVIEW(@"身份证号码错误");
        [ShowAlert showAlertWithMessage:@"tihsi" Message:@"sda" Buttons:@[@"确定",@"取消"] Sure:^{
            NSLog(@"");
        }];
        return;
    }
    
    WapSuppmentViewController *supp = [[WapSuppmentViewController alloc]init];
    supp.identifyNum = self.textFiledForIdentifyNum.text;
    [self.navigationController pushViewController:supp animated:YES];
    
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
