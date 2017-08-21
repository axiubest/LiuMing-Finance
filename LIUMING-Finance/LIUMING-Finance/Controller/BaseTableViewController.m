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
#import "MJRefresh.h"
#import "PopView.h"
@interface BaseTableViewController ()
{
    NSInteger page;
}
@property (strong, nonatomic) UIView *contentView;

@end

@implementation BaseTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;//load more
    [self.arr removeAllObjects];
    [self setupTableView];
    [self addRefresh];
    [self request];
    NSLog(@"-----%ld",_type);
    
}

- (void)addRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.arr removeAllObjects];
        page = 1;
        [self request];
    }];
    
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            page+=1;
            [self request];
        }];
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



- (void)request{
    NSDictionary *dict;
    if ([self.title isEqualToString:@"催收订单"]) {
      dict = @{@"oi_state":[NSString stringWithFormat:@"%ld", _type], @"ui_id":[XIU_Login userId], @"ui_type":@"5", @"page_num":[NSNumber numberWithInteger:page]};
    }
    else {
        dict = @{@"oi_state":[NSString stringWithFormat:@"%ld", _type], @"ui_id":[XIU_Login userId], @"page_num":[NSNumber numberWithInteger:page]};
    }
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:[self.title isEqualToString:@"催收订单"] ? API_home : API_List withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        
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
            [self.arr addObject:model];
        }
        [self.tableView reloadData];
        [self endRefresh];
    }];
}

-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
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
        cell.headerTitleLabel.text =[NSString stringWithFormat:@"账单号:%@", model.oi_num];
        cell.headerSubTitleLabel.text = model.oi_state;
        if ([model.oi_state isEqualToString:@"已还款"]) {
            cell.headerSubTitleLabel.textColor = [UIColor colorWithHexString:@"#1a7aff"];
        }else{
            cell.headerSubTitleLabel.textColor = [UIColor colorWithHexString:@"#fe324a"];
        }
        cell.bodyTitleLabel.text = [NSString stringWithFormat:@"借款%@元, 分%@期 %@-%@【姓名:%@】", model.oi_jkprice, model.oi_jkloans, model.nowloans, model.oi_jkloans, model.name];

        cell.bodySubTitleLabel.text = model.hkzje;
            if (model.fxprice.length> 0) {
                cell.bodyFineLabel.text = [NSString stringWithFormat:@"(含罚息：%@元)", model.fxprice];
                cell.bodyFineLabel.hidden = NO;
            }else{
                cell.bodyFineLabel.hidden = YES;
            }
        cell.footerTitleLabel.text =[NSString stringWithFormat:@"还款日期：%@",model.hktime] ;
        if ([model.oi_state isEqualToString:@"已逾期"] || [model.oi_state isEqualToString:@"待催收"]) {
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
    

    
    
    /*********************************/
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
    // 审核中没有期数 还款日期为借款日期
    if ([self.title isEqualToString:@"进度查询"]) {
       cell.bodyTitleLabel.text = [NSString stringWithFormat:@"借款%@元, 分%@期", model.oi_jkprice, model.oi_jkloans];
        cell.footerTitleLabel.text =[NSString stringWithFormat:@"借款日期：%@", model.hktime] ;

    }else {
       cell.bodyTitleLabel.text = [NSString stringWithFormat:@"借款%@元, 分%@期 %@-%@", model.oi_jkprice, model.oi_jkloans, model.nowloans, model.oi_jkloans];
        cell.footerTitleLabel.text =[NSString stringWithFormat:@"还款日期：%@", model.hktime] ;

    }
   
    cell.bodySubTitleLabel.text = model.hkzje;
    if (model.fxprice.length> 0 && ![model.fxprice isEqualToString:@"0.00"]) {
        cell.bodyFineLabel.text = [NSString stringWithFormat:@"(含罚息：%@元)", model.fxprice];
        cell.bodyFineLabel.hidden = NO;
    }else{
        cell.bodyFineLabel.hidden = YES;
    }

    if ([model.oi_state isEqualToString:@"借款中"] || [model.oi_state isEqualToString:@"已逾期"] || [model.oi_state isEqualToString:@"还款中"]) {
            [cell.footerBtn setTitle:@"立即还款" forState:UIControlStateNormal];
        [cell.footerBtn.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){26/255.0, 113/255.0, 1, 1 })];
        [cell.footerBtn setTitleColor:[UIColor colorWithHexString:@"#1a7aff"] forState:UIControlStateNormal];
    }else {
        cell.footerBtn.hidden = YES;
    }
    [cell.footerBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}


#pragma mark 按钮点击
- (void)clickBtn:(UIButton *)sender {
    
    if ([self.title isEqualToString:@"我的清单"])  {
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
        _contentView.backgroundColor = [UIColor clearColor];
//        UIImageView *imageV = [[UIImageView alloc]initWithFrame:_contentView.bounds];
        
        PopView *pop = [[NSBundle mainBundle]loadNibNamed:[PopView XIU_ClassIdentifier] owner:self options:nil].lastObject;
        [pop.bottomBtn addTarget:self action:@selector(clickCopyAliPay) forControlEvents:UIControlEventTouchUpInside];
        pop.frame = _contentView.bounds;
        
//        imageV.image = [UIImage imageNamed:@"WechatIMG1.jpeg"];
        [_contentView addSubview:pop];
        
        [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
        [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
        [[HWPopTool sharedInstance] showWithPresentView:_contentView animated:YES];
        
    }
    if ([self.title isEqualToString:@"催收订单"]) {
        HKMyListCell *cell = (HKMyListCell *)[[[sender superview] superview] superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[self.arr[indexPath.row] ui_phone]];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        

    }
}


#pragma mark 复制支付宝账号按钮
- (void)clickCopyAliPay {
    [[HWPopTool sharedInstance] closeWithBlcok:nil];
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string=@"15555555555";
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        XIUHUD(@"复制支付宝成功，现在您可以去粘贴");
    });

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 168;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.title isEqualToString:@"进度查询"]) {
        return;
    }
    if ([self.title isEqualToString:@"催收订单"]){
        return;
    }else{


        
        RepaymentInfo_ViewController *vc = [[RepaymentInfo_ViewController alloc] init];
        vc.mod = self.arr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(NSMutableArray *)arr{
    if (!_arr) {
        
        _arr = [NSMutableArray array];
    }
    return _arr;
}


@end
