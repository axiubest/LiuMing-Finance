//
//  ManagerStatus_ViewController.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/9/1.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "ManagerStatus_ViewController.h"
#import "MyManagerCell.h"
#import "MJRefresh.h"
#import "ManagerModel.h"
#import "MJExtension.h"
@interface ManagerStatus_ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@property (weak, nonatomic) IBOutlet UIButton *willBtn;
@property (weak, nonatomic) IBOutlet UIButton *overBtn;

@property (weak, nonatomic) IBOutlet UIView *waitLine;
@property (weak, nonatomic) IBOutlet UIView *overLine;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ManagerStatus_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的客户";
    page = 1;
    _XIUTableView.sectionHeaderHeight =10.f ;
    _XIUTableView.sectionFooterHeight = CGFLOAT_MIN;
    [_XIUTableView registerNib:[MyManagerCell XIU_ClassNib] forCellReuseIdentifier:[MyManagerCell XIU_ClassIdentifier]];
    _XIUTableView.rowHeight = 180;
    [self clickBtn:_typeNum == 100 ? _willBtn : _overBtn];
    [self addRefresh];
    
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



- (IBAction)clickBtn:(UIButton *)sender {
    _typeNum = sender.tag;
    page = 1;
    [self.dataSource removeAllObjects];
    //will
    if (sender.tag == 100) {
        [_willBtn setTitleColor:[UIColor colorWithHexString:@"4B98DF"] forState:UIControlStateNormal];
        [_overBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _waitLine.hidden = NO;
        _overLine.hidden = YES;
        
    }if (sender.tag == 200) {//over
        [_willBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_overBtn setTitleColor:[UIColor colorWithHexString:@"4B98DF"] forState:UIControlStateNormal];
        _waitLine.hidden = YES;
        _overLine.hidden = NO;
    }
    [self request];
}

- (void)request {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_my_customer withParams:@{@"ui_id":[XIU_Login userId], @"ui_applying":_typeNum == 100 ? @"1":@"2", @"page_num":[NSNumber numberWithInteger:page]} withMethodType:Post andBlock:^(id data, NSError *error) {
        if ([data[@"status"] isEqualToString:@"sucess"]) {
            for (NSMutableArray *dic in data[@"data"]) {
                ManagerModel *mod = [[ManagerModel alloc] init];
                mod = [ManagerModel mj_objectWithKeyValues:dic];
                [self.dataSource addObject:mod];
            }
            [self.XIUTableView reloadData];
            [self  endRefresh];
        }
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyManagerCell XIU_ClassIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setValueWithModel:self.dataSource[indexPath.section]];
    cell.describtionLab.text = [NSString stringWithFormat:@"借款%@, 分%@期", [self.dataSource[indexPath.section] oi_jkprice],[self.dataSource[indexPath.section] oi_jkloans]];
    
    if (_typeNum == 100) {
        cell.timeLab.hidden = YES;
        cell.timeOrStatusLab.text = [self.dataSource[indexPath.section] ui_addtime];
        cell.timeOrStatusLab.textColor = [UIColor darkGrayColor];
        cell.describtionLab.hidden = YES;
    }else {
        cell.timeLab.hidden = NO;
        cell.timeOrStatusLab.text = [self.dataSource[indexPath.section] ui_state];
        cell.timeOrStatusLab.textColor = [cell.timeOrStatusLab.text isEqualToString:@"已结清"] || [cell.timeOrStatusLab.text isEqualToString:@"已还清"] ? [UIColor colorWithHexString:@"4B98DF"] : [UIColor redColor];
        cell.describtionLab.hidden = NO;

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
