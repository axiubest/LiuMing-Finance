//
//  HKPhotoUploadCell.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKPhotoUploadCell.h"
#import "UIButton+WebCache.h"
@interface HKPhotoUploadCell()
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourBtn;

@end
@implementation HKPhotoUploadCell
+(HKPhotoUploadCell *)photoUploadCell{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    

    
    [self setUpAllBtn];
}

-(void)setUpAllBtn{
    [self.oneBtn.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.9, 0.9, 0.9, 1 });
    
    [self.oneBtn.layer setBorderColor:colorref];//边框颜色
    
    
    
    [self.twoBtn.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref1 = CGColorCreate(colorSpace1,(CGFloat[]){ 0.9, 0.9, 0.9, 1 });
    
    [self.twoBtn.layer setBorderColor:colorref1];//边框颜色
    
    
    [self.threeBtn.layer setBorderWidth:1.0]; //边框宽度
    [self.threeBtn.layer setBorderColor:colorref1];//边框颜色
    
    [self.fourBtn.layer setBorderWidth:1.0]; //边框宽度
    [self.fourBtn.layer setBorderColor:colorref1];//边框颜色
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBtnArr:(NSArray *)btnArr{
    _btnArr = btnArr;
    NSLog(@"%@", _btnArr);
    if ([btnArr[0] isKindOfClass:[NSString class]]) {
        [self.oneBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:btnArr[0]] forState:UIControlStateNormal];
    }else {
        [self.oneBtn setImage:btnArr[0] forState:UIControlStateNormal];
 
    }
    
       [self.twoBtn setImage:btnArr[1] forState:UIControlStateNormal];
     [self.threeBtn setImage:btnArr[2] forState:UIControlStateNormal];
     [self.fourBtn setImage:btnArr[3] forState:UIControlStateNormal];
}

- (IBAction)btnClick:(UIButton *)btn {
    if ([self.myDelegate respondsToSelector:@selector(photoUploadCellBtnClick:widthBtn:)]){
        [self.myDelegate photoUploadCellBtnClick:self widthBtn:btn];
    }
}


@end
