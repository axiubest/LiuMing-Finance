//
//  ContractCell.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/8/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "ContractCell.h"
@interface ContractCell ()
{
    ContractModel *tmpModel;
}
@end

@implementation ContractCell



- (void)setDta:(ContractModel *)model {
    tmpModel = model;
    _headerTitleLabel.text =[NSString stringWithFormat:@"订单编号：%@",model.oi_num];
    _bodyTitleLabel.text = [NSString stringWithFormat:@"借款%@元，分%@期",model.oi_jkprice, model.oi_jkloans];
    _footerTitleLabel.text = [NSString stringWithFormat:@"借款日期：%@", model.hktime];
    
    if ([model.oi_sign4 isEqualToString:@"1"]) {
        //居间合同已经签署
        [_JuJianBtn setTitle:@"居间已签署" forState:UIControlStateNormal];
    }if ([model.oi_sign5 isEqualToString:@"1"]) {
        //借款合同已经签署
        [_borrowBtn setTitle:@"借款已签署" forState:UIControlStateNormal];
    }if ([model.oi_sign3 isEqualToString:@"1"]) {
        //借款合同已经签署
        [_ShouJuBtn setTitle:@"收据已签署" forState:UIControlStateNormal];
    }
    
    
    
    
    //第三方合同处理
    if ([[XIU_Login type] isEqualToString:ThirdType]) {
        if ([model.oi_sign1 isEqualToString:@"1"]) {
            //居间合同已经签署
            [_JuJianBtn setTitle:@"居间已签署" forState:UIControlStateNormal];
        }if ([model.oi_sign2 isEqualToString:@"1"]) {
            //借款合同已经签署
            [_borrowBtn setTitle:@"借款已签署" forState:UIControlStateNormal];
        }
    }


    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.JuJianBtn.layer setBorderWidth:1.0];
    [self.JuJianBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
    self.JuJianBtn.layer.cornerRadius = 14;
    self.JuJianBtn.layer.masksToBounds = YES;
    
    [self.ShouJuBtn.layer setBorderWidth:1.0];
    [self.ShouJuBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
    self.ShouJuBtn.layer.cornerRadius = 14;
    self.ShouJuBtn.layer.masksToBounds = YES;
    
    [self.borrowBtn.layer setBorderWidth:1.0];
    [self.borrowBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
    self.borrowBtn.layer.cornerRadius = 14;
    self.borrowBtn.layer.masksToBounds = YES;
}

- (IBAction)clickJuJian:(id)sender {
    if (!(tmpModel.oi_htid1.length > 0)) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"合同未生成";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        return;
    }
    //居间
    [_delegate clickJuJianBtnWithOi_pdf:tmpModel.oi_pdf1 Oi_htid:tmpModel.oi_id Type:@"1" Oi_sign:tmpModel.oi_sign4];
}
- (IBAction)clickJieKuan:(id)sender {
    if (!(tmpModel.oi_htid2.length > 0)) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"合同未生成";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        return;
    }
    
    //借款
    [_delegate clickJieKuanBtnWithOi_pdf:tmpModel.oi_pdf2 Oi_htid:tmpModel.oi_id Type:@"2" Oi_sign:tmpModel.oi_sign5];
}
- (IBAction)clickShouJu:(id)sender {
    if (!(tmpModel.oi_htid3.length > 0)) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"合同未生成";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        return;
    }
    [_delegate clickShouJuBtnWithOi_pdf:tmpModel.oi_pdf3 Oi_htid:tmpModel.oi_id Type:@"3" Oi_sign:tmpModel.oi_sign3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
