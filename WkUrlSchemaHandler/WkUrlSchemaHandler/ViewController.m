//
//  ViewController.m
//  WkUrlSchemaHandler
//
//  Created by wangxiaoman on 2021/1/25.
//  Copyright © 2021 wangxiaoman. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface WKWebView()
@end

@implementation WKWebView(Handler)

+ (BOOL)handlesURLScheme:(NSString *)urlScheme
{
    if([urlScheme isEqualToString:@"http"]||[urlScheme isEqualToString:@"https"])
        return NO;
    return YES;
}

@end
@interface CustomUrlHandler:NSObject<WKURLSchemeHandler>

@end

@implementation CustomUrlHandler
#pragma WKURLSchemeHandler
- (void)webView:(WKWebView *)webView startURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSString *reqUrl = urlSchemeTask.request.URL.absoluteString;
    NSLog(@"start to load res url:%@",reqUrl);
    NSURL *url = [NSURL URLWithString:reqUrl];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

               [urlSchemeTask didReceiveResponse:response];
               [urlSchemeTask didReceiveData:data];
               if (error) {
                   NSLog(@"load error url:%@,and error des:%@",reqUrl,error.description);
                   [urlSchemeTask didFailWithError:error];
               } else {
                   NSLog(@"load suc url:%@",reqUrl);
                   [urlSchemeTask didFinish];
               }
           }];
           [dataTask resume];
}
- (void)webView:(WKWebView *)webView stopURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}


@end

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic,strong)WKWebView*webview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    [configuration setURLSchemeHandler:[CustomUrlHandler new] forURLScheme: @"http"];
    [configuration setURLSchemeHandler:[CustomUrlHandler new] forURLScheme: @"https"];
    WKWebView *webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.webview = webview;
    
    [self.view addSubview:webview];
    webview.navigationDelegate = self;
    NSURLRequest*req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://cn.bing.com/?mkt=zh-CN"]];
    [webview loadRequest:req];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.webview.frame = self.view.bounds;
    
}


#pragma WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    if(decisionHandler){
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}



- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    decisionHandler(WKNavigationResponsePolicyAllow);

}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%@",NSStringFromSelector(_cmd));

}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%@",NSStringFromSelector(_cmd));

}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%@",NSStringFromSelector(_cmd));

}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%@",NSStringFromSelector(_cmd));

}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%@",NSStringFromSelector(_cmd));

}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"%@",NSStringFromSelector(_cmd));

}

//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
//{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
//
//}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    NSLog(@"%@",NSStringFromSelector(_cmd));

}

@end
