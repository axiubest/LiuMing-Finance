//
//  HKPerfectInfoView.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKPerfectInfoView.h"

@implementation HKPerfectInfoView
+(HKPerfectInfoView *)perfectInfoView{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
-(void)show{
    self.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)hide{
   
    [self removeFromSuperview];
}

- (IBAction)dismissClick:(id)sender {
    [self hide];
}

- (IBAction)perfectInfoClick:(id)sender {
//    NSLog(@"aaaaa");
    if([self.myDelegate respondsToSelector:@selector(perfectInfoViewBtnClick:)]){
       
        [self.myDelegate perfectInfoViewBtnClick:self];
    }
}



@end
