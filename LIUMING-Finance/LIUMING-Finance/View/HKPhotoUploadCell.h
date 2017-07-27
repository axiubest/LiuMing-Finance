//
//  HKPhotoUploadCell.h
//  LIUMING-Finance
//
//  Created by Mac on 17/7/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKPhotoUploadCell;
@protocol HKPhotoUploadCellDelegate<NSObject>
-(void)photoUploadCellBtnClick:(HKPhotoUploadCell *)cell widthBtn:(UIButton *)btn;
@end

@interface HKPhotoUploadCell : UITableViewCell
+(HKPhotoUploadCell *)photoUploadCell;
@property (nonatomic,weak) id<HKPhotoUploadCellDelegate> myDelegate;
@property (nonatomic,strong) NSArray *btnArr;
@end
