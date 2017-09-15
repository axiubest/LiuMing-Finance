//
//  MyProfit_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "MyProfit_ViewController.h"
#import "HKProfitCell.h"
#import "MyList_ViewController.h"
#import "MJRefresh.h"
@interface MyProfit_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLab;
@property (nonatomic,strong) NSMutableArray *arr;
@end

@implementation MyProfit_ViewController

-(NSMutableArray *)arr{
    if (!_arr){
        _arr = [NSMutableArray array];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
    page = 1;
    [self addRefresh];
    _allMoneyLab.text = _allGetStr;
    self.title = @"我的收益";
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
}

- (void)addRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.arr removeAllObjects];
        page = 1;
        [self request];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page+=1;
        [self request];
    }];
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.arr[indexPath.row];
    HKProfitCell *cell = [tableView dequeueReusableCellWithIdentifier:[HKProfitCell XIU_ClassIdentifier]];
    cell.titleLabel.text = [NSString stringWithFormat:@"客户【%@】借款%@,分%@期", [dic objectForKey:@"name"], [dic objectForKey:@"oi_jkprice"], [dic objectForKey:@"oi_jkloans"]];
    cell.subTitle1Label.text = dic[@"add_time"];
    cell.subTitle2Label.text = dic[@"pl_price"];
    return cell;
}
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)request {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_profit withParams:@{@"ui_id":[XIU_Login userId], @"page_num":[NSNumber numberWithInteger:page]} withMethodType:Post andBlock:^(id data, NSError *error) {
        

            for (NSDictionary *dic in data[@"data"]) {
                NSMutableDictionary *d = [NSMutableDictionary dictionary];
                [d setObject:dic[@"pl_price"] forKey:@"pl_price"];
                [d setObject:dic[@"oi_jkloans"] forKey:@"oi_jkloans"];
                [d setObject:dic[@"oi_jkprice"] forKey:@"oi_jkprice"];
                [d setObject:dic[@"name"] forKey:@"name"];
                 [d setObject:dic[@"add_time"] forKey:@"add_time"];
                [self.arr addObject:d];
        }
        [self.tableView reloadData];
        [self endRefresh];
    }];
}



@end
