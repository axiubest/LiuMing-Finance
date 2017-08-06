//
//  HKPerfectInfoView.h
//  LIUMING-Finance
//
//  Created by Mac on 17/7/11.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  HKPerfectInfoView;

@protocol HKPerfectInfoViewDelegate<NSObject>
-(void)perfectInfoViewBtnClick:(HKPerfectInfoView *)view;
@end

@interface HKPerfectInfoView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *destribtionList;
@property (weak, nonatomic) IBOutlet UIButton *btn;


+(HKPerfectInfoView *)perfectInfoView;
-(void)show;
-(void)hide;

@property (nonatomic,weak) id<HKPerfectInfoViewDelegate> myDelegate;
@end
