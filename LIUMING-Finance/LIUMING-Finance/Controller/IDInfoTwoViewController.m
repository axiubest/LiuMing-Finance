//
//  IDInfoTwoViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "IDInfoTwoViewController.h"
#import "HKDelegateCell.h"
#import "HKSubmitCell.h"
#import "HKPhotoUploadCell.h"
#import "MyInfo_ViewController.h"
@interface IDInfoTwoViewController ()<UITableViewDelegate,UITableViewDataSource,HKSubmitCellDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,HKPhotoUploadCellDelegate>{
    UIActionSheet *sheet;
    UIImage *tmpImg;
    
    NSString *ui_yhtype;//类型 1student 2company 默认1
    NSString *ui_workname;
    NSString *ui_xzaddress;//公司地址寝室地址
    NSString *ui_faculty;//院系
    NSString *ui_professional_class;//专业班级
    NSString *ui_school_roll;//学籍类型
    NSString *ui_comphone;//company phone
    NSString *ui_job;
    NSString *ui_ed;//入职时间
    
    UIImage *img1;
    UIImage *img2;
    UIImage *img3;
    UIImage *img4;
    
    

}
@property (weak, nonatomic) IBOutlet UIButton *studentBtn;
@property (weak, nonatomic) IBOutlet UIButton *workBtn;
@property (weak, nonatomic) IBOutlet UIView *btnContentView;
@property (nonatomic,weak) UIView *lineView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger sourecType;

@property (nonatomic,strong) NSMutableArray *arr;

@property (nonatomic,assign) NSInteger currentBtnTag;
@property (nonatomic,weak) UITableViewCell *currentCell;
@end

@implementation IDInfoTwoViewController
-(NSArray *)arr{
    if (!_arr) {
        //学生
        NSMutableArray *aa = [NSMutableArray array];
        UIImage *image = [UIImage imageNamed:@"添加照片"];
        NSArray *a = @[
                 @{@"name":@"学习名称",@"place":@"请输入您的学校名称",@"isHide":@1},
                 @{@"name":@"就读院系",@"place":@"请输入您的院系",@"isHide":@1},
                 @{@"name":@"专业班级",@"place":@"请输入您的班级",@"isHide":@1},
                 @{@"name":@"学籍类型",@"place":@"请输入您的学籍类型",@"isHide":@0},
                 @{@"name":@"寝室地址",@"place":@"请输入您的寝室地址信息",@"isHide":@0},
                 @{@"name":@"照片上传",@"place":@[image,image,image,image],@"isHide":@0}
                 ];
        [aa addObjectsFromArray:a];
        _arr = aa;
    }
    return _arr;
}

-(UIView *)lineView{
    if (!_lineView) {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor colorWithHexString:@"#328cfe"];
        [self.btnContentView addSubview:v];
        _lineView = v;
    }
    return _lineView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份信息";
    
    ui_workname = [XIU_Login ui_workname];
    ui_faculty = [XIU_Login ui_faculty];
    ui_xzaddress = [XIU_Login ui_xzaddress];
    ui_professional_class = [XIU_Login ui_professional];
    ui_comphone =  [XIU_Login ui_comphone];
    ui_school_roll =  [XIU_Login ui_school_roll];
    ui_job = [XIU_Login ui_job];
    ui_xzaddress = [XIU_Login ui_xzaddress];
    ui_ed = [XIU_Login ui_ed];


    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self studentBtnClick:self.studentBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)keyBoardWillHide:(NSNotification *)note{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.y = 0;
    }];
    
}

-(void)keyBoardWillShow:(NSNotification *)note{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = frame.origin.y;
    CGFloat cellY = CGRectGetMaxY(self.currentCell.frame)+109-self.tableView.contentOffset.y;
    if (cellY>y){
        CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [UIView animateWithDuration:duration animations:^{
            self.view.y = -cellY + y;
        }];
    }
}


- (NSString *)imageBase64WithDataURL:(UIImage *)image
{
    NSData *imageData =nil;
    NSString *mimeType =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x =50 / image.size.height;
    if (x >1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, x);
    mimeType = @"image/jpeg";
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions:0]];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)studentBtnClick:(UIButton *)btn {
    if (btn.selected) return;
    btn.selected = YES;
    self.workBtn.selected = NO;
    [self drawLine:btn];
    if (self.workBtn.selected) {
        ui_yhtype = @"2";
    }else {
        ui_yhtype = @"1";
    }
    
    self.arr = [NSMutableArray array];
    NSArray *a = @[
      @{@"name":@"学校名称",@"place":@"请输入您的学校名称",@"isHide":@1},
      @{@"name":@"就读院系",@"place":@"请输入您的院系",@"isHide":@1},
      @{@"name":@"专业班级",@"place":@"请输入您的班级",@"isHide":@1},
      @{@"name":@"学籍类型",@"place":@"请输入您的学籍类型",@"isHide":@0},
      @{@"name":@"寝室地址",@"place":@"请输入您的寝室地址信息",@"isHide":@0},
      @{@"name":@"照片上传",@"place":@[img1 == nil ? [UIImage imageNamed:@"添加照片"] : img1,img2 == nil ? [UIImage imageNamed:@"添加照片"] : img2,img3 == nil ? [UIImage imageNamed:@"添加照片"] : img3,img4 == nil ? [UIImage imageNamed:@"添加照片"] : img4],@"isHide":@1}
      ];
    [self.arr addObjectsFromArray:a];
    [self.tableView reloadData];
    
}
- (IBAction)workBtnClcik:(UIButton *)btn {
    if (btn.selected) return;
    
    btn.selected = YES;
    self.studentBtn.selected = NO;
    [self drawLine:btn];
    
    self.arr = [NSMutableArray array];
    NSArray *a = @[
                 @{@"name":@"公司名称",@"place":@"请输入您的公司名称",@"isHide":@1},
                 @{@"name":@"公司地址",@"place":@"请输入您的公司地址",@"isHide":@1},
                 @{@"name":@"公司电话",@"place":@"请输入您的公司电话",@"isHide":@1},
                 @{@"name":@"公司职务",@"place":@"请输入您在公司的职务",@"isHide":@1},
                 @{@"name":@"入职时间",@"place":@"请输入您的入职时间",@"isHide":@1},
                 @{@"name":@"照片上传",@"place":@[img1 == nil ? [UIImage imageNamed:@"添加照片"] : img1,img2 == nil ? [UIImage imageNamed:@"添加照片"] : img2,img3 == nil ? [UIImage imageNamed:@"添加照片"] : img3,img4 == nil ? [UIImage imageNamed:@"添加照片"] : img4],@"isHide":@1}
                 ];
    [self.arr addObjectsFromArray:a];
    [self.tableView reloadData];
}




//画线
-(void)drawLine:(UIButton *)btn{
    //下划线
    CGSize size = [btn.currentTitle sizeWithFont:NB_FONT(15)];
    CGFloat x = (KWIDTH*0.5-size.width)*0.5+btn.x;
    CGFloat h = 2;
    CGFloat y = self.btnContentView.height - h;
    self.lineView.frame = CGRectMake(x, y, size.width, h);
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
        if (indexPath.row==5) {
            return 200;
        }
        return 56+11+11;
    }else{
        return 278*0.5;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        if (indexPath.row == 5) {
            HKPhotoUploadCell *cell = [HKPhotoUploadCell photoUploadCell];
            cell.btnArr = self.arr[indexPath.row][@"place"];
            cell.myDelegate = self;
            return cell;
        }
        
        
        [_tableView registerNib:[HKDelegateCell XIU_ClassNib] forCellReuseIdentifier:[NSString stringWithFormat:@"%ldx", indexPath.row]];
        HKDelegateCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ldx", indexPath.row]];
        cell.nameLabel.text = self.arr[indexPath.row][@"name"];
        cell.inputField.placeholder = self.arr[indexPath.row][@"place"];
        [cell.inputField addTarget:self action:@selector(click:) forControlEvents:UIControlEventEditingChanged];
        cell.inputField.tag = indexPath.row;
        cell.downImg.hidden = [self.arr[indexPath.row][@"isHide"] integerValue];
        
        //tableView 及时刷新
        switch (indexPath.row) {
            case 0:
                cell.inputField.text = ui_workname;
                break;
            case 1:
                cell.inputField.text = [ui_yhtype isEqualToString:@"1"] ? ui_faculty : ui_xzaddress;
                break;
            case 2:
                cell.inputField.text = [ui_yhtype isEqualToString:@"1"] ? ui_professional_class : ui_comphone;
                break;
            case 3:
                cell.inputField.text = [ui_yhtype isEqualToString:@"1"] ? ui_school_roll : ui_job;
                break;
            case 4:
                cell.inputField.text = [ui_yhtype isEqualToString:@"1"] ? ui_xzaddress : ui_ed;
                break;
                
            default:
                break;
        }
        
        return cell;
    }else{
        HKSubmitCell *cell = [HKSubmitCell submitCell];
        cell.myDelegate =  self;
        cell.btnStr = @"提交";
        return cell;
    }
}

- (void)click:(UITextField *)textField {
    
    switch (textField.tag) {
        case 0:
            ui_workname = textField.text;
            break;
        case 1:
            
            if ([ui_yhtype isEqualToString:@"1"]) {
                ui_faculty = textField.text;
            }else {
                ui_xzaddress = textField.text;
            }
            break;
        case 2:
            if ([ui_yhtype isEqualToString:@"1"]) {
                ui_professional_class = textField.text;
            }else {
                ui_comphone = textField.text;
            }
            break;
        case 3:
            if ([ui_yhtype isEqualToString:@"1"]) {
                ui_school_roll = textField.text;
            }else {
                ui_job = textField.text;
            }
            break;
        case 4:
            if ([ui_yhtype isEqualToString:@"1"]) {
                ui_xzaddress = textField.text;
            }else {
                ui_ed = textField.text;
            }
            break;
        default:
            break;
    }
    
    
}



-(void)submitCellBtnClick:(HKSubmitCell *)cell{
    [self reuqest];
}

- (void)reuqest {
    
    if (img1 == nil) {
        XIUHUD(@"请上传身份证正面");
        return;
    }if (img2 == nil) {
        XIUHUD(@"请上传身份证反面");
        return;
    }if (img3 == nil) {
        XIUHUD(@"请上传手持身份证");
        return;
    }if (img4 == nil) {
        XIUHUD(@"请上传工作／工牌证明");
        return;
    }
    NSDictionary *dic = [NSDictionary dictionary];
    if ([ui_yhtype isEqualToString:@"1"]) {
        dic = @{@"ui_id":[XIU_Login userId],@"ui_yhtype":ui_yhtype,@"ui_workname":ui_workname, @"ui_faculty":ui_faculty, @"ui_professional_class":ui_professional_class, @"ui_school_roll":ui_school_roll, @"ui_xzaddress":ui_xzaddress, @"ui_url1":[self imageBase64WithDataURL:img1], @"ui_url2":[self imageBase64WithDataURL:img2],@"ui_url3":[self imageBase64WithDataURL:img3], @"ui_url4":[self imageBase64WithDataURL:img4]};
    }if ([ui_yhtype isEqualToString:@"2"]) {
      dic = @{@"ui_id":[XIU_Login userId],@"ui_yhtype":ui_yhtype,@"ui_xzworkname":ui_workname,  @"ui_comphone":ui_comphone, @"ui_xzaddress":ui_xzaddress, @"ui_job":ui_job, @"ui_ed":ui_ed,@"ui_url1":[self imageBase64WithDataURL:img1], @"ui_url2":[self imageBase64WithDataURL:img2], @"ui_url3":[self imageBase64WithDataURL:img3], @"ui_url4":[self imageBase64WithDataURL:img4]};
    }

    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_doPage2 withParams:dic withMethodType:Post andBlock:^(id data, NSError *error) {
        if ([data[@"status"] isEqualToString:@"error"]) {
            XIUHUD(@"信息提交重复");
            return ;
        }if ([data[@"status"] isEqualToString:@"success"]) {
            [XIU_Login doLogin:data[@"data"]];
            MyInfo_ViewController *homeVC = [[MyInfo_ViewController alloc] init];
            UIViewController *target = nil;
            for (UIViewController * controller in self.navigationController.viewControllers) { //遍历
                if ([controller isKindOfClass:[homeVC class]]) { //这里判断是否为你想要跳转的页面
                    target = controller;
                }
            }
            if (target) {
                [self.navigationController popToViewController:target animated:YES]; //跳转
            }        }
    }];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row == 5) {
        
    }
}

- (void)onClickImage {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 255) {
        _sourecType = 0;
    }if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                return;
            case 1:
                
                _sourecType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 2:
                _sourecType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
        }
    }else {
        if (buttonIndex == 0) {
            return;
        }else {
            _sourecType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    //    跳转相机或相册
    [self changePersonHeadImageWith:_sourecType];
}

#pragma mark Jump Camera or Library
- (void)changePersonHeadImageWith:(NSInteger)sourecType {
    UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
    imagePick.delegate = self;
    imagePick.allowsEditing = YES;
    imagePick.sourceType = sourecType;
    [self presentViewController:imagePick animated:YES completion:^{
        [self.tableView reloadData];
        
    }];
}

#pragma mark ---------UIImagePickControllerDelegate------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    tmpImg = image;
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i=0; i<[self.arr[5][@"place"] count]; i++) {
        if (self.currentBtnTag == i) {
            if (i == 0) {
                img1 = image;
            }if (i == 1) {
                img2 = image;
            }if (i == 2) {
                img3 = image;
            }if (i == 3) {
                img4 = image;
            }
            [arr addObject:image];
        }else{
            [arr addObject:self.arr[5][@"place"][i]];
        }
    }
    
    NSLog(@"---%@",self.arr[5][@"place"]);
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i=0; i<[self.arr count]; i++) {
        NSDictionary *tempDic = self.arr[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (i==5) {
            dic[@"name"] = tempDic[@"name"];
            dic[@"place"] = arr;
            dic[@"isHide"] = tempDic[@"isHide"];
        }else{
            dic[@"name"] = tempDic[@"name"];
            dic[@"place"] = tempDic[@"place"];
            dic[@"isHide"] = tempDic[@"isHide"];
        }
        [tempArr addObject:dic];
    }
    
    self.arr = tempArr;

    
   
    
    [self.tableView reloadData];
}

#pragma mark ---------HKPhotoUploadCellDelegate------------
-(void)photoUploadCellBtnClick:(HKPhotoUploadCell *)cell widthBtn:(UIButton *)btn{
    self.currentBtnTag = btn.tag;
    [self onClickImage];
}
-(void)delegateCell:(HKDelegateCell *)cell{
    self.currentCell = cell;
}

@end
