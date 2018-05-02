//
//  ConnectBlueViewController.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/27.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "ConnectBlueViewController.h"
#define open @"5A0B050E0B080C12A90000"
#define channelOnPeropheralView @"peropheralView"
#define channelOnCharacteristicView @"characteristicView"
#define ReciveBlueDisConnect @"BabyNotificationAtDidDisconnectPeripheral"

@interface ConnectBlueViewController ()<CBCentralManagerDelegate>
{
    
    BabyBluetooth *baby;
    
}

@property (nonatomic, strong) CBPeripheral *currenPeripheral;
@property (nonatomic, strong) NSMutableArray *descriptorArr;
@property (nonatomic, strong) CBService *currenService;

@property (nonatomic, strong) CBCentralManager *observeManger;
@property (nonatomic, strong) NSTimer *timer;

@end

static NSInteger i = 1;

@implementation ConnectBlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDicConnect:) name:ReciveBlueDisConnect object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCentralDataForBlueDevice:) name:BabyNotificationAtDidDiscoverPeripheral object:nil];
    
}

#pragma mark-------------蓝牙设备断开
-(void)onDicConnect:(NSNotification *)notify{
    
    NSDictionary *dic = notify.object;
    NSError *error = dic[@"error"];
    CBPeripheral *peripheral = dic[@"peripheral"];
    if (error && [peripheral.name isEqualToString:@"Bioland-BPM"]) {
        LKErrorBubble(@"蓝牙连接断开", 2)
    }
}

#pragma mark-------------获取蓝牙设备的UUID(没有mac地址)
-(void)onCentralDataForBlueDevice:(NSNotification *)notify{

    NSDictionary *dicCentral = (NSDictionary *)notify.object;
    if (dicCentral) {
        NSDictionary *advertisementData = dicCentral[@"advertisementData"];
        NSString *peripheralName = advertisementData[@"kCBAdvDataLocalName"];
        NSArray *arryUUID = advertisementData[@"kCBAdvDataServiceUUIDs"];
        if (peripheralName && arryUUID && [peripheralName isEqualToString:@"Bioland-BPM"]) {
            NSLog(@"------%@",arryUUID);
            NSLog(@"%@--------",arryUUID[0]);
        }
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    i = 0;
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark -蓝牙打开

-(void)getCBMangerState{
    
    baby = [BabyBluetooth shareBabyBluetooth];
    self.observeManger  = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.descriptorArr = [NSMutableArray array];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBManagerStatePoweredOff:
            LKErrorBubble(@"蓝牙已关闭", 2);
            break;
        case CBManagerStatePoweredOn:
            
            //开始扫描设备
            baby.scanForPeripherals().begin();
            //设置蓝牙委托
            [self babyDelegate];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
            break;
        default:
            break;
    }
}

-(void)onTimer{
    i++;
    if (i%5 == 0) {
        LKErrorBubble(@"扫描失败", 2);
        [baby cancelScan];
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark -蓝牙配置

//蓝牙网关初始化和委托方法设置
-(void)babyDelegate{
    
    //CA_IOS_VERSION()
    
    LKWaitBubble(@"搜索设备中...")
    __weak typeof(self) weakSelf = self;
    __weak typeof(baby) weakBaby = baby;
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        // 5D26AC3D-94C5-4ADE-9D49-33C3CB8E5764
        weakSelf.currenPeripheral = peripheral;
        
        [weakSelf showRoundProgressWithTitle:@"连接设备中..."];
        weakBaby.having(weakSelf.currenPeripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
    }];
    
    //设置设备连接成功的委托
    [baby setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
        
        [weakBaby cancelScan];
        [weakSelf.timer invalidate];
        weakSelf.timer = nil;
        
        [weakSelf showRoundProgressWithTitle:@"读取数据中..."];
    }];
    
    //设置发现设service的Characteristics的委托
    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        weakSelf.currenService = service;
        
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:@"2A23"]] forService:service];
    }];
    
    
    
    //设置读取Descriptor的委托
    [baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        [weakSelf.descriptorArr addObject:descriptor];
        if (weakSelf.descriptorArr.count == 5) {
            [weakSelf getDesptorDelegate];
            [weakSelf getCBDescriptor];
        }
    }];
    
    [baby setBlockOnFailToConnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        
        //        LKErrorBubble(@"蓝牙连接失败", 2);
    }];
    
    //设置查找设备的过滤器
    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        if ([peripheralName hasPrefix:@"Bioland-BPM"] || [peripheralName hasPrefix:@"Bioland-BGM"] ) {
            return YES;
        }
        return NO;
    }];
}

#pragma mark----对蓝牙的操作
-(void)getCBDescriptor{
    
    if (self.currenPeripheral.state != CBPeripheralStateConnecting && self.currenPeripheral.state != CBPeripheralStateConnected) {
        LKErrorBubble(@"获取数据失败", 2);
        return;
    }
    [self  notifyBlueBooth];
    [self commandBlueBoothOpen:open];
}
//订阅
-(void)notifyBlueBooth{
    CBCharacteristic *recordBuf =  [BabyToy findCharacteristicFormServices:[NSMutableArray arrayWithArray:self.currenPeripheral.services] UUIDString:@"1002"];
    
    if (recordBuf && recordBuf.isNotifying == NO) {
        
        baby.channel(channelOnCharacteristicView).characteristicDetails(self.currenPeripheral,recordBuf);
        [self.currenPeripheral setNotifyValue:YES forCharacteristic:recordBuf];
    }
}
//命令开机

-(void)commandBlueBoothOpen:(NSString *)command{
    
    //    Byte byte[] = {0xA0,0xA0,0xA0,0xA0,0xA0,0xA0,0xA0};
    NSData *adata = [self stringToByte:command];
    
    CBCharacteristic *readAndWrite =  [BabyToy findCharacteristicFormServices:[NSMutableArray arrayWithArray:self.currenPeripheral.services] UUIDString:@"1001"];
    if (readAndWrite) {
        [self.currenPeripheral writeValue:adata forCharacteristic:readAndWrite type:CBCharacteristicWriteWithResponse];
        
    }
}

-(NSData*)stringToByte:(NSString*)string
{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;
        
        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}


#pragma mark----蓝牙读取数据
-(void)getDesptorDelegate{
    
    __weak typeof(self)weakSelf = self;
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        
        NSString *str = [NSString stringWithFormat:@"%@",characteristic.value];
        
        NSArray *arry = [str componentsSeparatedByString:@" "];
        NSString *strStart = arry[0];
        NSString *packType;
        if (strStart.length>=7) {
            packType = [strStart substringWithRange:NSMakeRange(5, 2)];
            if ([packType isEqualToString:@"00"] && arry.count==4) {
                [weakSelf commandBlueBoothOpen:open];
                NSLog(@"信息包：%@",characteristic.value);
                
            }else if ([packType isEqualToString:@"01"]&& arry.count==2){
                [weakSelf commandBlueBoothOpen:open];
                NSLog(@"开始包%@",characteristic.value);
                
            }else if ([packType isEqualToString:@"02"]){
                
            }else if ([packType isEqualToString:@"03"] && arry.count==4){
                [weakSelf showRightWithTitle:@"测量成功" autoCloseTime:2];
                NSString *strData = arry[2];
                [weakSelf showResult:strData];
                NSLog(@"结果包%@",str);
            }
        }
        
    }];
    
    //设置发现characteristics的descriptors的委托
    [baby setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        //        NSLog(@"CharacteristicViewController===characteristic name:%@",characteristic.service.UUID);
    }];
    //设置读取Descriptor的委托
    [baby setBlockOnReadValueForDescriptorsAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        
        
    }];
    
    [baby setBlockOnFailToConnectAtChannel:channelOnCharacteristicView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        
        [weakSelf showErrorWithTitle:@"蓝牙连接失败" autoCloseTime:2];
    }];
    
}

-(void)showResult:(NSString *)result{
    
    NSString *height;
    NSString *low;
    NSString *heart;
    if (result.length>=8) {
        
        height = [self getHexChangeWith:[result substringWithRange:NSMakeRange(0, 2)]];
        low = [self getHexChangeWith:[result substringWithRange:NSMakeRange(4, 2)]];
        heart = [self getHexChangeWith:[result substringWithRange:NSMakeRange(6, 2)]];
    }else
    {
        LKErrorBubble(@"测量失败", 2);
        return;
    }
    
    NSDictionary *dic = @{DIASTOLICLOW:low,SYSTOLICHEIGHT:height,HEARTRATE:heart,@"EquipmentId":@"-1",@"Memberid":[NSString stringIsNSULL:[DEFAULTS objectForKey:ID_USER]]};
    [self.arryDataSource addObject:dic];
    __weak typeof(self) weakSelf = self;
    [RequestManger postWithUrl:URL_UPLOADING_BLOODPRESSURE Header:HEADERDIC_VERIFYCODE Param:dic ShowProgress:self Tip:SUCCESSFROMUPLOADDATA Success:^(id responsed) {
        weakSelf.isScuess = YES;
    } Fail:^(NSError *error) {
        
    }];
    
}

-(void)dealloc{

}

-(NSString *)getHexChangeWith:(NSString *)str{
    
    return [NSString stringWithFormat:@"%lu",strtoul([str UTF8String],0,16)];
    
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
