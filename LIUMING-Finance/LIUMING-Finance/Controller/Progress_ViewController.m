//
//  Progress_ViewController.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/7/31.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "Progress_ViewController.h"

@interface Progress_ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation Progress_ViewController

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
