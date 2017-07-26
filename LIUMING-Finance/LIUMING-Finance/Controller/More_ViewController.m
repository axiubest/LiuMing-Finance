//
//  More_ViewController.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/6/19.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "More_ViewController.h"

@interface More_ViewController ()

@end

@implementation More_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpTabbarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpTabbarItem{
    self.tabBarItem.title = @"更多";
    self.tabBarItem.image = [UIImage imageNamed:@"更多"];
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"更多1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
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
