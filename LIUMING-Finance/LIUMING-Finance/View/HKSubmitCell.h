//
//  HKSubmitCell.h
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HKSubmitCell;
@protocol HKSubmitCellDelegate<NSObject>
-(void)submitCellBtnClick:(HKSubmitCell *)cell;
@end
@interface HKSubmitCell : UITableViewCell
+(HKSubmitCell *)submitCell;
@property (nonatomic,copy) NSString *btnStr;
@property (weak, nonatomic) IBOutlet UIButton *doBtn;

@property (nonatomic,weak) id<HKSubmitCellDelegate> myDelegate;
@end
