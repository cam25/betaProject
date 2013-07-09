//
//  FirstViewController.m
//  testApp
//
//  Created by Cameron Mozie on 7/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "FirstViewController.h"
#import "CustomCell.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad

{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *url = [NSURL URLWithString:@"http://www.ourmanna.com/verses/api/get?format=text&order=random"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data = [[NSMutableData alloc]init];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [data appendData:theData];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSError *jsonError = nil;
    verses = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (!verses) {
        NSLog(@"Error parsing JSON: %@", jsonError);
    } else {
        for(NSDictionary *item in verses) {
            NSLog(@"Item: %@", item);
        }
    }
        [mainTableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (cell != nil) {
        
        cell.textLabel.text = [[verses objectAtIndex:indexPath.row]objectForKey:@"verseurl:"];
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end
