//
//  CustomCell.h
//  testApp
//
//  Created by Cameron Mozie on 7/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    IBOutlet UILabel *actualVerseOfDay;
}
@property (nonatomic,strong) UILabel *actualVerseOfDay;
@end
