//
//  HKProfitCell.h
//  LIUMING-Finance
//
//  Created by Mac on 17/7/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKProfitCell : UITableViewCell
+(HKProfitCell *)profitCell;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle1Label;
@property (weak, nonatomic) IBOutlet UILabel *subTitle2Label;

@end
