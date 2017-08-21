//
//  Register_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "Register_ViewController.h"
#import "Login_ViewController.h"
#import "HKNavigationController.h"
#import "FinancialContribution_ViewController.h"
#import "MyList_ViewController.h"
#import "Manager_ViewController.h"
@interface Register_ViewController ()
{
    NSInteger _count;
    NSTimer *_Timer;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePswTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UITextField *recommendTextField;
@end

@implementation Register_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)clickGetCode:(UIButton *)sender {
    if (_phoneTextField.text.length != 11) {
        XIUHUD(@"请输入正确手机号");
        return;
    }
    _count = 60;
    sender.enabled = NO;
    sender.backgroundColor = [UIColor lightGrayColor];
    sender.tintColor = [UIColor darkGrayColor];
    _Timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
   
    [self getCodeRequest];
}


-(void)timerFired:(NSTimer *)timer
{
    if (_count !=1) {
        _count -=1;
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%ld  秒",_count] forState:UIControlStateNormal];
    }
    else
    {
        [timer invalidate];
        self.getCodeBtn.enabled = YES;
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getCodeBtn.backgroundColor = [UIColor colorWithHexString:@"1A71FF"];
        self.getCodeBtn.tintColor = [UIColor whiteColor];
        
    }
}


- (IBAction)registerBtnClick:(id)sender {

    if (_phoneTextField.text.length != 11) {
        XIUHUD(@"手机号输入错误");

        return;
    }if (![_pswTextField.text isEqualToString:_surePswTextField.text]) {
        XIUHUD(@"两次密码输入不一致");

        return;
    }if (_codeTextField.text.length != 6) {
        XIUHUD(@"验证码输入错误");

        return;

    }
    [self request];
    

}

- (void)request {
  
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_doRegister withParams:@{@"ui_phone":_phoneTextField.text, @"ui_pwd":_pswTextField.text, @"again_ui_pwd":_surePswTextField.text, @"cd_code":_codeTextField.text, @"recommend_code":_recommendTextField.text > 0 ? _recommendTextField.text : @""} withMethodType:Post andBlock:^(id data, NSError *error) {
        if ([data[@"status"] isEqualToString:@"user is exists"]) {
            XIUHUD(@"您已注册过账号");
            return ;
        }
        if ([data[@"status"] isEqualToString:@"success"]) {
            XIUHUD(@"注册成功");
            
                [self pushToLogin];
            
        }
    }];
}


- (void)pushToLogin {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_doLogin withParams:@{@"ui_phone":_phoneTextField.text, @"ui_pwd":_pswTextField.text} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        id requestData = data[@"data"];
        [XIU_Login doLogin:requestData];
        if ([[XIU_Login type] isEqualToString:@"3"]||[[XIU_Login type] isEqualToString:@"6"] || [[XIU_Login type] isEqualToString:@"7"]) {

            [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
            
        }if ([[XIU_Login type] isEqualToString:@"2"]) {
            
            
            FinancialContribution_ViewController *v = [[FinancialContribution_ViewController alloc] init];
            HKNavigationController *nav = [[HKNavigationController alloc] initWithRootViewController:v];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            
        }if ([[XIU_Login type] isEqualToString:@"5"]) {
            MyList_ViewController *v = [[MyList_ViewController alloc] init];
            v.title = @"催收订单";
            HKNavigationController *nav = [[HKNavigationController alloc] initWithRootViewController:v];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            
        } if ([[XIU_Login type] isEqualToString:ManagerType]) {
            
            Manager_ViewController *v = [[Manager_ViewController alloc] init];
            v.title = @"客户经理";
            HKNavigationController *nav = [[HKNavigationController alloc] initWithRootViewController:v];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        }
    }];
}
- (void)getCodeRequest {
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_code withParams:@{@"ui_phone":_phoneTextField.text, @"ui_id":@""} withMethodType:Post andBlock:^(id data, NSError *error) {
        
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
