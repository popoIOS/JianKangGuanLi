//
//  AddDeviceControllerViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/23.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "AddDeviceControllerViewController.h"
#import "ChooseDeviceViewController.h"

@interface AddDeviceControllerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arryForDevice;
}
@property (weak, nonatomic) IBOutlet UITableView *tableAddDevice;

@end

@implementation AddDeviceControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTable];

    [self setNav];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataFromNet];
}

-(void)getDataFromNet{

    [RequestManger postWithUrl:URL_ALAREADYWAPDEVICE_BLUETHOOTH Header:HEADERDIC_VERIFYCODE Param:nil ShowProgress:self Tip:nil Success:^(id responsed) {
        arryForDevice = (NSArray *)responsed;
        [self.tableAddDevice reloadData];
    } Fail:^(NSError *error) {
        
    }];
    
}

-(void)setNav{
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"选择设备";

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"添加设备" style:UIBarButtonItemStylePlain target:self action:@selector(onCilckAddDevice)];
    self.navigationItem.rightBarButtonItem = item;    
}

-(void)onCilckAddDevice{

    [self.navigationController pushViewController:[ChooseDeviceViewController new] animated:YES];
    
}

#pragma mark-------设置表
-(void)setTable{
    [self.tableAddDevice registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AddDeviceCell"];
}

#pragma mark-------TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arryForDevice.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddDeviceCell" forIndexPath:indexPath];
    if (arryForDevice.count>0) {
        NSDictionary *dic = arryForDevice[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@    %@",dic[@"bindingUserName"],dic[@"eqTitle"]];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSDictionary *dic = arryForDevice[indexPath.row];
        [self unWapTheDevice:dic[@"id"]];
    }];
    return @[rowAction];
}

-(void)unWapTheDevice:(NSString *)deviceId{
    NSDictionary *para = @{@"eqId":[NSString stringIsNSULL:deviceId]};
    [RequestManger postWithUrl:URL_DELEGATEDEVICE_BLUETHOOTH Header:HEADERDIC_VERIFYCODE Param:para ShowProgress:self Tip:@"删除成功" Success:^(id responsed) {
        
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
