//
//  LoginViewController.m
//  WeiKe
//
//  Created by Ji_YuFeng on 15/11/24.
//  Copyright © 2015年 Ji_YuFeng. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "NicoNetworking.h"
#import "UserModel.h"
#import "MBProgressHUD.h"
#import "MyDefine.h"

@interface LoginViewController ()
<
UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UIView *LoginBackView;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UITextField *PassWord;
@property (weak, nonatomic) IBOutlet UIView *MainBackView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.PassWord.delegate = self;
    self.UserName.delegate = self;
    
    self.navigationController.navigationBarHidden = YES;
    self.LoginBackView.layer.cornerRadius = 10;
    self.LoginButton.layer.cornerRadius = 10;
    
    
    //取得密码
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"PassWord"];
    
    if (userName) {
        self.UserName.text = userName;
        self.PassWord.text = passWord;
    }
    
}


#pragma mark - 键盘回车 -
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.PassWord resignFirstResponder];
    
    [self loginNetworking];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (iPhone4_4s) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = -145;
            self.view.frame = frame;
        }];
    }else if (iPhone5_5s){
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = -60;
            self.view.frame = frame;
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (iPhone4_4s) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
    }else if (iPhone5_5s){
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.UserName resignFirstResponder];
    [self.PassWord resignFirstResponder];
 
}

- (IBAction)LoginAction:(id)sender {
    [self.view endEditing:YES];
    if ([self.UserName.text isEqualToString:@""] || [self.PassWord.text isEqualToString:@""]) {
        
        MBProgressHUD *hud      = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.minSize = CGSizeMake(100, 100);
        UIImage *image          = [[UIImage imageNamed:@"Checkerror"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView  = [[UIImageView alloc] initWithImage:image];
        hud.customView          = imageView;
        hud.mode                = MBProgressHUDModeCustomView;
        hud.label.numberOfLines = 0;
        hud.label.font          = font(14);
        hud.label.text          = NSLocalizedString(@"用户名或密\n码为空", @"HUD completed title");
        [hud hideAnimated:YES afterDelay:0.75f];
        [hud removeFromSuperViewOnHide];
        return;
    }
        
    [self loginNetworking];
}


- (void)loginNetworking {
    
    MBProgressHUD *hud   = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode             = MBProgressHUDModeIndeterminate;
    hud.minSize          = CGSizeMake(110, 115);
    
    NSDictionary *params = @{
                             @"name":self.UserName.text,
                             @"password":self.PassWord.text,
                             @"action":@"login"
                            };
    
    
    
    [NicoNetworking nicoGetWithBaseURL:HomeUrl subURL:@"/Passport.ashx" parameters:params success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if ([[responseObject objectForKey:@"user"][0][@"State"]integerValue] == 1) {
            //  将用户数据存储到Usermodel
            UserModel *model = [[UserModel alloc]init];
            model.Name       = responseObject[@"user"][0][@"Name"];
            model.UserName   = responseObject[@"user"][0][@"UserName"];
            model.ID         = [responseObject[@"user"][0][@"ID"]integerValue];
            model.CompanyID  = [responseObject[@"user"][0][@"CompanyID"]integerValue];
            [UserModel writeUserModel:model];
            
            [self saveWords];
            //保存登录状态
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hadLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            MBProgressHUD *hud      = [MBProgressHUD HUDForView:self.view];
            UIImage *image          = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIImageView *imageView  = [[UIImageView alloc] initWithImage:image];
            hud.customView          = imageView;
            hud.mode                = MBProgressHUDModeCustomView;
            hud.label.font          = font(14);
            hud.label.text          = NSLocalizedString(@"登录成功", @"HUD completed title");
            [hud hideAnimated:YES afterDelay:0.75f];
            [hud removeFromSuperViewOnHide];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([[NSUserDefaults standardUserDefaults] integerForKey:@"logOut"]) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else{
                    //切换跟视图控制器，之前的跟视图控制器自动释放
                    HomeViewController *home            = [[HomeViewController alloc]init];
                    self.view.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:home];
                }
            });
        }else{
            
            MBProgressHUD *hud      = [MBProgressHUD HUDForView:self.view];
            UIImage *image          = [[UIImage imageNamed:@"Checkerror"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIImageView *imageView  = [[UIImageView alloc] initWithImage:image];
            hud.customView          = imageView;
            hud.mode                = MBProgressHUDModeCustomView;
            hud.label.font          = font(14);
            hud.label.numberOfLines = 0;
            hud.label.text          = NSLocalizedString(@"用户名或密\n码错误", @"HUD completed title");
            [hud hideAnimated:YES afterDelay:0.75f];
            [hud removeFromSuperViewOnHide];
            
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        MBProgressHUD *hud     = [MBProgressHUD HUDForView:self.view];
        UIImage *image         = [[UIImage imageNamed:@"Checkerror"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView         = imageView;
        hud.label.font         = font(14);
        hud.mode               = MBProgressHUDModeCustomView;
        hud.label.text         = NSLocalizedString(@"登录失败", @"HUD completed title");
        [hud hideAnimated:YES afterDelay:0.75f];
        [hud removeFromSuperViewOnHide];
    }];
    
}



#pragma mark - 保存用户名和密码 -
- (void)saveWords{
    [[NSUserDefaults standardUserDefaults] setObject:self.UserName.text forKey:@"UserName"];
    [[NSUserDefaults standardUserDefaults] setObject:self.PassWord.text forKey:@"PassWord"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
