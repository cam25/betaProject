//
//  FirstViewController.m
//  testApp
//
//  Created by Cameron Mozie on 8/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "FirstViewController.h"
#import "SplashScreenViewController.h"
#import "AppDelegate.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

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
    
  // VOTDtext.text = [[[[parser objectForKey:@"text"] [objectForKey:@"chapter"] objectForKey:@"bookname"];
  
   
    //NSArray * jsonArray = [[[[[[parser objectForKey:@"bookname"] objectForKey:@"chapter"] objectAtIndex:0] objectForKey:@"verse"] objectForKey:@"text"] objectAtIndex:0];

    VOTDtext.text = [NSString stringWithFormat:@"Book Name: %@\n" @"Chapter: %@ \n" @"Verse: %@\n" @"%@",bookName,handle,verse,text];
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
     //jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //VOTDtext.text = [jsonArray objectAtIndex:0];
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([app.showedSplash isEqualToString:@"yes"])
    {
        app.showedSplash = @"no";
        [defaults setObject:@"no" forKey:@"splash"];
        [defaults synchronize];
        SplashScreenViewController *splash = [[SplashScreenViewController alloc]initWithNibName:@"SplashScreenViewController" bundle:nil];
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
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.title = @"Share ";
        alertView.message = @" This will allow for sharing to twitter.";
        [alertView addButtonWithTitle:@"OK"];
        [alertView show];
    }
}


@end
