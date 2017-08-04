//
//  AppDelegate.m
//  LIUMING-Finance
//
//  Created by A-XIU on 2017/6/19.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "AppDelegate.h"
#import "Login_ViewController.h"
#import "FinancialContribution_ViewController.h"
#import "BaseTableViewController.h"
#import "HKNavigationController.h"
#import "MyList_ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //判断用户是否登陆
    
    if (![XIU_Login isLogin]) {

        self.window.rootViewController = [Login_ViewController loadViewControllerFromMainStoryBoard];
    }else{
        //3终端 2财务 5催收
        if ([[XIU_Login type] isEqualToString:@"3"]) {
            self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
  
        }if ([[XIU_Login type] isEqualToString:@"2"]) {
            FinancialContribution_ViewController *v = [[FinancialContribution_ViewController alloc] init];
            HKNavigationController *nav = [[HKNavigationController alloc] initWithRootViewController:v];
            self.window.rootViewController = nav;
            
        }if ([[XIU_Login type] isEqualToString:@"5"]) {
            MyList_ViewController *v = [[MyList_ViewController alloc] init];
            v.title = @"催收订单";
            HKNavigationController *nav = [[HKNavigationController alloc] initWithRootViewController:v];
            self.window.rootViewController = nav;
            
        }
        
         }
    
    
     [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
