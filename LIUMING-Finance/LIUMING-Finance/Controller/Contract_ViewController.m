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
#import "Login_ViewController.h"

@interface Contract_ViewController ()<ContractCellDelegate, UITableViewDelegate, UITableViewDataSource>
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

    NSDictionary *dic;
    if ([[XIU_Login type] isEqualToString:ThirdType]) {
        dic = @{@"ui_id":[XIU_Login userId],@"page_num":[NSNumber numberWithInteger:page], @"ui_type":ThirdType};
    }else {
        dic = @{@"ui_id":[XIU_Login userId],@"page_num":[NSNumber numberWithInteger:page]};
    }
    //第三方接口-API_home  用户接口-Agreement/agreement_lists
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath: [[XIU_Login type] isEqualToString:ThirdType] ? API_home : @"Agreement/agreement_lists" withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {

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
    
    
    //第三方人员显示借款人信息
    cell.ui_nameLab.text = [[XIU_Login type] isEqualToString:ThirdType] ? [self.dataSource[indexPath.section] ui_name] : @"";
    cell.delegate = self;
    return cell;
    
}



//居间协议1
- (void)clickJuJianBtnWithOi_pdf:(NSString *)pdf Oi_htid:(NSString *)oi_htid Type:(NSString *)type Oi_sign:(NSString *)oi_sign{
    [self pushWebViewWithPdf:pdf Oi_id:oi_htid  Type:type Oi_Sign:oi_sign];
}

//借款合同2
- (void)clickJieKuanBtnWithOi_pdf:(NSString *)pdf Oi_htid:(NSString *)oi_htid Type:(NSString *)type Oi_sign:(NSString *)oi_sign{
    [self pushWebViewWithPdf:pdf Oi_id:oi_htid  Type:type Oi_Sign:oi_sign];

}
//收据合同3
- (void)clickShouJuBtnWithOi_pdf:(NSString *)pdf Oi_htid:(NSString *)oi_htid Type:(NSString *)type Oi_sign:(NSString *)oi_sign{
    
    if ([[XIU_Login type] isEqualToString:ThirdType]) {
        [self pushWebViewWithPdf:pdf Oi_id:oi_htid Type:type Oi_Sign:@""];
    }else {
        [self pushWebViewWithPdf:pdf Oi_id:oi_htid Type:type Oi_Sign:oi_sign];
    }
}


- (void)pushWebViewWithPdf:(NSString *)pdf Oi_id:(NSString *)oi_id  Type:(NSString *)type Oi_Sign:(NSString *)oi_sign{
    XIU_WebViewController *vc = [[XIU_WebViewController alloc] init];
    vc.pdf_url = pdf;
    vc.hetong = type;
    vc.oi_id = oi_id;
    vc.oi_sign = oi_sign;
    [self presentViewController:vc animated:YES completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    if ([[XIU_Login type] isEqualToString:ThirdType]) {
        [self createNavgationButtonWithImageNmae:@"退出" title:nil target:self action:@selector(clickEdit) type:UINavigationItem_Type_LeftItem];
            self.title = @"合同列表";

    }
    [self request];
    [self addRefresh];
}

- (void)clickEdit {
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"确定退出？" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确定", nil];
    
    alert.tag = 100;
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
        [XIU_Login doLogOut];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        
        window.rootViewController = [Login_ViewController loadViewControllerFromMainStoryBoard];

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
