//
//  MyList_ViewController.m
//  LIUMING-Finance
//
//  Created by Mac on 17/7/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "MyList_ViewController.h"
#import "BaseTableViewController.h"
#import "HKTitleBtn.h"
#import "Login_ViewController.h"
#import "SearchViewController.h"
@interface MyList_ViewController ()<UIScrollViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) UIScrollView *contentView;
@property (weak, nonatomic) UIView *titlesView;
@property (weak, nonatomic) UIView *sliderView;
@property (weak, nonatomic) HKTitleBtn *selectedButton;
@property (strong, nonatomic) MASConstraint *sliderViewCenterX;

@end

@implementation MyList_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"我的清单";
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupChildViewControllers];
    [self setupContentView];
    [self setupTitlesView];
    
    [self setNavSearchButton];
    
    
}

#pragma mark search
- (void)setNavSearchButton {
    //3终端 2财务 5催收

    if ([[XIU_Login type] isEqualToString:@"5"]) {
          [self createNavgationButtonWithImageNmae:@"搜索" title:nil target:self action:@selector(clickSearchBtn) type:UINavigationItem_Type_RightItem];
    }
    if (![[XIU_Login type] isEqualToString:@"3"]) {//不为终端用户左边展示退出按钮
        [self createNavgationButtonWithImageNmae:@"退出" title:nil target:self action:@selector(clickEditBtn) type:UINavigationItem_Type_LeftItem];
    }
  
}


- (void)clickEditBtn {
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"确定退出？" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [XIU_Login doLogOut];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        
        window.rootViewController = [Login_ViewController loadViewControllerFromMainStoryBoard];
    }
}
- (void)clickSearchBtn {
    SearchViewController *vc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupChildViewControllers
{
    [self setupOneChildViewController:HKListTypeAll];
    [self setupOneChildViewController:HKListTypeBorrowMoney];
    [self setupOneChildViewController:HKListTypeSettle];//已结清
    [self setupOneChildViewController:HKListTypeYuQi];
    [self setupOneChildViewController:HKListTypeProsecution];//已起诉
    
}
- (void)setupOneChildViewController:(HKListType)type
{
    BaseTableViewController *vc = [[BaseTableViewController alloc] init];
    vc.title = self.title;
    vc.type = type;
    [self addChildViewController:vc];
}
- (void)setupContentView
{
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    contentView.frame = CGRectMake(0, 44, self.view.width, self.view.height-44);
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentView.delegate = self;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    contentView.scrollEnabled = NO;
    [self.view addSubview:contentView];
    
    self.contentView = contentView;
}
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];

    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    titlesView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titlesView.frame = CGRectMake(0, 64, self.view.frame.size.width, 44);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 5个按钮
    HKTitleBtn *button = [self setupTitleButton:@"全部"];
    HKTitleBtn *button1 = [self setupTitleButton:@"借款中"];
    HKTitleBtn *button2 = [self setupTitleButton:@"已结清"];
    HKTitleBtn *button3 = [self setupTitleButton:@"已逾期"];
    HKTitleBtn *button4 = [self setupTitleButton:@"已起诉"];
    NSArray *a = @[button,button1,button2,button3,button4];
    
    [self.contentView layoutIfNeeded];
    
    
    
    [self titleClick:a[self.myType]];
    
    
    [self switchController:self.myType];
    
    // 底部滑条
    UIView *sliderView = [[UIView alloc] init];
    sliderView.backgroundColor = [UIColor colorWithHexString:@"#328cfe"];
    [self.titlesView addSubview:sliderView];
    self.sliderView = sliderView;
    
    [sliderView mas_makeConstraints:^(MASConstraintMaker *make) {

         make.size.mas_equalTo(CGSizeMake(43, 2));
        make.bottom.equalTo(self.titlesView);
        self.sliderViewCenterX = make.centerX.equalTo(a[self.myType]);
    }];
    
    
    
}


- (HKTitleBtn *)setupTitleButton:(NSString *)title
{
    HKTitleBtn *button = [HKTitleBtn buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titlesView addSubview:button];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.titlesView).multipliedBy(0.2);
        make.top.bottom.equalTo(self.titlesView);
        NSUInteger index = self.titlesView.subviews.count - 1;
        if (index == 0) {
            make.left.mas_equalTo(self.titlesView);
        } else {
            make.left.mas_equalTo([self.titlesView.subviews[index - 1] mas_right]);
        }
    }];
    
    return button;
}

- (void)titleClick:(HKTitleBtn *)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 消除约束
    [self.sliderViewCenterX uninstall];
    self.sliderViewCenterX = nil;
    
    // 添加约束
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.sliderViewCenterX = make.centerX.equalTo(button);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.sliderView layoutIfNeeded];
    }];
    
    int index = (int)[self.titlesView.subviews indexOfObject:button];
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.frame.size.width, self.contentView.contentOffset.y) animated:YES];
    
}

- (void)switchController:(NSInteger)index
{
    
    
    BaseTableViewController *vc = self.childViewControllers[index];

    vc.view.y = 0;
    vc.view.width = self.contentView.width;
    vc.view.height = self.contentView.height;
    vc.view.x = vc.view.width * index;
    [self.contentView addSubview:vc.view];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
//    NSLog(@"----index==%f",scrollView.contentOffset.x);
    [self titleClick:self.titlesView.subviews[index]];
    [self switchController:index];
}
- (void)scrollViewDidEndScrollingAnimation:(nonnull UIScrollView *)scrollView
{
    
    [self switchController:(int)(scrollView.contentOffset.x / scrollView.frame.size.width)];
}
@end
