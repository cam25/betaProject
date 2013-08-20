//
//  VideoViewController.m
//  testApp
//
//  Created by Cameron Mozie on 8/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//
#import <MediaPlayer/MediaPlayer.h>
#import "VideoViewController.h"
#import "ThirdTabViewController.h"
#import "CustomTableViewCell.h"
#import "Videos.h"
@interface VideoViewController ()

@end

@implementation VideoViewController
@synthesize videoView,movieTitle,movieDetails;
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
    
    
     movieTitle.text = movieDetails.movieName;
    NSLog(@"%@",movieDetails.movieName);
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
   
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
-(IBAction)playStop:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    //variable that holds the movie trailer url from my movieInfo object
    NSURL *movieURL = movieDetails.moviesURL;
    
    //inits for the movie player with the contents of the trailer url from the movieInfo object
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    NSLog(@"%@",movieDetails.moviesURL);
    
    //if stop button is pressed
    if (button.tag == 0) {
        
        if (moviePlayer != nil)
        {
            //stops the player
            [moviePlayer stop];
        }
        
    }
    else if (button.tag == 1)
    {
        
        //adds the movie player view as a subview of the movie view so it can play in the movie view
        
        [videoView addSubview:moviePlayer.view];
       
        //sizes the frame of the view
        moviePlayer.view.frame = CGRectMake(0.0f, 0.0f, videoView.frame.size.width, videoView.frame.size.height);
        
        //defaults
        moviePlayer.fullscreen = NO;
        moviePlayer.controlStyle = MPMovieControlStyleNone;
        
        //plays the video
         //[moviePlayer prepareToPlay];
        [moviePlayer play];
        
        
    }

}
@end
