//
//  OrderDetail_ViewController.m
//  LIUMING-Finance
//
//  Created by Apple on 2017/8/28.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "OrderDetail_ViewController.h"
#import "OrderDetailCell.h"
@interface OrderDetail_ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@property (weak, nonatomic) IBOutlet UILabel *borrowMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@property (weak, nonatomic) IBOutlet UILabel *repaymentLab;//还款
@property (weak, nonatomic) IBOutlet UILabel *alreadyLab;
@property (weak, nonatomic) IBOutlet UILabel *notYetLab;


@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation OrderDetail_ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单详情";
    _XIUTableView.sectionFooterHeight = CGFLOAT_MIN;
    [self request];
}
- (void)request {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_plan withParams:@{@"oi_id":_oi_id} withMethodType:Post andBlock:^(id data, NSError *error) {
        _borrowMoneyLab.text = data[@"oi_jkprice"];
        _dateLab.text =[NSString stringWithFormat:@"期数:%@", data[@"oi_jkloans"]];
        _repaymentLab.text = data[@"all_money"];
        _alreadyLab.text =[self exchageNumber:data[@"yhprice"]] ; 
        _notYetLab.text =[self exchageNumber:data[@"whprice"]] ;
        if ([data[@"data"] count] > 0) {
            for (NSDictionary *dic in data[@"data"]) {
                [self.dataSource addObject:dic];
            }
            [self.XIUTableView reloadData];
        }
    }];
}

- (NSString *)exchageNumber:(NSNumber *)num {
    
    return [NSString stringWithFormat:@"%@", num];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15;
    }
    return CGFLOAT_MIN;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[OrderDetailCell XIU_ClassIdentifier]];
    cell.dateLab.text = self.dataSource[indexPath.section][@"pl_loans"];
    cell.moneyLab.text =[NSString stringWithFormat:@"¥%@", self.dataSource[indexPath.section][@"mqprice"]];
    
    cell.rightLab1.text = self.dataSource[indexPath.section][@"hkzt"];
    cell.rightLab1.textColor = [cell.rightLab1.text isEqualToString:@"待还款"] ? [UIColor redColor] : [UIColor blackColor];
    
    cell.moneyLab.textColor = [cell.rightLab1.text isEqualToString:@"待还款"] ? [UIColor colorWithHexString:@"328cfe"]: [UIColor colorWithHexString:@"4d4d4d"];
    cell.rightLab2.text = [NSString stringWithFormat:@"%@还款", self.dataSource[indexPath.section][@"hktime"]] ;
    
    return cell;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
//        _dataSource = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    }
    return _dataSource;
}


@end
