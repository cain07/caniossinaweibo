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

#define CZAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define CZClient_id     @"2389394849"
#define CZRedirect_uri  @"http://www.baidu.com"
#define CZClient_secret @"03729d16a4cd277c7da26398f7a01282"

@interface CSOAuthViewController ()<UIWebViewDelegate>

@end

@implementation CSOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Do any additional setup after loading the view.
    
    // 展示登陆的网页 -> UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    // 加载网页
    
    // 一个完整的URL:基本URL + 参数
    // https://api.weibo.com/oauth2/authorize?client_id=&redirect_uri=
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"2389394849";
    NSString *redirect_uri = @"http://www.baidu.com";
    
    // 拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    
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
    // 发送Post请求
    
    // 创建请求管理者:请求和解析
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = CZClient_id;
    params[@"client_secret"] = CZClient_secret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = CZRedirect_uri;
    
    // 发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) { // 请求成功的时候调用
        
        NSLog(@"%@",responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) { // 请求失败的时候调用
        NSLog(@"%@",error);
    }];
}


@end
