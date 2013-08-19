//
//  ThirdTabViewController.m
//  testApp
//
//  Created by Cameron Mozie on 8/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "ThirdTabViewController.h"
#import "VideoViewController.h"
#import "Videos.h"
#import "AppDelegate.h"
#import "CustomTableViewCell.h"
@interface ThirdTabViewController ()

@end

@implementation ThirdTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Videos", @"Videos");
        self.tabBarItem.image = [UIImage imageNamed:@"Video"];
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"Videos";
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    variousVideos = [[NSMutableArray alloc]init];
    
    Videos *video1 = [[Videos alloc]initWithTitle:[NSURL URLWithString:@"http://db.tt/vlQboymb"] videoTitle:@"Do spiritual teachers have bad days?" authorName:@"Oprah"];
    
    Videos *video2 = [[Videos alloc]initWithTitle:[NSURL URLWithString:@"http://db.tt/KwYc0IEM"] videoTitle:@"The awe factor of God" authorName:@"Francis Chan"];
    
     
    Videos *video3 = [[Videos alloc]initWithTitle:[NSURL URLWithString:@"http://db.tt/Kq9z2GcC"] videoTitle:@"Whats so great about jesus" authorName:@"Francis Chan"];
    
    
    Videos *video4 = [[Videos alloc]initWithTitle:[NSURL URLWithString:@"http://db.tt/EgsAeLXk"] videoTitle:@"Law Of Attraction" authorName:@"Will smith on travis smiley show"];

    
    Videos *video5 = [[Videos alloc]initWithTitle:[NSURL URLWithString:@"http://db.tt/mDueQmZs"] videoTitle:@"Never wouldve Made it" authorName:@"Marvin Sapp"];
    
    [variousVideos addObject:video1];
    [variousVideos addObject:video2];
    [variousVideos addObject:video3];
    [variousVideos addObject:video4];
    [variousVideos addObject:video5];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView1 numberOfRowsInSection:(NSInteger)section
{
    
    return 5;//returns number of hair types based on how many objects in array
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//1 section in tabel view
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //sets secondviewcontroller to variable detailsView
    VideoViewController *detailsView = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:nil];
    if (detailsView != nil) {
        
        Videos *info = [variousVideos objectAtIndex:indexPath.row];
        
        detailsView.movieDetails = info;
        
        //calls second view/details view
    [self.navigationController pushViewController:detailsView animated:true];
        
        
    }
  
    
    
    
    
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableView" owner:self options:nil];
     CustomTableViewCell*cell = (CustomTableViewCell *) [nib objectAtIndex:0];
    
    Videos *info = [variousVideos objectAtIndex:indexPath.row];
    
    if (cell != nil) {
      
        cell.movieName.text = info.movieName;
        cell.authorsName.text = info.authorMovie;
        
    
    }
    return cell;
    
}
@end
