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
    _moneySlider.value = _moneySlider.maximumValue/2;
    _moneyLab.text = [NSString stringWithFormat:@"%.0f",  _moneySlider.value];
    [self setUpBase];
    NSLog(@"%@", kPathDocument);
    
    [self request];
    
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
}

-(void)setUpBase{
    [self.everyMonth.layer setBorderWidth:1.0];
    [self.everyMonth.layer setBorderColor:CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){1, 1, 1, 1 })];
//    self.everyMonth.backgroundColor = [UIColor yellowColor];
    self.everyMonth.layer.cornerRadius = 18;
    self.everyMonth.layer.masksToBounds = YES;
    
    //
    [self.giveBtn setTitle:@"我要还款" forState:UIControlStateNormal];
    [self.progressBtn setTitle:@"进度查询" forState:UIControlStateNormal];
    [self.userMoneyBtn setTitle:@"费用说明" forState:UIControlStateNormal];
}

#pragma mark 借款申请按钮
- (IBAction)clickGetMoneyBtn:(id)sender {
//    网络请求判断
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
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_Apply withParams:@{@"ui_id":@"1", @"oi_jkprice":_moneyLab.text, @"oi_jkloans":_timeLab.text} withMethodType:Post andBlock:^(id data, NSError *error) {
        if ([data[@"status"] isEqualToString:@"error"]) {
            XIUHUD(@"借款失败");
        }if ([data[@"status"] isEqualToString:@"noquota"]) {
            XIUHUD(@"额度不够");
        }if ([data[@"status"] isEqualToString:@"sucess"]) {
            XIUHUD(@"借款成功");
        }
       
    }];
}

-(void)gotoInfo{
    if ([XIU_Login isVerification]) return;

    HKPerfectInfoView *infoView = [HKPerfectInfoView perfectInfoView];
    infoView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    infoView.myDelegate = self;
    [infoView show];
    
}
- (IBAction)clickToolButton:(HKButton *)sender {
    if (sender.tag == HKListTypeAll) {//跳转到进度查询
        
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
    IDInfoOne_ViewController *vc = [[IDInfoOne_ViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)request {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_home withParams:@{@"ui_type":@3, @"ui_id":@"2"} withMethodType:Post andBlock:^(id data, NSError *error) {
        if ([data[@"xiaoxi"] isEqual:@2]) {//不完善
            [self gotoInfo];
        }
        if ([data[@"ui_limit"] length] > 0) {//有额度
            _moneySlider.enabled = NO;

            _moneyLab.text = data[@"ui_limit"] ;
            _moneySlider.maximumValue = [data[@"ui_limit"] integerValue];
            _moneySlider.value = [data[@"ui_limit"] floatValue] / 2;
            [self everyMonthLab];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
