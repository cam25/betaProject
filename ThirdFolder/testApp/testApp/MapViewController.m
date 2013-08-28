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
@synthesize locationManager,foundUserLocationCallback,annotations,lastMapItemPinTapped,variousLocations,localSearch,localSearchRequest,_mapViewMode,locationsCoordinates,userLocationSet,toolbar;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Locate A Church", @"Locate A Church");
        self.tabBarItem.image = [UIImage imageNamed:@"Gps"];
    }
    return self;
}

//inits my various location array
- (void)viewWillAppear:(BOOL)animated
{
    self.variousLocations = [[NSMutableArray alloc]init];
}

- (void)viewDidLoad
{
     [super viewDidLoad];
    
    //setting all the delegates and initting my location manager
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.searchBar.delegate = self;
    
   
    //on load of the view start updating my location
    [self.locationManager startUpdatingLocation];

   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
  
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//sets coordinates by address if you are searching for chuch via address
-(void)setupCoordsUsingAddress:(NSString *)address {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        //logs the error
        NSLog(@"%@", error);
    }];
}

//sets user location when called
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *userLocation = [locations lastObject];
    
    self.locationsCoordinates = userLocation.coordinate;
    self.userLocationSet = YES;
    [self showLocation];
    
    if(self.foundUserLocationCallback) {
        self.foundUserLocationCallback(self.locationsCoordinates);
    }
    
    self.foundUserLocationCallback = nil;
    
    if(userLocation.horizontalAccuracy <= 100.0f) {
        [self.locationManager stopUpdatingLocation];
    }
}

//shows location at the coordinates of the user
-(void)showLocation {
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.2f;
    span.longitudeDelta = 0.2f;
    
    MKCoordinateRegion region = MKCoordinateRegionMake(self.locationsCoordinates, span);
    
    CLLocationCoordinate2D location;
    location.latitude = self.locationsCoordinates.latitude;
    location.longitude = self.locationsCoordinates.longitude;
    region.span = span;
    region.center = location;
    
    [self.mapView setRegion:region animated:YES];
}


//loads the mapViewMode and adds annotations to the view when called
-(void)setMapViewMode:(MapViewMode)mapViewMode {
    

    _mapViewMode = mapViewMode;
    [self.mapView addAnnotations:self.variousLocations];
    if(self.annotations) {
        [self.mapView addAnnotation:self.annotations];
        NSLog(@"%@",annotations);
    }
}


//creation of annotations
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *const kPinIdentifier = @"AnnotationDrop";
    
    if([annotation isKindOfClass:[MyAnnotation class]]) {
        MKPinAnnotationView *view = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:kPinIdentifier];
        if(!view) {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kPinIdentifier];
            view.canShowCallout = YES;
            view.calloutOffset = CGPointMake(-5, 5);
            view.animatesDrop = YES;
            UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Gps.png"]];
            view.leftCalloutAccessoryView = profileIconView;
         
        }
        view.pinColor = MKPinAnnotationColorRed;
        return view;
    }
    return nil;
}

//handles the tap of the annotations
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    self.lastMapItemPinTapped = (MyAnnotation *)view.annotation;
}

//searches for matches based on search string
-(void)startLookup:(NSString *)searchString {
    
   
    
    MKCoordinateSpan   local = MKCoordinateSpanMake(0.5900, 0.5900);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.locationsCoordinates, local);
    
    [self.mapView setRegion:region animated:NO];
    
    self.localSearchRequest = [[MKLocalSearchRequest alloc] init];
    self.localSearchRequest.region = region;
    self.localSearchRequest.naturalLanguageQuery = searchString;
    
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:self.localSearchRequest];
    
    [self.localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        if(!error){
            
            [self loadData:response];
            NSLog(@"count: %i", self.variousLocations.count);
            [self.mapView addAnnotations:self.variousLocations];
            self.mapViewMode = MapViewModeNormal;
            
            MKCoordinateSpan   local = MKCoordinateSpanMake(0.2, 0.2);
            MKCoordinateRegion region = MKCoordinateRegionMake(self.locationsCoordinates, local);
            
            [self.mapView setRegion:region animated:NO];
        }
    }];
}

//finds search results based on distance of users gps
-(void)findQuery:(NSString *)namestr placeMarksArray:(NSArray *)placemarks {
    
    // Search 0.250km from point for stores.
    CLPlacemark *placemark = placemarks[0];
    CLLocation *location = placemark.location;
    
    self.locationsCoordinates = location.coordinate;
    
    [self startLookup:namestr];
    
    NSLog(@"%@",namestr);
}

//populates data into the map view based on the place mark and coordinates
-(void)loadData:(MKLocalSearchResponse *)response {
    
    NSInteger i = 0;
    
    for(MKMapItem *mapItem in response.mapItems){
        
        MKPlacemark *placeMark = mapItem.placemark;
        
        CLLocationDegrees latitude  = placeMark.coordinate.latitude;
        CLLocationDegrees longitude = placeMark.coordinate.longitude;
        
        // Add the pair of coordinates
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
      
        MyAnnotation *ann = [[MyAnnotation alloc]initUsingCoordinate:coordinate mapItemName:mapItem.name];
        
        // Create a new station object with the coordinates created.
        [self.variousLocations addObject:ann];
        i++;
        
        NSLog(@"%@",mapItem.name);
    }
}

//search is clicked it removes current annotations and starts a new lookup
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self startLookup:searchBar.text];
    
	self.searchBar.text = @"";
	[self.searchBar resignFirstResponder];
}

//if a user chooses to not search for anything can click done and removes the keyboard with this function
-(IBAction)doneButtonClicked:(id)sender
{
    UIButton *button = (UIButton*)sender;
    if (button.tag == 1) {
        
        [self.searchBar resignFirstResponder];
    }
   
    
}
@end
