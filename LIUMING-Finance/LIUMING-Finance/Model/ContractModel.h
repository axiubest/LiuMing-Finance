//
//  ContractModel.h
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/8/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContractModel : NSObject
@property (nonatomic, copy) NSString *oi_id, *oi_num, *oi_uid, *oi_addtime, *oi_jkprice, *oi_jkloans, *oi_state, *oi_kfjlid, *oi_reason, *oi_mark, *oi_dkaddtime, *hktime, *ui_name;

@property (nonatomic, copy) NSString *oi_htid1, *oi_htid2, *oi_htid3, *oi_pdf1, *oi_pdf2, *oi_pdf3, *oi_sign1, *oi_sign2, *oi_sign3, *oi_sign4, *oi_sign5;
@end
