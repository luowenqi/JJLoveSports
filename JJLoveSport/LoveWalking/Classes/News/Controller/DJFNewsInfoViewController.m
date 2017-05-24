//
//  DJFNewsInfoViewController.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/13.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFNewsInfoViewController.h"
#import <WebKit/WebKit.h>
@interface DJFNewsInfoViewController ()

@end

@implementation DJFNewsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebView* wkWebView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://food.fanqiedy.com/NewsInfo.aspx?nId=%@",_nId]];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
    
    [wkWebView loadRequest:urlRequest];
    [self.view addSubview:wkWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
