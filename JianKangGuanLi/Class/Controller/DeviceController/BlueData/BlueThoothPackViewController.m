//
//  BlueThoothPackViewController.m
//  TheSecondProject
//
//  Created by ydz on 17/3/7.
//  Copyright © 2017年 贾. All rights reserved.
//

#import "BlueThoothPackViewController.h"
@interface BlueThoothPackViewController ()<UITableViewDelegate,UITableViewDataSource,CalendarViewControllerDelegate>

/*
 TableViewHeader
 */
@property (strong, nonatomic) IBOutlet UIView *tableHeader;
@property (weak, nonatomic) IBOutlet UIView *viewLineChart;
@property (nonatomic, strong) JHLineChart *lineChart;
@property (weak, nonatomic) IBOutlet UIButton *btnDate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *maxPresure;
@property (weak, nonatomic) IBOutlet UILabel *minPresure;
@property (weak, nonatomic) IBOutlet UILabel *maxDate;
@property (weak, nonatomic) IBOutlet UILabel *minDate;


/*
 数据存储
 */
@property (nonatomic, strong)NSMutableArray *arryDataForY;
@property (nonatomic, strong)NSMutableArray *arryDataForX;
@end


@implementation BlueThoothPackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTable];
    [self defaultData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getDataFromNet:[self getStrFromNSDate:self.selectedDate]];
    
}

-(void)setTable{

    [self setTableViewHeaderForLineChart];
    self.tableView.tableHeaderView = self.tableHeader;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Tablecell"];
    
    self.title = @"血压测试";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"测量" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnClickMeasure)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)defaultData{
    [self.btnDate setTitle:[self getStrFromNSDate:self.selectedDate] forState:UIControlStateNormal];
}

-(void)setTableViewHeaderForLineChart{
    if (self.lineChart == nil) {
        self.lineChart = [[JHLineChart alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-20, 150) andLineChartType:JHChartLineEveryValueForEveryX];
        self.lineChart.contentInsets = UIEdgeInsetsMake(0, 25, 20, 10);
        self.lineChart.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
        self.lineChart.showYLevelLine = YES;
        self.lineChart.showYLine = NO;
        self.lineChart.showValueLeadingLine = NO;
        self.lineChart.isLineVertical = NO;
        self.lineChart.valueFontSize = 11.0;
        self.lineChart.backgroundColor = [UIColor clearColor];
        /* Line Chart colors */
        /* Colors for every line chart*/
        /* color for XY axis */
        self.lineChart.contentFill = NO;
        /*        Set whether the curve path         */
        self.lineChart.pathCurve = YES;
        /*       Start animation        */
        [self.tableHeader addSubview:self.lineChart];
    }
    if ([self.type integerValue] == 2) {
        self.lineChart.isFixedForYArrar = @[@65,@70,@75,@80,@85,@90];
    }
    self.lineChart.xAndYNumberColor = [UIColor whiteColor];
    self.lineChart.pointNumberColorArr = [Singleton arryForLineColor:self.arryDataForY.count Color:[UIColor whiteColor]];
    self.lineChart.valueLineColorArr = [Singleton arryForLineColor:self.arryDataForY.count Color:[UIColor whiteColor]];
    self.lineChart.pointColorArr = [Singleton arryForLineColor:self.arryDataForY.count Color:[UIColor whiteColor]];
    [self.lineChart clear];
    self.lineChart.xLineDataArr = self.arryDataForX;
    self.lineChart.valueArr = self.arryDataForY;
    [self.lineChart showAnimation];

    [self setTheMaxAndMinData];
}

-(void)setTheMaxAndMinData{
    CGFloat max_value = 0.0;
    CGFloat min_value = 0.0;

    if ([self.type integerValue] == 2) {
        max_value = [[self.arryDataForY[0] valueForKeyPath:@"@max.floatValue"] floatValue];  //最大值
        min_value = [[self.arryDataForY[0] valueForKeyPath:@"@min.floatValue"] floatValue];  //最大值
    }else if ([self.type integerValue] == 1){
        max_value = [[self.arryDataForY[0] valueForKeyPath:@"@max.floatValue"] floatValue];  //最大值
        min_value = [[self.arryDataForY[1] valueForKeyPath:@"@min.floatValue"] floatValue];  //最大值
    }

    NSString *maxCreateDate;
    NSString *minCreateDate;
    for (NSDictionary *dic in self.arryDataSource) {
        if ([self.type integerValue] == 2) {
            if ([dic[HEARTRATE] floatValue] == max_value) {
                maxCreateDate = dic[@"createDate"];
            }
            if ([dic[HEARTRATE] floatValue] == min_value) {
                minCreateDate = dic[@"createDate"];
            }
        }else if ([self.type integerValue] == 1){
            if ([dic[SYSTOLICHEIGHT] floatValue] == max_value) {
                maxCreateDate = dic[@"createDate"];
            }
            if ([dic[DIASTOLICLOW] floatValue] == min_value) {
                minCreateDate = dic[@"createDate"];
            }
        }
    }
    NSString *strMax;
    NSString *strMin;

    if ([self.type integerValue] == 1) {
   
        strMax = @"最高血压";
        strMin = @"最低血压";
        
    }else if ([self.type integerValue] == 2){
        strMax = @"最高心率";
        strMin = @"最低心率";
    }
    
    
    self.maxPresure.text = [NSString stringWithFormat:@"%@:\n%.0f",[NSString stringIsNSULL:strMax],max_value];
    self.minPresure.text = [NSString stringWithFormat:@"%@:\n%.0f",[NSString stringIsNSULL:strMin],min_value];
    self.maxDate.text = [NSString stringWithFormat:@"测量时间:\n%@",[NSString stringIsNSULL:maxCreateDate]];
    self.minDate.text = [NSString stringWithFormat:@"测量时间:\n%@",[NSString stringIsNSULL:minCreateDate]];
    
}

#pragma mark--------获取数据
-(void)getDataFromNet:(NSString *)selectedDate{
    if ([self.type integerValue]==0) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSDictionary *para = @{@"Type":self.type,@"Memberid":[NSString stringIsNSULL:[DEFAULTS objectForKey:ID_USER]],@"EquipmentId":@"-1",@"CreateDate":selectedDate};
    [RequestManger postWithUrl:URL_GERDATAFROMDEVICE_BLUETHOOTH Header:HEADERDIC_VERIFYCODE Param:para ShowProgress:self Tip:nil Success:^(id responsed) {
        self.arryDataSource = [NSMutableArray arrayWithArray:(NSArray *)responsed];
         [Singleton handleDataFromBloodAddHeartRate:(NSArray *)responsed IsBooldAndHearRate:[self.type integerValue] Sucess:^(NSMutableArray *aryX, NSMutableArray *arryY) {
             weakSelf.arryDataForX = aryX;
             weakSelf.arryDataForY = arryY;
             [weakSelf setTableViewHeaderForLineChart];
             [weakSelf.tableView reloadData];

         }]  ;
        
    } Fail:^(NSError *error) {
        
    }];
}


#pragma mark--------开始测量血压
-(void)onBtnClickMeasure{

    [self getCBMangerState];
    
}

#pragma mark--------改变日期
- (IBAction)chooseDate:(id)sender {
    
    CJCalendarViewController *calendarController = [[CJCalendarViewController alloc] init];
    calendarController.view.frame = self.view.frame;
    
    calendarController.delegate = self;
    
    [self presentViewController:calendarController animated:YES completion:nil];
    
}
- (IBAction)beforDate:(id)sender {
    NSDateComponents *coml = [[NSDateComponents alloc]init];
    coml.day = -1;
    [self getNewDateFromSelectedDate:coml];
    [self getDataFromNet:[self getStrFromNSDate:self.selectedDate]];
}
- (IBAction)nextDate:(id)sender {
    
    NSDateComponents *coml = [[NSDateComponents alloc]init];
    coml.day = +1;
    [self getNewDateFromSelectedDate:coml];
    [self getDataFromNet:[self getStrFromNSDate:self.selectedDate]];
}

-(void)getNewDateFromSelectedDate:(NSDateComponents *)compl{
    NSCalendar *calend = [NSCalendar currentCalendar];
    NSDate *newDate = [calend dateByAddingComponents:compl toDate:self.selectedDate options:NSCalendarMatchStrictly];
    [_btnDate setTitle:[self getStrFromNSDate:newDate] forState:UIControlStateNormal];
    self.selectedDate = newDate;
}

-(void) CalendarViewController:(CJCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    [_btnDate setTitle:dateStr forState:UIControlStateNormal];
    self.selectedDate = [[Singleton shareDateFormatter] dateFromString:dateStr];
    [self getDataFromNet:[self getStrFromNSDate:self.selectedDate]];

}

#pragma mark--------TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arryDataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Tablecell" forIndexPath:indexPath];
    NSDictionary *dic = self.arryDataSource[indexPath.row];
    if ([dic objectForKey:SYSTOLICHEIGHT] && [dic objectForKey:DIASTOLICLOW]) {
        cell.textLabel.text = [NSString stringWithFormat:@"高压：%@   低压：%@    ",[dic objectForKey:SYSTOLICHEIGHT],[dic objectForKey:DIASTOLICLOW]];
    }else if ([dic objectForKey:HEARTRATE]){
        cell.textLabel.text = [NSString stringWithFormat:@"心率：%@",[dic objectForKey:HEARTRATE]];

    }
    return cell;
}

-(void)setIsScuess:(BOOL)isScuess{
    if (isScuess == YES) {
        [self getDataFromNet:[self getStrFromNSDate:self.selectedDate]];
    }
}

-(void)dealloc{
}

-(NSString *)getStrFromNSDate:(NSDate *)date{
    [[Singleton shareDateFormatter] setDateFormat:@"yyyy-MM-dd"];
    return [[Singleton shareDateFormatter] stringFromDate:date];
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
