//
//  CSOAuthViewController.m
//  sina
//
//  Created by mac on 16/9/11.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "CSAccount.h"
#import "CSAccountTool.h"
#import "CSRootTool.h"

#define CSAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define CSClient_id     @"1951394302"
#define CSRedirect_uri  @"http://news.baidu.com/"
#define CSClient_secret @"57aa44f17fd6a2d37cacf5ff74efc8a4"

@interface CSOAuthViewController ()<UIWebViewDelegate>

@end

@implementation CSOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 展示登陆的网页 -> UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    // 加载网页
    // 一个完整的URL:基本URL + 参数
    // https://api.weibo.com/oauth2/authorize?client_id=&redirect_uri=
    
    // 拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",CSAuthorizeBaseUrl,CSClient_id,CSRedirect_uri];
    
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 加载请求
    [webView loadRequest:request];
    
    // 设置代理
    webView.delegate = self;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    // 提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载..."];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    
    // 获取code(RequestToken)
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) { // 有code=
        
        // code=81524df3190ea6e58e33c9a0eba1ac56
        // 0 + length
        
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        // 换取accessToken
        [self accessTokenWithCode:code];
        
        // 不会去加载回调界面
        return NO;
        
    }
    
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    [CSAccountTool accountWithCode:code success:^{
        [CSRootTool chooseRootViewController:CSKeyWindow];
    } failure:^(NSError *error) {
         NSLog(@"%@",error);
    }];
}


@end
