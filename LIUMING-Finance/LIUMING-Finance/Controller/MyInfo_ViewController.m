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
#import "TextViewController.h"

#import "ActionSheetStringPicker.h"
#import "ActionSheetDatePicker.h"
#import "NSDate+convenience.h"
#import "NSDate+Helper.h"
#import "EditCell.h"
#import "UIImageView+WebCache.h"
#import "TextFieldCell.h"
@interface MyInfo_ViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIActionSheet *sheet;
    UIImage *tmpImg;
    NSData *imgData;
    NSString *ui_name;
    NSString *ui_sex;
    NSString *ui_birthday;
    NSString *ui_address;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger sourecType;

@property (nonatomic,strong)NSArray *arr;




@end

@implementation MyInfo_ViewController

-(NSArray *)arr{
   _tjrName =  _tjrName.length > 0 ? _tjrName : @"";
    if (!_arr) {
        _arr = @[
                 @[@{@"icon":@"完善身份信息",@"title":@"完善身份信息",@"subTitle":@"实名认证，手机认证，获取信贷额度"}],
                 @[
                    @{@"title":@"头像",@"subImage":@""},//头像
                    @{@"title":@"真实姓名",@"subTitle":ui_name},
                    @{@"title":@"性别",@"subTitle":ui_sex},
                    @{@"title":@"生日",@"subTitle":ui_birthday}
                    ],
                 @[@{@"title":@"现居地",@"subTitle":ui_address}],
                 @[@{@"title":@"推荐人",@"subTitle":_tjrName}],
                 @[@{@"title":@"保存"}]
                    
                ];
    }
    return _arr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //要刷新

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信息";
    ui_name = [XIU_Login ui_name];
    ui_sex = [XIU_Login ui_sex];
    ui_birthday = [XIU_Login ui_birthday];
    ui_address = [XIU_Login ui_address];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[EditCell XIU_ClassNib] forCellReuseIdentifier:[EditCell XIU_ClassIdentifier]];
        [_tableView registerNib:[TextFieldCell XIU_ClassNib] forCellReuseIdentifier:[TextFieldCell XIU_ClassIdentifier]];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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
    
    if (indexPath.section == 1 && indexPath.row == 1) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[TextFieldCell XIU_ClassIdentifier]];
        cell.title.text = dic[@"title"];
        [cell.distribtionTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        cell.distribtionTextField.tag = indexPath.section;
            cell.distribtionTextField.text = ui_name;
            return cell;
        
    }
    
    
    HKMyInfoCell *cell = [HKMyInfoCell myInfoCell];

    if (dic[@"title"]) {
        cell.infoTitle.text = dic[@"title"];
    }
    if (dic[@"subTitle"]) {
        if (indexPath.row == 1) {
        cell.infoSubTitle.text = ui_name;
        }
        if (indexPath.row == 2) {
            cell.infoSubTitle.text = ui_sex;
        }
        if (indexPath.row == 3) {
            cell.infoSubTitle.text = ui_birthday;
        }
        cell.infoSubTitle.hidden = NO;
    }
    if (dic[@"subImage"]) {//头像
   
        if (imgData.length > 0) {
            cell.subImg.image = tmpImg;
        }else {
            NSLog(@"%@", [XIU_Login ui_img]);
            [cell.subImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", [XIU_Login ui_img]]] placeholderImage:[UIImage imageNamed:@"logo"]];
        }
        cell.SubTitle.hidden = YES;
        cell.subImg.hidden = NO;
    }if (indexPath.section == 2) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[TextFieldCell XIU_ClassIdentifier]];
        cell.title.text = dic[@"title"];
        [cell.distribtionTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        cell.distribtionTextField.tag = indexPath.section;
        cell.distribtionTextField.text = ui_address;
        return cell;
    }
    
    if (indexPath.section==3) {
        cell.subImg.hidden = YES;
        cell.infoSubTitle.hidden = YES;
        cell.arrowImg.hidden = YES;
        cell.SubTitle.hidden = NO;
        cell.SubTitle.text = dic[@"subTitle"];
        
    }if (indexPath.section == 4) {
        EditCell *cell = [tableView dequeueReusableCellWithIdentifier:[EditCell XIU_ClassIdentifier]];
        [cell.editBtn setTitle:@"保存基本信息" forState:UIControlStateNormal];
        [cell.editBtn addTarget:self action:@selector(clickEditBtn) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return  cell;
    
}


- (void)textFieldChanged:(UITextField *)textField {
    if (textField.tag == 1) {
        ui_name = textField.text  ;
        
    }if (textField.tag == 2) {
        ui_address = textField.text;
        
    }
}

#pragma mark 提交
- (void)clickEditBtn {
  
    if (ui_name.length < 2) {
        XIUHUD(@"姓名不能为空")return;
    }
    if (ui_birthday.length < 2) {
        XIUHUD(@"生日不能为空")return;
    }
    if (ui_address.length < 2) {
        XIUHUD(@"地址不能为空")return;
    }
    if ([XIU_Login ui_img].length < 1 && tmpImg  == nil) {
        XIUHUD(@"请上传头像")return;
    }
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_updateUser withParams:@{@"ui_id":[XIU_Login userId], @"ui_name":ui_name, @"ui_sex":[[XIU_Login ui_sex] isEqualToString:@"男"] ? @"1":@"0", @"ui_birthday":[XIU_Login ui_birthday], @"ui_img":[XIU_Login ui_img].length > 1 ? (tmpImg == nil ? @"" : [self imageBase64WithDataURL:tmpImg]) : [self imageBase64WithDataURL:tmpImg], @"ui_address":ui_address} withMethodType:Post andBlock:^(id data, NSError *error) {
        if ([data[@"status"] isEqualToString:@"error"]) {
            XIUHUD(@"信息提交重复");
            return ;
        }
        id requestData = data[@"data"];
        [XIU_Login doLogin:requestData];
        XIUHUD(@"提交成功");
        [_tableView reloadData];
        
    }];
}


- (NSString *)imageBase64WithDataURL:(UIImage *)image
{
    NSData *imageData =nil;
    NSString *mimeType =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
//    CGFloat x =50 / image.size.height;
//    if (x >1)
//    {
//        x = 1.0;
//    }
    imageData = UIImageJPEGRepresentation(image, 0.1f);
    if ([self imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 0.1f);
        mimeType = @"image/jpeg";
    }

    
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions:0]];
}

- (BOOL) imageHasAlpha: (UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
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
    
    }if (indexPath.section == 1 && indexPath.row == 0) {
        [self onClickImage];

    }
    if (indexPath.section == 1 && indexPath.row == 1) {
//        TextViewController *vc  =[[TextViewController alloc] init];
//        vc.type = @"姓名";
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.textField.text = [XIU_Login ui_name];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        [ActionSheetStringPicker showPickerWithTitle:nil rows:@[@[@"男", @"女"]] initialSelection:@[@"男"] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
            NSNumber *num = @1;
            if ([selectedValue[0] isEqualToString:@"男"]) {
                num = @1;
            }if ([selectedValue[0] isEqualToString:@"女"]) {
                num = @0;
            }
          NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
            NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
            [dics setValue:num forKey:@"ui_sex"];

            [[NSUserDefaults standardUserDefaults]setObject:dics forKey:kLoginUserDict] ;
            [weakself.tableView reloadData];
            
        } cancelBlock:nil origin:self.view];

    }if (indexPath.section == 1 && indexPath.row == 3) {
        NSDate *curDate = [NSDate dateFromString:@"1999-09-09" withFormat:@"yyyy-MM-dd"];
        if (!curDate) {
            curDate = [NSDate dateFromString:@"1990-01-01" withFormat:@"yyyy-MM-dd"];
        }
        ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:curDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *strDate = [dateFormatter stringFromDate:selectedDate];

            NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
            NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
            [dics setValue:strDate forKey:@"ui_birthday"];
            [[NSUserDefaults standardUserDefaults]setObject:dics forKey:kLoginUserDict] ;
            ui_birthday = strDate;
            [weakself.tableView reloadData];
            
        } cancelBlock:^(ActionSheetDatePicker *picker) {
            
        } origin:self.view];
        picker.minimumDate = [[NSDate date] offsetYear:-120];
        picker.maximumDate = [NSDate date];
        [picker showActionSheetPicker];
        

    }if (indexPath.section == 2) {
//        TextViewController *vc  =[[TextViewController alloc] init];
//        vc.type = @"地址";
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.textField.text = [XIU_Login ui_address];
//        [self.navigationController pushViewController:vc animated:YES];
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
    NSData *data =UIImageJPEGRepresentation(image, 0.5);
    imgData = data;

    [self.tableView reloadData];
}

@end
