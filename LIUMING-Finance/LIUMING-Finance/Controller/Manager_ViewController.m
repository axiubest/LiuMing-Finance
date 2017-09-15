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

@property (nonatomic, strong) NSMutableDictionary *dic;
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
        cell.nameLab.text = self.dic[@"ui_name"];
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
        cell.disLab.text = self.dic[@"profit"];
    }
    if (indexPath.section == 2) {
        cell.title.text = @"我的代理";
        cell.disLab.text = @"";
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
          MyProfit_ViewController *vc = (MyProfit_ViewController *)[MyProfit_ViewController loadViewControllerFromMainStoryBoard];
        vc.allGetStr = self.dic[@"profit"];
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
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)request {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_home withParams:@{@"ui_type":[XIU_Login type], @"ui_id":[XIU_Login userId]} withMethodType:Post andBlock:^(id data, NSError *error) {
        if([data[@"status"] isEqualToString:@"sucess"]) {
            [self.dic setObject:[data[@"data"][@"me_ui_code"] length] > 0 ? data[@"data"][@"me_ui_code"] : @"" forKey:@"me_ui_code"];
            [self.dic setObject:data[@"data"][@"ui_qqwx"] > 0 ? data[@"data"][@"ui_qqwx"] : @"" forKey:@"ui_qqwx"];
            [self.dic setObject:data[@"data"][@"profit"] > 0 ? data[@"data"][@"profit"] : @"" forKey:@"profit"];
            [self.dic setObject:data[@"data"][@"ui_name"] > 0 ? data[@"data"][@"ui_name"] : @"" forKey:@"ui_name"];
        }
        [self.XIUTableView reloadData];
    }];
}

-(NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

@end
