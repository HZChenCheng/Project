//
//  HZWebViewController.m
//  WKWebView
//
//  Created by 陈诚 on 2017/5/23.
//  Copyright © 2017年 iOS_Developer. All rights reserved.
//

#import "HZWebViewController.h"
#import <WebKit/WebKit.h>

@interface HZWebViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView *webView;

@end

@implementation HZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 基本配置
    [self commonInit];

    // 加载Url(项目中的实际地址)，这里以"www.baidu.com"举例
    NSString *urlString = @"www.baidu.com";
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:16.f];
    [self.webView loadRequest:request];
    
    // 注册一个通知，以便可以处理相关业务，例如在优惠券页面选中优惠券后可以传递给H5页面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueTransmit:) name:@"SelectedCouponNotification" object:nil];

}

- (void)valueTransmit:(NSNotification *)notification {
    
    NSDictionary *dict = notification.userInfo;
    id object          = notification.object;
    
    /*
     
     // 优惠券页面选中的优惠券数组(里面包含的是是优惠券模型HZCouponModel)
     NSArray *couponArray = notification.object;
     
     // 模型数组->字典数组
     NSArray *dictArray = [HZCouponModel mj_keyValuesArrayWithObjectArray:couponArray];
     
     // 字典数组->Json,与H5之间是通过Json数据格式进行交互
     NSString *str = [dictArray toJSONString];
     
     // backOrderWeb 是H5定义好的方法
     NSString *js = [NSString stringWithFormat:@"backOrderWeb(%@)",str];

     */
    
    // js代码中可以传包含多个模型的数组等等
    NSString *js = @"";
    
    // App->H5 传值
    [self.webView evaluateJavaScript:js completionHandler:^(id object, NSError *error) {
        if (error) {
            // 逻辑处理
        }else {
            NSLog(@"%@",error);
        }
    }];
}

- (void)commonInit {
    
    // 配置参数
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc]init];
    
    // 默认为0
    config.preferences.minimumFontSize = 10;
    
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    // web内容处理池，由于没有属性可以设置，也没有方法可以调用，不用手动创建
    config.processPool = [[WKProcessPool alloc]init];
    
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    // couponCallBack，orderIdCallBack，couponsJumpToPayDone 是与前端约定好的方法名称
    [config.userContentController addScriptMessageHandler:self name:@"couponCallBack"];
    [config.userContentController addScriptMessageHandler:self name:@"orderIdCallBack"];
    [config.userContentController addScriptMessageHandler:self name:@"couponsJumpToPayDone"];
    
    WKWebView *webView                                = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    webView.backgroundColor                           = [UIColor clearColor];
    webView.opaque                                    = YES;
    webView.scrollView.showsVerticalScrollIndicator   = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.navigationDelegate                        = self;
    webView.UIDelegate                                = self;
    self.webView                                      = webView;
    [self.view addSubview:webView];
}

#pragma mark - WKNavigationDelegate

/*
 * 在发送请求之前，决定是否跳转
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *urlString = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    
    if ([[urlString lastPathComponent] isEqualToString:@"openCoupon"]) {
        // 打开优惠券页面
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([[urlString lastPathComponent] isEqualToString:@"backProdutionDetail"]) {
        // 回到产品详情
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

/*
 * 页面加载完成之后调用
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载完成");
}

/*
 * 页面加载失败时调用
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载失败");
}

/*
 * 当内容开始返回时调用
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

/*
 * 开始导航跳转时会回调
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"来到这个方法");
}

/*
 * 执行JS代码时会调用
 */
- (void)evaluateJavaScript:(NSString *)javaScriptString
         completionHandler:(void (^)(id, NSError *))completionHandler {
}

/*
 * H5->App 传值
 * 注入JS对象名称AppModel，当JS通过AppModel来调用时，
 * 在WKScriptMessageHandler代理中接收到
 */
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message
{
    
    NSString *messageName = message.name;
    id messageBody        = message.body;
    
    // 可在以下对应语句中做逻辑处理，例如跳转到对应的界面
    if ([messageName isEqualToString:@"couponCallBack"]) {
        
    }else if ([messageName isEqualToString:@"orderIdCallBack"]) {
        
    }else if ([messageName isEqualToString:@"couponsJumpToPayDone"]) {
        
    }
}

#pragma mark - WKUIDelegate

/**
 *  @author ChenCheng
 *
 *  web界面有弹出框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           弹出框的内容
 *  @param frame             主窗口
 *  @param completionHandler 弹出框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (action) {
            completionHandler();
        }
    }];
    
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:action];
}

/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (action) {
            completionHandler(NO);
        }
    }];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (action) {
            completionHandler(YES);
        }
    }];
    
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:cancelAction];
    [alertController addAction:action];

}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
    
}

@end
