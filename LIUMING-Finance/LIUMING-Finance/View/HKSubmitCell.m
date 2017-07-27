//
//  HKSubmitCell.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKSubmitCell.h"
@interface HKSubmitCell()

@property (weak, nonatomic) IBOutlet UIButton *doBtn;
@end
@implementation HKSubmitCell
+(HKSubmitCell *)submitCell{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}
-(void)setBtnStr:(NSString *)btnStr{
    _btnStr = btnStr;
    [self.doBtn setTitle:btnStr forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)btnClick:(id)sender {
    if ([self.myDelegate respondsToSelector:@selector(submitCellBtnClick:)]) {
        [self.myDelegate submitCellBtnClick:self];
    }
}

@end
