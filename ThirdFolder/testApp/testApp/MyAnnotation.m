//
//  MyAnnotation.m
//  testApp
//
//  Created by Cameron Mozie on 8/22/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "MyAnnotation.h"
#import <MapKit/MKAnnotation.h>
#import "MapViewController.h"
@implementation MyAnnotation

@synthesize coordinate, title;

-(id)initUsingCoordinate:(CLLocationCoordinate2D)c mapItemName:(NSString *)mapItemName {
    
    //setters
    self = [super init];
    if(self) {
        self.title = mapItemName;
        self.coordinate = c;
    }
    return self;
}


@end
