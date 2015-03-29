//
//  ViewController.m
//  searcher
//
//  Created by yasin aktimur on 29.03.2015.
//  Copyright (c) 2015 yasin aktimur. All rights reserved.
//

#import "ViewController.h"
#define ResultsTableView self.searchResultsTableViewController.tableView

#define Identifier @"Cell"

@interface ViewController ()

@property (strong, nonatomic) UISearchController *searchController;

@property (strong, nonatomic) UITableViewController *searchResultsTableViewController;

@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NSArray *results;
@property UIBarButtonItem *searcBarButton;

@end

@implementation ViewController
@synthesize  lister;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Arrays init & sorting.
    self.cities = [@[@"Boston", @"New York", @"Oregon", @"Tampa", @"Los Angeles", @"Dallas", @"Miami", @"Olympia", @"Montgomery", @"Washington", @"Orlando", @"Detroit"] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj2 localizedCaseInsensitiveCompare:obj1] == NSOrderedAscending;
    }];
    
    
    
    self.results = [[NSMutableArray alloc] init];
    
    // A table view for results.
    UITableView *searchResultsTableView = [[UITableView alloc] initWithFrame:self.lister.frame];
    searchResultsTableView.dataSource = self.lister.dataSource;
    searchResultsTableView.delegate = self.lister.delegate;
    
    // Registration of reuse identifiers.
    [searchResultsTableView registerClass:UITableViewCell.class forCellReuseIdentifier:Identifier];
    [self.lister registerClass:UITableViewCell.class forCellReuseIdentifier:Identifier];
    
    // Init a search results table view controller and setting its table view.
    self.searchResultsTableViewController = [[UITableViewController alloc] init];
    self.searchResultsTableViewController.tableView = searchResultsTableView;
    
    // Init a search controller with its table view controller for results.
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsTableViewController];
    
    
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    
    // Make an appropriate size for search bar and add it as a header view for initial table view.
    [self.searchController.searchBar sizeToFit];
    //self.lister.tableHeaderView = self.searchController.searchBar;
    

    self.navigationItem.titleView = self.searchController.searchBar;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    // Enable presentation context.
    self.definesPresentationContext = YES;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Done"

    self.searcBarButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searcher)];
    self.navigationItem.rightBarButtonItem = self.searcBarButton;
 
    [self.searchController.searchBar setHidden:YES];
  
}





#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:ResultsTableView]) {
        if (self.results) {
            return self.results.count;
        } else {
            return 0;
        }
    } else {
        
        return self.cities.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    NSString *text;
    if ([tableView isEqual:ResultsTableView]) {
        text = self.results[indexPath.row];
    } else {
        text = self.cities[indexPath.row];
    }
    
    cell.textLabel.text = text;
    
    
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - Search Results Updating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    UISearchBar *searchBar = searchController.searchBar;
    if (searchBar.text.length > 0) {
        NSString *text = searchBar.text;
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *city, NSDictionary *bindings) {
            NSRange range = [city rangeOfString:text options:NSCaseInsensitiveSearch];
            
            return range.location != NSNotFound;
        }];
        
        // Set up results.
        NSArray *searchResults = [self.cities filteredArrayUsingPredicate:predicate];
        self.results = searchResults;
        
        // Reload search table view.
        [self.searchResultsTableViewController.tableView reloadData];
    }
}

#pragma mark - Search Controller Delegate

- (void)didDismissSearchController:(UISearchController *)searchController {
    [self.searchController.searchBar setHidden:YES];
    self.searcBarButton = [[UIBarButtonItem alloc]
                           initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searcher)];
    self.navigationItem.rightBarButtonItem = self.searcBarButton;
    
 
}




-(void)searcher {
    self.navigationItem.rightBarButtonItem = nil;
    self.searcBarButton = nil;
    [self.searchController.searchBar setHidden:NO];
    [self.searchController.searchBar becomeFirstResponder];
    //[self.searchController setActive:YES];
    

    
    
    
    
    
}
@end

