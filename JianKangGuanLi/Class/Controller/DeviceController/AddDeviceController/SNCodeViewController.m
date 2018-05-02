//
//  SNCodeViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/28.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "SNCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeScanningVC.h"

@interface SNCodeViewController ()<ScaningCodeDelegate,UITextFieldDelegate>
{
    NSString *deviceId;
}
@property (weak, nonatomic) IBOutlet UITextField *textSNCode;
@property (weak, nonatomic) IBOutlet UIImageView *deviceImage;


@end

@implementation SNCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNav];

}

-(void)setNav{
self.title = @"添加设备";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(onClickComplant)];
    self.navigationItem.rightBarButtonItem = item;
}


#pragma mark--------TextFiledDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    deviceId = textField.text;
}

#pragma mark--------开是绑定

-(void)onClickComplant{
    [self.textSNCode resignFirstResponder];
    
    NSDictionary *para = @{@"eqId":@"",@"userId":[NSString stringIsNSULL:[DEFAULTS objectForKey:ID_USER]],@"eqMac":@"",@"eqNumber":@""};
    [RequestManger postWithUrl:URL_WAPDEVICE_BLUETHOOTH Header:HEADERDIC_VERIFYCODE Param:para ShowProgress:self Tip:@"添加成功" Success:^(id responsed) {
         
    } Fail:^(NSError *error) {
         
    }];
}

#pragma mark--------开始扫描二维码

- (IBAction)startScan:(id)sender {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {

            QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];

        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"⚠️ 警告" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC1 = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC1 addAction:alertA1];
        [self presentViewController:alertC1 animated:YES completion:nil];
    }
}

#pragma mark--------扫描返回数据
-(void)scaningCodeReturnString:(NSString *)string{
    deviceId = string;
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
