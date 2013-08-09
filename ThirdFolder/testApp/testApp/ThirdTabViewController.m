//
//  ThirdTabViewController.m
//  testApp
//
//  Created by Cameron Mozie on 8/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "ThirdTabViewController.h"
#import "VideoViewController.h"
#import "AppDelegate.h"
@interface ThirdTabViewController ()

@end

@implementation ThirdTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Videos", @"Videos");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"Videos";
    
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
    
  
    
    //calls second view/details view
    [self.navigationController pushViewController:detailsView animated:true];
    
    
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
    
}
@end
