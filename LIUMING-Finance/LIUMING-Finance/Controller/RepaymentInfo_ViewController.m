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
#import "ActionSheetStringPicker.h"
#import "OrderDetail_ViewController.h"
#import "HWPopTool.h"
#import "PopView.h"
@interface RepaymentInfo_ViewController ()<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,HKSubmitCellDelegate>
{
    NSString *moneyStr;
}
//title
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *everyMontPayIntLabel;
@property (weak, nonatomic) IBOutlet UILabel *everyMonthPayFloatLabel;
//剩余的月数
@property (weak, nonatomic) IBOutlet UILabel *surplusMonthLabel;
//剩余的时间
@property (weak, nonatomic) IBOutlet UILabel *surplusTimeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *moneyType;
@property (nonatomic,strong) NSArray *arr;
@property (strong, nonatomic) UIView *contentView;

@end

@implementation RepaymentInfo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _moneyType = @"线上";//还款初始值为线上
    self.title = @"还款详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSLog(@"%@", _mod);
    
    self.titleLabel.text = [NSString stringWithFormat:@"总借款金额：%@元，分%@期", _mod.oi_jkprice, _mod.oi_jkloans];

    moneyStr = _mod.myyhprice.length > 1 ? _mod.myyhprice : @"0.00";
    self.everyMontPayIntLabel.text = [NSString stringWithFormat:@"%@.", [moneyStr componentsSeparatedByString:@"."][0]];
    self.everyMonthPayFloatLabel.text =  [moneyStr componentsSeparatedByString:@"."][1];
    self.surplusTimeLabel.text = _mod.hktime;
    self.surplusMonthLabel.text =[NSString stringWithFormat:@"%@／%@", _mod.nowloans, _mod.oi_jkloans];
//    if (self.dic[@"bodyFine"]) {
//        NSString *str = [self.dic[@"bodyFine"] stringByReplacingOccurrencesOfString:@"(含罚息¥" withString:@""];
//        fine = [str  stringByReplacingOccurrencesOfString:@")" withString:@"元"];
//    }
    NSString *subtitle = [NSString stringWithFormat:@"%@", _mod.fxprice];
    self.arr = @[
                 @{@"iconImage":@"还款方式",@"title":@"罚息",@"subtitle":subtitle},
                  @{@"iconImage":@"还款方式",@"title":@"还款方式",@"subtitle":_moneyType},
                  @{@"iconImage":@"还款状态",@"title":@"还款状态",@"subtitle":_mod.oi_state},
                  @{@"iconImage":@"还款总额",@"title":@"还款总额",@"subtitle":_mod.hkzje}
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
        cell.doBtn.hidden = [[_mod oi_state] isEqualToString:@"已结清"] ? YES : [[_mod oi_state] isEqualToString:@"已还款"] ? YES : [[_mod oi_state] isEqualToString:@"不通过"] ? YES : [[_mod oi_state] isEqualToString:@"审核中"] ? YES : NO;
        cell.myDelegate = self;
        return cell;
    }
    
    NSDictionary *dic = self.arr[indexPath.row];
    HKBaseTableViewCell *cell = [HKBaseTableViewCell baseTableVeiwCell];
    cell.iconImage.image = [UIImage imageNamed:dic[@"iconImage"]];
    cell.iconLabel.text = dic[@"title"];
    if (dic[@"subtitle"]) {
        cell.subLabel.text = indexPath.row == 1 ? _moneyType : dic[@"subtitle"];

            cell.subLabel.hidden = NO;
            cell.rowImage.hidden = YES;
        

    }else{
        cell.subLabel.hidden = YES;
        cell.rowImage.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderDetail_ViewController *vc = [OrderDetail_ViewController loadViewControllerFromMainStoryBoard];
    vc.oi_id = _mod.oi_id;
    [self showViewController:vc sender:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    XIU_WeakSelf(self)
//    if (indexPath.row == 1) {
//        [ActionSheetStringPicker showPickerWithTitle:nil rows:@[@[@"线上", @"线下"]] initialSelection:@[@"线上"] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
//
//            _moneyType = selectedValue[0];
//            
//            
//            [weakself.tableView reloadData];
//            
//        } cancelBlock:nil origin:self.view];
//
//    }
}
- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitCellBtnClick:(HKSubmitCell *)cell{

    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"确定还款" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [al show];
    [self request];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }else {//确认
        if ([_moneyType isEqualToString:@"线上"]) {
            _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
            _contentView.backgroundColor = [UIColor clearColor];
            PopView *pop = [[NSBundle mainBundle]loadNibNamed:[PopView XIU_ClassIdentifier] owner:self options:nil].lastObject;
            pop.payNum.text = _mod.com_mobile;
            [pop.bottomBtn addTarget:self action:@selector(clickCopyAliPay) forControlEvents:UIControlEventTouchUpInside];
            pop.frame = _contentView.bounds;
            
            //        imageV.image = [UIImage imageNamed:@"WechatIMG1.jpeg"];
            [_contentView addSubview:pop];
            
            [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
            [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
            [[HWPopTool sharedInstance] showWithPresentView:_contentView animated:YES];

            
        }
        
        [self request];
    }
}

#pragma mark 复制支付宝账号按钮

- (void)clickCopyAliPay {
    [[HWPopTool sharedInstance] closeWithBlcok:nil];
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string=_mod.com_mobile;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        XIUHUD(@"复制支付宝成功，现在您可以去粘贴");
    });
    
}

- (void)request {
    //保护
    NSString *nowLoans = _mod.nowloans.length > 0 ?  _mod.nowloans : @"1";
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_repay withParams:@{@"ui_id":[XIU_Login userId], @"pl_price":moneyStr,@"pl_oiid":_mod.oi_id, @"pl_loans":nowLoans, @"pl_hktype":[_moneyType isEqualToString:@"线上"] ? @"2" :@"1"} withMethodType:Post andBlock:^(id data, NSError *error) {
        if([data[@"status"] isEqualToString:@"error"]) {
        XIUHUD(@"还款失败");
            return ;
        }
        if([data[@"status"] isEqualToString:@"repay"]) {
            XIUHUD(@"已经还款");
            return;
        }
        if([data[@"status"] isEqualToString:@"sucess"]) {
            XIUHUD(@"还款成功");
            return ;
        }

    }];
}
@end
