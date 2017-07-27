//
//  HKMyTableViewCell.h
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol My_ToolCellDelegate <NSObject>

- (void)clickMy_ToolCellWithTag:(NSInteger)tag;

@end

@interface My_ToolCell : UITableViewCell
+(My_ToolCell *)myTableVeiwCell;

@property (nonatomic, assign) id<My_ToolCellDelegate> delegate;
@end
