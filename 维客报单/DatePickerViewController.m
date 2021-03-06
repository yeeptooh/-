//
//  DatePickerViewController.m
//  WeiKe
//
//  Created by 张冬冬 on 16/4/6.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "DatePickerViewController.h"
#import "HYBModalTransition.h"
@interface DatePickerViewController ()
<
UIViewControllerTransitioningDelegate
>
@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 25, Width, 216)];
    NSDate *currentDate = [NSDate date];
    [self.datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
    [self.datePicker setDate:currentDate animated:YES];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.view addSubview:self.datePicker];
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(Width/2 + Width/8, 260, Width/4, 40);
    backBtn.layer.cornerRadius = 5;
    backBtn.layer.masksToBounds = YES;
    backBtn.backgroundColor = color(59, 165, 249, 1);
    [backBtn setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [backBtn setTitleColor:color(210, 210, 210, 1) forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius = 5;
    saveBtn.layer.masksToBounds = YES;
    saveBtn.backgroundColor = color(59, 165, 249, 1);
    [saveBtn setTitleColor:color(245, 245, 245, 1) forState:UIControlStateNormal];
    [saveBtn setTitleColor:color(210, 210, 210, 1) forState:UIControlStateHighlighted];
    [saveBtn addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.frame = CGRectMake(Width/8, 260, Width/4, 40);
    [self.view addSubview:saveBtn];
}

- (void)saveButtonClicked:(UIButton *)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:self.datePicker.date];
    self.returnDate(dateString);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)backBtnClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [HYBModalTransition transitionWithType:kHYBModalTransitionPresent duration:0.25 presentHeight:350 scale:CGPointMake(0.9, 0.9)];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [HYBModalTransition transitionWithType:kHYBModalTransitionDismiss duration:0.25 presentHeight:350 scale:CGPointMake(0.9, 0.9)];
}

@end
