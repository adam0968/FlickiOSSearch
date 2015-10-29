//
//  Networking.m
//  FlickrIosSearch
//
//  Created by Adam Hellewell on 10/28/15.
//  Copyright © 2015 Adam Hellewell. All rights reserved.
//

#import "Networking.h"

@implementation Networking


#pragma mark Singleton Methods

+ (id)sharedManager {
    static Networking *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        flickrAPIKey = @"1dd17dde0fed7286935d83875fcc17dd";
    }
    return self;
}


-(NSDictionary*)getFlickrSearchResultsForText:(NSString*)searchString {
    NSString *urlString = [NSString stringWithFormat: @"https://api.flickr.com/services/rest/?method=flickr.photos.search&text=%@&api_key=%@&format=json&nojsoncallback=?", searchString,flickrAPIKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLResponse *response;
    NSError *error;
    //send it synchronous
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    // check for an error. If there is a network error, you should handle it here.
    if(!error)
    {
        //log response
        NSLog(@"Response from server = %@", responseString);
    }
    
    
    return [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
}


-(NSData*)getFlickrPhoto:(NSDictionary*)photoInfo andPhotoSize:(NSString*)photoSize {
    
    //http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
    NSString *urlString = [NSString stringWithFormat: @"http://farm%@.staticflickr.com/%@/%@_%@_%@.jpg", photoInfo[@"farm"], photoInfo[@"server"], photoInfo[@"id"], photoInfo[@"secret"],photoSize];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLResponse *response;
    NSError *error;
    //send it synchronous
    
    
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    return responseData;
    
}




@end
