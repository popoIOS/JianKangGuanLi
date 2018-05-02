//
//  ManualOperationViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/4/1.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "ManualOperationViewController.h"

@interface ManualOperationViewController ()
//高压
@property (weak, nonatomic) IBOutlet UITextField *textSystolic;
//低压
@property (weak, nonatomic) IBOutlet UITextField *textDiastolic;
//心率
@property (weak, nonatomic) IBOutlet UITextField *heartRate;
//血糖
@property (weak, nonatomic) IBOutlet UITextField *textBloodSugar;
//测量时间
@property (weak, nonatomic) IBOutlet UITextField *textMeasureTime;

@end

@implementation ManualOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNav];

}

-(void)setNav{
    self.title = @"健康数据记录";
}

#pragma mark----确定按钮
- (IBAction)onClickSure:(id)sender {
    if ([_textSystolic.text isEqualToString:@""] && [_textSystolic.text isEqualToString:@""] && [_heartRate.text isEqualToString:@""]) {
        SHOWALERTVIEW(@"请输入数据");
        return;
    }

    NSDictionary *para = @{@"EquipmentId":@"0",@"Memberid":[NSString stringIsNSULL:[DEFAULTS objectForKey:ID_USER]],@"Diastolic":[NSString stringIsNSULL:self.textDiastolic.text],@"Systolic":[NSString stringIsNSULL:self.textSystolic.text],@"Heartrate":[NSString stringIsNSULL:self.heartRate.text]};
    [RequestManger postWithUrl:URL_UPLOADING_BLOODPRESSURE Header:HEADERDIC_VERIFYCODE Param:para ShowProgress:self Tip:@"添加数据成功" Success:^(id responsed) {
        [self.navigationController popViewControllerAnimated:YES];
    } Fail:^(NSError *error) {
        
    }];
    
    
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
