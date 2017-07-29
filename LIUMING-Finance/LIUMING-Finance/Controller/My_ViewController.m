//
//  My_ViewController.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/6/19.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "My_ViewController.h"
#import "Delegate_ViewController.h"
#import "Feedback_ViewController.h"
#import "AboutUs_ViewController.h"
#import "MyInfo_ViewController.h"
#import "MyList_ViewController.h"
#import "MyProfit_ViewController.h"
#import "Login_ViewController.h"

#import "HKNameTableViewCell.h"
#import "My_ToolCell.h"
#import "HKBaseTableViewCell.h"
#import "HKNameRowCell.h"
#import "EditCell.h"

#import "HKBaseTableModel.h"

@interface My_ViewController ()<HKNameTableViewCellDelegate,UITableViewDataSource, UITableViewDelegate,My_ToolCellDelegate>
@property (nonatomic,strong)NSArray *arr;
@property (nonatomic,strong)NSMutableDictionary *dataDic;

@property (weak, nonatomic)  UITableView *XIUTableView;

@end

@implementation My_ViewController

-(UITableView *)XIUTableView {
    if (!_XIUTableView) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, KWIDTH, self.view.height + 20) style:UITableViewStyleGrouped];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = 0;
        [self.view addSubview:table];
        
        _XIUTableView = table;
    }
    return _XIUTableView;
}

-(NSArray *)arr{
    if (!_arr) {
        HKBaseTableModel *model = [[HKBaseTableModel alloc] init];
        model.iconImg = @"客户经理";
        model.iconTitle = @"客户经理";
        model.subTitle = [self.dataDic[@"tjr_name"] length] > 0 ?  self.dataDic[@"tjr_name"] : @"--";
        HKBaseTableModel *model1 = [[HKBaseTableModel alloc] init];
        model1.iconImg = @"申请代理";
        model1.iconTitle = @"申请代理";
        HKBaseTableModel *model2 = [[HKBaseTableModel alloc] init];
        model2.iconImg = @"意见反馈";
        model2.iconTitle = @"意见反馈";
        HKBaseTableModel *model3 = [[HKBaseTableModel alloc] init];
        model3.iconImg = @"关于我们";
        model3.iconTitle = @"关于我们";
        _arr = @[@0,@0,@[model],@[model1,model2],@[model3]];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self XIUTableView];
    [self request];
    [_XIUTableView registerNib:[EditCell XIU_ClassNib] forCellReuseIdentifier:[EditCell XIU_ClassIdentifier]];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated {
     self.navigationController.navigationBar.hidden = NO;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.0001;
    }
    return 10;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
       return 2;
    }else if(section == 2){
        return 1;
    }else if(section == 3){
        return 2;
    }else{
        return 1;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        return 250;
        
    }else if (indexPath.section==1&&indexPath.row==1){
        
        return 90;
        
    }

    return 45;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section==0) {
       HKNameTableViewCell *cell = [HKNameTableViewCell nameTableVeiwCell];
        cell.myDelegate = self;
        
        cell.nameLab.text = [XIU_Login userName];
        cell.tjr_nameLab.text =[NSString stringWithFormat:@"推荐人:%@", [self.dataDic[@"tjr_name"] isKindOfClass:[NSNull class]] ? @" 无推荐人": self.dataDic[@"tjr_name"]] ;
        cell.getMoneyLab.text =self.dataDic[@"profit"];
        cell.canUseMoneyLab.text = self.dataDic[@"ui_limit"];
        return cell;
    }else if(indexPath.section==1&&indexPath.row==1){
      My_ToolCell* cell = [My_ToolCell myTableVeiwCell];
        cell.delegate = self;
        return cell;
    }else if(indexPath.section > 1 && indexPath.section != 5){
        HKBaseTableViewCell *cell = [HKBaseTableViewCell baseTableVeiwCell];
        NSArray *arr = self.arr[indexPath.section];
        cell.model = arr[indexPath.row];
        return cell;
        
    }if (indexPath.section == 5) {
        EditCell *cell = [tableView dequeueReusableCellWithIdentifier:[EditCell XIU_ClassIdentifier]];
        [cell.editBtn addTarget:self action:@selector(clickEditBtn) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else{

        cell = [HKNameRowCell nameRowCell];
        
    }
    
    return cell;
}


#pragma mark  退出登录
- (void)clickEditBtn {
    XIUHUD(@"您已退出登录");
    [XIU_Login doLogOut];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    window.rootViewController = [Login_ViewController loadViewControllerFromMainStoryBoard];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3&&indexPath.row==0) {
        Delegate_ViewController *vc = [[Delegate_ViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==3&&indexPath.row==1){
        Feedback_ViewController *vc = [[Feedback_ViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.section==4){
        AboutUs_ViewController *vc = [[AboutUs_ViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section==1&&indexPath.row==0){
        MyList_ViewController *vc = [[MyList_ViewController alloc] init];
        vc.title = @"我的清单";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)clickMy_ToolCellWithTag:(NSInteger)tag {
    MyList_ViewController *vc = [[MyList_ViewController alloc] init];
    vc.myType = tag;
    vc.title = @"我的清单";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}

//HKNameTableViewCellDelegate
-(void)nameTableViewCellClick:(HKNameTableViewCell *)view{
    MyInfo_ViewController *vc = [[MyInfo_ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)nameTableProfitViewClick:(HKNameTableViewCell *)view{
    MyProfit_ViewController *vc = [[MyProfit_ViewController alloc] init];
    vc.allGetStr = self.dataDic[@"profit"];
    [self.navigationController  pushViewController:vc animated:YES];
}

- (void)request {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_my_index withParams:@{@"ui_id":@"2"} withMethodType:Post andBlock:^(id data, NSError *error) {
        [self.dataDic setObject:data[@"data"][@"profit"] forKey:@"profit"];
        [self.dataDic setObject:data[@"data"][@"tjr_name"] forKey:@"tjr_name"];
        [self.dataDic setObject:data[@"data"][@"ui_limit"] forKey:@"ui_limit"];//额度
        [self.XIUTableView reloadData];

    }];
}

-(NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}
@end
