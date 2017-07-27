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
@interface FinancialContribution_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation FinancialContribution_ViewController

- (void)request {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_home withParams:@{@"ui_type":@"2", @"ui_id":@"1"} withMethodType:Post andBlock:^(id data, NSError *error) {
        
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
    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setBarButton2];
    [self request];
}

-(void)setBarButton2{
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:@"设置" highImage:@"设置" target:self action:@selector(rightBtnClick1)];
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImage:@"搜索" highImage:@"搜索" target:self action:@selector(rightBtnClick2)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
}

-(void)rightBtnClick2{
    NSLog(@"rightBtnClick2");
}
-(void)rightBtnClick1{
    NSLog(@"rightBtnClick1");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 168;
}


/*
 @"headerImg":@"已出账单",
 @"headerTitle":@"订单编号：600020170619988228",
 @"headerSubTitle":@"未打款",
 @"bodyTitle":@"客户［张三］借款8000元，分3期",
 @"bodySubTitle":@"¥8000.00",
 @"bodyFine":@"(支付宝帐号：154570380@qq.com)",
 @"footerTitle":@"06/19 13:32:48",
 @"footerSubTitle":@"立即打款"
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HKFinancialContributionCell *cell = [HKFinancialContributionCell financialContributionCell];
//    NSDictionary *dic = self.arr[indexPath.row];
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
