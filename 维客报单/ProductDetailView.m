//
//  ProductDetailView.m
//  WeiKe
//
//  Created by 张冬冬 on 16/3/30.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import "ProductDetailView.h"
#import "UserModel.h"
#import "NicoNetworking.h"
#import "BreedViewController.h"
#import "ClassifyViewController.h"

@interface ProductDetailView ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>
@property (nonatomic, strong) NSMutableArray *breedList;
@property (nonatomic, strong) NSMutableArray *productNameList;
@property (nonatomic, strong) NSMutableArray *productIDList;
@property (nonatomic, strong) NSMutableArray *classifyNameList;
@property (nonatomic, strong) NSMutableArray *classifyIDList;

@end
@implementation ProductDetailView

- (NSMutableArray *)breedList{
    if (!_breedList) {
        _breedList = [NSMutableArray array];
    }
    return _breedList;
}

- (NSMutableArray *)productNameList {
    if (!_productNameList) {
        _productNameList = [NSMutableArray array];
    }
    return _productNameList;
}

- (NSMutableArray *)productIDList{
    if (!_productIDList) {
        _productIDList = [NSMutableArray array];
    }
    return _productIDList;
}

- (NSMutableArray *)classifyNameList{
    if (!_classifyNameList) {
        _classifyNameList = [NSMutableArray array];
    }
    return _classifyNameList;
}

- (NSMutableArray *)classifyIDList{
    if (!_classifyIDList) {
        _classifyIDList = [NSMutableArray array];
    }
    return _classifyIDList;
}


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.baseFrame = frame;
        self.delegate = self;
        self.dataSource = self;
        [self netWorkingRequest];
        self.backgroundColor = color(241, 241, 241, 1);
        self.tableFooterView = [[UIView alloc]init];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (Height - StatusBarAndNavigationBarHeight)/12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *labelList = @[
                           @"商品属性",
                           @"类 别",
                           @"产品型号",
                           @"产品数量",
                           @"购买商场",
                           ];
    static NSString *identifier = @"Mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width/4, 40)];
    label.text = labelList[indexPath.row];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentRight;
    
    cell.backgroundColor = [UIColor clearColor];
    [cell addSubview:label];
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTintColor:[UIColor blackColor]];
        button.frame = CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10);
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor whiteColor];
        button.tag = indexPath.row + 200;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if (indexPath.row == 0) {
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"productName"]);
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch"]) {
                [button setTitle:@"" forState:UIControlStateNormal];
            }else {
                [button setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"productName"] forState:UIControlStateNormal];
            }
            
 
        }
        
        if (indexPath.row == 1) {
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"classifyName"]);
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch"]) {
                [button setTitle:@"" forState:UIControlStateNormal];
            }else {
                [button setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"classifyName"] forState:UIControlStateNormal];
            }
        }

    }else{
        
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(Width *5/16, 5, Width*10/16, (Height - StatusBarAndNavigationBarHeight)/12 - 10)];
        textfield.delegate = self;
        textfield.layer.cornerRadius = 5;
        textfield.font = [UIFont systemFontOfSize:14];
        textfield.layer.masksToBounds = YES;
        textfield.backgroundColor = [UIColor whiteColor];
        if (indexPath.row == 3) {
            textfield.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (indexPath.row == 4) {
            textfield.returnKeyType = UIReturnKeyDone;
        }
        textfield.tag = 100 + indexPath.row;
        [cell addSubview:textfield];
        
    }
    
    return cell;
}


- (void)netWorkingRequest {
    UserModel *userModel = [UserModel readUserModel];
    NSDictionary *params = @{
                             @"comid":@(userModel.CompanyID)
                             };
    [NicoNetworking nicoGetWithBaseURL:HomeUrl subURL:@"/Task.ashx?action=getproductbreed" parameters:params success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        for (NSDictionary *dic in responseObject[@"list"]) {
            [self.productNameList addObject:dic[@"Name"]];
            [self.productIDList addObject:dic[@"ID"]];
        }
        
        self.productID = [self.productIDList[0] integerValue];
        [[NSUserDefaults standardUserDefaults] setObject:self.productNameList forKey:@"productNameList"];
        [[NSUserDefaults standardUserDefaults] setObject:self.productNameList[0] forKey:@"productName"];
        [[NSUserDefaults standardUserDefaults] setInteger:self.productID forKey:@"productID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSDictionary *params = @{@"comid":@(userModel.CompanyID),@"parent":@(self.productID)};
        [NicoNetworking nicoGetWithBaseURL:HomeUrl subURL:@"/Task.ashx?action=getproductclassify" parameters:params success:^(id responseObject) {
            for (NSDictionary *dic in responseObject[@"list"]) {
                [self.classifyNameList addObject:dic[@"Name"]];
                [self.classifyIDList addObject:dic[@"ID"]];
            }
            self.classifyID = [self.classifyIDList[0] integerValue];
            
            [[NSUserDefaults standardUserDefaults] setObject:self.classifyNameList forKey:@"classifyNameList"];
            [[NSUserDefaults standardUserDefaults] setObject:self.classifyNameList[0] forKey:@"classifyName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } failure:^(NSError *error) {
            
        }];
    
    } failure:^(NSError *error) {
        
    }];

}

- (void)buttonClicked:(UIButton *)sender {
    [self endEditing:YES];
    if (sender.tag == 200) {
        BreedViewController *breedVC = [[BreedViewController alloc]init];
        breedVC.breedList = self.productNameList;
        breedVC.returnBreed = ^(NSString *name, NSInteger row){
            [sender setTitle:name forState:UIControlStateNormal];
            
            UserModel *userModel = [UserModel readUserModel];

            NSInteger ID = [self.productIDList[row] integerValue];
            self.productID = ID;

            NSDictionary *params = @{@"comid":@(userModel.CompanyID),@"parent":@(self.productID)};
            
            [NicoNetworking nicoGetWithBaseURL:HomeUrl subURL:@"/Task.ashx?action=getproductclassify" parameters:params success:^(id responseObject) {
                if (self.classifyNameList.count) {
                    [self.classifyNameList removeAllObjects];
                    [self.classifyIDList  removeAllObjects];
                }
                
                for (NSDictionary *dic in responseObject[@"list"]) {
                    [self.classifyNameList addObject:dic[@"Name"]];
                    [self.classifyIDList addObject:dic[@"ID"]];
                }
                
                UIButton *btn = [self viewWithTag:201];
                [btn setTitle:self.classifyNameList[0] forState:UIControlStateNormal];
            } failure:^(NSError *error) {
                
            }];
            
        };
        
        [[self viewController] presentViewController:breedVC animated:YES completion:nil];

    }else {
        
        ClassifyViewController *classifyVC = [[ClassifyViewController alloc]init];
        classifyVC.classifyList = self.classifyNameList;
        classifyVC.returnClassify = ^(NSString *name , NSInteger row){
            [sender setTitle:name forState:UIControlStateNormal];
            
            self.classifyID = [self.classifyIDList[row] integerValue];
            
        };
        
        [[self viewController] presentViewController:classifyVC animated:YES completion:nil];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 104) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.frame;
            frame.origin.y = frame.origin.y - 50;
            
            self.frame = frame;
        }];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 104) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = self.baseFrame;
        }];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 104) {
        [self endEditing:YES];
    }else{
        UITextField *lastTextField = (UITextField *)[self viewWithTag:textField.tag];
        [lastTextField resignFirstResponder];
        
        UITextField *nextTextField = (UITextField *)[self viewWithTag:textField.tag + 1];
        [nextTextField becomeFirstResponder];
        
    }
    
    return YES;
}


- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
