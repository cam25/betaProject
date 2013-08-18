//
//  Videos.m
//  testApp
//
//  Created by Cameron Mozie on 8/15/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "Videos.h"

@implementation Videos
@synthesize moviesURL,movieName,authorMovie;

-(id)initWithTitle:(NSURL *)videos videoTitle:(NSString *)movieTitle authorName:(NSString *)author
{
    if ((self = [super init])) {
        
        //setters
        moviesURL = videos;
        movieName = movieTitle;
        authorMovie = author;
        
        
        
        
    }
    return self;
}


@end
