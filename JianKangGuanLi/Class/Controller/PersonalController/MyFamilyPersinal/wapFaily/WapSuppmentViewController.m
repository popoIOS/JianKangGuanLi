//
//  WapSuppmentViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/28.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "WapSuppmentViewController.h"

@interface WapSuppmentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblIdentifyNum;
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UITextField *textMedicalNum;

@end

@implementation WapSuppmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setDefaultData];

}

-(void)setDefaultData{
    self.title = @"绑定家庭成员";

    self.lblIdentifyNum.text = [NSString stringWithFormat:@"身份证号：%@",self.identifyNum];
}

- (IBAction)onClickWapSuppment:(id)sender {
    
    [self.view endEditing:YES];

    
    
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
