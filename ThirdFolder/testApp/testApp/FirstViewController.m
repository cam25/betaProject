//
//  FirstViewController.m
//  testApp
//
//  Created by Cameron Mozie on 8/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "FirstViewController.h"
#import "SplashScreenViewController.h"
#import "AppDelegate.h"
#import "NSString+stripHtml.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize bgimageView,VOTDtext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Verse Of Day", @"Verse Of Day");
        self.tabBarItem.image = [UIImage imageNamed:@"VOTD"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    
    //------+parsing info
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL
                                                          URLWithString:@"http://labs.bible.org/api/?passage=votd&type=json"]];

    
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    NSError *error = nil;
    NSArray *parser = [NSJSONSerialization JSONObjectWithData:response
                                                      options:0 error:&error];
    NSLog(@"Response:::%@",parser);
    
    //--------+end of parser code
    
    
    //setting variables to hold the response from the api at the key for each specific object
    NSString *handle = [[parser objectAtIndex:0] objectForKey:@"chapter"];
    NSString *verse = [[parser objectAtIndex:0]objectForKey:@"verse"];
    NSString *bookName = [[parser objectAtIndex:0]objectForKey:@"bookname"];
    NSString *text = [[parser objectAtIndex:0]objectForKey:@"text"];
    
   //decoder to not allow for unwanted characters
    NSString *decoded = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)text, CFSTR("!*'();:@&=+$,/?%#[]<>"), NSUTF8StringEncoding);
 
    NSLog(@"%@",decoded);
    
    
    //calling of my strip html to strop the string of any unwanted html elements
    NSString *stripped = [decoded stripHtml];
    NSLog(@"%@",stripped);
    
    
    //displays the verse of the day inside textview
    VOTDtext.text = [NSString stringWithFormat:@" %@" @" %@ :" @" %@\n\n" @"%@",bookName,handle,verse,stripped];
    
    //Get a UIImage from the UIView
    UIGraphicsBeginImageContext(bgimageView.bounds.size);
    [bgimageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Blur the UIImage with a CIFilter
    CIImage *imageToBlur = [CIImage imageWithCGImage:viewImage.CGImage];
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: 1.5f] forKey: @"inputRadius"];
    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
    UIImage *endImage = [[UIImage alloc] initWithCIImage:resultImage];
    
    //Place the UIImage in a UIImageView
    UIImageView *newView = [[UIImageView alloc] initWithFrame:bgimageView.bounds];
    newView.image = endImage;
    [bgimageView addSubview:newView];

    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//alerts the user to connect to the internet to have access to the applications funcationality
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.title = @"Error ";
    alertView.message = @" Please make sure you have some type of internet connection.";
    [alertView addButtonWithTitle:@"OK"];
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //created app delegate object for accessing inside of app delegate
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    //user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //if the showedSplash bool is yes then set the default to no to not allow it to show up each time the screen is presented and present the view
    if ([app.showedSplash isEqualToString:@"yes"])
    {
        app.showedSplash = @"no";
        [defaults setObject:@"no" forKey:@"splash"];
        [defaults synchronize];
        
        
        SplashScreenViewController *splash = [[SplashScreenViewController alloc]initWithNibName:@"SplashScreenViewController" bundle:nil];
        
        
        splash.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        
        [self presentViewController:splash animated:TRUE completion:nil];
        
    
        //if defaults has an object for key splash = to yes present view
    } else if ([[defaults objectForKey:@"splash"] isEqualToString:@"yes"])
    {
        app.showedSplash = @"no";
        [defaults setObject:@"no" forKey:@"splash"];
        [defaults synchronize];
        SplashScreenViewController *splash = [[SplashScreenViewController alloc]initWithNibName:@"SplashScreenViewController" bundle:nil];
        [self presentViewController:splash animated:TRUE completion:nil];
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    //sets the object for the splash screen to yes in defaults if its no to allow the splash to show up upon reopening of app
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![[defaults objectForKey:@"splash"] isEqualToString:@"no"])
    {
        [defaults setObject:@"yes" forKey:@"splash"];
        [defaults synchronize];
    }
}

-(IBAction)onClick:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
    
    //if share button is clicked access twitter data
        if (button.tag == 0) {//if share button is clicked unhide done button
        SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if (slComposeViewController != nil) {
            
            //sets default text
            [slComposeViewController setInitialText:@"Posted From Spiritual Balance:"];
            
            [self presentViewController:slComposeViewController animated:true completion:nil];
        }
        NSLog(@"post");
    }
}


@end
