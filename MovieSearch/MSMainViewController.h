//
//  MSMainTableViewController.h
//  MovieSearch
//
//  Created by Darkes on 2015/4/3.
//  Copyright (c) 2015年 Boitec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSMainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
