//
//  TextViewController.h
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/7/29.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+BackButtonHandler.h"

@interface TextViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSString *type;
@end
