//
//  Register_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "GetPwdViewController.h"
#import "Login_ViewController.h"
@interface GetPwdViewController ()
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

@end

@implementation GetPwdViewController

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
        NSLog(@"%ld", _count);
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    
    if (_phoneTextField.text.length != 11) {
        hud.labelText = @"手机号输入错误";
        [hud hide:YES afterDelay:3];
        return;
    }if (![_pswTextField.text isEqualToString:_surePswTextField.text]) {
        hud.labelText = @"两次密码输入不一致";
        [hud hide:YES afterDelay:3];
        return;
    }if (_codeTextField.text.length != 6) {
        hud.labelText = @"验证码输入错误";
        [hud hide:YES afterDelay:3];
        return;
        
    }
    [self request];
    
    
}

- (void)request {
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_forgotpwd withParams:@{@"ui_phone":_phoneTextField.text, @"ui_pwd":_pswTextField.text, @"again_ui_pwd":_surePswTextField.text, @"cd_code":_codeTextField.text} withMethodType:Post andBlock:^(id data, NSError *error) {
        if ([data[@"status"] isEqualToString:@"nouser"]) {
            XIUHUD(@"手机号不存在");
            return ;
        }
        if ([data[@"status"] isEqualToString:@"code_false"]) {
            XIUHUD(@"验证码错误");
            return ;
        }
        if ([data[@"status"] isEqualToString:@"overdue"]) {
            XIUHUD(@"验证码过期");
            return ;
        }
        if ([data[@"status"] isEqualToString:@"success"]) {
            XIUHUD(@"注册成功");
            Login_ViewController *vc = [[Login_ViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
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
