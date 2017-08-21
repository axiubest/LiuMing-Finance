//
//  Manager_ViewController.m
//  LIUMING-Finance
//
//  Created by Apple on 2017/8/21.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "Manager_ViewController.h"
#import "ManagerCell.h"
#import "MJRefresh.h"
#import "Login_ViewController.h"
@interface Manager_ViewController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
{
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation Manager_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavgationButtonWithImageNmae:@"退出" title:nil target:self action:@selector(clickEdit) type:UINavigationItem_Type_LeftItem];
    [self.dataSource removeAllObjects];
    [_XIUTableView registerNib:[ManagerCell XIU_ClassNib] forCellReuseIdentifier:[ManagerCell XIU_ClassIdentifier]];
    [self addRefresh];
    _XIUTableView.sectionFooterHeight = CGFLOAT_MIN;
//    [self request];
    
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


-(void)endRefresh{
    [self.XIUTableView.mj_header endRefreshing];
    [self.XIUTableView.mj_footer endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.dataSource.count;
        return 10;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:[ManagerCell XIU_ClassIdentifier]];
    [cell.callBtn addTarget:self action:@selector(clickCallBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


#pragma mark 拨打电话
- (void)clickCallBtn:(UIButton *)sender {
    ManagerCell *cell = (ManagerCell *)[[[sender superview] superview] superview];
    NSIndexPath *indexP = [self.XIUTableView indexPathForCell:cell];
    
}
- (void)request {
    //static NSString *const KBASEURL = @"http://xiaoming.liumingdai.com/index.php/home/";
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:@"Agreement/agreement_lists" withParams:@{@"ui_id":[XIU_Login userId],@"page_num":[NSNumber numberWithInteger:page]} withMethodType:Post andBlock:^(id data, NSError *error) {
        
//        for (NSDictionary *obj in data[@"data"]) {
//            ContractModel *mod  =[[ContractModel alloc] init];
//            mod = [ContractModel mj_objectWithKeyValues:obj];
//            [self.dataSource addObject:mod];
//        }
        [self.XIUTableView reloadData];
        [self endRefresh];
    }];
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
