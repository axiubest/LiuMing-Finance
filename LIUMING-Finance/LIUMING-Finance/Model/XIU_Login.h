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
+(NSString *)userName;
+(NSString *)userId;
+(NSString *)ui_phone;
+(NSString *)ui_qqwx;
+(NSString *)ui_sex;
+(NSString *)type;
+ (BOOL)isVerification;
+ (XIU_User *)curLoginUser;
@end
