//
//  ContractCell.h
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/8/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContractModel.h"

@protocol ContractCellDelegate <NSObject>


//居间协议
- (void)clickJuJianBtnWithOi_pdf:(NSString *)pdf Oi_htid:(NSString *)oi_htid Type:(NSString *)type;


//收据合同
- (void)clickShouJuBtnWithOi_pdf:(NSString *)pdf Oi_htid:(NSString *)oi_htid Type:(NSString *)type;

//借款合同
- (void)clickJieKuanBtnWithOi_pdf:(NSString *)pdf Oi_htid:(NSString *)oi_htid Type:(NSString *)type;
@end

@interface ContractCell : UITableViewCell


@property (assign, nonatomic) id<ContractCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodySubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *footerTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *borrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *JuJianBtn;
@property (weak, nonatomic) IBOutlet UIButton *ShouJuBtn;


- (void)setDta:(ContractModel *)model;
@end
