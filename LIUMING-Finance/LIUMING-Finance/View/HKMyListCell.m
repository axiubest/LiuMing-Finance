//
//  HKMyListCell.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKMyListCell.h"
@interface HKMyListCell()
@property (weak, nonatomic) IBOutlet UIView *bodyView;

@end
@implementation HKMyListCell
+(HKMyListCell *)myListCell{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.footerBtn.layer setBorderWidth:1.0];
    [self.footerBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
    //    self.everyMonth.backgroundColor = [UIColor yellowColor];
    self.footerBtn.layer.cornerRadius = 14;
    self.footerBtn.layer.masksToBounds = YES;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
