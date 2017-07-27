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

@interface IDInfoTwoViewController ()<UITableViewDelegate,UITableViewDataSource,HKSubmitCellDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,HKPhotoUploadCellDelegate>{
    UIActionSheet *sheet;
    UIImage *tmpImg;
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
    
    UIImage *image = [UIImage imageNamed:@"添加照片"];
    self.arr = [NSMutableArray array];
    NSArray *a = @[
      @{@"name":@"学校名称",@"place":@"请输入您的学校名称",@"isHide":@1},
      @{@"name":@"就读院系",@"place":@"请输入您的院系",@"isHide":@1},
      @{@"name":@"专业班级",@"place":@"请输入您的班级",@"isHide":@1},
      @{@"name":@"学籍类型",@"place":@"请输入您的学籍类型",@"isHide":@0},
      @{@"name":@"寝室地址",@"place":@"请输入您的寝室地址信息",@"isHide":@0},
      @{@"name":@"照片上传",@"place":@[image,image,image,image],@"isHide":@1}
      ];
    [self.arr addObjectsFromArray:a];
    [self.tableView reloadData];
    
}
- (IBAction)workBtnClcik:(UIButton *)btn {
    if (btn.selected) return;
    
    btn.selected = YES;
    self.studentBtn.selected = NO;
    [self drawLine:btn];
    
    UIImage *image = [UIImage imageNamed:@"添加照片"];
    self.arr = [NSMutableArray array];
    NSArray *a = @[
                 @{@"name":@"公司名称",@"place":@"请输入您的公司名称",@"isHide":@1},
                 @{@"name":@"公司地址",@"place":@"请输入您的公司地址",@"isHide":@0},
                 @{@"name":@"公司电话",@"place":@"请输入您的公司电话",@"isHide":@1},
                 @{@"name":@"公司职务",@"place":@"请输入您在公司的职务",@"isHide":@1},
                 @{@"name":@"入职事件",@"place":@"请输入您的入职时间",@"isHide":@0},
                 @{@"name":@"照片上传",@"place":@[image,image,image,image],@"isHide":@1}
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
        
        
        HKDelegateCell *cell ;
        cell = [HKDelegateCell delegateCell];
        cell.nameLabel.text = self.arr[indexPath.row][@"name"];
        cell.inputField.placeholder = self.arr[indexPath.row][@"place"];
        cell.downImg.hidden = [self.arr[indexPath.row][@"isHide"] integerValue];
        return cell;
    }else{
        HKSubmitCell *cell = [HKSubmitCell submitCell];
        cell.myDelegate =  self;
        cell.btnStr = @"提交";
        return cell;
    }
}

-(void)submitCellBtnClick:(HKSubmitCell *)cell{
    NSLog(@"我提交了");
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
//    self.arr[5][@"place"] = arr;
    
//    [self.arr[5] setObject:arr forKey:@"place"];
    
   
    
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
