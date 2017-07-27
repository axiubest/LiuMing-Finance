//
//  UIBarButtonItem+XMGExtension.h
//  备课-百思不得姐
//
//  Created by MJ Lee on 15/6/15.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XMGExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
