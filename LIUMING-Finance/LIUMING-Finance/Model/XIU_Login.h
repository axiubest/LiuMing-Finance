//
//  XIU_Login.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XIU_User.h"


@interface XIU_Login : NSObject

@property (readwrite, nonatomic, copy) NSString *phone;

@property (readwrite, nonatomic, copy) NSString *password;


- (NSString *)toPath;
- (NSDictionary *)params;

+ (void)doLogin:(NSDictionary *)loginData;
+(BOOL)isLogin;
+(void)doLogOut;

+(NSString *)ui_name;
+(NSString *)ui_address;
+(NSString *)userName;
+(NSString *)userId;
+(NSString *)ui_phone;
+(NSString *)ui_qqwx;
+(NSString *)ui_img;
+(NSString *)ui_birthday;
+(NSString *)ui_sex;
+(NSString *)type;

+(NSString *)ui_code;
+(NSString *)ui_cardid;
+(NSString *)ui_alipay;
+(NSString *)ui_income;
+(NSString *)ui_limit;
+(NSString *)ui_name1;
+(NSString *)ui_phone1;
+(NSString *)ui_name2;
+(NSString *)ui_phone2;









+ (BOOL)isVerification;
+ (XIU_User *)curLoginUser;
@end
