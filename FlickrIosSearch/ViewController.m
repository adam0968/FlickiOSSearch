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
    
    
   NSDictionary* dictionary = [[Networking sharedManager]getFlickrSearchResultsForText:@"Adam"];

    
    NSArray* arrayOfImages = [[dictionary objectForKey:@"photos"] objectForKey:@"photo"];
    
    UIImageView* iv = [[UIImageView alloc]initWithFrame:self.view.bounds];
    iv.image = [UIImage imageWithData:[
                                       [Networking sharedManager]
                                       getFlickrPhoto:arrayOfImages[0]andPhotoSize:@"t"]
                ];
    iv.contentMode = UIViewContentModeCenter;
    [self.view addSubview:iv];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
