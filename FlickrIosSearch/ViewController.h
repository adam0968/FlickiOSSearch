//
//  ViewController.h
//  FlickrIosSearch
//
//  Created by Adam Hellewell on 10/28/15.
//  Copyright © 2015 Adam Hellewell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Networking.h"
#import "FlickrTableViewCell.h"

@interface ViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSArray* arrayOfPhotos;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

