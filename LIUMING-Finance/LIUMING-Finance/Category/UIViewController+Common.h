//
//  UIViewController+Common.h
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/7/16.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Common)

//load cell name of nib
+ (UINib *)XIU_ClassNib;

//load cell name of identifier
+(NSString *)XIU_ClassIdentifier;

+(UIViewController *)loadViewControllerFromMainStoryBoard;
@end
