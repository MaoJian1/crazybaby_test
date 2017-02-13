//
//  DetailViewController.h
//  crazybaby_test
//
//  Created by Walnut Tech on 10/2/17.
//  Copyright © 2017年 MaoJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIWebViewDelegate>{


    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
}

@property (nonatomic, strong) NSString *htmlurl;

@property (strong, nonatomic) IBOutlet UIWebView *detail_webview;



@end
