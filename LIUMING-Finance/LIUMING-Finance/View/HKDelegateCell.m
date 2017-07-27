//
//  HKDelegateCell.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKDelegateCell.h"
@interface HKDelegateCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
@implementation HKDelegateCell
+(HKDelegateCell *)delegateCell{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}




- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.delegate = self;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


//- (void)keyboardWillChangeFrame:(NSNotification *)note
//{
//    
////    // 键盘显示\隐藏完毕的frame
////    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
////    // 修改底部约束
////    self.bottomSapce.constant = XMGScreenH - frame.origin.y;
////    // 动画时间
////    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
////    // 动画
////    [UIView animateWithDuration:duration animations:^{
////        [self.view layoutIfNeeded];
////    }];
//}
//
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
