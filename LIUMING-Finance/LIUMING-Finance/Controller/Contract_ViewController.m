//
//  Contract_ViewController.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/8/13.
//  Copyright © 2017年 XIU. All rights reserved.
//
#import "ContractCell.h"
#import "Contract_ViewController.h"
#import "MJRefresh.h"
#import "ContractModel.h"
#import "MJExtension.h"
@interface Contract_ViewController ()
{
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@property(nonatomic, strong) NSMutableArray <ContractModel *>*dataSource;
@end

@implementation Contract_ViewController


- (void)addRefresh {
    self.XIUTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataSource removeAllObjects];
        page = 1;
        [self request];
    }];
    
    self.XIUTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page+=1;
        [self request];
    }];
}
- (void)request {
    //static NSString *const KBASEURL = @"http://xiaoming.liumingdai.com/index.php/home/";
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:@"Agreement/agreement_lists" withParams:@{@"ui_id":@"29",@"page_num":[NSNumber numberWithInteger:page]} withMethodType:Post andBlock:^(id data, NSError *error) {
        NSLog(@"%@", data);
        for (NSDictionary *obj in data[@"data"]) {
            ContractModel *mod  =[[ContractModel alloc] init];
            mod = [ContractModel mj_objectWithKeyValues:obj];
            [self.dataSource addObject:mod];
        }
        [self.XIUTableView reloadData];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 168;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContractCell *cell = [tableView dequeueReusableCellWithIdentifier:[ContractCell XIU_ClassIdentifier]];
    [cell setDta:self.dataSource[indexPath.section]];
    [cell.JuJianBtn addTarget:self action:@selector(cickJuJianBtn) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    [self request];
    [self addRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray <ContractModel *>*)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
