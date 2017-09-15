//
//  MyManagerCell.h
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/9/1.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ManagerModel;
@interface MyManagerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *describtionLab;
@property (weak, nonatomic) IBOutlet UILabel *timeOrStatusLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *weChatView;

- (void)setValueWithModel:(ManagerModel *)mod;
@end
