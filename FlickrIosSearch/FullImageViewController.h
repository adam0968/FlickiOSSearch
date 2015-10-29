//
//  FullImageViewController.h
//  FlickrIosSearch
//
//  Created by Adam Hellewell on 10/28/15.
//  Copyright © 2015 Adam Hellewell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Networking.h"

@interface FullImageViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) NSDictionary* photoInfo;

@end
