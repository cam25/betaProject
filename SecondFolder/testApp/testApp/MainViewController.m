//
//  MainViewController.m
//  testApp
//
//  Created by Cameron Mozie on 8/8/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "MainViewController.h"
#import "SecondTabViewController.h"
#import "ThirdTabViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

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
    
    UITabBar *tabBar1 = [[UITabBar alloc] initWithFrame:CGRectMake(0, 411, 320, 49)];
    tabBar1.tag = 1;
    tabBar1.delegate = (id<UITabBarDelegate>)self;
    //[ addSubview:tabBar1];
    tabBar1.alpha = 1.0;
    tabBar1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [tabBar1 setTintColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]];
    //[tabBar1 release];
    
    
    // ----------------------------;
    // Tab Bar Item -> tabBarItem1;
    // ----------------------------;
    
    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"VOTD" image:[UIImage imageNamed:@"FirstViewController_Image_2.png"] tag:0];
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"FirstViewController_Image_3.png"] withFinishedUnselectedImage:nil];
    
    
    // ----------------------------;
    // Tab Bar Item -> tabBarItem2;
    // ----------------------------;
    
    UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Find a verse" image:[UIImage imageNamed:@"FirstViewController_Image_4.png"] tag:1];
    
    
    // ----------------------------;
    // Tab Bar Item -> tabBarItem3;
    // ----------------------------;
    
    UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"Videos" image:[UIImage imageNamed:@"FirstViewController_Image_5.png"] tag:2];
    
    tabBar1.items = [NSArray arrayWithObjects:tabBarItem1, tabBarItem2, tabBarItem3, nil];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (tabBar.tag == 0 && item.tag == 0) {;
        [self didTap_tabBarItem1];
    };
    if (tabBar.tag == 1 && item.tag == 2) {;
        [self didTap_tabBarItem2];
    };
}

- (void)didTap_tabBarItem1 {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didTap_tabBarItem2 {
     ThirdTabViewController *controller = [[ThirdTabViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
