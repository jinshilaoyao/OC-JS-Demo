//
//  OtherViewController.m
//  OC与JS的交互Demo
//
//  Created by yesway on 2016/11/18.
//  Copyright © 2016年 Don9. All rights reserved.
//

#import "OtherViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol WebViewJSExport <JSExport>

- (void)callCamera:(NSString *)str;
- (NSString *)share:(NSString *)shareString;

@end

@interface OtherViewController ()<UIWebViewDelegate,WebViewJSExport>
@property (nonatomic,strong) JSContext * context;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initWebView];

}

- (void)initWebView {
    self.context = [[JSContext alloc] init];
    
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"HelloWorld.html"];
    NSURL * url = [NSURL fileURLWithPath:path];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext * context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _context = context;
    
//    [_context setObject:self forKeyedSubscript:@"WBBridge"];
    self.context[@"WBBridge"] = self;
    _context.exceptionHandler = ^(JSContext * context, JSValue * value) {
        context.exception = value;
        NSLog(@"异常信息 %@",value);
    };
}
- (void)callCamera:(NSString *)str {
    NSLog(@"调用相机");
    NSLog(@"%@",str);
}
- (NSString *)share:(NSString *)shareString {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@",@"啊啊啊啊");
    });
    return @"分享成功";
}



-(NSInteger)add:(NSInteger)a and:(NSInteger)b{
    return  a+b;
}

-(void)JSCallOC_block{
    self.context = [[JSContext alloc] init];
    
    __weak typeof(self) weakSelf = self;
    self.context[@"add"] = ^NSInteger(NSInteger a, NSInteger b){
        return [weakSelf add:a and:b];
    };
    JSValue *sum = [self.context evaluateScript:@"add(4,5)"];
    NSInteger intSum = [sum toInt32];
    NSLog(@"intSum: %zi",intSum);
}

- (void)OCCallJs {
    self.context = [[JSContext alloc] init];
    
    NSString * js = @"function add(a,b) {return a+b}";
    [self.context evaluateScript:js];
    JSValue * addjs = self.context[@"add"];
    
    JSValue * sum = [addjs callWithArguments:@[@(10),@(13)]];
    NSInteger intSum = [sum toInt32];
    NSLog(@"%ld",(long)intSum);
}

@end
