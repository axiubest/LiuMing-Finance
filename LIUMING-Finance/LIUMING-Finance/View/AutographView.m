//
//  AutographView.m
//  LIUMING-Finance
//
//  Created by Apple on 2017/8/14.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "AutographView.h"

@implementation AutographView


/*
 *clearbtn;
 *generateBtn;
 *sureBtn;
 */
-(void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5f;
    
    _img.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _img.layer.borderWidth = 0.5f;
    
    
    [self.autographView.layer setBorderWidth:1.0];
    self.autographView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.clearbtn.layer setBorderWidth:1.0];
    [self.clearbtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
    self.clearbtn.layer.cornerRadius = _clearbtn.height/2;
    self.clearbtn.layer.masksToBounds = YES;
    
    [self.generateBtn.layer setBorderWidth:1.0];
    [self.generateBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
    self.generateBtn.layer.cornerRadius = _generateBtn.height/2;
    self.generateBtn.layer.masksToBounds = YES;
    

    self.sureBtn.layer.cornerRadius = _sureBtn.height/2;
    self.sureBtn.layer.masksToBounds = YES;
}



@end
