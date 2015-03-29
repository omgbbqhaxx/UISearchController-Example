//
//  ViewController.h
//  searcher
//
//  Created by yasin aktimur on 29.03.2015.
//  Copyright (c) 2015 yasin aktimur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UISearchResultsUpdating, UISearchControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *lister;

@end

