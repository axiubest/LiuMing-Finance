//
//  SearchViewController.m
//  LIUMING-Finance
//
//  Created by Apple on 2017/8/4.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "SearchViewController.h"
#import "MyListModel.h"
#import "MJExtension.h"
#import "HKMyListCell.h"
@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@property (nonatomic, weak)UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgationSearchBar];
    self.XIUTableView.hidden = YES;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 168;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyListModel *model = self.dataSource[indexPath.row];
    
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    HKMyListCell *cell = [HKMyListCell myListCell];
    cell.dataDic = dic;
    cell.headerImg.image = [UIImage imageNamed:@"已出账单"];
    
    cell.headerTitleLabel.text =[NSString stringWithFormat:@"已出账单:%@", model.oi_num];
    cell.headerSubTitleLabel.text = model.oi_state;
    if ([model.oi_state isEqualToString:@"已还款"]) {
        cell.headerSubTitleLabel.textColor = [UIColor colorWithHexString:@"#1a7aff"];
    }else{
        cell.headerSubTitleLabel.textColor = [UIColor colorWithHexString:@"#fe324a"];
    }
    cell.bodyTitleLabel.text = [NSString stringWithFormat:@"借款%@元, 分%@期 %@-%@", model.oi_jkprice, model.oi_jkloans, model.nowloans, model.oi_jkloans];
    cell.bodySubTitleLabel.text = model.myyhprice;
    cell.footerTitleLabel.text =[NSString stringWithFormat:@"还款日期：%@",model.hktime] ;
    if ([model.fxprice integerValue] > 0) {
        cell.bodyFineLabel.text = [NSString stringWithFormat:@"(含罚息：%@元)",model.fxprice];
        cell.bodyFineLabel.hidden = NO;
    }else{
        cell.bodyFineLabel.hidden = YES;
    }

    if ([model.oi_state isEqualToString:@"已逾期"] || [model.oi_state isEqualToString:@"待催收"]) {
        cell.footerBtn.hidden = NO;

        [cell.footerBtn setTitle:@"立即催收" forState:UIControlStateNormal];
        [cell.footerBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
        [cell.footerBtn setTitleColor:[UIColor colorWithHexString:@"#1a7aff"] forState:UIControlStateNormal];
    }else {
        cell.footerBtn.hidden = YES;
    }
    
    cell.footerBtn.tag = indexPath.row;
            [cell.footerBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


- (void)clickBtn:(UIButton *)sender{
    HKMyListCell *cell = (HKMyListCell *)[[[sender superview] superview] superview];
    NSIndexPath *indexPath = [_XIUTableView indexPathForCell:cell];
    

    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[self.dataSource[indexPath.row] ui_phone]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}
-(void)createNavgationSearchBar {
    
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 30)];
    
    searchBarView.backgroundColor  =[UIColor clearColor];
    
    UISearchBar *search = [[UISearchBar alloc] init];
    search.delegate = self;
    [searchBarView addSubview:search];
    search.placeholder = @"请输入订单编号";
    self.navigationItem.titleView = searchBarView;
    search.translatesAutoresizingMaskIntoConstraints = NO;
    search.backgroundImage = [UIImage imageNamed:@"clearImage"];
    
    search.returnKeyType = UIReturnKeySearch;
    [search becomeFirstResponder];
    
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(searchBarView).with.insets(UIEdgeInsetsMake(0, -30,0,0));
    }];
    _searchBar = search;
    
    [self createNavgationButtonWithImageNmae:nil title:@"取消" target:self action:@selector(cancelDidClick) type:UINavigationItem_Type_RightItem];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

//当搜索框中的内容发生改变时会自动进行搜索

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    if (searchText.length == 0) {
        self.XIUTableView.hidden = YES;
        return;
    }

    
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:API_home withParams:@{@"ui_type":@5, @"oi_state":@"", @"oi_num":searchText, @"ui_id":[XIU_Login userId]} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        [self.dataSource removeAllObjects];
        for (NSDictionary *obj in data[@"data"]) {
            
            MyListModel *model = [[MyListModel alloc] init];
            model = [MyListModel mj_objectWithKeyValues:obj];
            if ([model.oi_state isEqualToString:@"9"]) {
                model.oi_state = @"审核中";
            }
            if ([model.oi_state isEqualToString:@"1"]) {
                model.oi_state = @"借款中";
            }
            if ([model.oi_state isEqualToString:@"2"]) {
                model.oi_state = @"还款中";
            }
            if ([model.oi_state isEqualToString:@"3"]) {
                model.oi_state = @"已还款";
            }
            if ([model.oi_state isEqualToString:@"4"]) {
                model.oi_state = @"已逾期";
            }
            if ([model.oi_state isEqualToString:@"5"]) {
                model.oi_state = @"已结清";
            }
            if ([model.oi_state isEqualToString:@"6"]) {
                model.oi_state = @"待催收";
            }
            if ([model.oi_state isEqualToString:@"7"]) {
                model.oi_state = @"已起诉";
            }
            if ([model.oi_state isEqualToString:@"8"]) {
                model.oi_state = @"不通过";
            }
            [self.dataSource addObject:model];
        }

        self.XIUTableView.hidden = self.dataSource.count >0 ? NO : YES;
        [self.XIUTableView reloadData];
        
    }];
}


- (void)cancelDidClick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
