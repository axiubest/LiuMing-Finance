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
#import "XIU_WebViewController.h"
@interface Contract_ViewController ()<ContractCellDelegate>
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
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:@"Agreement/agreement_lists" withParams:@{@"ui_id":[XIU_Login userId],@"page_num":[NSNumber numberWithInteger:page]} withMethodType:Post andBlock:^(id data, NSError *error) {

        for (NSDictionary *obj in data[@"data"]) {
            ContractModel *mod  =[[ContractModel alloc] init];
            mod = [ContractModel mj_objectWithKeyValues:obj];
            [self.dataSource addObject:mod];
        }
        [self.XIUTableView reloadData];
        [self endRefresh];
    }];
}

-(void)endRefresh{
    [self.XIUTableView.mj_header endRefreshing];
    [self.XIUTableView.mj_footer endRefreshing];
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
    cell.delegate = self;
    return cell;
    
}



//居间协议1
- (void)clickJuJianBtnWithOi_pdf:(NSString *)pdf Oi_htid:(NSString *)oi_htid Type:(NSString *)type{
    [self pushWebViewWithPdf:pdf Oi_id:oi_htid  Type:type];
}

//借款合同2
- (void)clickJieKuanBtnWithOi_pdf:(NSString *)pdf Oi_htid:(NSString *)oi_htid Type:(NSString *)type{
    [self pushWebViewWithPdf:pdf Oi_id:oi_htid  Type:type];

}
//收据合同3
- (void)clickShouJuBtnWithOi_pdf:(NSString *)pdf Oi_htid:(NSString *)oi_htid Type:(NSString *)type{
    [self pushWebViewWithPdf:pdf Oi_id:oi_htid Type:type];

}


- (void)pushWebViewWithPdf:(NSString *)pdf Oi_id:(NSString *)oi_id  Type:(NSString *)type{
    XIU_WebViewController *vc = [[XIU_WebViewController alloc] init];
    vc.pdf_url = pdf;
    vc.hetong = type;
    vc.oi_id = oi_id;
    [self presentViewController:vc animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
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
