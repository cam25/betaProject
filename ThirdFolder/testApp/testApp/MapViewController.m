//
//  MapViewController.m
//  testApp
//
//  Created by Cameron Mozie on 8/22/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "MapViewController.h"
#import "MyAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <MapKit/MapKit.h>

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize locationManager,foundUserLocationCallback,mapItemPin,lastMapItemPinTapped,mapItems,localSearch,localSearchRequest,mapViewMode,coords,userLocationSet;

static CGFloat userPosZoomLat = 0.2;
static CGFloat userPosZoomLon = 0.2;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Find A Church", @"Find A Church");
        self.tabBarItem.image = [UIImage imageNamed:@"church"];
    }
    return self;
}
- (void)viewDidLoad
{
     [super viewDidLoad];

    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.searchBar.delegate = self;
    
   
    
    [self.locationManager startUpdatingLocation];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
  
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupCoordsUsingAddress:(NSString *)address {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(!error && placemarks && placemarks.count > 0) {
            [self findQuery:@"church" placeMarksArray:placemarks];
        }
        
    }];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *userLocation = [locations lastObject];
    
    self.coords = userLocation.coordinate;
    self.userLocationSet = YES;
    [self showLocation];
    
    if(self.foundUserLocationCallback) {
        self.foundUserLocationCallback(self.coords);
    }
    
    self.foundUserLocationCallback = nil;
    
    if(userLocation.horizontalAccuracy <= 100.0f) {
        [self.locationManager stopUpdatingLocation];
    }
}

-(void)showLocation {
    
    MKCoordinateSpan   local = MKCoordinateSpanMake(userPosZoomLat, userPosZoomLon);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.coords, local);
    
    CLLocationCoordinate2D location;
    location.latitude = self.coords.latitude;
    location.longitude = self.coords.longitude;
    region.span = local;
    region.center = location;
    
    [self.mapView setRegion:region animated:YES];
}



-(void)setMapViewMode:(MapViewMode)mapViewMode {
    

    mapViewMode = mapViewMode;
    [self.mapView addAnnotations:self.mapItems];
    if(self.mapItemPin) {
        [self.mapView addAnnotation:self.mapItemPin];
        NSLog(@"%@",mapItemPin);
    }
}



-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *const kPinIdentifier = @"MapItemAnnotation";
    
    if([annotation isKindOfClass:[MyAnnotation class]]) {
        MKPinAnnotationView *view = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:kPinIdentifier];
        if(!view) {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kPinIdentifier];
            view.canShowCallout = YES;
            view.calloutOffset = CGPointMake(-5, 5);
            view.animatesDrop = YES;
        }
        view.pinColor = MKPinAnnotationColorRed;
        return view;
    }
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    self.lastMapItemPinTapped = (MyAnnotation *)view.annotation;
}

-(void)startLookup:(NSString *)searchString {
    
    // Set the size (local/span) of the region (address, w/e) we want to get search results for.
    
    MKCoordinateSpan   local = MKCoordinateSpanMake(0.6250, 0.6250);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.coords, local);
    
    [self.mapView setRegion:region animated:NO];
    
    self.localSearchRequest = [[MKLocalSearchRequest alloc] init];
    self.localSearchRequest.region = region;
    self.localSearchRequest.naturalLanguageQuery = searchString;
    
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:self.localSearchRequest];
    
    [self.localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        if(!error){
            
            [self loadData:response];
            NSLog(@"%@", response);
            self.mapViewMode = MapViewModeNormal;
            
            MKCoordinateSpan   local = MKCoordinateSpanMake(0.2, 0.2);
            MKCoordinateRegion region = MKCoordinateRegionMake(self.coords, local);
            
            [self.mapView setRegion:region animated:NO];
        }
    }];
}

-(void)findQuery:(NSString *)namestr placeMarksArray:(NSArray *)placemarks {
    
    // Search 0.250km from point for stores.
    CLPlacemark *placemark = placemarks[0];
    CLLocation *location = placemark.location;
    
    self.coords = location.coordinate;
    
    [self startLookup:namestr];
    
    NSLog(@"%@",namestr);
}

-(void)loadData:(MKLocalSearchResponse *)response {
    
    NSUInteger matchesCount = [response.mapItems count];
    NSInteger i = 0;
    
    self.mapItems = [[NSMutableArray alloc] initWithCapacity:matchesCount];
    
    for(MKMapItem *mapItem in response.mapItems){
        
        MKPlacemark *placeMark = mapItem.placemark;
        
        CLLocationDegrees latitude  = placeMark.coordinate.latitude;
        CLLocationDegrees longitude = placeMark.coordinate.longitude;
        
        // Add the pair of coordinates
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
      
        
        // Create a new station object with the coordinates created.
        [self.mapItems addObject:[[MyAnnotation alloc] initUsingCoordinate:coordinate
                                                                          mapItemName:mapItem.name]];
        i++;
        
        NSLog(@"%@",mapItem.name);
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self startLookup:searchBar.text];
    
	self.searchBar.text = @"";
	[self.searchBar resignFirstResponder];
}


@end
