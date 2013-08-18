//
//  VideoViewController.h
//  testApp
//
//  Created by Cameron Mozie on 8/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Videos.h"
@interface VideoViewController : UIViewController
{
    IBOutlet UIView *videoView;
    IBOutlet UILabel *movieTitle;
    
    MPMoviePlayerController *moviePlayer;
    
}
@property (nonatomic,strong)UIView *videoView;
@property (nonatomic,strong)UILabel *movieTitle;
@property (nonatomic,strong)Videos *movieDetails;
-(IBAction)onClick:(id)sender;
-(IBAction)playStop:(id)sender;
@end
