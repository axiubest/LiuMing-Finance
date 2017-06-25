//
//  XIU_ViewController.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/10.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ViewController.h"


@interface XIU_ViewController ()

@property (nonatomic, weak) UIView *NetWorkReachabilityView;

@end

@implementation XIU_ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#378AD6"];
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
       }



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    


}


- (NSString *)toPath {
    return @"UserServlet?dowhat=getOneByPhone&";
}

//- (BOOL)isLogin {
//   return  [XIU_Login isLogin];
//}

- (void)showEmptyDataSetViewWithTitle:(NSDictionary *)emptyDictionary {
    
}


- (void)createNavgationButtonWithImageNmae:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action type:(UINavigationItem_Type)navigationItem_Type {
    if (title == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        [button sizeToFit];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithCustomView:button];
        if (navigationItem_Type == UINavigationItem_Type_LeftItem) {
            self.navigationItem.leftBarButtonItem = Item;
        }else if (navigationItem_Type == UINavigationItem_Type_RightItem) {
            self.navigationItem.rightBarButtonItem = Item;
        }
        return;
    }else if (imageName == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button sizeToFit];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithCustomView:button];
        if (navigationItem_Type == UINavigationItem_Type_LeftItem) {
            self.navigationItem.leftBarButtonItem = Item;
        }else if (navigationItem_Type == UINavigationItem_Type_RightItem) {
            self.navigationItem.rightBarButtonItem = Item;
        }
        return;
    }else {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(-5, -5, 30, 30)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
//        button.frame = CGRectMake(backView.x, backView.y, 25, 25);
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:button];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:10.f];
        label.tag = 888;
        label.textAlignment = 1;
        label.textColor = [UIColor blackColor];
        label.text = title;
        [backView addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(button.mas_bottom).with.offset(0);
//
//            make.centerX.equalTo(button.mas_centerX);
//        }];
        
        UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithCustomView:backView];
        if (navigationItem_Type == UINavigationItem_Type_LeftItem) {
            self.navigationItem.leftBarButtonItem = Item;
        }else if (navigationItem_Type == UINavigationItem_Type_RightItem) {
            self.navigationItem.rightBarButtonItem = Item;
        }

        
        
    }

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setEditing:NO];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)createNavgationButtonOfLeftWithImageNmae:(NSString *)imageName target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
