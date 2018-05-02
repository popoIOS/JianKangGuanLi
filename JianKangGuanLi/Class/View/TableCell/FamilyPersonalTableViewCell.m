//
//  FamilyPersonalTableViewCell.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/28.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "FamilyPersonalTableViewCell.h"
#import "FamliyMemberModel.h"


@implementation FamilyPersonalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

-(void)setCellDataFromTable:(FamliyMemberModel *)memberFam{

    self.lblNameSexBirthday.text = [NSString stringWithFormat:@"%@    %@    %@",[NSString stringIsNSULL:memberFam.name],[NSString stringIsNSULL:memberFam.sex],[NSString stringIsNSULL:memberFam.birth]];
    self.lblPhoneNum.text = [NSString stringWithFormat:@"手机号：%@",[NSString stringIsNSULL:memberFam.tel]];
    self.lblIdentifyNum.text = [NSString stringWithFormat:@"身份证号：%@",[NSString stringIsNSULL:memberFam.idcard]];

    self.lblMedicalCardNum.text = [NSString stringWithFormat:@"社保卡：%@",[NSString stringIsNSULL:@""]];
}

- (IBAction)btnAuthorize:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTYFYFORAUTIFYFAMILY object:self];
    
}

- (IBAction)btnUnwap:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
