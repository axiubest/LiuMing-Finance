//
//  OrderDetailCell.h
//  LIUMING-Finance
//
//  Created by Apple on 2017/8/28.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

@property (weak, nonatomic) IBOutlet UILabel *rightLab1;
@property (weak, nonatomic) IBOutlet UILabel *rightLab2;
@end
