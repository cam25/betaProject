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
    
    Videos *video1 = [[Videos alloc]initWithTitle:[NSURL URLWithString:@"http://www.youtube.com/watch?v=NCBfazYb7qk"] videoTitle:@"Do spiritual teachers have bad days?" authorName:@"Oprah"];
    
    Videos *video2 = [[Videos alloc]initWithTitle:[NSURL URLWithString:@"http://www.youtube.com/watch?v=3Ya12I036lg"] videoTitle:@"The awe factor of God" authorName:@"Francis Chan"];
    
     
    Videos *video3 = [[Videos alloc]initWithTitle:[NSURL URLWithString:@"http://www.youtube.com/watch?v=GXzKABKSZZw"] videoTitle:@"Whats so great about jesus" authorName:@"Francis Chan"];
    
    
    Videos *video4 = [[Videos alloc]initWithTitle:[NSURL URLWithString:@"http://www.youtube.com/watch?v=Ztibky5-960"] videoTitle:@"Transformation:Its A Mind Thing" authorName:@"Bishop T.D.Jakes"];

    
    Videos *video5 = [[Videos alloc]initWithTitle:[NSURL URLWithString:@"http://www.youtube.com/watch?v=x7OSBQr3fR0"] videoTitle:@"God make miracles out of our mistakes" authorName:@"Joel Osteen"];
    
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
