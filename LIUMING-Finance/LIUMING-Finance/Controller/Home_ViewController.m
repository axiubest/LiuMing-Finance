//
//  Home_ViewController.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/6/19.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "Home_ViewController.h"
#import "IDInfoOne_ViewController.h"
#import "HKPerfectInfoView.h"
#import "HKButton.h"
#import "HKSlider.h"
#import "MyList_ViewController.h"
#import "BaseTableViewController.h"
@interface Home_ViewController ()<HKPerfectInfoViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *everyMonth;
@property (weak, nonatomic) IBOutlet HKButton *giveBtn;
@property (weak, nonatomic) IBOutlet HKButton *progressBtn;
@property (weak, nonatomic) IBOutlet HKButton *userMoneyBtn;

@property (weak, nonatomic) IBOutlet HKSlider *moneySlider;
@property (weak, nonatomic) IBOutlet HKSlider *timeSlider;

@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation Home_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self everyMonthLab];
    [self request];
    _moneySlider.value = _moneySlider.maximumValue/2;
    _moneyLab.text = [NSString stringWithFormat:@"%.0f",  _moneySlider.value];
    [self setUpBase];
    NSLog(@"%@", kPathDocument);
    
    NSString *every =[NSString stringWithFormat:@"每月还款%.2f元", [self.moneyLab.text integerValue] / [self.timeLab.text integerValue] +  [self.moneyLab.text integerValue] * 0.02];
    [_everyMonth setTitle:every forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (IBAction)clickSlider:(HKSlider *)sender {
    if (sender.tag == 111) {//money
        NSString *num =[NSString stringWithFormat:@"%.0f",sender.value];
        
       NSString *tmp = [num substringToIndex:num.length - 2];
        self.moneyLab.text = [NSString stringWithFormat:@"%@00", tmp];;
        
    }else if (sender.tag == 222) {//time
        self.timeLab.text = [NSString stringWithFormat:@"%.0f", sender.value];
    }
    
    [self everyMonthLab];
    
}


- (void)everyMonthLab {
    NSString *every =[NSString stringWithFormat:@"每月还款%.2f元", [self.moneyLab.text integerValue] / [self.timeLab.text integerValue] +  [self.moneyLab.text integerValue] * 0.02];
    [_everyMonth setTitle:every forState:UIControlStateNormal];
}


-(void)setUpBase{
    [self.everyMonth.layer setBorderWidth:1.0];
    [self.everyMonth.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){1, 1, 1, 1 })];

    self.everyMonth.layer.cornerRadius = 18;
    self.everyMonth.layer.masksToBounds = YES;
    
    //
    [self.giveBtn setTitle:@"我要还款" forState:UIControlStateNormal];
    [self.progressBtn setTitle:@"进度查询" forState:UIControlStateNormal];
    [self.userMoneyBtn setTitle:@"费用说明" forState:UIControlStateNormal];
}

#pragma mark 借款申请按钮
- (IBAction)clickGetMoneyBtn:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kXiaoxiState] isEqual:@3]) {
        HKPerfectInfoView *infoView = [HKPerfectInfoView perfectInfoView];
        infoView.destribtionList.text = @"正在审核中";
        [infoView.btn setTitle:@"查看进度" forState:UIControlStateNormal];
        infoView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        infoView.myDelegate = self;
        [infoView show];

        return;
    };
    
//    网络请求判断
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kXiaoxiState] isEqual:@2]) {//不完善
        HKPerfectInfoView *infoView = [HKPerfectInfoView perfectInfoView];
        infoView.destribtionList.text = @"完善信息后，即可获得借贷额度";
        [infoView.btn setTitle:@"去完善" forState:UIControlStateNormal];
        infoView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        infoView.myDelegate = self;
        [infoView show];

        return;
    }
    NSString *str = [NSString stringWithFormat:@"确定申请借款：%@元？", _moneyLab.text];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认申请" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }else {//确认
        [self applyRequest];
    }
}

#pragma mark 借款申请
- (void)applyRequest {
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_Apply withParams:@{@"ui_id":[XIU_Login userId], @"oi_jkprice":_moneyLab.text, @"oi_jkloans":_timeLab.text} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        if ([data[@"status"] isEqualToString:@"error"]) {
            XIUHUD(@"借款失败");
        }if ([data[@"status"] isEqualToString:@"noquota"]) {
            XIUHUD(@"额度不够");
        }if ([data[@"status"] isEqualToString:@"sucess"]) {
            XIUHUD(@"借款成功");
            id requestData = data[@"data"];
            [XIU_Login doLogin:requestData];
        }
       
    }];
}

-(void)gotoInfo{

    HKPerfectInfoView *infoView = [HKPerfectInfoView perfectInfoView];
    infoView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    infoView.myDelegate = self;
    [infoView show];
    
}

- (void)pushJinDuViewController {
    BaseTableViewController *vc = [[BaseTableViewController alloc] init];
    vc.type = HKListTypeProgress;
    vc.title = @"进度查询";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)clickToolButton:(HKButton *)sender {
    if (sender.tag == HKListTypeAll) {//跳转到进度查询
        [self pushJinDuViewController];
        
    }
    if (sender.tag == HKListTypeBorrowMoney) {
        MyList_ViewController *vc = [[MyList_ViewController alloc] init];
        vc.myType = sender.tag;
        vc.title = @"我的清单";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        

    }
   }


-(void)perfectInfoViewBtnClick:(HKPerfectInfoView *)view{
    [view hide];
    if ([view.destribtionList.text isEqualToString:@"正在审核中"]) {
        [self pushJinDuViewController];
        return;
    }
    IDInfoOne_ViewController *vc = [[IDInfoOne_ViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)request {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_home withParams:@{@"ui_type":@3, @"ui_id":[XIU_Login userId]} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        NSNumber *num = data[@"xiaoxi"];
        
        
        NSLog(@"%@", [XIU_Login ui_limit]);
        
        if ([[XIU_Login ui_limit] length] > 0) {//有额度
            _moneyLab.text =[NSString stringWithFormat:@"%ld", [[XIU_Login ui_limit] integerValue] / 2];
            _moneySlider.maximumValue = [[XIU_Login ui_limit] integerValue];
            _moneySlider.value = [[XIU_Login ui_limit] floatValue] / 2;
            [self everyMonthLab];
        }
        
        
        [[NSUserDefaults standardUserDefaults] setObject:num forKey:kXiaoxiState];
        if ([num isEqual:@3]) {
            return ;
        }
        if ([num isEqual:@2]) {//不完善
            [self gotoInfo];
            return ;
        }

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
