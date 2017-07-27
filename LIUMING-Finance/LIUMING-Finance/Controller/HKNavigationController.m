//
//  HKNavigationController.m
//  我的百思
//
//  Created by Mac on 16/9/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "HKNavigationController.h"
#import "UIBarButtonItem+XMGExtension.h"
@interface HKNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HKNavigationController
+(void)load{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = NB_FONT(19);
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes:dic];
//    [bar setBackgroundColor:[UIColor colorWithHexString:@"#3789FE"]];
//    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    [bar lt_setBackgroundColor:[UIColor colorWithHexString:@"#3789FE"]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
//    self.interactivePopGestureRecognizer.delegate = self;
//    NSLog(@"%@",self.interactivePopGestureRecognizer);
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count>1;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count>0) {
        viewController.navigationItem.leftBarButtonItem =[UIBarButtonItem itemWithImage:@"返回按钮" highImage:@"返回按钮" target:self action:@selector(back)];
        
        viewController.hidesBottomBarWhenPushed = YES;

    }
    [super pushViewController:viewController animated:animated];
    
}
-(void)back{
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
