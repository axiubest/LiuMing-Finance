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
    
}

- (void)request {
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_doLogin withParams:@{@"ui_phone":_phoneTextField.text, @"ui_pwd":_passwordTextField.text} withMethodType:Post andBlock:^(id data, NSError *error) {
        
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
          [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    }];
    
 
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.view endEditing:YES];

}
@end
