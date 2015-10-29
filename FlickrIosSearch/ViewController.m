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

#define tableViewCellHeight 195

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor = [UIColor whiteColor];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneEditing:)],
                           nil];
    [numberToolbar sizeToFit];

    self.searchBar.inputAccessoryView = numberToolbar;
}

-(void)doneEditing:(id)sender {
    [self.view endEditing:YES];
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
    if ([searchText isEqualToString:@""]) {
        
    } else {
        [self loadData];
    }
    
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
    return tableViewCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showFullImage" sender:arrayOfPhotos[indexPath.row]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showFullImage"]) {
        FullImageViewController* fivc = (FullImageViewController*)segue.destinationViewController;
        fivc.photoInfo = (NSDictionary*)sender;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
