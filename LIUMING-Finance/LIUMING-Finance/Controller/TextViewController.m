//
//  TextViewController.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/7/29.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController



- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
    {
        if ([_type isEqualToString:@"地址"]) {
            
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
            NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
            [dics setValue:_textField.text forKey:@"ui_address"];
            
            [[NSUserDefaults standardUserDefaults]setObject:dics forKey:kLoginUserDict] ;
        }

        if ([_type isEqualToString:@"姓名"]) {
            
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
            NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
            [dics setValue:_textField.text forKey:@"ui_name"];
            
            [[NSUserDefaults standardUserDefaults]setObject:dics forKey:kLoginUserDict] ;
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if ([_type isEqualToString:@"地址"]) {
        _textField.text = [XIU_Login ui_address];
    }if ([_type isEqualToString:@"姓名"]) {
        _textField.text = [XIU_Login ui_name];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
