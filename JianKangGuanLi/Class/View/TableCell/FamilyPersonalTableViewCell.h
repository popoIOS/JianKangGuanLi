//
//  FamilyPersonalTableViewCell.h
//  JianKangGuanLi
//
//  Created by ydz on 17/3/28.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyPersonalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblNameSexBirthday;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNum;
@property (weak, nonatomic) IBOutlet UILabel *lblMedicalCardNum;
@property (weak, nonatomic) IBOutlet UILabel *lblIdentifyNum;

-(void)setCellDataFromTable:(NSDictionary *)dic;

@end
