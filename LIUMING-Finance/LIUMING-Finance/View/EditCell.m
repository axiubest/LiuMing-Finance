//
//  EditCell.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/7/22.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "EditCell.h"

@implementation EditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _editBtn.layer.cornerRadius = 22;
    _editBtn.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
