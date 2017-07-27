//
//  HKSlider.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/10.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKSlider.h"

@implementation HKSlider
-(void)awakeFromNib{
    [super awakeFromNib];
        [self setThumbImage:[UIImage imageNamed:@"进度条按钮"] forState:UIControlStateNormal];
        [self setThumbImage:[UIImage imageNamed:@"进度条按钮"] forState:UIControlStateHighlighted];
}
- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, KWIDTH-2*25, 15);
}

@end
