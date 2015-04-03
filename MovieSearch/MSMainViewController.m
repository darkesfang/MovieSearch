//
//  MSMainTableViewController.m
//  MovieSearch
//
//  Created by Darkes on 2015/4/3.
//  Copyright (c) 2015年 Boitec. All rights reserved.
//

#import "MSMainViewController.h"
#import "AFNetworking.h"
#import "MSResultTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@interface MSMainViewController () {
    MBProgressHUD *hud;
    AFHTTPRequestOperationManager *manager;
}

@end


@implementation MSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _movies = [NSMutableArray new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MSResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    self.tableView.rowHeight = 80.;
    [self.tableView reloadData];
    
    [self searchWithkeyword:@"hobbit"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     MSResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    NSDictionary *movie = [self.movies objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [movie objectForKey:@"title"];
    cell.yearLabel.text = [NSString stringWithFormat:@"%@", [movie objectForKey:@"year"]];
    cell.ratingLabel.text = [movie objectForKey:@"rating"];
    cell.imageView.image = nil;
    
    NSString *imageUrl = [[[movie objectForKey:@"poster"] objectForKey:@"urls"] objectForKey:@"w92"];
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    [cell.posterImage setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        cell.imageView.image = image;
        [cell setNeedsLayout];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
    
    
    return cell;
}


#pragma mark - Search bar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self searchWithkeyword:searchBar.text];
}

- (void)searchWithkeyword:(NSString *)key {
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *url = [NSString stringWithFormat:@"http://api.movies.io/movies/search?q=%@", key];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.movies = [responseObject objectForKey:@"movies"];
        [self.tableView reloadData];
        
        if (hud != nil) {
            [hud hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        if (hud != nil) {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [error localizedDescription];
            [hud hide:YES afterDelay:3];
        }
    }];
}

@end
