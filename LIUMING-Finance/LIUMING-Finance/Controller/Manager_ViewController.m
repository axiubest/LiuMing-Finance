//
//  Manager_ViewController.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/9/1.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "Manager_ViewController.h"
#import "ManagerInfoCell.h"
#import "HKNameRowCell.h"
#import "MyProfit_ViewController.h"
#import "Manager_MyDelegate_ViewController.h"
#import "ManagerStatus_ViewController.h"
#import "Login_ViewController.h"
@interface Manager_ViewController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;

@end

@implementation Manager_ViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 210 : 44;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ManagerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[ManagerInfoCell XIU_ClassIdentifier]];
        [cell.overBtn bk_whenTapped:^{
            ManagerStatus_ViewController *vc = [[ManagerStatus_ViewController alloc] init];
            vc.typeNum = 200;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell.waitBtn bk_whenTapped:^{
            ManagerStatus_ViewController *vc = [[ManagerStatus_ViewController alloc] init];
            vc.typeNum = 100;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell.editBtn addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    HKNameRowCell *cell = [tableView dequeueReusableCellWithIdentifier:[HKNameRowCell XIU_ClassIdentifier]];
    if (indexPath.section == 1) {
        cell.title.text = @"我的收益";
    }
    if (indexPath.section == 2) {
        cell.title.text = @"我的代理";
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
          MyProfit_ViewController *vc = [MyProfit_ViewController loadViewControllerFromMainStoryBoard];
        [self.navigationController pushViewController:vc animated:YES];

    }
    if (indexPath.section == 2) {
        Manager_MyDelegate_ViewController *v = [[Manager_MyDelegate_ViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }
}

- (void)clickEdit {
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"确定退出？" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [XIU_Login doLogOut];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        
        window.rootViewController = [Login_ViewController loadViewControllerFromMainStoryBoard];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? CGFLOAT_MIN : 10;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _XIUTableView.sectionFooterHeight = CGFLOAT_MIN;
     [self.XIUTableView registerNib:[HKNameRowCell XIU_ClassNib] forCellReuseIdentifier:[HKNameRowCell XIU_ClassIdentifier]];
    [self.XIUTableView registerNib:[ManagerInfoCell XIU_ClassNib] forCellReuseIdentifier:[ManagerInfoCell XIU_ClassIdentifier]];
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
