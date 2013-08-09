//
//  ViewController.m
//  testApp
//
//  Created by Cameron Mozie on 8/8/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
@interface ViewController ()

@end

@implementation ViewController

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
-(IBAction)onClick:(id)sender
{
   MainViewController *mainView = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
    [self presentViewController:mainView animated:YES completion:nil];
}
@end
