//
//  UIViewController+Common.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/7/16.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "UIViewController+Common.h"
#import "NSString+Common.h"

@implementation UIViewController (Common)



+(UIViewController *)loadViewControllerFromMainStoryBoard {
  return  [[UIStoryboard storyboardWithName: @"Main"bundle:nil] instantiateViewControllerWithIdentifier:[self XIU_ClassIdentifier]];
}

#pragma mark DefaultNib
+ (UINib *)XIU_ClassNib {
    return [UINib nibWithNibName:[self XIU_NibName] bundle:nil];
}

+(NSString *)XIU_ClassIdentifier {
    return [self XIU_NibName];
}

+ (NSString *)XIU_NibName {
    /* Swift has "Namespaced" class names that prepend the module
     * For instance: "Wikipedia.MyCellClassName"
     * So we need to remove the "Wikipedia." for this to work
     */
    return [NSStringFromClass(self) xiu_substringAfterString:@"."];
}

@end
