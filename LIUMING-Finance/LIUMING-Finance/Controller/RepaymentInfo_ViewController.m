//
//  RepaymentInfo_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "RepaymentInfo_ViewController.h"
#import "HKBaseTableViewCell.h"
#import "HKSubmitCell.h"

@interface RepaymentInfo_ViewController ()<UITableViewDelegate,UITableViewDataSource,HKSubmitCellDelegate>
//title
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *everyMontPayIntLabel;
@property (weak, nonatomic) IBOutlet UILabel *everyMonthPayFloatLabel;
//剩余的月数
@property (weak, nonatomic) IBOutlet UILabel *surplusMonthLabel;
//剩余的时间
@property (weak, nonatomic) IBOutlet UILabel *surplusTimeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *arr;
@end

@implementation RepaymentInfo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"还款详情";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.titleLabel.text = [NSString stringWithFormat:@"总借款金额：%@元，分%@期", _mod.oi_jkprice, _mod.oi_jkloans];
    NSString *moneyStr = _mod.myyhprice;
    self.everyMontPayIntLabel.text = [NSString stringWithFormat:@"%@.", [moneyStr componentsSeparatedByString:@"."][0]];
    self.everyMonthPayFloatLabel.text =  [moneyStr componentsSeparatedByString:@"."][1];
    self.surplusTimeLabel.text = _mod.hktime;
    self.surplusMonthLabel.text =[NSString stringWithFormat:@"%@", _mod.nowloans];
//    if (self.dic[@"bodyFine"]) {
//        NSString *str = [self.dic[@"bodyFine"] stringByReplacingOccurrencesOfString:@"(含罚息¥" withString:@""];
//        fine = [str  stringByReplacingOccurrencesOfString:@")" withString:@"元"];
//    }
    NSString *subtitle = [NSString stringWithFormat:@"%@", _mod.fxprice];
    self.arr = @[
                 @{@"iconImage":@"还款方式",@"title":@"罚息",@"subtitle":subtitle},
                  @{@"iconImage":@"还款方式",@"title":@"还款方式"},
                  @{@"iconImage":@"还款状态",@"title":@"还款状态",@"subtitle":_mod.oi_state},
                  @{@"iconImage":@"还款总额",@"title":@"还款总额",@"subtitle":moneyStr}
                 ];
    
}

//@"headerImg":@"已出账单",
//@"headerTitle":@"已出账单",
//@"headerSubTitle":@"已逾期",
//@"bodyTitle":@"借款8000元，分2期  2-3",
//@"bodySubTitle":@"¥3096.67",
//@"bodyFine":@"(含罚息¥200.00)",
//@"footerTitle":@"还款日期：06/19",
//@"footerSubTitle":@"立即还款"
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==4) {
        return 278*0.5;
    }
    return 45;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==4) {
        HKSubmitCell *cell = [HKSubmitCell submitCell];
        cell.btnStr = @"提交";
        cell.myDelegate = self;
        return cell;
    }
    
    NSDictionary *dic = self.arr[indexPath.row];
    HKBaseTableViewCell *cell = [HKBaseTableViewCell baseTableVeiwCell];
    cell.iconImage.image = [UIImage imageNamed:dic[@"iconImage"]];
    cell.iconLabel.text = dic[@"title"];
    if (dic[@"subtitle"]) {
         cell.subLabel.text = dic[@"subtitle"];
        cell.subLabel.hidden = NO;
        cell.rowImage.hidden = YES;
    }else{
        cell.subLabel.hidden = YES;
        cell.rowImage.hidden = NO;
    }
    return cell;
}



-(void)submitCellBtnClick:(HKSubmitCell *)cell{
    NSLog(@"我点击啦");
}

@end
