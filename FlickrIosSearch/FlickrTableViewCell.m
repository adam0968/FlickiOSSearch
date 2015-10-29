//
//  FlickrTableViewCell.m
//  FlickrIosSearch
//
//  Created by Adam Hellewell on 10/28/15.
//  Copyright © 2015 Adam Hellewell. All rights reserved.
//

#import "FlickrTableViewCell.h"

@implementation FlickrTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFlickrImageInBackground:(NSDictionary*)photoInfo {
    self.flickrImage.image = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage* image = [UIImage imageWithData:[[Networking sharedManager] getFlickrPhoto:photoInfo andPhotoSize:@"t"]];
        dispatch_async(dispatch_get_main_queue(), ^{
        self.flickrImage.image = image;
        });
    });
    
    
}

@end
