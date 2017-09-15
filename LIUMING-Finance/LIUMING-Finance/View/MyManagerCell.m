//
//  MyManagerCell.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/9/1.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "MyManagerCell.h"
#import "ManagerModel.h"

@interface MyManagerCell ()
{
    ManagerModel *tmpModel;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLab;
@property (weak, nonatomic) IBOutlet UILabel *weChatlab;


@end

@implementation MyManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_phoneView bk_whenTapped:^{
        
        if (tmpModel.ui_phone.length > 0) {
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",tmpModel.ui_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview.superview animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"手机号码为空";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
            
    }
}];
    
    [_weChatView bk_whenTapped:^{
        if (tmpModel.ui_qqwx.length > 0) {
            UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string=tmpModel.ui_qqwx;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview.superview animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"复制成功，现在您可以去粘贴了";
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1.5];

        }else {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview.superview animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"微信号码为空";
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1.5];
        }
    }];
}

- (void)setValueWithModel:(ManagerModel *)mod {
    tmpModel = mod;
    _nameLab.text = mod.ui_name;
    _timeLab.text = mod.ui_addtime;
    _moneyLab.text =[NSString stringWithFormat:@"¥%@", mod.oi_jkprice];
    _phoneNumLab.text = mod.ui_phone;
    _weChatlab.text = mod.ui_qqwx;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
