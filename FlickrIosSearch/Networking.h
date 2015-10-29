//
//  Networking.h
//  FlickrIosSearch
//
//  Created by Adam Hellewell on 10/28/15.
//  Copyright © 2015 Adam Hellewell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Networking : NSObject
{
    NSString* flickrAPIKey;
}

+ (id)sharedManager;

-(NSDictionary*)getFlickrSearchResultsForText:(NSString*)searchString;
-(NSData*)getFlickrPhoto:(NSDictionary*)photoInfo andPhotoSize:(NSString*)photoSize;

@end
