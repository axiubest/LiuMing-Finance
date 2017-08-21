//
//  Login_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/13.
//  Copyright © 2017年 XIU. All rights reserved.
//
#import "MJExtension.h"

#import "Login_ViewController.h"
#import "Register_ViewController.h"
#import "HKNavigationController.h"
#import "FinancialContribution_ViewController.h"
#import "MyList_ViewController.h"
#import "Manager_ViewController.h"
#import "Contract_ViewController.h"
@interface Login_ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation Login_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)ClickForgot:(id)sender {
//    Register_ViewController *r = [[Register_ViewController alloc] init];
//    r.isResign = NO;
//    [self presentViewController:r animated:YES completion:nil];
}

- (IBAction)clickResign:(id)sender {
    Register_ViewController *r = [[Register_ViewController alloc] init];
    
    [self.navigationController pushViewController:r animated:YES];
}

- (IBAction)loginBtnClick:(id)sender {
    

    if (_phoneTextField.text.length != 11) {
        XIUHUD(@"手机号输入错误");

        return;
    }
    if (_passwordTextField.text.length < 5) {
        XIUHUD(@"密码格式错误");

        return;
    }
    [self request];
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
}

- (void)request {
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        
        hud.removeFromSuperViewOnHide = YES;
        [hud show:YES];

    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_doLogin withParams:@{@"ui_phone":_phoneTextField.text, @"ui_pwd":_passwordTextField.text} withMethodType:Post andBlock:^(id data, NSError *error) {
        [hud hide:YES];
        if ([data[@"status"] isEqualToString:@"nouser"]) {
            
            XIUHUD(@"账号密码错误");
            return ;
        } if ([data[@"status"] isEqualToString:@"Locked"]) {
            
            XIUHUD(@"账号被锁定");
            return ;
        }
        
        id requestData = data[@"data"];
            [XIU_Login doLogin:requestData];
        NSLog(@"%@--", kPathDocument);
        
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"正在登录";
    hud.removeFromSuperViewOnHide = YES;

        if ([[XIU_Login type] isEqualToString:@"3"] || [[XIU_Login type] isEqualToString:@"7"]) {
            [hud hide:YES];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
            
        }if ([[XIU_Login type] isEqualToString:@"2"]) {
            [hud hide:YES];

            FinancialContribution_ViewController *v = [[FinancialContribution_ViewController alloc] init];
            HKNavigationController *nav = [[HKNavigationController alloc] initWithRootViewController:v];
           [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            
            
        }if ([[XIU_Login type] isEqualToString:@"5"]) {
            [hud hide:YES];
            MyList_ViewController *v = [[MyList_ViewController alloc] init];
            v.title = @"催收订单";
            HKNavigationController *nav = [[HKNavigationController alloc] initWithRootViewController:v];
             [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            
        }if ([[XIU_Login type] isEqualToString:ManagerType]) {
            [hud hide:YES];
            Manager_ViewController *v = [[Manager_ViewController alloc] init];
            v.title = @"客户经理";
            HKNavigationController *nav = [[HKNavigationController alloc] initWithRootViewController:v];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        }if ([[XIU_Login type] isEqualToString:ThirdType]) {//第三方人员显示合同列表
            Contract_ViewController *v = [[Contract_ViewController alloc] init];
            v.title = @"合同列表";
            HKNavigationController *nav = [[HKNavigationController alloc] initWithRootViewController:v];
              [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        }

    }];
    
 
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.view endEditing:YES];
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];

}
@end
