//
//  HKBaseTableViewCell.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKBaseTableViewCell.h"
#import "HKBaseTableModel.h"
@interface HKBaseTableViewCell()



@end
@implementation HKBaseTableViewCell
+(HKBaseTableViewCell *)baseTableVeiwCell{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HKBaseTableModel *)model{
    _model = model;
    self.iconImage.image = [UIImage imageNamed:model.iconImg];
    self.iconLabel.text = model.iconTitle;
    if (model.subTitle) {
        self.subLabel.text = model.subTitle;
        self.subLabel.hidden = NO;
        self.rowImage.hidden = YES;
    }else{
        self.subLabel.hidden = YES;
        self.rowImage.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
