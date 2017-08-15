//
//  HKMyTableViewCell.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "My_ToolCell.h"

@interface My_ToolCell ()

@property (weak, nonatomic) IBOutlet UIView *borrowView;
@property (weak, nonatomic) IBOutlet UIView *giveBackView;
@property (weak, nonatomic) IBOutlet UIView *overdueView;
@property (weak, nonatomic) IBOutlet UIView *overView;
@end
@implementation My_ToolCell

+(My_ToolCell *)myTableVeiwCell{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}




- (void)awakeFromNib {
    [super awakeFromNib];
    [_borrowView bk_whenTapped:^{
        [_delegate clickMy_ToolCellWithTag:HKListTypeBorrowMoney];
    }];
    [_giveBackView bk_whenTapped:^{
        [_delegate clickMy_ToolCellWithTag:HKListTypeOverMoney];
    }];
    [_overdueView bk_whenTapped:^{
        [_delegate clickMy_ToolCellWithTag:HKListTypeOverdue];
    }];
    [_overView bk_whenTapped:^{
        [_delegate clickMy_ToolCellWithTag:4];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
