//
//  JavaScriptCallOCViewController.m
//  OC与JS的交互Demo
//
//  Created by songjc on 16/11/12.
//  Copyright © 2016年 Don9. All rights reserved.
//

#import "JavaScriptCallOCViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol WebExport <JSExport>

JSExportAs
(myLog ,
 - (void)myOCLog:(NSString *)string
 );


@end

@interface JavaScriptCallOCViewController ()<UIWebViewDelegate,WebExport>

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)JSContext *context;

@property(nonatomic,strong)UIButton * button;

@end

@implementation JavaScriptCallOCViewController


- (void)myOCLog:(NSString *)string{

    NSLog(@"你好,世界!");
    
}

-(void)viewDidLoad{

    [super viewDidLoad];
    
    
    self.webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [self.webView loadRequest: request];
    
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 50, 40)];
    _button.backgroundColor = [UIColor redColor];
    [_button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_button];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{


     self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
     self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
    };
    
    
    __weak typeof(self)temp = self;
    self.context[@"myAction"] = ^(){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [temp.navigationController popViewControllerAnimated:YES];
        });
        
    };
    self.context[@"log"] = ^(NSString *string1, NSString * string2){
        NSLog(@"%@ --- %@",string1,string2);
    };
    
    self.context[@"native"] = self;

}

- (void)dealloc {
    NSLog(@"%@",@"aaaaa");
}
@end



