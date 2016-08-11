//
//  MyInfoWebViewController.m
//  维客报单
//
//  Created by 张冬冬 on 16/8/11.
//  Copyright © 2016年 张冬冬. All rights reserved.
//

#import "MyInfoWebViewController.h"
#import <WebKit/WebKit.h>
#import "UserModel.h"
#import "LoginViewController.h"
@interface MyInfoWebViewController ()
<
WKNavigationDelegate
>
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIView *noNetWorkingView;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *url;
@end

@implementation MyInfoWebViewController
- (WKWebView *)webView {
    if (!_webView) {
        UserModel *userModel = [UserModel readUserModel];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - StatusBarAndNavigationBarHeight - TabbarHeight)];
        _webView.navigationDelegate = self;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/page.aspx?type=user&comid=%@&uid=%@",HomeUrl,@(userModel.CompanyID),@(userModel.ID)]]]];
        
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progressTintColor = BlueColor;
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self setBottonButton];
}


- (void)setBottonButton {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, Height - StatusBarAndNavigationBarHeight - TabbarHeight, Width, TabbarHeight)];
    view.backgroundColor = color(230, 230, 230, 1);
    [self.view addSubview:view];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    effectView.frame = view.bounds;
    [view addSubview:effectView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.6)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [effectView.contentView addSubview:lineView];
    
    
    
    
    UIButton *quitButton = [UIButton buttonWithType:0];
    
    [quitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    
    [quitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quitButton addTarget:self action:@selector(quitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    //    quitButton.titleLabel.font = font(12);
    quitButton.frame = CGRectMake(0, 0, Width/2, TabbarHeight);
    quitButton.backgroundColor =  MainBlueColor;
    [effectView.contentView addSubview:quitButton];
    
    
    UIButton *changePwdButton = [UIButton buttonWithType:0];
    
    [changePwdButton setTitle:@"修改密码" forState:UIControlStateNormal];
    
    [changePwdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changePwdButton addTarget:self action:@selector(changePwdButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    changePwdButton.backgroundColor = MainBlueColor;
    changePwdButton.frame = CGRectMake(Width/2, 0, Width/2, TabbarHeight);
    //    changePwdButton.titleLabel.font = font(12);
    [effectView.contentView addSubview:changePwdButton];
    
    UIView *colView = [[UIView alloc] initWithFrame:CGRectMake(Width/2-0.7, 15, 1.4, TabbarHeight - 30)];
    colView.backgroundColor = [UIColor whiteColor];
    [effectView.contentView addSubview:colView];
}

- (void)quitButtonClicked {
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"logOut"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
    NSArray *vcList = self.navigationController.viewControllers;
    dispatch_async(dispatch_get_main_queue(), ^{
        [vcList[0] presentViewController:[[LoginViewController alloc]init] animated:YES completion:nil];
    });

    
}

- (void)changePwdButtonClicked {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_noNetWorkingView) {
        [self.noNetWorkingView removeFromSuperview];
        self.noNetWorkingView = nil;
    }
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
    }
    //加载完成
    if (!self.webView.isLoading) {
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0;
        }];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [UIView animateWithDuration:0.5 animations:^{
        self.progressView.alpha = 0;
    }];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (error) {
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0;
        }];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.view addSubview:self.noNetWorkingView];
    }
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end
