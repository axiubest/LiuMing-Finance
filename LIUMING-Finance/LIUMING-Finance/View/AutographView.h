//
//  AutographView.h
//  LIUMING-Finance
//
//  Created by Apple on 2017/8/14.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYDrawView.h"
@interface AutographView : UIView
@property (weak, nonatomic) IBOutlet UIButton *clearbtn;
@property (weak, nonatomic) IBOutlet UIButton *generateBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;


@property (weak, nonatomic) IBOutlet MYDrawView *autographView;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end
