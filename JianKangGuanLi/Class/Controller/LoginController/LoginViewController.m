//
//  LoginViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/23.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "LoginViewController.h"
#import "CeShiViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textUserNum;
@property (weak, nonatomic) IBOutlet UITextField *textUserPassWord;
@property (weak, nonatomic) IBOutlet UIView *btn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    
    [self setDefaultDataForLogin];
    // Do any additional setup after loading the view from its nib.
}

-(void)setNav{
    self.title = @"登录";
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

-(void)setDefaultDataForLogin{
    if ([DEFAULTS objectForKey:LOGINID_USER]) {
        _textUserNum.text = [DEFAULTS objectForKey:LOGINID_USER];
    }
}

#pragma mark------------去登录
- (IBAction)onClickToLogin:(id)sender {
    if ([self.textUserNum.text isEqualToString:@""]) {
        SHOWALERTVIEW(@"请输入账号");
    }else if ([self.textUserPassWord.text isEqualToString:@""]){
        SHOWALERTVIEW(@"请输入密码");
    }else{
        [self.view endEditing:YES];
        [self goToLogin];
    }
}

-(void)goToLogin{
    
    NSDictionary *para = @{@"loginId":self.textUserNum.text,@"password":self.textUserPassWord.text};
    [RequestManger postWithUrl:URL_USER_GOTOLOGIN Header:nil Param:para ShowProgress:self Tip:@"登录成功" Success:^(id responsed) {
        
        NSDictionary *dic = (NSDictionary *)responsed;
        [DEFAULTS setObject:dic[LOGINID_USER] forKey:LOGINID_USER];
        [DEFAULTS setObject:dic[TEL_USER] forKey:TEL_USER];
        [DEFAULTS setObject:dic[USERNAME_USER] forKey:USERNAME_USER];
        [DEFAULTS setObject:[NSString stringWithFormat:@"%@",dic[ID_USER]] forKey:ID_USER];
        [DEFAULTS setObject:dic[VERITIFYCODE_USER] forKey:VERITIFYCODE_USER];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[KVCForModelClass KVCForFamilyMemberModel:dic[MEMBERLIST_USER]]];
        [DEFAULTS setValue:data forKey:MEMBERLIST_USER];
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];

    } Fail:^(NSError *error) {
          
    }];
}
-(void)dealloc{}
#pragma mark------------忘记密码
- (IBAction)onClickResetPassword:(id)sender {
}
#pragma mark------------去注册
- (IBAction)onClickRegise:(id)sender {
    [self presentViewController:[CeShiViewController new] animated:YES completion:nil];;
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
