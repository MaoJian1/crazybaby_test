//
//  github_rep_TableViewCell.h
//  crazybaby_test
//
//  Created by Walnut Tech on 10/2/17.
//  Copyright © 2017年 MaoJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface github_rep_TableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *repo_name;

@property (strong, nonatomic) IBOutlet UILabel *repo_owner;

@property (strong, nonatomic) IBOutlet UILabel *repo_star;


@end
