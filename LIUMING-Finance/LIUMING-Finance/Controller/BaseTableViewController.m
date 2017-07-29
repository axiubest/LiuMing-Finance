//
//  HKBaseTableViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "BaseTableViewController.h"
#import "RepaymentInfo_ViewController.h"
#import "FinancialContribution_ViewController.h"
#import "HKMyListCell.h"
#import "MyListModel.h"
#import "MJExtension.h"
#import "HWPopTool.h"

@interface BaseTableViewController ()
@property (strong, nonatomic) UIView *contentView;

@end

@implementation BaseTableViewController

-(NSMutableArray *)arr{
    if (!_arr) {

         _arr = [NSMutableArray array];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.arr removeAllObjects];
    [self setupTableView];

        [self request];
    
}
- (void)setupTableView
{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
}
-(void)setType:(HKListType)type{
    _type = type;
    
}



- (void)request {
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_List withParams:@{@"oi_state":[NSString stringWithFormat:@"%ld", _type], @"ui_id":@"1"} withMethodType:Post andBlock:^(id data, NSError *error) {
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
            if ([model.oi_state isEqualToString:@"5"]) {
                model.oi_state = @"已逾期";
            }
            if ([model.oi_state isEqualToString:@"4"]) {
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
            [self.arr addObject:model];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.title isEqualToString:@"催收订单"]) {
        MyListModel *model = self.arr[indexPath.row];
        
        
        NSDictionary *dic = self.arr[indexPath.row];
        HKMyListCell *cell = [HKMyListCell myListCell];
        cell.dataDic = dic;
        cell.headerImg.image = [UIImage imageNamed:@"已出账单"];
        cell.headerTitleLabel.text = @"已出账单";
        cell.headerSubTitleLabel.text = model.oi_state;
        if ([model.oi_state isEqualToString:@"已还款"]) {
            cell.headerSubTitleLabel.textColor = [UIColor colorWithHexString:@"#1a7aff"];
        }else{
            cell.headerSubTitleLabel.textColor = [UIColor colorWithHexString:@"#fe324a"];
        }
        cell.bodyTitleLabel.text = [NSString stringWithFormat:@"借款%@元, 分%@期 %@-%@", model.oi_jkprice, model.oi_jkloans, model.nowloans, model.oi_jkloans];
        cell.bodySubTitleLabel.text = model.myyhprice;
        //    if (dic[@"bodyFine"]) {
        //        cell.bodyFineLabel.text = dic[@"bodyFine"];
        //        cell.bodyFineLabel.hidden = NO;
        //    }else{
        //        cell.bodyFineLabel.hidden = YES;
        //    }
        cell.footerTitleLabel.text =[NSString stringWithFormat:@"还款日期：%@",model.hktime] ;
        if ([model.oi_state isEqualToString:@"已逾期"]) {
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
    

    MyListModel *model = self.arr[indexPath.row];

    
    NSDictionary *dic = self.arr[indexPath.row];
    HKMyListCell *cell = [HKMyListCell myListCell];
    cell.dataDic = dic;
    cell.headerImg.image = [UIImage imageNamed:@"已出账单"];
    cell.headerTitleLabel.text = @"已出账单";
    cell.headerSubTitleLabel.text = model.oi_state;
    if ([model.oi_state isEqualToString:@"已还款"]) {
        cell.headerSubTitleLabel.textColor = [UIColor colorWithHexString:@"#1a7aff"];
    }else{
         cell.headerSubTitleLabel.textColor = [UIColor colorWithHexString:@"#fe324a"];
    }
    cell.bodyTitleLabel.text = [NSString stringWithFormat:@"借款%@元, 分%@期 %@-%@", model.oi_jkprice, model.oi_jkloans, model.nowloans, model.oi_jkloans];
    cell.bodySubTitleLabel.text = model.myyhprice;
//    if (dic[@"bodyFine"]) {
//        cell.bodyFineLabel.text = dic[@"bodyFine"];
//        cell.bodyFineLabel.hidden = NO;
//    }else{
//        cell.bodyFineLabel.hidden = YES;
//    }
    cell.footerTitleLabel.text =[NSString stringWithFormat:@"还款日期：%@", model.hktime] ;
    if ([model.oi_state isEqualToString:@"借款中"] || [model.oi_state isEqualToString:@"已逾期"]) {
            [cell.footerBtn setTitle:@"立即还款" forState:UIControlStateNormal];
        [cell.footerBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
        [cell.footerBtn setTitleColor:[UIColor colorWithHexString:@"#1a7aff"] forState:UIControlStateNormal];
    }else {
        cell.footerBtn.hidden = YES;
    }
    [cell.footerBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
 //    [cell.footerBtn setTitle:dic[@"footerSubTitle"] forState:UIControlStateNormal];
//    if ([dic[@"footerSubTitle"] isEqualToString:@"立即还款"]) {
//        [cell.footerBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
//        [cell.footerBtn setTitleColor:[UIColor colorWithHexString:@"#1a7aff"] forState:UIControlStateNormal];
//    }else{
//        [cell.footerBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){101/255.0, 101/255.0, 101/255.0, 1 })];
//        [cell.footerBtn setTitleColor:[UIColor colorWithHexString:@"#656565"] forState:UIControlStateNormal];
//    }
    
    return cell;
}


#pragma mark 按钮点击
- (void)clickBtn:(UIButton *)sender {
    
    if ([self.title isEqualToString:@"我的清单"])  {
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
        _contentView.backgroundColor = [UIColor clearColor];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:_contentView.bounds];
        imageV.image = [UIImage imageNamed:@"WechatIMG1.jpeg"];
        [_contentView addSubview:imageV];
        
        [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
        [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
        [[HWPopTool sharedInstance] showWithPresentView:_contentView animated:YES];

    }
    if ([self.title isEqualToString:@"催收订单"]) {
       NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"186xxxx6979"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 168;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.title isEqualToString:@"催收订单"]){
//        FinancialContribution_ViewController *vc = [[FinancialContribution_ViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }else{
        RepaymentInfo_ViewController *vc = [[RepaymentInfo_ViewController alloc] init];
        vc.mod = self.arr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
