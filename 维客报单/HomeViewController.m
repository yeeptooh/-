//
//  HomeViewController.m
//  维客报单
//
//  Created by 张冬冬 on 16/8/11.
//  Copyright © 2016年 张冬冬. All rights reserved.
//

#import "HomeViewController.h"
#import "StandardWebViewController.h"
#import "BaoxiuWebViewController.h"
#import "MyInfoWebViewController.h"
#import "ShareAnimation.h"
#import "ShareViewController.h"
#import "AllOrderViewController.h"
#import "UserModel.h"
#import "NicoNetworking.h"
@interface HomeViewController ()
<
UIViewControllerTransitioningDelegate
>
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationItem.title = @"维客报单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTopBaseView];
    [self setBottomBaseView];

}

- (void)viewWillAppear:(BOOL)animated {
    [self networking];
}


- (void)setTopBaseView {
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, Width - 20, 30)];
    label1.text = @"任务管理";
    label1.font = font(14);
    label1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, Width, 0.5)];
    label2.backgroundColor = color(150, 150, 150, 1);
    [self.view addSubview:label2];
    
    
    NSArray *labelTextList = @[@"报单", @"全部工单"];
    for (NSInteger i = 0; i < 2; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"homebutton%@",@(i + 1)]] forState:UIControlStateNormal];
        button.tag = 1000 + i;
        button.frame = CGRectMake(90.0/8 +((90.0/8) * 2 + ((Width - 90)/4))*i, 40, (Width - 90)/4, (Width - 90)/4);
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(90.0/8 +((90.0/8) * 2 + ((Width - 90)/4))*i, 42 + (Width - 90)/4, (Width - 90)/4, 20);
        label.text = labelTextList[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = font(14);
        [self.view addSubview:label];
        
    }
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70 + (Width - 90)/4, Width, 0.5)];
    label3.backgroundColor = color(150, 150, 150, 1);
    [self.view addSubview:label3];
   
}

- (void)setBottomBaseView {
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 70 + (Width - 90)/4, Width - 20, 30)];
    label1.text = @"服务中心";
    label1.font = font(14);
    label1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100 + (Width - 90)/4, Width, 0.5)];
    label2.backgroundColor = color(150, 150, 150, 1);
    [self.view addSubview:label2];
    
    
    NSArray *labelTextList = @[@"收费标准", @"我的信息", @"保修政策", @"分享好友"];
    for (NSInteger i = 0; i < 4; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"homebutton%@",@(i + 3)]] forState:UIControlStateNormal];
        button.tag = 1002 + i;
        button.frame = CGRectMake(90.0/8 +((90.0/8) * 2 + ((Width - 90)/4))*i, 110 + (Width - 90)/4, (Width - 90)/4, (Width - 90)/4);
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(90.0/8 +((90.0/8) * 2 + ((Width - 90)/4))*i, 112 + (Width - 90)/4 + (Width - 90)/4, (Width - 90)/4, 20);
        label.text = labelTextList[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = font(14);
        [self.view addSubview:label];
        
    }
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 140 + (Width - 90)/4 + (Width - 90)/4, Width, 0.5)];
    label3.backgroundColor = color(150, 150, 150, 1);
    [self.view addSubview:label3];
}

- (void)networking {
    UserModel *userModel = [UserModel readUserModel];
    
    NSDictionary *parames = @{@"uid":@(userModel.ID),@"comid":@(userModel.CompanyID)};
    
    [NicoNetworking nicoGetWithBaseURL:HomeUrl subURL:@"Task.ashx?action=updateTaskCount" parameters:parames success:^(id responseObject) {
        
        [self updateUIWithResponse:responseObject];
    } failure:^(NSError *error) {
        
    }];
   
}

- (void)updateUIWithResponse:(NSDictionary *)response {
    UILabel *redLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0/8 +((90.0/8) * 2 + ((Width - 90)/4)) + (Width - 90)/4 - 20*Width/320, 40, 20*Width/320, 20*Width/320)];
    redLabel.backgroundColor = [UIColor redColor];
    redLabel.layer.masksToBounds = YES;
    redLabel.layer.cornerRadius = redLabel.frame.size.height/2;
    redLabel.textAlignment = 1;
    redLabel.textColor = [UIColor whiteColor];
    redLabel.text = response[@"TaskCount"][0][@"TaskAll"];
    if ([redLabel.text isEqualToString:@"0"]) {
        redLabel.text = @"";
        redLabel.backgroundColor = [UIColor clearColor];
    }

    redLabel.font = [UIFont systemFontOfSize:10*Width/320];
    [self.view addSubview:redLabel];
}

- (void)buttonClicked:(UIButton *)sender {
    if (sender.tag == 1000) {
        
    }else if (sender.tag == 1001) {
        
        AllOrderViewController *allVC = [[AllOrderViewController alloc] init];
        [self.navigationController pushViewController:allVC animated:YES];
        
        
    }else if (sender.tag == 1002) {
        StandardWebViewController *standardVC = [[StandardWebViewController alloc] init];
        [self.navigationController pushViewController:standardVC animated:YES];
        
    }else if (sender.tag == 1003) {
        MyInfoWebViewController *infoVC = [[MyInfoWebViewController alloc] init];
        [self.navigationController pushViewController:infoVC animated:YES];
        
    }else if (sender.tag == 1004) {
        BaoxiuWebViewController *baoxiuVC = [[BaoxiuWebViewController alloc] init];
        [self.navigationController pushViewController:baoxiuVC animated:YES];
        
    }else if (sender.tag == 1005) {
//        ShareViewController *sVC = [[ShareViewController alloc]init];
//        sVC.transitioningDelegate = self;
//        sVC.modalPresentationStyle = UIModalPresentationCustom;
//        [self presentViewController:sVC animated:YES completion:nil];
    }
}



#pragma mark - UIViewControllerTransitioningDelegate -

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [ShareAnimation shareAnimationWithType:ShareAnimationTypePresent duration:0.15 presentHeight:258];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [ShareAnimation shareAnimationWithType:ShareAnimationTypeDismiss duration:0.05 presentHeight:258];
}













@end
