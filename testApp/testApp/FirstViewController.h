//
//  FirstViewController.h
//  testApp
//
//  Created by Cameron Mozie on 7/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *mainTableView;
    //NSDictionary *verses;
    NSMutableData *data;
    NSArray *verses;
}
@property (nonatomic,strong) NSArray *verses;
@end
