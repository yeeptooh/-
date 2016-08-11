//
//  StandardWebViewController.m
//  维客报单
//
//  Created by 张冬冬 on 16/8/11.
//  Copyright © 2016年 张冬冬. All rights reserved.
//

#import "StandardWebViewController.h"
#import "UserModel.h"
@implementation StandardWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UserModel *userModel = [UserModel readUserModel];
    self.url = [NSString stringWithFormat:@"%@page.aspx?type=shoufei&comid=%@&uid=%@",HomeUrl,@(userModel.CompanyID),@(userModel.ID)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self setNaviTitle];
}


- (void)setNaviTitle {
    self.navigationItem.title = @"收费标准";
}
@end
