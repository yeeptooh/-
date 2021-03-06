//
//  TownViewController.h
//  WeiKe
//
//  Created by 张冬冬 on 16/3/31.
//  Copyright © 2016年 Ji_YuFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnTown)(NSString *townName, NSInteger row);
@interface TownViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *townList;
@property (nonatomic, copy) ReturnTown returnTown;
@end
