//
//  FirstViewController.h
//  testApp
//
//  Created by Cameron Mozie on 8/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UITextViewDelegate>
{
    IBOutlet UIButton *shareButton;
    NSArray *jsonArray;
    NSDictionary *userDictionary;
    NSMutableData *data;
    //IBOutlet UITextView *VOTDtext;
    NSArray *usersArray;
    NSMutableArray *bibleVerses;
}
@property (weak, nonatomic) IBOutlet UIImageView *bgimageView;
@property (weak, nonatomic) IBOutlet UITextView *VOTDtext;

-(IBAction)onClick:(id)sender;

@end
