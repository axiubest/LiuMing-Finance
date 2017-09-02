//
//  ManagerStatus_ViewController.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/9/1.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "ManagerStatus_ViewController.h"
#import "MyManagerCell.h"
@interface ManagerStatus_ViewController ()<UITableViewDelegate, UITableViewDataSource>
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
    _XIUTableView.sectionHeaderHeight =10.f ;
    _XIUTableView.sectionFooterHeight = CGFLOAT_MIN;
    [_XIUTableView registerNib:[MyManagerCell XIU_ClassNib] forCellReuseIdentifier:[MyManagerCell XIU_ClassIdentifier]];
    _XIUTableView.rowHeight = 180;
    [self clickBtn:_typeNum == 100 ? _willBtn : _overBtn];
    
}
- (IBAction)clickBtn:(UIButton *)sender {
    _typeNum = sender.tag;
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
    [self.XIUTableView reloadData];
    
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
    if (_typeNum == 100) {
        cell.describtionLab.hidden = YES;
    }else {
        cell.describtionLab.hidden = NO;

    }
    
    return cell;
    
}


-(NSMutableArray *)dataSource {
    if (!_dataSource) {
//        _dataSource = [NSMutableArray array];
        _dataSource = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",nil];
    }
    return _dataSource;
}

@end
