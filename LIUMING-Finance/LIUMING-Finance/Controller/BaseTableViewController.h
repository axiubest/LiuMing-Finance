//
//  HKBaseTableViewController.h
//  LIUMING-Finance
//
//  Created by Mac on 17/7/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController
/** 帖子的类型 */
@property (assign, nonatomic) HKListType type;
@property (nonatomic,strong) NSMutableArray *arr;
@end
