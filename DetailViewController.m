//
//  DetailViewController.m
//  crazybaby_test
//
//  Created by Walnut Tech on 10/2/17.
//  Copyright © 2017年 MaoJian. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backtomain"] style:UIBarButtonItemStylePlain target:self action:@selector(GoBack:)];
    
    //webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 44, 320, 440)];
    [self.detail_webview setUserInteractionEnabled:YES];//是否支持交互
    //[webView setDelegate:self];
    self.detail_webview.delegate=self;
    [self.detail_webview setOpaque:NO];//opaque是不透明的意思
    [self.detail_webview setScalesPageToFit:YES];//自动缩放以适应屏幕
    //[self.view addSubview:webView];
    
    //加载网页的方式
    //1.创建并加载远程网页
    NSURL *url = [[NSURL alloc] initWithString:self.htmlurl];
    [self.detail_webview loadRequest:[NSURLRequest requestWithURL:url]];
    //2.加载本地文件资源
    /* NSURL *url = [NSURL fileURLWithPath:filePath];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [webView loadRequest:request];*/
    //3.读入一个HTML，直接写入一个HTML代码
    //NSString *htmlPath = [[[NSBundle mainBundle]bundlePath]stringByAppendingString:@"webapp/loadar.html"];
    //NSString *htmlString = [NSString stringWithContentsOfURL:htmlPath encoding:NSUTF8StringEncoding error:NULL];
    //[webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlPath]];
    
    opaqueView = [[UIView alloc]initWithFrame:self.view.frame];
    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:self.view.frame];
    [activityIndicatorView setCenter:opaqueView.center];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [opaqueView setBackgroundColor:[UIColor blackColor]];
    [opaqueView setAlpha:0.6];
    [self.view addSubview:opaqueView];
    [opaqueView addSubview:activityIndicatorView];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [activityIndicatorView startAnimating];
    opaqueView.hidden = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [activityIndicatorView startAnimating];
    opaqueView.hidden = YES;
}

//UIWebView如何判断 HTTP 404 等错误
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSURL *url = [[NSURL alloc] initWithString:self.htmlurl];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2)) {
        // self.earthquakeData = [NSMutableData data];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [self.detail_webview loadRequest:[ NSURLRequest requestWithURL: url]];
        self.detail_webview.delegate = self;
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
                                  NSLocalizedString(@"HTTP Error",
                                                    @"Error message displayed when receving a connection error.")
                                                             forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
        
        if ([error code] == 404) {
            NSLog(@"xx");
            self.detail_webview.hidden = YES;
        }
        
    }
}

- (IBAction)GoBack:(id)sender {
    
    NSLog(@"goback");
    
    if(self.detail_webview.canGoBack){
        [self.detail_webview goBack];
        
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
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
