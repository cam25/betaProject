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
@synthesize coordinate, title,subTitle;


-(id)initUsingCoordinate:(CLLocationCoordinate2D)coordinate mapItemName:(NSString *)mapItemName {
    
    
    return [self initUsingCoordinate:coordinate mapItemName:mapItemName withOptionalSubTitle:nil];
}

-(id)initUsingCoordinate:(CLLocationCoordinate2D)coordinate mapItemName:(NSString *)mapItemName withOptionalSubTitle:(NSString *)optionalSubTitle {
    
    self = [super init];
    if(self) {
        self.title = mapItemName;
       self.coordinate = coordinate;
        if(optionalSubTitle != nil) {
           self.subTitle = optionalSubTitle;
        }
    }
    return self;
}


@end
