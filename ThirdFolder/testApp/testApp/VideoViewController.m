//
//  VideoViewController.m
//  testApp
//
//  Created by Cameron Mozie on 8/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "VideoViewController.h"
#import "ThirdTabViewController.h"
@interface VideoViewController ()

@end

@implementation VideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    

self.title = @"Video Playback";
    
 
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)onClick:(id)sender
{
    
        
       ThirdTabViewController *controller =[[ThirdTabViewController alloc] initWithNibName:@"ThirdTabViewController" bundle:nil];
        
        [self.navigationController pushViewController:controller animated:true];

}
@end
