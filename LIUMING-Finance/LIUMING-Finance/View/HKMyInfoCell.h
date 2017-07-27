//
//  HKMyInfoCell.h
//  LIUMING-Finance
//
//  Created by Mac on 17/7/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKMyInfoCell : UITableViewCell
+(HKMyInfoCell *)myInfoCell;
@property (weak, nonatomic) IBOutlet UILabel *infoTitle;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (weak, nonatomic) IBOutlet UIImageView *subImg;
@property (weak, nonatomic) IBOutlet UILabel *SubTitle;
@property (weak, nonatomic) IBOutlet UILabel *infoSubTitle;

@end
