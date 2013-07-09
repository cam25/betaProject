//
//  CustomCell.m
//  testApp
//
//  Created by Cameron Mozie on 7/9/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize actualVerseOfDay;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
