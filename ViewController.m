//
//  ViewController.m
//  crazybaby_test
//
//  Created by Walnut Tech on 10/2/17.
//  Copyright © 2017年 MaoJian. All rights reserved.
//

#import "ViewController.h"
#import "GithubRepo.h"
#import "GithubRepoSearchSettings.h"
#import "github_rep_TableViewCell.h"
#import "DetailViewController.h"


@interface ViewController (){

    NSMutableArray *table_array;

}
@property (nonatomic, strong) GithubRepoSearchSettings *searchSettings;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchSettings = [[GithubRepoSearchSettings alloc] init];

    table_array = [[NSMutableArray alloc] init];
    
    _test_tableview.delegate = self;
    _test_tableview.dataSource = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:animated];
    
    [self.test_tableview setUserInteractionEnabled:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return 1;
    //return [postObjectsArray count];
    
    
    return [table_array count];
    
}

// Cell Allocate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * showUserInfoCellIdentifier = @"maincellID";
    
    github_rep_TableViewCell *maintablecell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    
    
    //MainTableViewCell *maintablecell = [tableView cellForRowAtIndexPath:indexPath];
    if (!maintablecell)
    {
        //maintablecell = [tableView cellForRowAtIndexPath:indexPath];
        maintablecell = [[github_rep_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:showUserInfoCellIdentifier];
        
    }
    
    //[table_array objectAtIndex: indexPath.row]
    
    NSLog(@"tabledebug %li",(long)[[table_array objectAtIndex: indexPath.row] stars]);

    [maintablecell.repo_name setText:[[table_array objectAtIndex: indexPath.row] name] ];
    [maintablecell.repo_owner setText:[[table_array objectAtIndex: indexPath.row] ownerHandle] ];
    
    [maintablecell.repo_star setText:[NSString stringWithFormat:@"stars: %ld", (long)[[table_array objectAtIndex: indexPath.row] stars]]];

    
    
    return maintablecell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    NSLog(@"didSelectRowAtIndexPath");
    
    [self.test_tableview setUserInteractionEnabled:NO];
    

    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
    detailViewController.htmlurl = [[table_array objectAtIndex: indexPath.row] htmlurl]; // hand off the current product to the detail view controller
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    // note: should not be necessary but current iOS 8.0 bug (seed 4) requires it
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
//    searchBar.showsCancelButton = YES;
//    NSString  *text = self.test_searchbar.text;
//    
//    NSLog(@"githubdebug1 %@", text);
//    
//    if(text.length) {
//        
//        self.searchSettings.searchString = text;
//        
//        [GithubRepo fetchRepos: self.searchSettings successCallback:^(NSArray *repos) {
//            for (GithubRepo *repo in repos) {
//                NSLog(@"githubdebug2 %@", repo);
//            }
//           
//        }];
//        
//        return;
//    }
//    //[ActivityIndicator startAnimating];
//    NSLog(@"searchBarTextDidBeginEditing");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"searchBarSearchButtonClicked");

    [searchBar resignFirstResponder];
    
    searchBar.showsCancelButton = YES;
    NSString  *text = self.test_searchbar.text;
    
    NSLog(@"githubdebug1 %@", text);
    
    if(text.length) {
        
        self.searchSettings.searchString = text;
        
        [GithubRepo fetchRepos: self.searchSettings successCallback:^(NSArray *repos) {
            
            table_array = [[NSMutableArray alloc] init];
            
            for (GithubRepo *repo in repos) {
                NSLog(@"githubdebug2 %@", repo.name);
                
                [table_array addObject:repo];
                
                
            }
            
            NSLog(@"githubdebug2 reloaddata");
            [self.test_tableview reloadData];
            
        }];
        
        return;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    searchBar.showsCancelButton = YES;
    NSString  *text = self.test_searchbar.text;
    
    NSLog(@"githubdebug1 %@", text);
    
    if(text.length) {
        
        self.searchSettings.searchString = text;
        
        [GithubRepo fetchRepos: self.searchSettings successCallback:^(NSArray *repos) {
            
            table_array = [[NSMutableArray alloc] init];
            
            for (GithubRepo *repo in repos) {
                NSLog(@"githubdebug2 %@", repo.name);
                
                [table_array addObject:repo];
                
                
            }
            
            NSLog(@"githubdebug2 reloaddata");
            [self.test_tableview reloadData];
            
        }];
        
        return;
    }
    //[ActivityIndicator startAnimating];
    NSLog(@"searchBarTextDidBeginEditing");


}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self cancelSearching];
    NSLog(@"bugbugbug");
    
    table_array = [[NSMutableArray alloc] init];
    
    [self.test_tableview reloadData];

}


-(void)cancelSearching{
    NSLog(@"bugbug");
    //self.searchBarActive = NO;
    [_test_searchbar resignFirstResponder];
    _test_searchbar.text  = @"";
    [_test_searchbar setShowsCancelButton:NO animated:YES];
}


-(void)resetSearch
{

}



@end
