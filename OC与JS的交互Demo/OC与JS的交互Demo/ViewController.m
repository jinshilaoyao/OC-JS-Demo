//
//  ViewController.m
//  OC与JS的交互Demo
//
//  Created by songjc on 16/11/12.
//  Copyright © 2016年 Don9. All rights reserved.
//

#import "ViewController.h"
#import "JavaScriptCallOCViewController.h"
#import "OCCallJavaScriptViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:YES];


}


- (IBAction)pushJSCallOCViewController:(id)sender {
    
    JavaScriptCallOCViewController *vc = [[JavaScriptCallOCViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (IBAction)pushOCCallJSViewController:(id)sender {
    
    OCCallJavaScriptViewController *vc = [[OCCallJavaScriptViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
