//
//  Section2DetailTableViewCell.h
//  WeiKe
//
//  Created by Ji_YuFeng on 16/1/23.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Section2DetailTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *typeLabel;


@property (weak, nonatomic) IBOutlet UIButton *ServiceClassify;

@property (weak, nonatomic) IBOutlet UIButton *ProductType;
@property (weak, nonatomic) IBOutlet UIButton *ProductNum;

@property (weak, nonatomic) IBOutlet UIButton *OutNum;

@property (weak, nonatomic) IBOutlet UIButton *BuyShop;

@property (weak, nonatomic) IBOutlet UIButton *BuyTime;


@end
