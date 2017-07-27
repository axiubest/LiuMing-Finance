//
//  HKFinancialContributionCell.h
//  LIUMING-Finance
//
//  Created by Mac on 17/7/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKFinancialContributionCell : UITableViewCell
+(HKFinancialContributionCell *)financialContributionCell;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodySubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *footerTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *footerBtn;
@property (weak, nonatomic) IBOutlet UILabel *bodyFineLabel;
@property (weak, nonatomic) IBOutlet UIButton *footerZFBBtn;

@end
