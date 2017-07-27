//
//  HKButton.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/10.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKButton.h"

@implementation HKButton



-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = 72;
    CGFloat imgH = 72;
    self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
//    CGFloat titleX = 0;
    CGFloat titleY = imgH+10;
    CGSize size = [self.titleLabel.text sizeWithFont:NB_FONT(14)];
    self.titleLabel.x = (self.width-size.width)*0.5;
    self.titleLabel.y = titleY;
    self.titleLabel.width = imgW;
    self.titleLabel.height = 40;
}

@end
