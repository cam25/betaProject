//
//  SecondViewController.h
//  testApp
//
//  Created by Cameron Mozie on 8/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UISearchBarDelegate, UITextViewDelegate>

{
    NSMutableArray *totalStrings;
    NSMutableArray *filteredStrings;
   // UITextView *searchTextView;
    BOOL isFiltered;
}


@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITextView *searchTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *infoButton;

@end
