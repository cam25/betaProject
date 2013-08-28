//
//  SecondViewController.m
//  testApp
//
//  Created by Cameron Mozie on 8/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "SecondViewController.h"
#import "NSString+stripHtml.h"
@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize searchBar,searchTextView;
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

	// Do any additional setup after loading the view, typically from a nib.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [searchBar resignFirstResponder];
    
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)onClick:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
    if (button.tag == 0) {//if search icon clicked show alert
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.title = @"Search Example ";
        alertView.message = @" To conduct a single verse search enter the book name with a space then the chapter followed by a colon and then the verse. (ex1. John 3:16 ) (ex2. 1Kings 1:2) Once info is entered click the Get Your Word Button to display the scripture.";
        [alertView addButtonWithTitle:@"OK"];
        [alertView show];
       
    }else if (button.tag == 1)
    {
//        UIAlertView *alertView = [[UIAlertView alloc] init];
//        alertView.title = @"Clear ";
//        alertView.message = @" This will allow for clearing text view.";
//        [alertView addButtonWithTitle:@"OK"];
//        [alertView show];
        
        searchTextView.text = @" ";
    }
    else if (button.tag == 2 && searchBar.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.title = @"Error ";
        alertView.message = @" Please enter text in search field.";
        [alertView addButtonWithTitle:@"OK"];
        [alertView show];
    }
    else if (button.tag == 2)
    {
        [searchBar resignFirstResponder];
        NSString *unescaped = searchBar.text;
        NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                      NULL,
                                                                                      (CFStringRef)unescaped,
                                                                                      NULL,
                                                                                      CFSTR("!*'();@$,/?%#[]-"),
                                                                                      kCFStringEncodingUTF8));
        
        NSLog(@"escapedString: %@",escapedString);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL
                                                              URLWithString:[NSString stringWithFormat:@"http://labs.bible.org/api/?passage=%@&type=json",escapedString]]];
        
        
        NSLog(@"%@",request);
        
        
        NSData *response = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:nil error:nil];
        NSError *error = nil;
        NSArray *parser = [NSJSONSerialization JSONObjectWithData:response
                                                          options:0 error:&error];
        NSLog(@"Response:::%@",parser);
 

        
        NSString *handle = [[parser objectAtIndex:0] objectForKey:@"chapter"];
        NSString *verse = [[parser objectAtIndex:0]objectForKey:@"verse"];
        
        NSString *bookName = [[parser objectAtIndex:0]objectForKey:@"bookname"];
        NSString *text = [[parser objectAtIndex:0]objectForKey:@"text"];
        NSString *strippedString = [text stripHtml];
        searchTextView.text = [NSString stringWithFormat:@" %@  %@:%@  \n\n%@", bookName, handle, verse, strippedString];
        
    }
  
}



@end
