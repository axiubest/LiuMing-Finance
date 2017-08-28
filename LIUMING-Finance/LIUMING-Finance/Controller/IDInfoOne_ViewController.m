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
#import <ContactsUI/ContactsUI.h>
#define Is_up_Ios_9             ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0

@interface IDInfoOne_ViewController ()<UITableViewDelegate,UITableViewDataSource,HKSubmitCellDelegate,UITextFieldDelegate,CNContactPickerDelegate>
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
    NSString *phone3;
    NSString *phoneName3;
    NSString *phone4;
    NSString *phoneName4;
    NSString *phone5;
    NSString *phoneName5;
    NSString *phone6;
    NSString *phoneName6;
    NSString *ui_alipay;
    NSString *province;
    NSString *city;
    NSString *area;
    

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
                 @{@"name":@"省",@"place":@"请输入省份",@"isHide":@1},
                 @{@"name":@"市",@"place":@"请输入所在城市",@"isHide":@1},
                 @{@"name":@"区",@"place":@"请输入区／县",@"isHide":@1},
                 @{@"name":@"现居地址",@"place":@"请输入您的现居住地信息",@"isHide":@1},
                 @{@"name":@"月收入",@"place":@"请输入您的每月收入",@"isHide":@1},
                 @{@"name":@"微信号",@"place":@"请输入您的微信号",@"isHide":@1},
                 @{@"name":@"借贷额度",@"place":@"请输入您的借贷额度",@"isHide":@1},
                  @{@"name":@"支付宝",@"place":@"请输入您的支付宝账号",@"isHide":@1},
                 @{@"name":@"第一位亲属紧急联系人",@"place":@"请输入您的紧急联系人姓名，如：父亲姓名",@"isHide":@1},
                 @{@"name":@"第一位亲属紧急联系人电话",@"place":@"请输入您的紧急联系人电话号码",@"isHide":@0},
                 @{@"name":@"第二位亲属紧急联系人",@"place":@"请输入您的紧急联系人姓名，如：母亲姓名",@"isHide":@1},
                 @{@"name":@"第二位亲属紧急联系人电话",@"place":@"请输入您的紧急联系人电话号码",@"isHide":@0},@{@"name":@"第三位亲属紧急联系人",@"place":@"请输入您的紧急联系人姓名，如：母亲姓名",@"isHide":@1},
                 @{@"name":@"第三位亲属紧急联系人电话",@"place":@"请输入您的紧急联系人电话号码",@"isHide":@0},@{@"name":@"第四位亲属紧急联系人",@"place":@"请输入您的紧急联系人姓名，如：母亲姓名",@"isHide":@1},
                 @{@"name":@"第四位亲属紧急联系人电话",@"place":@"请输入您的紧急联系人电话号码",@"isHide":@0},@{@"name":@"第五位亲属紧急联系人",@"place":@"请输入您的紧急联系人姓名，如：母亲姓名",@"isHide":@1},
                 @{@"name":@"第五位亲属紧急联系人电话",@"place":@"请输入您的紧急联系人电话号码",@"isHide":@0},@{@"name":@"第六位亲属紧急联系人",@"place":@"请输入您的紧急联系人姓名，如：母亲姓名",@"isHide":@1},
                 @{@"name":@"第六位亲属紧急联系人电话",@"place":@"请输入您的紧急联系人电话号码",@"isHide":@0}
                 ];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setValues];
    self.view.backgroundColor = [UIColor whiteColor];
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
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHideShow:) name:UIKeyboardWillHideNotification object:nil];
}

//- (void)keyboardWillShow:(NSNotification *)notification {
//    CGRect keyboardFrame  =[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat height = keyboardFrame.origin.y;
//    CGFloat textField_maxY = (textF.tag + 1) * 90;
//    CGFloat space = -self.tableVlew.contentOffset.y + textField_maxY;
//    CGFloat transformY = height - space;
//    if (transformY < 0) {
//        CGRect frame = self.view.frame;
//        frame.origin.y = transformY;
//        self.view.frame = frame;
//    }
//}
//
//- (void)keyboardHideShow:(NSNotification *)notification {
//    CGRect frame = self.view.frame;
//    frame.origin.y = 0;
//    self.view.frame = frame;
//}



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
    
    phoneName3 = [XIU_Login ui_name3];
    
    phone3 = [XIU_Login ui_phone3];
    
    phoneName4 = [XIU_Login ui_name4];
    
    phone4 = [XIU_Login ui_phone4];
    phoneName5 = [XIU_Login ui_name5];
    
    phone5 = [XIU_Login ui_phone5];
    
    phoneName6 = [XIU_Login ui_name6];
    
    phone6 = [XIU_Login ui_phone6];

    
    province = [XIU_Login province];
    city = [XIU_Login city];
    area = [XIU_Login area];
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
        return 250*0.5;
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
                cell.inputField.text = province;
                break;
            case 5:
                cell.inputField.text = city;
                break;
            case 6:
                cell.inputField.text = area;
                break;
            case 7:
                 cell.inputField.text = ui_address;
                break;
            case 8:
                 cell.inputField.text =  ui_income;
                break;
            case 9:
                 cell.inputField.text = ui_qqwx;
                break;
            case 10://applying 判断UI-limit额度是否可以更改，
                if (![[XIU_Login ui_applying] isEqualToString:@"1"]) {
                    cell.inputField.enabled = NO;
                    [cell.inputField setUserInteractionEnabled:NO];
                }else {
                    cell.inputField.enabled = YES;
                    [cell.inputField setUserInteractionEnabled:YES];

                }

                 cell.inputField.text = ui_limit;
                break;
            case 11:
                cell.inputField.text = ui_alipay;
                break;

            case 12:
                cell.inputField.text =phoneName1;
                break;
            case 13: {
                cell.inputField.text = phone1;
                cell.downImg.image = [UIImage imageNamed:@"通讯录"];
                cell.downImg.userInteractionEnabled = YES;
                [cell.downImg bk_whenTapped:^{
                    textF = cell.inputField;
                    [self JudgeAddressBookPower];
                }];
            }
                break;
            case 14:
                cell.inputField.text = phoneName2;
                break;
            case 15: {
                cell.inputField.text = phone2;
                cell.downImg.image = [UIImage imageNamed:@"通讯录"];
                cell.downImg.userInteractionEnabled = YES;
                [cell.downImg bk_whenTapped:^{
                    textF = cell.inputField;
                    [self JudgeAddressBookPower];
                }];
            }
                break;
            case 16:
                cell.inputField.text =phoneName3;
                break;
            case 17:{
                cell.inputField.text = phone3;
                cell.downImg.image = [UIImage imageNamed:@"通讯录"];
                cell.downImg.userInteractionEnabled = YES;
                [cell.downImg bk_whenTapped:^{
                    textF = cell.inputField;
                    [self JudgeAddressBookPower];
                }];
            }
                break;
            case 18:
                cell.inputField.text = phoneName4;
                break;
            case 19:{
                cell.inputField.text = phone4;
                cell.downImg.image = [UIImage imageNamed:@"通讯录"];
                cell.downImg.userInteractionEnabled = YES;
                [cell.downImg bk_whenTapped:^{
                    textF = cell.inputField;
                    [self JudgeAddressBookPower];
                }];
            }
                break;
            case 20:
                cell.inputField.text =phoneName5;
                break;
            case 21:{
                cell.inputField.text = phone5;
                cell.downImg.image = [UIImage imageNamed:@"通讯录"];
                cell.downImg.userInteractionEnabled = YES;
                [cell.downImg bk_whenTapped:^{
                    textF = cell.inputField;
                    [self JudgeAddressBookPower];
                }];
            }
                break;
            case 22:
                cell.inputField.text = phoneName6;
                break;
            case 23:{
                cell.inputField.text = phone6;
                cell.downImg.image = [UIImage imageNamed:@"通讯录"];
                cell.downImg.userInteractionEnabled = YES;
                [cell.downImg bk_whenTapped:^{
                    textF = cell.inputField;
                    [self JudgeAddressBookPower];
                }];
            }
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
            province = textField.text;
            break;
        case 5:
             city = textField.text;
            break;
        case 6:
            area = textField.text;
            break;

        case 7:
            ui_address = textField.text;
            
            break;
        case 8:
            ui_income = textField.text;
            
            break;
        case 9:
            ui_qqwx = textField.text;
            
            break;
        case 10:
            ui_limit = textField.text;
            
            break;
        case 11:
            ui_alipay = textField.text;
            
            break;
        case 12:
            phoneName1 = textField.text;
            
            break;
        case 13:
            phone1 = textField.text;
            
            break;
        case 14:
            phoneName2 = textField.text;
            
            break;
        case 15:
            phone2 = textField.text;
        case 16:
            phoneName3 = textField.text;
            
            break;
        case 17:
            phone3 = textField.text;
            
            break;
        case 18:
            phoneName4 = textField.text;
            
            break;
        case 19:
            phone4 = textField.text;
            
            break;
        case 20:
            phoneName5 = textField.text;
            
            break;
        case 21:
            phone5 = textField.text;
            
            break;
        case 22:
            phoneName6 = textField.text;
            
            break;
        case 23:
            phone6 = textField.text;
            
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
    }if (province.length == 0) {
        XIUHUD(@"请输入省");
        return;
    }if (city.length == 0) {
        XIUHUD(@"请输入市");
        return;
    }if (area.length == 0) {
        XIUHUD(@"请输入区／县");
        return;
    }
    if (ui_address.length == 0) {
        XIUHUD(@"请输入地址");
        return;
    }if (ui_income.length == 0) {
        XIUHUD(@"请输入月收入");
        return;
    }if (ui_qqwx.length == 0) {
        XIUHUD(@"请输微信号码");
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

//    if (![b isEqualToString:@"00"]) {
//        XIUHUD(@"借款额度格式错误(例:1000,1800,3300)");
//        return;
//    }

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
    }if (phoneName3.length < 2) {
        XIUHUD(@"请输入第三位紧急联系人");
        return;
    }if (phone3.length != 11) {
        XIUHUD(@"请输入第三位紧急联系人电话");
        return;
    }if (phoneName4.length < 2) {
        XIUHUD(@"请输入第四位紧急联系人");
        return;
    }if (phone4.length != 11) {
        XIUHUD(@"请输入第四位紧急联系人电话");
        return;
    }
    //可不填
    if (phoneName5.length < 1) {
        phoneName5 = @"";
    }if (phone5.length <1) {
       phone5 = @"";
    }if (phoneName6.length < 1) {
       phoneName6 = @"";
    }if (phone6.length < 1) {
        phone6 = @"";
    }
    

    [self request];
    
    
    
    //text
//    IDInfoTwoViewController *vc = [[IDInfoTwoViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
  }


- (void)request {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_doPage1 withParams:@{@"ui_id":[XIU_Login userId], @"ui_code":ui_code.length > 0 ? ui_code : @"",@"ui_cardid":ui_cardid,@"ui_province":province,@"ui_city":city,@"ui_area":area, @"ui_address":ui_address,@"ui_income":ui_income,@"ui_qqwx":ui_qqwx, @"ui_name1":phoneName1,@"ui_phone1":phone1, @"ui_name2":phoneName2, @"ui_phone2":phone2,@"ui_name3":phoneName3,@"ui_phone3":phone3, @"ui_name4":phoneName4, @"ui_phone4":phone4,@"ui_name5":phoneName5,@"ui_phone5":phone5, @"ui_name6":phoneName6, @"ui_phone6":phone6, @"ui_alipay":ui_alipay, @"ui_limit":ui_limit,@"ui_name":ui_name} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        if ([data[@"status"] isEqualToString:@"error"]) {
            XIUHUD(@"信息已提交");
       
        }
        if ([data[@"status"] isEqualToString:@"success"]) {
            [XIU_Login doLogin:data[@"data"]];
     
        }
        IDInfoTwoViewController *vc = [[IDInfoTwoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }];
}



#pragma mark call book

#pragma mark ---- 调用系统通讯录
- (void)JudgeAddressBookPower {
    ///获取通讯录权限，调用系统通讯录
    [self CheckAddressBookAuthorization:^(bool isAuthorized , bool isUp_ios_9) {
        if (isAuthorized) {
            [self callAddressBook:isUp_ios_9];
        }else {
            XIUHUD(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }];
}

- (void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized , bool isUp_ios_9))block {
    
        CNContactStore * contactStore = [[CNContactStore alloc]init];
        if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * __nullable error) {
                if (error)
                {
                    NSLog(@"Error: %@", error);
                }
                else if (!granted)
                {
                    
                    block(NO,YES);
                }
                else
                {
                    block(YES,YES);
                }
            }];
        }
        else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
            block(YES,YES);
        }
        else {
            XIUHUD(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    
}

- (void)callAddressBook:(BOOL)isUp_ios_9 {

        CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
        contactPicker.delegate = self;
        contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        [self presentViewController:contactPicker animated:YES completion:nil];

}

#pragma mark -- CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    CNPhoneNumber *phoneNumber = (CNPhoneNumber *)contactProperty.value;
    [self dismissViewControllerAnimated:YES completion:^{
        /// 联系人
        NSString *text1 = [NSString stringWithFormat:@"%@%@",contactProperty.contact.familyName,contactProperty.contact.givenName];
        /// 电话
        NSString *text2 = phoneNumber.stringValue;
        switch (textF.tag) {
            case 13:
                phone1 = text2;
                break;
            case 15:
                phone2 = text2;
                break;
            case 17:
                phone3 = text2;
                break;
            case 19:
                phone4 = text2;
                break;
            case 21:
                phone5 = text2;
                break;
            case 23:
                phone6 = text2;
                break;
            default:
                break;
        }
        [self.tableVlew reloadData];
        NSLog(@"联系人：%@, 电话：%@",text1,text2);
        
    }];
}
@end
