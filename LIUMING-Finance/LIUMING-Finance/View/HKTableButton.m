//
//  HKTableButton.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKTableButton.h"

@implementation HKTableButton

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imgW = 47;
    CGFloat imgH = 40;
    CGFloat imgX = (self.width-imgW)*0.5;
    CGFloat imgY = 0;
    self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    //    CGFloat titleX = 0;
    CGFloat titleY = imgH+1;
    CGSize size = [self.titleLabel.text sizeWithFont:NB_FONT(12)];
    self.titleLabel.x = (self.width-size.width)*0.5;
    self.titleLabel.y = titleY;
    self.titleLabel.width = imgW;
    self.titleLabel.height = 40;
}

@end
