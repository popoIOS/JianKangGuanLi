//
//  ChooseDeviceViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/30.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "ChooseDeviceViewController.h"
#import "SNCodeViewController.h"
#import <objc/runtime.h>
#define IdentofyForCell @"ChooseDeviceIdentifyForCell"

@interface ChooseDeviceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arryDevice;
}

@property (weak, nonatomic) IBOutlet UITableView *tableChhoseDevice;

@end

@implementation ChooseDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTable];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataFromRequest];
}

-(void)setTable{
    self.tableChhoseDevice.rowHeight = UITableViewAutomaticDimension;
    self.tableChhoseDevice.estimatedRowHeight = 300;
    [self.tableChhoseDevice registerClass:[UITableViewCell class] forCellReuseIdentifier:IdentofyForCell];
}

-(void)getDataFromRequest{

    [RequestManger postWithUrl:URL_CHOOSEDEVICE_BLUETHOOTH Header:nil Param:nil ShowProgress:self Tip:nil Success:^(id responsed) {
        arryDevice = (NSArray *)responsed;
        [self.tableChhoseDevice reloadData];
    } Fail:^(NSError *error) {
        
    }];
    
}

#pragma mark------------TableVIewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arryDevice.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentofyForCell forIndexPath:indexPath];
    if (arryDevice.count>0) {
        NSDictionary *dic = arryDevice[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:dic[@"photo"]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SNCodeViewController *sn = [[SNCodeViewController alloc]init];
    [self.navigationController pushViewController:sn animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
