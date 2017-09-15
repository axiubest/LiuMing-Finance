//
//  FileGlobalReference.h
//  MDObj
//
//  Created by Apple on 17/6/15.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#ifndef FileGlobalReference_h
#define FileGlobalReference_h

#import "XIU_ViewController.h"
#import "UIViewController+Common.h"
#import "XIU_HiddenNavViewController.h"
#import "XIU_NetAPIClient.h"
#import "Masonry.h"
#import "XIU_User.h"
#import "XIU_Login.h"
#import "Masonry.h"
#import "MBProgressHUD.h"



#import "UIView+Frame.h"
#import "UIColor+Hex.h"
#import "UIView+BlocksKit.h"
#import "UIView+Common.h"
#import "UIViewController+BackButtonHandler.h"



#define API_doLogin @"Login/doLogin"
#define API_doPage1 @"Login/doxiaoxi"
#define API_doPage2 @"Login/doxiaoxi2"

#define API_doRegister @"Login/doRegister"
#define API_code @"Login/code"
#define API_List @"Index/my_order"
#define API_profit @"Index/profit"
#define API_applying @"Index/do_applying"
#define API_my_index @"Index/my_index"
#define API_home @"Index/index"
#define API_forgotpwd @"Login/resetpsd"
#define API_Apply @"Index/applyMoney"
#define API_updateUser @"Index/updateUser"
#define API_payment @"Index/payment"
#define API_repay @"Index/repay"
#define API_plan @"Index/plan"
#define API_my_customer @"Index/my_customer"


#endif /* FileGlobalReference_h */

#define XIUHUD(MSG) MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];\
hud.mode = MBProgressHUDModeText;\
hud.labelText = MSG;\
hud.removeFromSuperViewOnHide = YES;\
[hud hide:YES afterDelay:1.5];

