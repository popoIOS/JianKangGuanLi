//
//  DefineCommon.h
//  TheSecondProject
//
//  Created by ydz on 17/2/15.
//  Copyright © 2017年 贾. All rights reserved.
//

#ifndef DefineCommon_h
#define DefineCommon_h


#define FAILFROMDATA @"数据加载失败"
#define SUCCESSFROMDATA @"数据加载成功"
#define SUCCESSFROMUPLOADDATA @"数据上传成功"
#define OUTTIMELOGIN @"登录超时,请重新登录"
#define DATAFROMPROGRESS @"数据加载中"

#define NOTYFYFORAUTIFYFAMILY @"AuthorizeForFanilyPersonalNotify"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
//根据RGB获取颜色
#define ColorCustom(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//本地数据存储
#define DEFAULTS [NSUserDefaults standardUserDefaults]
//弹出框提示语
#define SHOWALERTVIEW(msg) [ShowAlert showAlertWithMessage:@"提示" Message:msg Buttons:@[@"确定"] Sure:^{}];
//网络请求头部
#define HEADERDIC_VERIFYCODE @{@"VerifyCode":[NSString stringIsNSULL:[DEFAULTS objectForKey:VERITIFYCODE_USER]]}
//登录超时去登陆
#define LOGIN_OUTTIME_FORLOGIN(vc)  [vc.navigationController pushViewController:[LoginViewController new] animated:YES];


#define ID_USER @"id"
#define TEL_USER @"tel"
#define USERNAME_USER @"userName"
#define LOGINID_USER @"loginid"
#define PASSWORD_USER @"password"
#define MEMBERLIST_USER @"memberList"
#define VERITIFYCODE_USER @"verifyCode"
#define SYSTOLICHEIGHT @"systolic"
#define DIASTOLICLOW @"diastolic"
#define HEARTRATE @"heartRate"
//端口号
#define NET_URL @"http://192.168.1.100:1234"
//上传血压
#define URL_UPLOADING_BLOODPRESSURE [NSString stringWithFormat:@"%@/api/Equipment/AddEquipmentData",NET_URL]
////服务器获取血压
//#define URL_GETDATAFROMNET_BLOODPRESSURE [NSString stringWithFormat:@"%@/api/Equipment/GetBloodPressure",NET_URL]
//登录
#define URL_USER_GOTOLOGIN [NSString stringWithFormat:@"%@/api/Share/MemberLogin",NET_URL]
//选择要绑定的设备
#define URL_CHOOSEDEVICE_BLUETHOOTH [NSString stringWithFormat:@"%@/api/Equipment/GetEquipmentType",NET_URL]
//绑定设备
#define URL_WAPDEVICE_BLUETHOOTH [NSString stringWithFormat:@"%@/api/Equipment/GetEquipmentTypeByParentId",NET_URL]
//查看已经绑定的设备
#define URL_ALAREADYWAPDEVICE_BLUETHOOTH [NSString stringWithFormat:@"%@/api/Equipment/GetBindingEquipment",NET_URL]
//删除已经绑定的设备
#define URL_DELEGATEDEVICE_BLUETHOOTH [NSString stringWithFormat:@"%@/api/Equipment/DelBindingEqUser",NET_URL]
//获取设备上传的数据
#define URL_GERDATAFROMDEVICE_BLUETHOOTH [NSString stringWithFormat:@"%@/api/Equipment/GetEquipmentData",NET_URL]









#endif /* DefineCommon_h */
