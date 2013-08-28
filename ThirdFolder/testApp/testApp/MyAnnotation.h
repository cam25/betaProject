//
//  MyAnnotation.h
//  testApp
//
//  Created by Cameron Mozie on 8/22/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
@interface MyAnnotation : NSObject <MKAnnotation>

{
    NSString *title;
    CLLocationCoordinate2D coord;
}
-(id)initUsingCoordinate:(CLLocationCoordinate2D)c mapItemName:(NSString *)mapItemName;

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;



@end
