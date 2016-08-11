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
@interface HomeViewController ()

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

- (void)buttonClicked:(UIButton *)sender {
    if (sender.tag == 1000) {
        
    }else if (sender.tag == 1001) {
        
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
        
    }
}
















@end
