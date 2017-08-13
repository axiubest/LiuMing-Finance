//
//  ContractCell.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/8/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "ContractCell.h"

@implementation ContractCell

- (void)setDta:(ContractModel *)model {
    _headerTitleLabel.text =[NSString stringWithFormat:@"订单编号：%@",model.oi_id];
    _bodyTitleLabel.text = [NSString stringWithFormat:@"借款%@元，分%@期",model.oi_jkprice, model.oi_jkloans];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.JuJianBtn.layer setBorderWidth:1.0];
    [self.JuJianBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
    self.JuJianBtn.layer.cornerRadius = 14;
    self.JuJianBtn.layer.masksToBounds = YES;
    
    [self.ShouJuBtn.layer setBorderWidth:1.0];
    [self.ShouJuBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
    self.ShouJuBtn.layer.cornerRadius = 14;
    self.ShouJuBtn.layer.masksToBounds = YES;
    
    [self.borrowBtn.layer setBorderWidth:1.0];
    [self.borrowBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
    self.borrowBtn.layer.cornerRadius = 14;
    self.borrowBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
