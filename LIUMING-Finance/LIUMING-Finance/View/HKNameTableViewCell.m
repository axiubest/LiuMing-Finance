//
//  HKNameTableViewCell.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "HKNameTableViewCell.h"

@interface HKNameTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *myProfitView;

@end


@implementation HKNameTableViewCell




+(HKNameTableViewCell *)nameTableVeiwCell{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.myProfitView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profitViewClick)]];
    
//    添加点击事件
    [self.nameView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameViewClick)]];
}

-(void)profitViewClick{
    if([self.myDelegate respondsToSelector:@selector(nameTableProfitViewClick:)]){
        [self.myDelegate nameTableProfitViewClick:self];
    }
}

-(void)nameViewClick{
    if([self.myDelegate respondsToSelector:@selector(nameTableViewCellClick:)]){
        [self.myDelegate nameTableViewCellClick:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
