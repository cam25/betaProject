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
    NSString *subTitle;
}
  
    
@property (nonatomic) CLLocationCoordinate2D coordinate;
//@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;



-(id)initUsingCoordinate:(CLLocationCoordinate2D)coordinate mapItemName:(NSString *)mapItemName;
-(id)initUsingCoordinate:(CLLocationCoordinate2D)coordinate mapItemName:(NSString *)mapItemName withOptionalSubTitle:(NSString *)subTitle;

@end
