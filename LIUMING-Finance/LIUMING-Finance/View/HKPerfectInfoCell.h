//
//  HKPerfectInfoCell.h
//  LIUMING-Finance
//
//  Created by Mac on 17/7/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKPerfectInfoCell : UITableViewCell
+(HKPerfectInfoCell *)perfectInfoCell;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end
