//
//  ChartTableViewCell.m
//  TheSecondProject
//
//  Created by ydz on 17/2/15.
//  Copyright © 2017年 贾. All rights reserved.
//

#import "ChartTableViewCell.h"


@interface ChartTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *lableNoData;
@property (weak, nonatomic) IBOutlet UILabel *lableTitle;

@property (nonatomic, strong) NSArray *arryTitle;
@end


@implementation ChartTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.arryTitle = @[@"    运动",@"    血压",@"    心率",@"    睡眠"];
    
}

-(void)getDataFromTable:(NSIndexPath *)indexPath dataSourceY:(NSArray *)arrSourcey dataSourceX:(NSMutableArray *)arrSourcex{

    if (arrSourcey.count != 3 ) {
        arrSourcey = [NSMutableArray arrayWithArray:@[@[],@[],@[]]];
        arrSourcex = [NSMutableArray arrayWithArray:@[@[],@[]]];

    }
    
    if (indexPath.row==0) {
        [self setDataWithChartWithArray:arrSourcey[indexPath.row] titleWithString:self.arryTitle[indexPath.row]];
    }else if(indexPath.row == 1){
        [self setDataWithLineChartWithArray:arrSourcey[indexPath.row] titleWithString:self.arryTitle[indexPath.row] DataSorceX:arrSourcex[indexPath.row-1]];
    }else if(indexPath.row == 2){
        [self setDataWithLineChartWithArray:arrSourcey[indexPath.row] titleWithString:self.arryTitle[indexPath.row] DataSorceX:arrSourcex[indexPath.row-1]];
    }
    
}


-(void)setDataWithChartWithArray:(NSArray *)arr titleWithString:(NSString *)title{
    
    if (self.column==nil) {
        self.column = [[JHColumnChart alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-20, 150)];
        //self.column.valueArr = arr;
        self.column.valueArr = @[@[@12],@[@22],@[@1],@[@21],@[@19]];
        self.column.originSize = CGPointMake(30, 20);
        self.column.typeSpace = (SCREEN_WIDTH-30-20-5*20)/6;
        self. column.isShowYLine = NO;
        self.column.columnWidth = 20;
        self.column.bgVewBackgoundColor = [UIColor cyanColor];
        self.column.drawTextColorForX_Y = [UIColor blackColor];
        self.column.colorForXYLine = [UIColor darkGrayColor];
        self.column.columnBGcolorsArr = @[[UIColor colorWithRed:72/256.0 green:200.0/256 blue:255.0/256 alpha:1],[UIColor greenColor],[UIColor orangeColor]];
        self.column.xShowInfoText = @[@"00:00",@"06:00",@"12:00",@"18:00",@"24:00"];
        [self.column showAnimation];
        [self.backView addSubview:self.column];
        self.lableTitle.text = title;
    }
}

-(void)setDataWithLineChartWithArray:(NSArray *)arr titleWithString:(NSString *)title DataSorceX:(NSMutableArray *)arrX{

    if (self.lineChart ==nil) {
        self.lineChart = [[JHLineChart alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-20, 150) andLineChartType:JHChartLineValueNotForEveryX];
        self.lineChart.contentInsets = UIEdgeInsetsMake(0, 25, 20, 10);
        self.lineChart.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
        self.lineChart.showYLevelLine = YES;
        self.lineChart.showYLine = NO;
        self.lineChart.showValueLeadingLine = NO;
        self.lineChart.isLineVertical = NO;

        self.lineChart.valueFontSize = 11.0;
        self.lineChart.backgroundColor = [UIColor cyanColor];
        /* color for XY axis */
        self.lineChart.xAndYLineColor = [UIColor blackColor];
        /* XY axis scale color */
        self.lineChart.xAndYNumberColor = [UIColor darkGrayColor];
        /* Dotted line color of the coordinate point */
        self.lineChart.positionLineColorArr = @[[UIColor blueColor]];
        /*        Set whether to fill the content, the default is False         */
        self.lineChart.contentFill = NO;
        /*        Set whether the curve path         */
        self.lineChart.pathCurve = YES;
        /*        Set fill color array         */
        self.lineChart.contentFillColorArr = @[[UIColor colorWithRed:0 green:1 blue:0 alpha:0.468]];
        [self.backView addSubview:self.lineChart];
        /*       Start animation        */
        self.lableTitle.text = title;
    }
    [self.lineChart clear];
    if (arr.count == 1) {
        self.lineChart.isFixedForYArrar = @[@65,@70,@75,@80,@85,@90];
    }
    self.lineChart.pointNumberColorArr = [Singleton arryForLineColor:arr.count Color:[UIColor orangeColor]];
    self.lineChart.valueLineColorArr = [Singleton arryForLineColor:arr.count Color:[UIColor orangeColor]];
    self.lineChart.pointColorArr = [Singleton arryForLineColor:arr.count Color:[UIColor orangeColor]];
    self.lineChart.xLineDataArr = arrX;
    self.lineChart.valueArr = arr;
    [self.lineChart showAnimation];


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
