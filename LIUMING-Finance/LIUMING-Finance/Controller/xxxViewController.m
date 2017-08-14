//
//  xxxViewController.m
//  LIUMING-Finance
//
//  Created by Apple on 2017/8/14.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "xxxViewController.h"
#import "AutographView.h"
@interface xxxViewController ()

@end

@implementation xxxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   AutographView *v =  [[NSBundle mainBundle]loadNibNamed:[AutographView XIU_ClassIdentifier] owner:self options:nil].lastObject;
    v.frame = CGRectMake(10, 100, KWIDTH-20, KHEIGHT);
    [self.view addSubview:v];
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
