//
//  MyInfo_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "MyInfo_ViewController.h"
#import "HKMyInfoCell.h"
#import "HKPerfectInfoCell.h"
#import "IDInfoOne_ViewController.h"

#import "ActionSheetStringPicker.h"
#import "ActionSheetDatePicker.h"
#import "NSDate+convenience.h"
#import "NSDate+Helper.h"
@interface MyInfo_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *arr;




@end

@implementation MyInfo_ViewController

-(NSArray *)arr{
    if (!_arr) {
        _arr = @[
                 @[@{@"icon":@"完善身份信息",@"title":@"完善身份信息",@"subTitle":@"实名认证，手机认证，获取信贷额度"}],
                 @[
                    @{@"title":@"头像",@"subImage":@"pay"},
                    @{@"title":@"昵称"},
                    @{@"title":@"性别",@"subTitle":[XIU_Login ui_sex]},
                    @{@"title":@"生日"}
                    ],
                 @[@{@"title":@"现居地"}],
                 @[@{@"title":@"推荐人",@"subTitle":@"见涛"}]
                    
                ];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信息";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tempArr = self.arr[section];
    return tempArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *tempArr = self.arr[indexPath.section];
    NSDictionary *dic = tempArr[indexPath.row];
    
    if (indexPath.section==0) {
        HKPerfectInfoCell *cell = [HKPerfectInfoCell perfectInfoCell];
        cell.iconImage.image = [UIImage imageNamed:dic[@"icon"]];
        cell.TitleLabel.text = dic[@"title"];
        cell.subTitleLabel.text = dic[@"subTitle"];
        return cell;
    }
    
    
    HKMyInfoCell *cell = [HKMyInfoCell myInfoCell];
    if (dic[@"title"]) {
        cell.infoTitle.text = dic[@"title"];
    }
    if (dic[@"subTitle"]) {
        cell.infoSubTitle.text = dic[@"subTitle"];
        cell.infoSubTitle.hidden = NO;
    }
    if (dic[@"subImage"]) {
        cell.subImg.image = [UIImage imageNamed:dic[@"subImage"]];
        cell.subImg.hidden = NO;
    }
    if (indexPath.section==3) {
        cell.subImg.hidden = YES;
        cell.infoSubTitle.hidden = YES;
        cell.arrowImg.hidden = YES;
        cell.SubTitle.hidden = NO;
        cell.SubTitle.text = dic[@"subTitle"];
        
    }
    return  cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==1){
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor clearColor];
        UILabel *lable = [[UILabel alloc] init];
        lable.text = @"基本信息";
        lable.font = NB_FONT(15);
        lable.textColor = [UIColor colorWithHexString:@"#a8a8a8"];
        lable.frame = CGRectMake(15, 22, 200, 15);
        [v addSubview:lable];
        return v;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.0001;
    }
    if (section==1) {
        return 49;
    }
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 100;
    }
    
    return 45;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XIU_WeakSelf(self);

    if (indexPath.section==0) {
        IDInfoOne_ViewController *vc = [[IDInfoOne_ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        [ActionSheetStringPicker showPickerWithTitle:nil rows:@[@[@"男", @"女", @"未知"]] initialSelection:@[@"男"] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
            
//            weakself.curUser.userSex = @"";
            [weakself.tableView reloadData];
            
        } cancelBlock:nil origin:self.view];

    }if (indexPath.section == 1 && indexPath.row == 3) {
        NSDate *curDate = [NSDate dateFromString:@"1999-09-09" withFormat:@"yyyy-MM-dd"];
        if (!curDate) {
            curDate = [NSDate dateFromString:@"1990-01-01" withFormat:@"yyyy-MM-dd"];
        }
        ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:curDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin) {
            
//            weakself.curUser.userBirth = [selectedDate string_yyyy_MM_dd];
            [weakself.tableView reloadData];
            //                    request
        } cancelBlock:^(ActionSheetDatePicker *picker) {
            
        } origin:self.view];
        picker.minimumDate = [[NSDate date] offsetYear:-120];
        picker.maximumDate = [NSDate date];
        [picker showActionSheetPicker];
        

    }
}
@end
