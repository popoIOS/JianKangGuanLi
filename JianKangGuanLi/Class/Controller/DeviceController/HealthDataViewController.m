//
//  HealthDataViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/23.
//  Copyright © 2017年 yzd. All rights reserved.
//


#import "HealthDataViewController.h"
#import "ChartTableViewCell.h"
#import "CLCircle.h"
#import "BlueThoothPackViewController.h"
#import "AddDeviceControllerViewController.h"
#import "ManualOperationViewController.h"
#import "MeasurementBloodViewController.h"


#define identifyCell @"cellChart"

@interface HealthDataViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *btnTitle;
    NSArray *arryForFamilyMemeber;
}
@property (weak, nonatomic) IBOutlet UITableView *tableChart;
/*
 表头
 */
@property (strong, nonatomic) IBOutlet UIView *tableHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnToday;
@property (weak, nonatomic) IBOutlet UIButton *btnYesterday;
@property (weak, nonatomic) IBOutlet UIButton *btnBeforeTesterday;
@property (weak, nonatomic) IBOutlet UILabel *lableSign;
/*
 存贮数据数组
 */
@property (nonatomic, strong) NSDate *newdate;

@property (nonatomic, strong) NSMutableArray *arraySourceY;
@property (nonatomic, strong) NSMutableArray *arraySourceX;
@end

@implementation HealthDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arraySourceY = [NSMutableArray array];
    self.arraySourceX = [NSMutableArray array];
    [self setTableHeaderViewCircle];
    [self setTable];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self getData:[self isNSULLNewDate] Type:@"1"];
    [self setNav];

}

-(NSDate *)isNSULLNewDate{
    if (!self.newdate) {
        self.newdate = [NSDate date];
    }
    return self.newdate;
}

-(void)setNav{

    if ([DEFAULTS objectForKey:MEMBERLIST_USER]) {
        arryForFamilyMemeber = [NSKeyedUnarchiver unarchiveObjectWithData:[DEFAULTS objectForKey:MEMBERLIST_USER]];

    }
    btnTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTitle.frame = self.navigationItem.titleView.frame;
    if (arryForFamilyMemeber.count>0) {
        FamliyMemberModel *member = arryForFamilyMemeber[0];
        [btnTitle setTitle:member.name  forState:UIControlStateNormal];
    }else{
        [btnTitle setTitle:@"请选择成员" forState:UIControlStateNormal];
    }
    [btnTitle addTarget:self action:@selector(onClickChooseMember) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btnTitle ;
    self.tabBarController.tabBar.hidden = NO;

}

#pragma mark-----选择家庭成员
-(void)onClickChooseMember{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择家庭成员" preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (FamliyMemberModel *member in arryForFamilyMemeber) {
        [alert addAction:[UIAlertAction actionWithTitle:member.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [btnTitle setTitle:member.name  forState:UIControlStateNormal];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark-----设置表头

-(void)setTableHeaderViewCircle{
    CLCircle *c = [[CLCircle alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 200)];
    c.colorList = [ NSArray  arrayWithObjects :( id )[[ UIColor  yellowColor ] CGColor ],[( id )[UIColor redColor] CGColor] ,[[UIColor blueColor] CGColor], nil ];
    
    [self.tableHeader addSubview:c];
    
    UIButton *btnAddDevice = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAddDevice setImage:[UIImage imageNamed:@"shopAdd"] forState:UIControlStateNormal];
    btnAddDevice.frame = CGRectMake((SCREEN_WIDTH-40)/2, SCREEN_HEIGHT-40-60, 30, 30);
    btnAddDevice.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnAddDevice addTarget:self action:@selector(onBtnAddDevice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAddDevice];
}


#pragma mark-----已连接设备
- (IBAction)onClickToConnectDevice:(id)sender {
    
    AddDeviceControllerViewController *addDevice = [[AddDeviceControllerViewController alloc] init];
    addDevice.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addDevice animated:YES];
    
}

#pragma mark-----获取数据

-(void)getData:(NSDate *)date Type:(NSString *)t{

    __weak typeof(self) weakSelf = self;
    NSDictionary *para = @{@"Type":t,@"Memberid":[NSString stringIsNSULL:[DEFAULTS objectForKey:ID_USER]],@"EquipmentId":@"-1",@"CreateDate":[[Singleton shareDateFormatter] stringFromDate:date]};
    [RequestManger postWithUrl:URL_GERDATAFROMDEVICE_BLUETHOOTH Header:HEADERDIC_VERIFYCODE Param:para ShowProgress:self Tip:@"获取数据成功" Success:^(id responsed) {
        if ([t isEqualToString:@"1"]) {
            [self.arraySourceX removeAllObjects];
            [self.arraySourceY removeAllObjects];
            [Singleton handleDataFromBloodAddHeartRate:(NSArray *)responsed IsBooldAndHearRate:BloodPresure Sucess:^(NSMutableArray *aryX, NSMutableArray *arryY) {
                [weakSelf.arraySourceY addObject:arryY];
                [weakSelf.arraySourceX addObject:aryX];
                [weakSelf getData:date Type:@"2"];
                
            }];
        }else {
            [Singleton handleDataFromBloodAddHeartRate:(NSArray *)responsed IsBooldAndHearRate:HearRate Sucess:^(NSMutableArray *aryX, NSMutableArray *arryY) {
                [weakSelf.arraySourceY addObject:arryY];
                [weakSelf.arraySourceY insertObject:@[@[@12],@[@22],@[@1],@[@21],@[@19]] atIndex:0];
                [weakSelf.arraySourceX addObject:aryX];
                [weakSelf.tableChart reloadData];
                
            }];
        }
        
    } Fail:^(NSError *error) {
        
    }];
}

#pragma mark-----设置表UI

-(void)setTable{
    self.tableChart.tableHeaderView = self.tableHeader;
    [self.tableChart registerNib:[UINib nibWithNibName:@"ChartTableViewCell" bundle:nil] forCellReuseIdentifier:identifyCell];
}

#pragma mark-----TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifyCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell getDataFromTable:indexPath dataSourceY:self.arraySourceY dataSourceX:self.arraySourceX];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BlueThoothPackViewController *blue = [[BlueThoothPackViewController alloc]init];
    blue.type = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    blue.selectedDate = [self isNSULLNewDate];
    blue.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:blue animated:YES];
}

#pragma mark-----切换日期

- (IBAction)onBtnClickChangeDay:(UIButton *)sender {
    

    NSDateComponents *com = [[NSDateComponents alloc]init];
    if (sender.tag == 10001) {

    }else if(sender.tag ==  10002){
        com.day = -1;
    }else if(sender.tag ==  10003){
        com.day = -2;
    }
    NSCalendar *calend = [NSCalendar currentCalendar];
    self.newdate = [calend dateByAddingComponents:com toDate:[NSDate date] options:NSCalendarMatchStrictly];
    [self getData:self.newdate Type:@"1"];
    
    CGPoint point = sender.center;
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint signPoint = self.lableSign.center;
        signPoint.x = point.x;
        self.lableSign.center = signPoint;
    }];
}

#pragma mark-----新增设备
-(void)onBtnAddDevice{
    
    ManualOperationViewController *manual = [[ManualOperationViewController alloc]init];
    manual.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:manual animated:YES];
    
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
