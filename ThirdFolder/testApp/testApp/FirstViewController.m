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
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
