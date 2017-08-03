//
//  Feedback_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "Feedback_ViewController.h"

@interface Feedback_ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation Feedback_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.textContainerInset = UIEdgeInsetsMake(12, 12, 0, 0);
//    self.textView.contentMode = UIViewContentModeTopLeft;
    [self.textView.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 196.0/255, 196.0/255, 196.0/255, 1 });
    [self.textView.layer setBorderColor:colorref];//边框颜色
    [self.textView.layer setBorderWidth:1.0]; //边框宽度
    
}
- (IBAction)clickCommit:(id)sender {
    XIUHUD(@"您的意见已经提交");
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0* NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
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
