//
//  XIU_WebViewController.m
//  LIUMING-Finance
//
//  Created by Apple on 2017/8/14.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_WebViewController.h"

#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "AutographView.h"

@interface XIU_WebViewController ()<UIWebViewDelegate, NJKWebViewProgressDelegate,UIAlertViewDelegate>
{
    UIWebView *_webView;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    CALayer *hidLayer;
}

@property (nonatomic, weak)AutographView *drawView;
@property (nonatomic, weak)UIButton *navRightBtn;
@property (nonatomic, weak)UIView *headerView;
@end

@implementation XIU_WebViewController
#pragma mark 清除输入
- (void)clickClearWriteBtn {
    [self.drawView.autographView clear];

}

#pragma mark 生成签名
- (void)clickGenerateBtn {
    UIImage *image = [self imageWithUIView:self.drawView.autographView];
    self.drawView.img.image = image;
}


#pragma mark 确定
- (void)clickSureWriteBtn {

    NSData * imageData = UIImageJPEGRepresentation(self.drawView.img.image,1);
    if (imageData.length < 1) {
        XIUHUD(@"请生成签名");
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定提交" message:@"签名将显示到合同中，确定即为生效" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self request];
    }
}

- (void)request {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud show:YES];
    
    UIImage *image = [self imageWithUIView:self.drawView.autographView];
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:@"Agreement/to_sign" withParams:@{@"oi_id":_oi_id, @"hetong":_hetong, @"ui_eqb_img":[self imageBase64WithDataURL:image], @"ui_type":[XIU_Login type], @"ui_id":[XIU_Login userId]} withMethodType:Post andBlock:^(id data, NSError *error) {
        [hud hide:YES];
        if([data[@"status"] isEqualToString:@"false"]) {
            XIUHUD(@"签名失败");
        }else {
            XIUHUD(@"签名成功");
            self.drawView.hidden = YES;
            hidLayer.hidden = self.drawView.hidden;
        [self.navRightBtn setTitle:@"签名" forState:UIControlStateNormal];
        }
    }];
}


- (void)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.navRightBtn setTitle:@"签名" forState:UIControlStateNormal];
    
    
    //改版签名取消,点击签名按钮直弹出
    self.drawView.hidden = YES;
    hidLayer.hidden = YES;
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, self.view.height)];
    web.delegate = self;
    web.backgroundColor = [UIColor clearColor];
    _webView = web;
    [self.view addSubview:web];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect barFrame = CGRectMake(0, 64, KWIDTH ,progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self load];


}


-(void)load
{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_pdf_url]];
    [_webView loadRequest:req];
}
- (void)click {
      UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定提交？" message:@"签名将显示到合同中，确定即为生效" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
    
//    if (self.navRightBtn.selected == YES) {
//    [self.navRightBtn setTitle:@"签名" forState:UIControlStateNormal];
//        self.drawView.hidden = YES;
//        hidLayer.hidden = self.drawView.hidden;
//    }else {
//           [self.navRightBtn setTitle:@"取消" forState:UIControlStateNormal];
//        self.drawView.hidden = NO;
//        hidLayer.hidden = self.drawView.hidden;
//    }
//    _navRightBtn.selected = !_navRightBtn.selected;

}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}


- (UIImage*) imageWithUIView:(UIView*) view

{
    
    UIGraphicsBeginImageContext(view.bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tImage;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];

}

- (UIView *)headerView {
    if (!_headerView) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 64)];
        v.backgroundColor = [UIColor colorWithHexString:@"328CFE"];
        [self.view addSubview:v];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 28, 20, 30)];
        [btn setImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        [v addSubview:btn];
        _headerView = v;
    }
    return _headerView;
}

-(AutographView *)drawView {
    if (!_drawView) {
        
        CALayer *la = [CALayer layer];
        la.frame = CGRectMake(0, 64, KWIDTH, self.view.height)
        ;
        la.hidden = YES;
        hidLayer = la;
        la.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5].CGColor;
        [self.view.layer addSublayer:la];
        AutographView *draw = [[NSBundle mainBundle]loadNibNamed:[AutographView XIU_ClassIdentifier] owner:self options:nil].lastObject;
        draw.frame = CGRectMake(30, 100, KWIDTH - 60, KHEIGHT - 170);
        draw.hidden = YES;
        [draw.clearbtn addTarget:self action:@selector(clickClearWriteBtn) forControlEvents:UIControlEventTouchUpInside];
        [draw.generateBtn addTarget:self action:@selector(clickGenerateBtn) forControlEvents:UIControlEventTouchUpInside];
        [draw.sureBtn addTarget:self action:@selector(clickSureWriteBtn) forControlEvents:UIControlEventTouchUpInside];
        
        _drawView = draw;
        [self.view addSubview:draw];
    }
    return _drawView;
}


- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(KWIDTH - 80, 27, 80, 30)];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.selected = NO;
        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:button];
        _navRightBtn = button;
    }
    return _navRightBtn;
}
- (NSString *)imageBase64WithDataURL:(UIImage *)image
{
    NSData *imageData =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x =50 / image.size.height;
    if (x >1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, x);
    
    return [NSString stringWithFormat:@"%@",
            [imageData base64EncodedStringWithOptions:0]];
}
@end
