//
//  HKFinancialContributionCell.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKFinancialContributionCell.h"

@implementation HKFinancialContributionCell
+(HKFinancialContributionCell *)financialContributionCell{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.footerBtn.layer setBorderWidth:1.0];
    [self.footerBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
    self.footerBtn.layer.cornerRadius = 14;
    self.footerBtn.layer.masksToBounds = YES;
    
    [self.footerZFBBtn.layer setBorderWidth:1.0];
    [self.footerZFBBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){101/255.0, 101/255.0, 101/255.0, 1 })];
    self.footerZFBBtn.layer.cornerRadius = 14;
    self.footerZFBBtn.layer.masksToBounds = YES;
    
}


@end
