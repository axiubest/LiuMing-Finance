//
//  HKTabBarViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/10.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKTabBarViewController.h"

@interface HKTabBarViewController ()

@end

@implementation HKTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the vie
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8f8f8f" alpha:1.0],NSFontAttributeName:NB_FONT(10)} forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#1a71ff" alpha:1.0],NSFontAttributeName:NB_FONT(10)} forState:UIControlStateSelected];
    
//    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffset]
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
