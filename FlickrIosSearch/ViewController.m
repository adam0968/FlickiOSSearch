//
//  ViewController.m
//  FlickrIosSearch
//
//  Created by Adam Hellewell on 10/28/15.
//  Copyright © 2015 Adam Hellewell. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//   NSDictionary* dictionary = [[Networking sharedManager]getFlickrSearchResultsForText:@"Adam"];
//
//    
//    NSArray* arrayOfImages = [[dictionary objectForKey:@"photos"] objectForKey:@"photo"];
//    
//    UIImageView* iv = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    iv.image = [UIImage imageWithData:[
//                                       [Networking sharedManager]
//                                       getFlickrPhoto:arrayOfImages[0]andPhotoSize:@"t"]
//                ];
//    iv.contentMode = UIViewContentModeCenter;
//    [self.view addSubview:iv];
    
}

-(void)loadData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSDictionary* dictionary = [[Networking sharedManager]getFlickrSearchResultsForText:self.searchBar.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            arrayOfPhotos = [[dictionary objectForKey:@"photos"] objectForKey:@"photo"];
            [self.tableView reloadData];
        });
    });
    
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self loadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayOfPhotos.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlickrTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"FlickrTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    
    NSDictionary* dictionary = arrayOfPhotos[indexPath.row];
    
    cell.flickrLabel.text = [dictionary objectForKey:@"title"];
    
    [cell setFlickrImageInBackground:dictionary];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 195;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
