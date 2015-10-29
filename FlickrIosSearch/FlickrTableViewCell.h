//
//  FlickrTableViewCell.h
//  FlickrIosSearch
//
//  Created by Adam Hellewell on 10/28/15.
//  Copyright © 2015 Adam Hellewell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Networking.h"


@interface FlickrTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *flickrImage;
@property (weak, nonatomic) IBOutlet UILabel *flickrLabel;

-(void)setFlickrImageInBackground:(NSDictionary*)photoInfo;

@end
