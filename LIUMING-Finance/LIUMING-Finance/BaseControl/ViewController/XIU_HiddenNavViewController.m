//
//  XIU_HiddenNavViewController.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/6/19.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_HiddenNavViewController.h"

@interface XIU_HiddenNavViewController ()

@end

@implementation XIU_HiddenNavViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
