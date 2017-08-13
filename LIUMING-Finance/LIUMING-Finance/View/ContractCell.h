//
//  ContractCell.h
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/8/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContractModel.h"
@interface ContractCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodySubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *footerTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *borrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *JuJianBtn;
@property (weak, nonatomic) IBOutlet UIButton *ShouJuBtn;


- (void)setDta:(ContractModel *)model;
@end
