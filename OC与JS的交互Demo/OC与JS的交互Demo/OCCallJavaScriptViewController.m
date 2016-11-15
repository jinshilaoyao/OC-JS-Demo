//
//  OCCallJavaScriptViewController.m
//  OC与JS的交互Demo
//
//  Created by songjc on 16/11/12.
//  Copyright © 2016年 Don9. All rights reserved.
//

#import "OCCallJavaScriptViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface OCCallJavaScriptViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)JSContext *context;

@end

@implementation OCCallJavaScriptViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"改变" style:UIBarButtonItemStyleDone target:self action:@selector(changeWebTxet)];
    
    self.webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"ocCallJS.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [self.webView loadRequest: request];
    
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
    };
    


}

-(void)changeWebTxet{

    
    JSValue *labelAction = self.context[@"labelAction"];
    
    [labelAction callWithArguments:@[@"你好,JS世界!"]];


}


@end
