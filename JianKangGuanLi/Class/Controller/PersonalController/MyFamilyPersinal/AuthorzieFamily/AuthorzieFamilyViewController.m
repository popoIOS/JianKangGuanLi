//
//  AuthorzieFamilyViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/28.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "AuthorzieFamilyViewController.h"

#define IDENTIFYFORAUTHORIZECELL @"AuthorizeIdentifyCell"

@interface AuthorzieFamilyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arryForAuthorMember;
}
/*
 表头
 */
@property (weak, nonatomic) IBOutlet UILabel *lblNameSexBird;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNum;
@property (weak, nonatomic) IBOutlet UILabel *lblMedicalNum;
@property (weak, nonatomic) IBOutlet UILabel *lblIdCard;


@property (weak, nonatomic) IBOutlet UIView *headerViewAuthorize;
@property (weak, nonatomic) IBOutlet UITableView *tableAuthorize;
@property (weak, nonatomic) IBOutlet UITextField *textAuthorizeNum;


@end

@implementation AuthorzieFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTab];
    [self setDefault];
}

-(void)setDefault{
    
    self.title = @"授权";
    self.lblNameSexBird.text = [NSString stringWithFormat:@"%@    %@    %@",[NSString stringIsNSULL:self.member.name],[NSString stringIsNSULL:self.member.sex],[NSString stringIsNSULL:self.member.birth]];
    self.lblPhoneNum.text = [NSString stringWithFormat:@"手机号：%@",[NSString stringIsNSULL:self.member.tel]];
    self.lblIdCard.text = [NSString stringWithFormat:@"身份证号：%@",[NSString stringIsNSULL:self.member.idcard]];
    
    self.lblMedicalNum.text = [NSString stringWithFormat:@"社保卡：%@",[NSString stringIsNSULL:@""]];
    
    if ([DEFAULTS objectForKey:MEMBERLIST_USER]) {
        arryForAuthorMember = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[DEFAULTS objectForKey:MEMBERLIST_USER]]];
        
    }
    
}

-(void)setTab{
    self.tableAuthorize.tableHeaderView = self.headerViewAuthorize;
    [self.tableAuthorize registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFYFORAUTHORIZECELL];
}

#pragma mark----------TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arryForAuthorMember.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFYFORAUTHORIZECELL forIndexPath:indexPath];
    if (arryForAuthorMember.count>0) {
        FamliyMemberModel *model = arryForAuthorMember[indexPath.row];
        cell.textLabel.text = model.tel;

    }
    return cell;
}

- (IBAction)onClickAuthorize:(id)sender {

    
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
