//
//  MapViewController.h
//  testApp
//
//  Created by Cameron Mozie on 8/22/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"



typedef void (^UserLocationFoundCallback)(CLLocationCoordinate2D);
@interface MapViewController : UIViewController <MKMapViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate>


typedef NS_ENUM(NSInteger, MapViewMode) {
    MapViewModeNormal = 0,
    MapViewModeLoading,
};


@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UserLocationFoundCallback foundUserLocationCallback;
@property (nonatomic, strong) MyAnnotation *annotations;
@property (nonatomic, strong) MyAnnotation *lastMapItemPinTapped;
@property (nonatomic, strong) NSMutableArray *variousLocations;
@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic, strong) MKLocalSearchRequest *localSearchRequest;
@property (nonatomic) MapViewMode _mapViewMode;
@property CLLocationCoordinate2D locationsCoordinates;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong)IBOutlet UIToolbar *toolbar;

@property BOOL userLocationSet;

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
-(IBAction)doneButtonClicked:(id)sender;
//@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@end
