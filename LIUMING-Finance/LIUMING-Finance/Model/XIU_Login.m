//
//  XIU_Login.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_Login.h"
#import "MJExtension.h"
#import "NSDictionary+Common.h"




static XIU_User *curLoginUser;
@implementation XIU_Login

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.phone = @"";
        self.password = @"";
    }
    return self;
}

- (NSString *)toPath {
    return @"UserServlet?dowhat=getOneByPhone&";
}


#pragma mark 相应key-Value在此修改---密码加密调用[self.password sha1Str]
- (NSDictionary *)params {
    NSMutableDictionary *param = @{@"userPhone": self.phone,
                                    @"userPass" : self.password,}.mutableCopy;
    return param;
}

+(BOOL)isLogin {
  NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus];
    return loginStatus.boolValue;
 
}

+(NSString *)userId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_id"];
}
+(NSString *)ui_name {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_name"];
}
+(NSString *)ui_img {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_img"];
}

+(NSString *)ui_birthday {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_birthday"] length] < 2) {
        return @"请完善生日";
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_birthday"];
}


+(NSString *)ui_code {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_code"];
}
+(NSString *)ui_cardid {
     return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_cardid"];
}
+(NSString *)ui_alipay {
     return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_alipay"];
}
+(NSString *)ui_income {
   return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_income"];
}
+(NSString *)ui_limit {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_limit"];
}
+(NSString *)ui_name1 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_name1"];
}
+(NSString *)ui_phone1 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_phone1"];
}
+(NSString *)ui_name2 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_name2"];
}
+(NSString *)ui_phone2 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_phone2"];
}


+(NSString *)userName {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_account"] length] < 2) {
        return @"请前往完善姓名";
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_account"];
}

+(NSString *)type {
    return @"3";
//    return [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_type"]] ;
}

+(NSString *)ui_phone {
    //手机号码一定有
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_phone"];
}

+(NSString *)ui_address {
   return  [[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict] objectForKey:@"ui_address"];

}

+(NSString *)ui_qqwx {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_qqwx"] length] < 4) {
        return @"请前往完善微信号";
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_qqwx"];

}
+(NSString *)ui_sex {

    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_sex"]  isEqual: @1]) {
        return @"男";
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_sex"]  isEqual: @0]) {
        return @"女";
    }
    return @"您未完善性别";
    
}

+ (BOOL)isVerification {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict] objectForKey:@"xiaoxi"];
}

+ (void)doLogin:(NSDictionary *)loginData {
    if (loginData) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:kLoginStatus];
        
     NSDictionary *tmpDic = [loginData deleteAllNullValue:loginData];
        [defaults setObject:tmpDic forKey:kLoginUserDict];

        
        curLoginUser = [XIU_User mj_objectWithKeyValues:loginData];
        
        [defaults synchronize];

#pragma mark 在此还应进行所有登录过的用户信息保存
    }else {
        [XIU_Login doLogOut];
    }
}



+ (XIU_User *)curLoginUser {
    if (!curLoginUser) {
        NSDictionary *loginData = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
        [[NSUserDefaults standardUserDefaults] synchronize];
        curLoginUser = loginData? [XIU_User mj_objectWithKeyValues:loginData]: nil;
    }
    return curLoginUser;

}

+(void)doLogOut {
    if ([self isLogin]) {
        
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:kLoginStatus];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:kLoginUserDict];

        [[NSUserDefaults standardUserDefaults] synchronize];
    }
//    推送注销
    //缓存删除
}
@end
