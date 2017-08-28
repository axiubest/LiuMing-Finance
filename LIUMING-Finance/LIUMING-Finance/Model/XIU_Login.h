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
+(NSString *)tjr;//暂时
+(NSString *)ui_yhtype;

+(NSString *)ui_code;
+(NSString *)ui_cardid;
+(NSString *)ui_alipay;
+(NSString *)ui_income;
+(NSString *)ui_limit;
+(NSString *)ui_name1;
+(NSString *)ui_phone1;
+(NSString *)ui_name2;
+(NSString *)ui_phone2;
+(NSString *)ui_name3;
+(NSString *)ui_phone3;
+(NSString *)ui_name4;
+(NSString *)ui_phone4;
+(NSString *)ui_name5;
+(NSString *)ui_phone5;
+(NSString *)ui_name6;
+(NSString *)ui_phone6;

+(NSString *)ui_applying;

+(NSString *)url1;
+(NSString *)url2;
+(NSString *)url3;
+(NSString *)url4;


+(NSString *)ui_workname;
+(NSString *)ui_faculty;
+(NSString *)ui_professional;//专业班级
+(NSString *)ui_school_roll;//学籍类型
+(NSString *)ui_xzaddress;//寝室地址//公司地址
+(NSString *)ui_comphone;
+(NSString *)ui_job;
+(NSString *)ui_ed;


+(NSString *)province;
+(NSString *)city;
+(NSString *)area;



+ (BOOL)isVerification;
+ (XIU_User *)curLoginUser;
@end
