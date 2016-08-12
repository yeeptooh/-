//

/**********//**********//**********//**********//**********//**********//*
          .--,       .--,
         ( (  \.---./  ) )
          '.__/o   o\__.'
             {=  ^  =}
              >  -  <
             /       \
            //       \\
           //|   .   |\\
           "'\       /'"_.-~^`'-.
              \  _  /--'         `
            ___)( )(___
           (((__) (__)))
                                                                         
    高山仰止,景行行止.虽不能至,心向往之。
                                                                         
    最怕你一生碌碌无为 还安慰自己平凡可贵

*********//**********//**********//**********//**********//**********/


//  DetailTaskPlanViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/25.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "DetailTaskPlanViewController.h"
#import "DetailTaskPlanTableViewCell.h"
#import "SectionDetailTaskPlanTableViewCell.h"
#import "Section2DetailTableViewCell.h"
#import "DetailThirdTableViewCell.h"
#import "DetailForthTableViewCell.h"
#import "CancelTableViewCell.h"

//#import "TaskPlanToDoViewController.h"

//#import "AppointmentViewController.h"
//#import "ToCompleteTheWorkOrderViewController.h"//完成工单
//#import "ChangeBackViewController.h"
//#import "SendViewController.h"

//#import "AFNetClass.h"
//#import "MyProgressView.h"
//#import "BaseMapViewController.h"
//#import "UserModel.h"
//#import "ServiceViewController.h"

#import "AFNetworking.h"
#import "UserModel.h"
#import "OrderModel.h"

#import "MBProgressHUD.h"

//#import "DatePickerViewController.h"
//#import "TypeViewController.h"

//#import "SaleViewController.h"
//#import "CancelViewController.h"
//#import "AddPJViewController.h"
//#import "CancelPJViewController.h"

#import "OtherTableViewCell.h"

///*修改buttonclicked*/
//#import "ZDDTransition.h"
//#import "MyTransition.h"
//#import "ChangeNameViewController.h"
//#import "ChangeAddressViewController.h"
//#import "ProductTypeViewController.h"
//#import "BarCodeViewController.h"
//#import "BuyShopViewController.h"

#import <AVFoundation/AVFoundation.h>
//#import "DialogViewController.h"
//#import "DialogAnimation.h"
#define Common_BackColor [UIColor colorWithRed:215/255.0 green:227/255.0 blue:238/255.0 alpha:1]


@interface DetailTaskPlanViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate,
UIViewControllerTransitioningDelegate
>
{
    UIView *blackView;
    UIDatePicker *_datePicker;
    UIButton *button1;
    UIButton *button2;
    NSString *time1;
    NSString *time2;
    UITapGestureRecognizer *tap;
    int xcHeight;
    UIView * view;
    UIButton * button;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *ProductType;
@property (nonatomic, copy) NSString *ProductCode;
@property (nonatomic, copy) NSString *OutNum;
@property (nonatomic, copy) NSString *BuyShop;
@property (nonatomic, copy) NSString *BuyTime;
@property (nonatomic, copy) NSString *ServiceClassify;
@property (nonatomic, copy) NSString *BuyerAddress;
@property (nonatomic, strong) NSMutableArray *serviceList;
@property (nonatomic, strong) UIButton *aButton;
@property (nonatomic, strong) UITextField *text;
@property (nonatomic, strong) DetailTaskPlanTableViewCell *cell;

@property (nonatomic, strong) NSString *addressString;

@property (nonatomic, strong) NSString *buyAddressString;

@property (nonatomic, strong) NSString *barcode;
@property (nonatomic, strong) NSString *productType1;

@property (nonatomic, strong) NSString *repairType;

@property (nonatomic, strong) NSMutableArray *nameList;
@property (nonatomic, strong) NSMutableArray *storeNameList;

@property (nonatomic, strong) NSMutableArray *fromID;
@property (nonatomic, strong) NSMutableArray *toID;

@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) NSMutableArray *diaLogList;

@end

@implementation DetailTaskPlanViewController

- (NSMutableArray *)diaLogList {
    if (!_diaLogList) {
        _diaLogList = [NSMutableArray array];
    }
    return _diaLogList;
}

- (UIAlertController *)alertController {
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:@"此应用的照相功能已禁用" message:@"选择确定开启应用的相机功能" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }];
        
        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [_alertController addAction:openAction];
        [_alertController addAction:closeAction];
        
    }
    return _alertController;
}

-(NSMutableArray *)fromID {
    if (!_fromID) {
        _fromID = [NSMutableArray array];
    }
    return _fromID;
}

- (NSMutableArray *)toID {
    if (!_toID) {
        _toID = [NSMutableArray array];
        
    }
    return _toID;
}

- (NSMutableArray *)nameList {
    if (!_nameList) {
        _nameList = [NSMutableArray array];
        
    }
    return _nameList;
}

- (NSMutableArray *)storeNameList {
    if (!_storeNameList) {
        _storeNameList = [NSMutableArray array];
        
    }
    return _storeNameList;
}
- (NSMutableArray *)serviceList {
    if (!_serviceList) {
        _serviceList = [NSMutableArray array];
    }
    return _serviceList;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, Width, Height-StatusBarAndNavigationBarHeight - 150) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavigationBar];
    [self.view addSubview:self.tableView];
    [self keyboardAddNotice];
    [self setBaseView];
}

- (void)setBaseView {
    
    DetailTaskPlanTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailTaskPlanTableViewCell" owner:self options:nil] lastObject];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    [cell.BuyerName setTitle:[NSString stringWithFormat:@"%@",self.orderModel.BuyerName] forState:UIControlStateNormal];
    
    
    _BuyerAddress = self.orderModel.BuyerShortAddress;
    
    cell.BuyerPhone.text = self.orderModel.BuyerPhone;
    
    NSString *title;
    if (!self.addressString) {
        title = self.orderModel.BuyerShortAddress;
    }else{
        if ([self.orderModel.BuyerDistrict isEqualToString:@""]) {
            title = self.addressString;
        }else{
            if ([self.orderModel.BuyerTown isEqualToString:@""]) {
                title = [NSString stringWithFormat:@"%@%@",self.orderModel.BuyerDistrict,self.addressString];
            }else{
                title = [NSString stringWithFormat:@"%@%@%@",self.orderModel.BuyerDistrict,self.orderModel.BuyerTown,self.addressString];
            }
        }
        
    }
    
    [cell.BuyAddress setTitle:title forState:UIControlStateNormal];
    cell.BuyAddress.userInteractionEnabled = NO;
    cell.InfoFrom.text = [NSString stringWithFormat:@"来源: %@",self.orderModel.InfoFrom];
    cell.CallPhone.text = [NSString stringWithFormat:@"来电: %@",self.orderModel.CallPhone];
    cell.BillCode.text = [NSString stringWithFormat:@"单据: %@",self.orderModel.BillCode];
    cell.CallPhoneString = self.orderModel.BuyerPhone;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 155)];
    cell.frame = baseView.bounds;
    [baseView addSubview:cell];
    
    [self.view addSubview:baseView];
    
}



#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.theStatus  isEqualToString: @"回访"]) {
        if (self.status == 11) {
            
            return 3+self.flag;
        }
        return 4+self.flag;
        
    } else if ([self.theStatus  isEqualToString: @"未完成"]){
        return 2+self.flag;
    } else if ([self.theStatus  isEqualToString: @"已录入"]) {
        return 4+self.flag;
    } else if ([self.theStatus  isEqualToString: @"已核销"]) {
        return 3+self.flag;
    } else if ([self.theStatus  isEqualToString: @"待审核"]) {
        return 2+self.flag;
    } else if ([self.theStatus  isEqualToString: @"已结单"]) {
        return 4+self.flag;
    }else {
        return 2+self.flag;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        Section2DetailTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"Section2DetailTableViewCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.ProductType setTitle:self.orderModel.ProductType forState:UIControlStateNormal];
        cell.ProductType.tag = 2000;
        cell.ProductType.userInteractionEnabled = NO;
        cell.typeLabel.text = [NSString stringWithFormat:@"%@%@",self.orderModel.ProductBreed,self.orderModel.ProductClassify];
        [cell.ProductNum setTitle:self.orderModel.BarCode forState:UIControlStateNormal];
        cell.ProductNum.userInteractionEnabled = NO;
        [cell.OutNum setTitle:self.orderModel.BarCode2 forState:UIControlStateNormal];
        [cell.BuyShop setTitle:self.orderModel.BuyAddress forState:UIControlStateNormal];
        cell.BuyShop.userInteractionEnabled = NO;
        [cell.BuyTime setTitle:self.orderModel.BuyTimeStr forState:UIControlStateNormal];
        cell.BuyTime.userInteractionEnabled = NO;
        [cell.ServiceClassify setTitle:self.orderModel.RepairType forState:0];
        cell.ServiceClassify.userInteractionEnabled = NO;
        
        if (self.status == 15) {
            cell.ServiceClassify.enabled = NO;
            cell.ProductNum.enabled = NO;
            cell.ProductType.enabled = NO;
            cell.BuyShop.enabled = NO;
            cell.BuyTime.enabled = NO;
        }
        
        return cell;

    }else if (indexPath.row == 1) {
        
        SectionDetailTaskPlanTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"SectionDetailTaskPlanTableViewCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *atimeString = self.orderModel.CloseTime;
        NSRange arange = [atimeString rangeOfString:@"("];
        NSRange arange1 = [atimeString rangeOfString:@")"];
        NSInteger aloc = arange.location;
        NSInteger alen = arange1.location - arange.location;
        NSString *anewtimeString = [atimeString substringWithRange:NSMakeRange(aloc + 1, alen - 1)];
        // 时间戳转时间
        double alastactivityInterval = [anewtimeString doubleValue];
        NSDateFormatter *aformatter = [[NSDateFormatter alloc] init];
        [aformatter setDateStyle:NSDateFormatterMediumStyle];
        [aformatter setTimeStyle:NSDateFormatterShortStyle];
        [aformatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [aformatter setDateFormat:@"HH:mm"];
        NSDate *apublishDate = [NSDate dateWithTimeIntervalSince1970:alastactivityInterval/1000];
        NSDate *adate = [NSDate date];
        NSTimeZone *azone = [NSTimeZone systemTimeZone];
        NSInteger ainterval = [azone secondsFromGMTForDate:adate];
        apublishDate = [apublishDate  dateByAddingTimeInterval: ainterval];
        NSString *aappointmentTime = [aformatter stringFromDate:apublishDate];
        
        cell.CloseTime.text = [NSString stringWithFormat:@"%@",aappointmentTime];
        cell.ExpectantTime.text = [NSString stringWithFormat:@"%@",self.orderModel.ExpectantTimeStr];
        cell.BrokenPhenomenon.text = [NSString stringWithFormat:@"%@",self.orderModel.BrokenPhenomenon];
        cell.BrokenReason.text = [NSString stringWithFormat:@"%@",self.orderModel.BrokenReason];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"备注:    %@",self.orderModel.TaskPostscript]];
        
        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 3)];
        
        cell.TaskPostscript.attributedText = attributedString;
        [cell.businessInfoButton setTitle:self.orderModel.ServiceClassify forState:UIControlStateNormal];
        cell.businessInfoButton.userInteractionEnabled = NO;
        
        if (![self.orderModel.AddTime isEqual:[NSNull null]]) {
            NSString *timeString = self.orderModel.AddTime;
            NSRange range = [timeString rangeOfString:@"("];
            NSRange range1 = [timeString rangeOfString:@")"];
            NSInteger loc = range.location;
            NSInteger len = range1.location - range.location;
            NSString *newtimeString = [timeString substringWithRange:NSMakeRange(loc + 1, len - 1)];
            double lastactivityInterval = [newtimeString doubleValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
            [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
            NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval/1000];
            NSDate *date = [NSDate date];
            NSTimeZone *zone = [NSTimeZone systemTimeZone];
            NSInteger interval = [zone secondsFromGMTForDate:date];
            publishDate = [publishDate  dateByAddingTimeInterval: interval];
            NSString *appointmentTime = [formatter stringFromDate:publishDate];
            cell.FinishTime.text = [NSString stringWithFormat:@"%@",appointmentTime];
        }
        else{
            cell.FinishTime.text = @"";
        }
        return cell;
        
    } else if (indexPath.row == 2) {
        
        if (self.status == 11 || self.status == 15 || [self.theStatus  isEqualToString: @"已录入"] || [self.theStatus  isEqualToString: @"已结单"]) {
            
            DetailThirdTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"DetailThirdTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            int price1 = [self.orderModel.PriceAppend intValue];
            int price2 = [self.orderModel.PriceService intValue];
            int price3 = [self.orderModel.PriceMaterials intValue];
            
            NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"收费: %@",[NSString stringWithFormat:@"%d",price1+price2+price3]]];
            
            [attributedString1 addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 3)];
            
            cell.WorkMoney.attributedText = attributedString1;
            
            cell.ServiceClassify.text = self.orderModel.WorkPostscript;
            _ServiceClassify = self.orderModel.WorkPostscript;
            cell.WaiterShow.text = self.orderModel.WaiterShow;
            // 时间戳转时间
            if (![self.orderModel.FinishTime isEqual:[NSNull null]]) {
                NSString *timeString = self.orderModel.FinishTime;
                NSRange range = [timeString rangeOfString:@"("];
                NSRange range1 = [timeString rangeOfString:@")"];
                NSInteger loc = range.location;
                NSInteger len = range1.location - range.location;
                NSString *newtimeString = [timeString substringWithRange:NSMakeRange(loc + 1, len - 1)];
                double lastactivityInterval = [newtimeString doubleValue];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                [formatter setDateFormat:@"yyyy年MM月dd日"];
                NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval/1000];
                NSDate *date = [NSDate date];
                NSTimeZone *zone = [NSTimeZone systemTimeZone];
                NSInteger interval = [zone secondsFromGMTForDate:date];
                publishDate = [publishDate  dateByAddingTimeInterval: interval];
                NSString *appointmentTime = [formatter stringFromDate:publishDate];
                NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"完工时间: %@",appointmentTime]];
                
                [attributedString2 addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                cell.FinishTime.attributedText = attributedString2;
            }else{
                cell.FinishTime.text = @"完工时间: ";
                cell.FinishTime.textColor = color(85, 85, 85, 1);
            }
            
            return cell;
        } else if([self.theStatus isEqualToString:@"未完成"] || [self.theStatus isEqualToString:@"待审核"]){
            
            OtherTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            
            if (self.isCancel) {
                if (!self.isChange) {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.UnFinishRemark]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.CancelReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.NoEntryReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }else {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }
                
            }else if (self.isChange) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"更换配件: %@",self.orderModel.Change]];
                
                [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                cell.InfoLabel.attributedText = attributedString;
                
            }
            
            return cell;

        }else if ([self.theStatus isEqualToString:@"已核销"]) {
            CancelTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"CancelTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            if ([self.orderModel.CancelReason2 isEqual:[NSNull null]]) {
                self.orderModel.CancelReason2 = @"";
            }
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"核销信息: %@",self.orderModel.CancelReason2]];
            
            [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
            cell.cancelLabel.attributedText = attributedString;
            return cell;
        }else {
            OtherTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            
            if (self.isCancel) {
                if (!self.isChange) {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.UnFinishRemark]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.CancelReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.NoEntryReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }else {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }
                
            }else if (self.isChange) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"更换配件: %@",self.orderModel.Change]];
                
                [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                cell.InfoLabel.attributedText = attributedString;
                
            }
            return cell;
        }
    } else if (indexPath.row == 3) {
        
        if (self.status == 15 || [self.theStatus  isEqualToString: @"已录入"] || [self.theStatus  isEqualToString: @"已结单"]) {
            
            DetailForthTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"DetailForthTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            int theprice1 = [self.orderModel.MoneyService intValue];
            int theprice2 = [self.orderModel.MoneyMaterials intValue];
            int theprice3 = [self.orderModel.MoneyAppend intValue];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"收费: %d",theprice1+theprice2+theprice3]];
            
            [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 3)];
            
            cell.WorkMoney.attributedText = attributedString;
            cell.workScore.text = [NSString stringWithFormat:@"%@分",self.orderModel.WorkScore];
            cell.comment.text  = self.orderModel.Comment;
            return cell;
        }else if (self.status == 11 || [self.theStatus isEqualToString:@"已核销"]) {
            OtherTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            if (self.isCancel) {
                if (!self.isChange) {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.UnFinishRemark]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.CancelReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.NoEntryReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }else {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }
                
            }else if (self.isChange) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"更换配件: %@",self.orderModel.Change]];
                
                [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                cell.InfoLabel.attributedText = attributedString;
                
            }
            return cell;
        }
    }else if (indexPath.row == 4) {
        
        if ([self.theStatus  isEqualToString: @"已录入"] || self.status == 15 || [self.theStatus  isEqualToString: @"已结单"]) {
            OtherTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            if (self.isCancel) {
                if (!self.isChange) {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.UnFinishRemark]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.CancelReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@",self.orderModel.NoEntryReason]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }else {
                    if ([self.orderModel.UnFinishRemark isEqualToString:@""] || [self.orderModel.UnFinishRemark isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.UnFinishRemark, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                        
                    }
                    
                    if ([self.orderModel.CancelReason isEqualToString:@""] || [self.orderModel.CancelReason isEqual:[NSNull null]]) {
                        
                    }else{
                        
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.CancelReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                    
                    
                    
                    if ([self.orderModel.NoEntryReason isEqualToString:@""] || [self.orderModel.NoEntryReason isEqual:[NSNull null]]) {
                        
                    }else{
                        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change]];
                        
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                        [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)} range:[[NSString stringWithFormat:@"退单信息: %@\n更换配件: %@",self.orderModel.NoEntryReason, self.orderModel.Change] rangeOfString:@"更换配件:"]];
                        cell.InfoLabel.attributedText = attributedString;
                    }
                }
                
            }else if (self.isChange) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"更换配件: %@",self.orderModel.Change]];
                
                [attributedString addAttributes:@{NSForegroundColorAttributeName:color(85, 85, 85, 1)}range:NSMakeRange(0, 5)];
                cell.InfoLabel.attributedText = attributedString;
                
            }
        }
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 164;
    }else if (indexPath.row == 1) {
//        if ([self.orderModel.TaskPostscript isEqualToString:@""] || !self.orderModel.TaskPostscript) {
//            return UITableViewAutomaticDimension;
//        }
        return 192;
    }else if (indexPath.row == 2){
        
        return UITableViewAutomaticDimension;
        
    }else if (indexPath.row == 3){

        return UITableViewAutomaticDimension;
    
    }else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}



#pragma mark - 监听键盘 -
- (void)keyboardAddNotice {
    //注册键盘出现的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}




- (void)keyboardWasShown:(NSNotification*)aNotification {
    //添加手势
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [self.view removeGestureRecognizer:tap];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 单击手势 -
- (void)tapAction:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}


-(void)setNavigationBar {
    self.navigationItem.title = @"工单明细";
}


@end
