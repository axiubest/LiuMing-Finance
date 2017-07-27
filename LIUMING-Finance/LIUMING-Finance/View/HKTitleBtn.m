//
//  HKTitleBtn.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKTitleBtn.h"

@implementation HKTitleBtn

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHexString:@"#328cfe"] forState:UIControlStateDisabled];
        self.titleLabel.font = NB_FONT(15);
    }
    return self;
}

@end
