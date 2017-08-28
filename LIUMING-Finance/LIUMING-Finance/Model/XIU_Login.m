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

+(NSString *)url1 {
  return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_url1"];
}
+(NSString *)url2 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_url2"];
}
+(NSString *)url3 {
      return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_url3"];
}
+(NSString *)url4 {
      return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_url4"];
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
    return [NSString stringWithFormat:@"%.0f", [[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_limit"] floatValue]];
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

+(NSString *)ui_name3 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_name3"];
}
+(NSString *)ui_phone3 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_phone3"];
}

+(NSString *)ui_name4 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_name4"];
}
+(NSString *)ui_phone4 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_phone4"];
}

+(NSString *)ui_name5 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_name5"];
}
+(NSString *)ui_phone5 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_phone5"];
}

+(NSString *)ui_name6 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_name6"];
}
+(NSString *)ui_phone6 {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_phone6"];
}


+(NSString *)ui_workname {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_workname"];

}
+(NSString *)ui_faculty {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_faculty"];

}
//专业班级
+(NSString *)ui_professional{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_professional_class"];

}
+(NSString *)ui_yhtype {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_yhtype"];
  
}

+(NSString *)ui_school_roll {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_school_roll"];

}//学籍类型
+(NSString *)ui_xzaddress {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_xzaddress"];

}//寝室地址//公司地址
+(NSString *)ui_comphone {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_comphone"];

}
+(NSString *)ui_job {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_job"];

}
+(NSString *)ui_ed {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_ed"];

}
+(NSString *)ui_applying {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_applying"];
}
+(NSString *)userName {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_name"] length] < 1) {
        return @"请前往完善姓名";
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_name"];
}

+(NSString *)province {
     return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_province"];
}
+(NSString *)city {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_city"];
}
+(NSString *)area {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_area"];
}


+(NSString *)type {
    //3终端 2财务 5催收

//    return @"2";
    return [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_type"]] ;
}

+(NSString *)tjr{
  return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_tjrid"];

}//暂

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

    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_sex"]  isEqualToString: @"0"]) {
        return @"女";
    }if ([[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict][@"ui_sex"]  isEqualToString: @"1"]) {
        return @"男";
    }
        return @"未知";
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
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kXiaoxiState];//消息完善状态
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
//    推送注销
    //缓存删除
}
@end
