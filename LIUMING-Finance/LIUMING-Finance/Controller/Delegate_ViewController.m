//
//  Delegate_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "Delegate_ViewController.h"
#import "HKDelegateCell.h"
#import "HKSubmitCell.h"

@interface Delegate_ViewController ()<UITableViewDelegate, UITableViewDataSource, HKSubmitCellDelegate,UITextFieldDelegate>
{
    NSString *ui_name;
    NSString *ui_workname;
    NSString *ui_xzaddress;
    NSString *ay_tjr;
    NSString *ay_mark;
    UITextField *textF;


}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong) NSArray *arr;
@end

@implementation Delegate_ViewController
-(NSArray *)arr{
    if (!_arr) {
        

        _arr = @[
                 @{@"name":@"姓名",@"place":@"请输入您的真实姓名",@"isHide":@1, @"isEdit":@0, @"text":[XIU_Login userName]},
                  @{@"name":@"手机",@"place":@"请输入注册时的手机号码",@"isHide":@1, @"isEdit":@0,@"text":[XIU_Login ui_phone]},
                 @{@"name":@"微信",@"place":@"请输入您的微信号",@"isHide":@1, @"isEdit":@0, @"text":[XIU_Login ui_qqwx]},
                 @{@"name":@"性别",@"place":@"请输入您的性别",@"isHide":@0, @"isEdit":@0, @"text":[XIU_Login ui_sex]},
                 @{@"name":@"单位",@"place":@"请输入您的工作单位",@"isHide":@1, @"isEdit":@1},
                 @{@"name":@"地址",@"place":@"请输入您的地址",@"isHide":@0, @"isEdit":@1},
                 @{@"name":@"推荐人",@"place":@"请输入您的推荐人姓名",@"isHide":@1, @"isEdit":@1},
                 @{@"name":@"介绍",@"place":@"代理介绍",@"isHide":@1, @"isEdit":@1}
                 ];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请代理";
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
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
    CGFloat space = -self.myTableView.contentOffset.y + textField_maxY;
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


//- (void)viewDidDisappear:(BOOL)animated {
//    [self viewDidDisappear:animated];
//    [self.view endEditing:YES];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        HKDelegateCell *cell ;
        cell = [HKDelegateCell delegateCell];
        cell.nameLabel.text = self.arr[indexPath.row][@"name"];
        cell.inputField.placeholder = self.arr[indexPath.row][@"place"];
        cell.downImg.hidden = [self.arr[indexPath.row][@"isHide"] integerValue];
        cell.inputField.tag = indexPath.row;
        cell.inputField.delegate = self;
         [cell.inputField addTarget:self action:@selector(click:) forControlEvents:UIControlEventEditingChanged];
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            cell.inputField.enabled = NO;
            [cell.inputField setUserInteractionEnabled:NO];
            cell.inputField.text = self.arr[indexPath.row][@"text"];
        }
        return cell;
    }else{
        HKSubmitCell *cell = [HKSubmitCell submitCell];
        cell.myDelegate = self;
        return cell;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textF = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)click:(UITextField *)textField {
    
    switch (textField.tag) {
            case 4:
            ui_workname = textField.text;
            
            break;
            case 5:

            ui_xzaddress = textField.text;
            break;
        case 6:
            
            ay_tjr = textField.text;
            break;
        case 7:
            
            ay_mark = textField.text;
            break;

              default:
            break;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)submitCellBtnClick:(HKSubmitCell *)cell {
    [self request];
}


- (void)request {
    if (ui_workname.length < 2) {
        XIUHUD(@"请填写工作单位");
        return;
    }
    if (ui_xzaddress.length < 2) {
        XIUHUD(@"请填写单位地址");
        return;
    }
    if (ay_tjr.length < 2) {
        XIUHUD(@"请填写推荐人");
        return;
    }
    if (ay_mark.length < 3) {
        XIUHUD(@"请详细填写介绍");
        return;
    }
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_applying withParams:@{@"ui_id":[XIU_Login userId], @"ui_workname":ui_workname, @"ui_xzaddress":ui_xzaddress, @"ay_tjr":ay_tjr, @"ay_mark":ay_mark} withMethodType:Post andBlock:^(id data, NSError *error) {
        if ([data[@"status"] isEqualToString:@"success"]) {
            XIUHUD(@"申请成功,请等待审核结果");
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
             [self.navigationController popViewControllerAnimated:YES];
            });

          
        }
    }];
}
@end
