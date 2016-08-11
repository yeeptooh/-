
//
//  BaoxiuWebViewController.m
//  维客报单
//
//  Created by 张冬冬 on 16/8/11.
//  Copyright © 2016年 张冬冬. All rights reserved.
//

#import "BaoxiuWebViewController.h"
#import "UserModel.h"
@implementation BaoxiuWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UserModel *userModel = [UserModel readUserModel];
    self.url = [NSString stringWithFormat:@"%@page.aspx?type=baoxiu&comid=%@&uid=%@",HomeUrl,@(userModel.CompanyID),@(userModel.ID)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self setNaviTitle];
}


- (void)setNaviTitle {
    self.navigationItem.title = @"保修政策";
}

@end
