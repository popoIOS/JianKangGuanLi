//
//  FamilyPersonalViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/28.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "FamilyPersonalViewController.h"
#import "FamilyPersonalTableViewCell.h"
#import "WapForFamilyViewController.h"
#import "AuthorzieFamilyViewController.h"

#define IDENTIFYFORCELL @"FamilyPersonalIdentifyCell"

@interface FamilyPersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arryDataForFamily;
}
@property (weak, nonatomic) IBOutlet UITableView *tableViewFamily;

@end

@implementation FamilyPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNav];
    [self setTable];
    [self setNotify];
}

-(void)setNav{
    self.title  = @"家庭成员";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(onClickForAddNewPersonal)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)setTable{
    self.tableViewFamily.rowHeight = UITableViewAutomaticDimension;
    self.tableViewFamily.estimatedRowHeight = 300;
    [self.tableViewFamily registerNib:[UINib nibWithNibName:@"FamilyPersonalTableViewCell" bundle:nil] forCellReuseIdentifier:IDENTIFYFORCELL];

    if ([DEFAULTS objectForKey:MEMBERLIST_USER]) {
        arryDataForFamily = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[DEFAULTS objectForKey:MEMBERLIST_USER]]];
        
    }
}

-(void)setNotify{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onReceviceAutify:) name:NOTYFYFORAUTIFYFAMILY object:nil];
}

#pragma mark----新增家庭成员
-(void)onClickForAddNewPersonal{

    [self.navigationController pushViewController:[WapForFamilyViewController new] animated:YES];
    
}

#pragma mark----获取授权
-(void)onReceviceAutify:(NSNotification *)notify{
    FamilyPersonalTableViewCell *cell  = (FamilyPersonalTableViewCell *)notify.object;
    NSIndexPath *index = [self.tableViewFamily indexPathForCell:cell];
    
    AuthorzieFamilyViewController *auth = [[AuthorzieFamilyViewController alloc]init];
    auth.member = arryDataForFamily[index.row];;
    [self.navigationController pushViewController:auth animated:YES];
}

#pragma mark----TableViewDelaget
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arryDataForFamily.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    FamilyPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFYFORCELL forIndexPath:indexPath];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    if (arryDataForFamily.count>0) {
        FamliyMemberModel *member = arryDataForFamily[indexPath.row];
        [cell setCellDataFromTable:member];
    }
    
    return cell;
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
