//
//  CustomTableViewCell.h
//  testApp
//
//  Created by Cameron Mozie on 8/15/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
{
    IBOutlet UILabel *movieName;
    IBOutlet UILabel *authorsName;
}
@property (nonatomic, strong) IBOutlet UILabel *movieName;
@property (nonatomic, strong) IBOutlet UILabel *authorsName;
@end

