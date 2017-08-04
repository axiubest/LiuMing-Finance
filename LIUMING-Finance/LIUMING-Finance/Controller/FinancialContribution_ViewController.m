//
//  FinancialContribution_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "FinancialContribution_ViewController.h"
#import "HKFinancialContributionCell.h"
#import "FinanceModel.h"
#import "MJExtension.h"
#import "Login_ViewController.h"
@interface FinancialContribution_ViewController ()<UITableViewDelegate,UITableViewDataSource, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation FinancialContribution_ViewController

- (void)request {
    [self.dataSource removeAllObjects];
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_home withParams:@{@"ui_type":@"2", @"ui_id":[XIU_Login userId]} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        if ([data[@"status"] isEqualToString:@"sucess"]) {
            for (NSDictionary *obj in data[@"data"]) {
                FinanceModel *mo = [[FinanceModel alloc] init];
               mo = [FinanceModel mj_objectWithKeyValues:obj];
                [self.dataSource addObject:mo];
            }
            [self.tableView reloadData];

        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"财务打款";
    [self createNavgationButtonWithImageNmae:@"退出" title:nil target:self action:@selector(clickEdit) type:UINavigationItem_Type_LeftItem];
    [self request];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 168;
}

- (void)clickFooterBtn:(UIButton *)sender {
    [self requestSure:sender];
}
#pragma mark 确认打款
- (void)requestSure:(UIButton *)sender {
    
    HKFinancialContributionCell *cell = (HKFinancialContributionCell *)[[[sender superview] superview] superview];
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    NSLog(@"indexPath is = %ld",indexPath.row);
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_payment withParams:@{@"oi_id":[self.dataSource[indexPath.row] oi_id]} withMethodType:Post andBlock:^(id data, NSError *error) {
        if ([data[@"status"] isEqualToString:@"sucess"]) {
            XIUHUD(@"成功");
            
            [self request];
        }if ([data[@"status"] isEqualToString:@"error"]) {
            XIUHUD(@"失败");
            return;
        }
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HKFinancialContributionCell *cell = [HKFinancialContributionCell financialContributionCell];
    [cell.footerBtn addTarget:self action:@selector(clickFooterBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.headerImg.image = [UIImage imageNamed:@"已出账单"];
    cell.headerTitleLabel.text = [NSString stringWithFormat:@"订单编号：%@", [self.dataSource[indexPath.row] oi_id]];
    
    NSString *type = [[self.dataSource[indexPath.row] oi_state] isEqualToString:@"1"] ? @"未打款" : @"已打款";
    cell.headerSubTitleLabel.text = type;

    if ([type isEqualToString:@"已打款"]) {
        cell.headerSubTitleLabel.textColor = [UIColor colorWithHexString:@"#1a71ff"];
        cell.footerZFBBtn.hidden = YES;
        [cell.footerBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    }else{
        [cell.footerBtn setTitle:@"立即打款" forState:UIControlStateNormal];
        cell.headerSubTitleLabel.textColor = [UIColor colorWithHexString:@"#fe324a"];
         cell.footerZFBBtn.hidden = NO;
    }
    cell.bodyTitleLabel.text =[NSString stringWithFormat:@"客户【%@】借款%@，分%@期",[self.dataSource[indexPath.row] ui_name],[self.dataSource[indexPath.row] oi_jkprice], [self.dataSource[indexPath.row] oi_jkloans]];
    cell.bodySubTitleLabel.text = [self.dataSource[indexPath.row] oi_jkprice];
    if ([self.dataSource[indexPath.row] ui_alipay]) {
        cell.bodyFineLabel.text =[self.dataSource[indexPath.row] ui_alipay];
        cell.bodyFineLabel.hidden = NO;
    }else{
        cell.bodyFineLabel.hidden = YES;
    }
    cell.footerTitleLabel.text = [self.dataSource[indexPath.row] oi_dkaddtime];
    

    if ([type isEqualToString:@"未打款"]) {
        [cell.footerBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
        [cell.footerBtn setTitleColor:[UIColor colorWithHexString:@"#1a7aff"] forState:UIControlStateNormal];
    }else{
        [cell.footerBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){101/255.0, 101/255.0, 101/255.0, 1 })];
        [cell.footerBtn setTitleColor:[UIColor colorWithHexString:@"#656565"] forState:UIControlStateNormal];
    }

    
    return cell;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
