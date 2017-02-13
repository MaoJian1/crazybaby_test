//
//  ViewController.h
//  crazybaby_test
//
//  Created by Walnut Tech on 10/2/17.
//  Copyright © 2017年 MaoJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *test_searchbar;

@property (strong, nonatomic) IBOutlet UITableView *test_tableview;


@end

