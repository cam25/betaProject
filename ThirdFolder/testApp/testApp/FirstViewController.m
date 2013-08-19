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
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL
                                                          URLWithString:@"http://labs.bible.org/api/?passage=votd&type=json"]];
    
   // NSURL *url = [NSURL URLWithString:@"http://labs.bible.org/api/?passage=votd"];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    NSError *error = nil;
    NSArray *parser = [NSJSONSerialization JSONObjectWithData:response
                                                      options:0 error:&error];
    NSLog(@"Response:::%@",parser);
    
    
   //NSArray *arr = [[[[parser objectForKey:@"chapter"] objectForKey:@"text"] objectForKey:@"verse"] objectForKey:@"bookname"];
        
       
    
    NSString *handle = [[parser objectAtIndex:0] objectForKey:@"chapter"];
    NSString *verse = [[parser objectAtIndex:0]objectForKey:@"verse"];
    NSString *bookName = [[parser objectAtIndex:0]objectForKey:@"bookname"];
    NSString *text = [[parser objectAtIndex:0]objectForKey:@"text"];
    
    VOTDtext.text = [NSString stringWithFormat:@" %@" @" %@ :" @" %@\n\n" @"%@",bookName,handle,verse,text];
    
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
    
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([app.showedSplash isEqualToString:@"yes"])
    {
        app.showedSplash = @"no";
        [defaults setObject:@"no" forKey:@"splash"];
        [defaults synchronize];
        SplashScreenViewController *splash = [[SplashScreenViewController alloc]initWithNibName:@"SplashScreenViewController" bundle:nil];
        splash.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:splash animated:TRUE completion:nil];
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
    
    if (button.tag == 0) {//if edit button is clicked unhide done button
        SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if (slComposeViewController != nil) {
            
           // NSLog(@"%@", VOTDtext.text);
            //methods for setting text in tweet and images
            [slComposeViewController setInitialText:@"Posted From "];
            //[slComposeViewController addImage:[UIImage imageNamed:@"nats.png"]];
            [self presentViewController:slComposeViewController animated:true completion:nil];
        }
        NSLog(@"post");
    }
}


@end
