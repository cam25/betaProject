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
        self.tabBarItem.image = [UIImage imageNamed:@"Search"];
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

-(IBAction)onClick:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
    if (button.tag == 0) {//if edit button is clicked unhide done button
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.title = @"Search Example ";
        alertView.message = @" To conduct a search enter a single verse ex. John 3:16 or ex. John 3:16-17 for a range of verses or ex. John 3:16;John1:1 to search for multiple single verses and or ranges, all seperated by semi-colons";
        [alertView addButtonWithTitle:@"OK"];
        [alertView show];
       
    }else if (button.tag == 1)
    {
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.title = @"Clear ";
        alertView.message = @" This will allow for clearing text view.";
        [alertView addButtonWithTitle:@"OK"];
        [alertView show];
    }else if (button.tag == 2)
    {
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.title = @"Search ";
        alertView.message = @" This will allow for searcing on click.";
        [alertView addButtonWithTitle:@"OK"];
        [alertView show];
    }
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
