//
//  Feedback_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "Feedback_ViewController.h"

@interface Feedback_ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation Feedback_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)request {
    if (_textField.text.length < 1) {
        XIUHUD(@"请填写意见");
        return;
    }
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:@"Index/do_feedback" withParams:@{@"ui_id":[XIU_Login userId], @"fk_content":_textField.text} withMethodType:Post andBlock:^(id data, NSError *error) {
        XIUHUD(@"您的意见已经提交");
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0* NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}
- (IBAction)clickCommit:(id)sender {
    [self request];

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
