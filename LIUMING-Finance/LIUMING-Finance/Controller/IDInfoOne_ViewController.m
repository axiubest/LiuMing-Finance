//
//  IDInfoOne_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "IDInfoOne_ViewController.h"
#import "IDInfoTwoViewController.h"
#import "HKDelegateCell.h"
#import "HKSubmitCell.h"
#import "NSString+Common.h"
@interface IDInfoOne_ViewController ()<UITableViewDelegate,UITableViewDataSource,HKSubmitCellDelegate,UITextFieldDelegate>
{
    NSString *ui_name;
    NSString *ui_code;
    NSString *ui_cardid;
    NSString *ui_phone;
    NSString *ui_address;
    NSString *ui_income;
    NSString *ui_qqwx;
    NSString *ui_limit;//edu
    NSString *phone1;
    NSString *phoneName1;
    NSString *phone2;
    NSString *phoneName2;
    NSString *ui_alipay;
    

    UITextField *textF;



}
@property (weak, nonatomic) IBOutlet UITableView *tableVlew;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,weak) UITableViewCell *currentCell;
@end

@implementation IDInfoOne_ViewController
-(NSArray *)arr{
    if (!_arr) {
        _arr = @[
                 @{@"name":@"姓名",@"place":@"请输入您的真实姓名",@"isHide":@1},
                 @{@"name":@"邀请码",@"place":@"请输入邀请码，若无邀请码可不填",@"isHide":@1},
                 @{@"name":@"身份证号",@"place":@"请输入您本人的身份证号码",@"isHide":@1},
                 @{@"name":@"手机号码",@"place":@"请输入注册手机号服务密码",@"isHide":@1},
                 @{@"name":@"居住地",@"place":@"请输入您的居住地信息",@"isHide":@1},
                 @{@"name":@"月收入",@"place":@"请输入您的每月收入",@"isHide":@1},
                 @{@"name":@"微信号／QQ",@"place":@"请输入您的微信号或QQ号",@"isHide":@1},
                 @{@"name":@"借贷额度",@"place":@"请输入您的借贷额度",@"isHide":@1},
                  @{@"name":@"支付宝",@"place":@"请输入您的支付宝账号",@"isHide":@1},
                 @{@"name":@"第一位亲属紧急联系人",@"place":@"请输入您的紧急联系人姓名，如：父亲姓名",@"isHide":@1},
                 @{@"name":@"第一位亲属紧急联系人电话",@"place":@"请输入您的紧急联系人电话号码",@"isHide":@1},
                 @{@"name":@"第二位亲属紧急联系人",@"place":@"请输入您的紧急联系人姓名，如：母亲姓名",@"isHide":@1},
                 @{@"name":@"第二位亲属紧急联系人电话",@"place":@"请输入您的紧急联系人电话号码",@"isHide":@1}
                 ];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setValues];

    self.title = @"身份信息";
  
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textF = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHideShow:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardFrame  =[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardFrame.origin.y;
    CGFloat textField_maxY = (textF.tag + 1) * 95;
    CGFloat space = -self.tableVlew.contentOffset.y + textField_maxY;
    CGFloat transformY = height - space;
    if (transformY < 0) {
        CGRect frame = self.view.frame;
        frame.origin.y = transformY;
        self.view.frame = frame;
    }
}

- (void)keyboardHideShow:(NSNotification *)notification {
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    self.view.frame = frame;
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setValues {
    ui_name = [XIU_Login ui_name];

    ui_code = [XIU_Login ui_code];

    ui_cardid = [XIU_Login ui_cardid];

    ui_phone = [XIU_Login ui_phone];

    ui_address = [XIU_Login ui_address];

    ui_income = [XIU_Login ui_income];

    ui_qqwx = [XIU_Login ui_qqwx];

    ui_limit = [XIU_Login ui_limit];

    ui_alipay = [XIU_Login ui_alipay];

    phoneName1 = [XIU_Login ui_name1];

    phone1 = [XIU_Login ui_phone1];

    phoneName2 = [XIU_Login ui_name2];

    phone2 = [XIU_Login ui_phone2];

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.arr.count;
    }else{
        return 1;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 56+11+11;
    }else{
        return 278*0.5;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        [_tableVlew registerNib:[HKDelegateCell XIU_ClassNib] forCellReuseIdentifier:[NSString stringWithFormat:@"%ldx", indexPath.row]];
        HKDelegateCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ldx", indexPath.row]];
        cell.inputField.tag = indexPath.row;
        cell.inputField.delegate = self;
        cell.nameLabel.text = self.arr[indexPath.row][@"name"];
        cell.inputField.placeholder = self.arr[indexPath.row][@"place"];
        switch (indexPath.row) {
            case 0:
                cell.inputField.text = ui_name;
                break;
            case 1:
                 cell.inputField.text = ui_code;
                break;
            case 2:
                cell.inputField.text = ui_cardid;
                break;
            case 3:
                cell.inputField.text = ui_phone;
                cell.inputField.enabled = NO;
                [cell.inputField setUserInteractionEnabled:NO];
                break;
            case 4:
                 cell.inputField.text = ui_address;
                break;
            case 5:
                 cell.inputField.text =  ui_income;
                break;
            case 6:
                 cell.inputField.text = ui_qqwx;
                break;
            case 7:
                 cell.inputField.text = ui_limit;
                break;
            case 8:
                cell.inputField.text = ui_alipay;
                break;

            case 9:
                cell.inputField.text =phoneName1;
                break;
            case 10:
                cell.inputField.text = phone1;
                break;
            case 11:
                cell.inputField.text = phoneName2;
                break;
            case 12:
                cell.inputField.text = phone2;
                break;

            default:
                break;
        }

        cell.inputField.tag = indexPath.row;
        [cell.inputField addTarget:self action:@selector(click:) forControlEvents:UIControlEventEditingChanged];
        cell.downImg.hidden = [self.arr[indexPath.row][@"isHide"] integerValue];
        return cell;
    }else{
        HKSubmitCell *cell = [HKSubmitCell submitCell];
        cell.myDelegate =  self;
        cell.btnStr = @"下一步";
        return cell;
    }
}

- (void)click:(UITextField *)textField {
    
    switch (textField.tag) {
        case 0:
            ui_name = textField.text;
            break;
        case 1:
            ui_code = textField.text;
            break;
        case 2:
            ui_cardid = textField.text;
            
            break;
        case 3:
            ui_phone = textField.text;
            
            break;
        case 4:
            ui_address = textField.text;
            
            break;
        case 5:
            ui_income = textField.text;
            
            break;
        case 6:
            ui_qqwx = textField.text;
            
            break;
        case 7:
            ui_limit = textField.text;
            
            break;
        case 8:
            ui_alipay = textField.text;
            
            break;
        case 9:
            phoneName1 = textField.text;
            
            break;
        case 10:
            phone1 = textField.text;
            
            break;
        case 11:
            phoneName2 = textField.text;
            
            break;
        case 12:
            phone2 = textField.text;
            
            break;
        default:
            break;
    }

    
}

-(void)submitCellBtnClick:(HKSubmitCell *)cell{
    

    if (ui_name.length < 2) {
        XIUHUD(@"用户名输入错误");
        return;
    }if (ui_cardid.length != 18) {
        XIUHUD(@"身份证输入错误");
        return;
    }if (ui_address.length == 0) {
        XIUHUD(@"请输入地址");
        return;
    }if (ui_income.length == 0) {
        XIUHUD(@"请输入月收入");
        return;
    }if (ui_qqwx.length == 0) {
        XIUHUD(@"请输qq或者微信号码");
        return;
    }if (ui_limit.length < 4) {
        XIUHUD(@"借款额度过少,请更改");
        return;
    }
    if (![NSString checkIsNumber:ui_limit]) {
        XIUHUD(@"借款额度必须为纯数字");
        return;
    }
    NSLog(@"%@", ui_limit);
    NSString *s =[NSString stringWithFormat:@"%ld",[ui_limit integerValue]];
    NSString* b= [s substringWithRange:NSMakeRange(s.length - 2,2)];

    if (![b isEqualToString:@"00"]) {
        XIUHUD(@"借款额度格式错误(例:1000,1800,3300)");
        return;
    }

    if (ui_alipay.length < 5) {
        XIUHUD(@"请输入支付宝号码");
        return;
    }if (phoneName1.length < 2) {
        XIUHUD(@"请输入第一位紧急联系人");
        return;
    }if (phone1.length != 11) {
        XIUHUD(@"请输入第一位紧急联系人电话");
        return;
    }if (phoneName2.length < 2) {
        XIUHUD(@"请输入第二位紧急联系人");
        return;
    }if (phone2.length != 11) {
        XIUHUD(@"请输入第二位紧急联系人电话");
        return;
    }
    [self request];
    
    
    
    //text
//    IDInfoTwoViewController *vc = [[IDInfoTwoViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
  }


- (void)request {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_doPage1 withParams:@{@"ui_id":[XIU_Login userId], @"ui_code":ui_code.length > 0 ? ui_code : @"",@"ui_cardid":ui_cardid, @"ui_address":ui_address,@"ui_income":ui_income,@"ui_qqwx":ui_qqwx, @"ui_name1":phoneName1,@"ui_phone1":phone1, @"ui_name2":phoneName2, @"ui_phone2":phone2, @"ui_alipay":ui_alipay, @"ui_limit":ui_limit,@"ui_name":ui_name} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        if ([data[@"status"] isEqualToString:@"error"]) {
            XIUHUD(@"数据未更新");
       
        }
        if ([data[@"status"] isEqualToString:@"success"]) {
            [XIU_Login doLogin:data[@"data"]];
     
        }
        IDInfoTwoViewController *vc = [[IDInfoTwoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }];
}
@end
