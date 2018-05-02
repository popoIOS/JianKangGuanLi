//
//  PersonalViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/23.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "PersonalViewController.h"
#import "LoginViewController.h"
#import "FamilyPersonalViewController.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tablePersonal;
@property (weak, nonatomic) IBOutlet UIImageView *imageAvter;
@property (strong, nonatomic) IBOutlet UIView *viewHeader;


@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTable];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


-(void)setTable{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickToLogin)];
    [self.viewHeader addGestureRecognizer:tap];
    
    self.tablePersonal.tableHeaderView = self.viewHeader;
    [self.tablePersonal registerClass:[UITableViewCell class] forCellReuseIdentifier:@"personalCell"];
}

#pragma mark----TableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personalCell" forIndexPath:indexPath];
    cell.textLabel.text = @"我的家庭成员";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    FamilyPersonalViewController *famil = [[FamilyPersonalViewController alloc] init];
    famil.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:famil animated:YES];
    
}

#pragma mark-----去登录

-(void)onClickToLogin{
    [self.navigationController pushViewController:[LoginViewController new] animated:YES];
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
