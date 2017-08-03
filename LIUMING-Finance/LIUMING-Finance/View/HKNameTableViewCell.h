//
//  HKNameTableViewCell.h
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKNameTableViewCell;
@protocol HKNameTableViewCellDelegate<NSObject>
-(void)nameTableProfitViewClick:(HKNameTableViewCell *)view;
-(void)nameTableViewCellClick:(HKNameTableViewCell *)view;
@end

@interface HKNameTableViewCell : UITableViewCell
+(HKNameTableViewCell *)nameTableVeiwCell;
@property (nonatomic,weak) id<HKNameTableViewCellDelegate> myDelegate;
@property (weak, nonatomic) IBOutlet UILabel *canUseMoneyLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UIImageView *userIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *tjr_nameLab;
@property (weak, nonatomic) IBOutlet UILabel *getMoneyLab;

@end
