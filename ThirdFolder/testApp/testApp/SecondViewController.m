//
//  SecondViewController.m
//  testApp
//
//  Created by Cameron Mozie on 8/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Find A Verse", @"Find A Verse");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.mySearchBar.delegate = self;
//    self.searchTextView.delegate = self;
//    
//    totalStrings = [[NSMutableArray alloc] initWithObjects:@"One",@"Two",@"Three",@"Four",@"Five",@"six", @"Seven",nil];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    
//    if (searchText.length == 0) {
//        isFiltered = NO;
//    }else
//    {
//        isFiltered = YES;
//        filteredStrings = [[NSMutableArray alloc]init];
//        for (NSString *str in totalStrings) {
//            
//            NSRange stringRange = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
//            
//            if (stringRange.location != NSNotFound) {
//                [filteredStrings addObject:str];
//                
//            }
//
//        }
//    }
//        
//}
//-(void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
//{
//    [self.searchTextView resignFirstResponder];
//}

@end
