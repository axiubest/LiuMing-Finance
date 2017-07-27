//
//  HKBaseTableViewCell.h
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKBaseTableModel ;
@interface HKBaseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rowImage;

+(HKBaseTableViewCell *)baseTableVeiwCell;

@property (nonatomic,strong)HKBaseTableModel *model;
@end
